function count (){
  const item = document.getElementById('item-price')
  item.addEventListener('keyup',() => {
    const price=item.value;
    const commission = Math.floor(price * 0.1);
    const SpaceCom = document.getElementById('add-tax-price');
    SpaceCom.innerHTML = `${commission} `;
    const profit = price - commission;
    const SpacePro = document.getElementById('profit');
    SpacePro.innerHTML = `${profit} `;
  });
};

window.addEventListener('load', count);