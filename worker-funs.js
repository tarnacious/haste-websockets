function on_message(callback) {
    self.onmessage = function (e) {
        A(callback, [[0, e.data], 0]);
    }
}

function post_message(message) {
    postMessage(message);
}
