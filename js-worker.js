postMessage("I'm working before postMessage.");

onmessage = function (oEvent) {
  postMessage("Hi " + oEvent.data);
};
