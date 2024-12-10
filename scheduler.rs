use std::thread;
use rand::{Rng, thread_rng};
use std::sync::mpsc;
fn jobsgenerator(mut signal: bool, generator: mpsc::Sender<i32>) {
    let mut rng = thread_rng();
    while signal {
        let num = rng.gen_range(0..=100);
        if num == 0 {
            generator.send(num).unwrap();
            signal = false;
        }
        generator.send(num).unwrap();
    }
    println!("jobgenerator finished");
}

fn jobscheduler(scheduler:mpsc::Receiver<i32>,mi1:mpsc::Sender<i32>,mi2:mpsc::Sender<i32>){
    let mut total1 = 0;
    let mut total2 = 0;
    for cost in scheduler {
        if cost == 0{
            break;
        }
        if total1 <= total2 {
            total1+=cost;
            mi1.send(cost).unwrap();
        } else {
            total2+=cost;
            mi2.send(cost).unwrap();
        }
    }
    println!("jobscheduler finished");
}

fn sendtoreporter(i:i32,machineout:mpsc::Receiver<i32>,machine:mpsc::Sender<(i32,i32)>){
    for cost in machineout{
        if cost == 0{
            machine.send((i, -1)).unwrap();
        }
        else{
        machine.send((i,cost)).unwrap();
        }
    }
    println!("sendreporter finished");
}

fn reportwriter(output:mpsc::Receiver<(i32,i32)>){
    let mut total11 = 0;
    let mut total22 = 0;
    for t in output{
        if t.1 == -1{
            break;
        }
        if t.0 == 1{
            total11 += t.1;
        }
        else{
            total22 += t.1;
        }
    }
    println!("Totally Machine1 got {} and Machine2 got {}", total11, total22);
    println!("reportwriter finished");
}

fn main() {
    let (generator, scheduler) = mpsc::channel();
    let (mi1, mo1) = mpsc::channel();
    let (mi2, mo2) = mpsc::channel();
    let (machine,reporter) = mpsc::channel();
    let machine1_clone = machine.clone();
    let machine2_clone = machine.clone();
    let generator_clone = generator.clone();
let handle1 = thread::spawn(move || {
        jobsgenerator(true, generator_clone);
    });
let handle2 = thread::spawn(move || {
    jobscheduler(scheduler,mi1,mi2);
});
let handle3 = thread::spawn(move || {
    sendtoreporter(1,mo1,machine1_clone);
});
let handle4 = thread::spawn(move || {
    sendtoreporter(2,mo2,machine2_clone);
});
handle1.join().unwrap();
handle2.join().unwrap();
handle3.join().unwrap();
handle4.join().unwrap();
let handle5 = thread::spawn(move || {
    reportwriter(reporter);
});
drop(machine);
handle5.join().unwrap();
    println!("All threads have finished.");
}