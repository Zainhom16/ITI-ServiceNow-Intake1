// Clusore Example
function storeSecretMessage(msg) {
  return {
    updateMessage: function (updatedText) {
      msg = updatedText;
    },

    readMessage: function () {
      return msg;
    },
  };
}

const secret = storeSecretMessage("Hello!");
console.log(secret.readMessage());
secret.updateMessage("New secret");
console.log(secret.readMessage());
