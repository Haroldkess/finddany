
function paystackPopUp(publicKey, email, amount, ref, onClosed, callback) {
    let handler = PaystackPop.setup({
      key: publicKey,
      email: email,
      amount: amount,
      ref: ref,
      oncancel:  function () {
        alert("Window closed.");
        onClosed();
      },
      
      onclose: function () {
        alert("Window closed.");
        onClosed();
      },
      callback: function (response) {
        callback();
        let message = "Payment complete! Reference: " + response.reference;
        alert(message);
      },
    });
    return handler.openIframe();
  }




    