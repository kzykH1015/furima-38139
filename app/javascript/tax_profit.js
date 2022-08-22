function tax (){
  const itemTax = document.getElementById("add-tax-price");
  const itemProfit = document.getElementById("profit");
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
    const inputValue = itemPrice.value;
    const taxPrice = Math.floor(inputValue * 0.1)
    itemTax.innerHTML = taxPrice
    itemProfit.innerHTML = Math.floor(inputValue - taxPrice)
  });
};

window.addEventListener('load', tax);
