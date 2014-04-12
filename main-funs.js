function make_worker(url) {
    return new Worker(url);
}

function on_message(worker, callback) {
    worker.onmessage = function (e) {
        A(callback, [[0, e.data], 0]);
    }
}

function send_message(worker, message) {
    worker.postMessage(message);
}

function log_message(message) {
    console.log(message);
}
