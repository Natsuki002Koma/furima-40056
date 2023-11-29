function priceCalculation() {
  const itemPrice = document.getElementById("item-price")
  const taxPriceInput = document.getElementById("add-tax-price")
  const profitInput = document.getElementById("profit")

  itemPrice.addEventListener('input', function(){
    const itemPriceValue = itemPrice.value;
    taxPriceInput.innerHTML = Math.floor(itemPriceValue*0.1).toLocaleString();
    profitInput.innerHTML = (itemPriceValue - Math.floor(itemPriceValue*0.1)).toLocaleString();
  })
}
  
  window.addEventListener('turbo:load', priceCalculation)
  window.addEventListener('turbo:render', priceCalculation);