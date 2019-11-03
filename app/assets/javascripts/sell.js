

// $('.select-tab').change(function(){
//   var add =`.select-delivery-add__shipment-method
//               %h2 配送の方法
//               %span 必須
//             = f.select :shipment_method,["未定","らくらくメルカリ便"],{prompt: "---"},{class: "select-tab"}`
//   $(".select-delivery-add-area").append(add)
// })


$(function(){
  $('.price-input').on('input', function(){
    var data = $('.price-input').val();
    var fee = (data - (Math.round(data * 0.9)))
    var gain = data - fee
    $('.fee-reflect-area').html('¥' + fee);
    $('.gain-reflect-area').html('¥' + gain);

    if (data < 300) {
      $('.fee-reflect-area').html("-");
      $('.gain-reflect-area').html("-");
    } else if (data > 9999999) {
      $('.fee-reflect-area').html("-");
      $('.gain-reflect-area').html("-");
    }
  })
})

