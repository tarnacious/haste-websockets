var myWorker = new Worker("worker.js");

myWorker.onmessage = function (oEvent) {
      console.log("Called back by the worker! " + oEvent.data + " \n");
};

myWorker.postMessage("Sup yo1");
myWorker.postMessage("Sup yo2");
