const pay = () => {
  Payjp.setPublicKey("pk_test_c46c662df9fbe93b9884bb9e"); // PAY.JPテスト公開鍵
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_number"),
      cvc: formData.get("order_cvc"),
      exp_month: formData.get("order_exp_month"),
      exp_year: `20${formData.get("order_exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
    });
  });
};

window.addEventListener("load", pay);