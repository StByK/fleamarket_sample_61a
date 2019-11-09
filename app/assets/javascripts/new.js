
    // $(document).ready(function () {
    //   var input_area = $('.input-area');

    //   $(".upload-image").on('change', function(){
    //     var fileprop = $(this).prop('files')[0],
    //         find_img = $(this).next('img'),
    //         fileRdr = new FileReader();
        
    //     if(find_img.length){
    //         find_img.nextAll().remove();
    //         find_img.remove();
    //     }
        
    //     var img = '<img width="200" alt="" class="img_view"><a href="#" class="img_del">画像を削除する</a>';
    
    //     input_area.append(img);
        
    //     fileRdr.onload = function() {    
    //       input_area.find('img').attr('src', fileRdr.result);
    //       img_del(input_area); 
    //     }
    //     fileRdr.readAsDataURL(fileprop);  
    //   });
      
    //   function img_del(target)
    //   {
    //     target.find("a.img_del").on('click',function(){
    
    //       if(window.confirm('サーバーから画像を削除します。\nよろしいですか？'))
    //       {
    //         $(this).parent().find('input[type=file]').val('');
    //         $(this).parent().find('.img_view, br').remove();
    //         $(this).remove();
    //       }
    //       return false;
    //     });
    //   }  
    // });













  $(function(){
    $('#shipment-fee-select-tab').on('change',function(){
      var selected = $('#shipment-fee-select-tab').val();
      var add1 =`<div class="shipment-method">
                  <div class="select-delivery-add__shipment-method">
                    <h2>配送の方法</h2>
                    <span>必須</span>
                  </div>
                  <select class="select-tab" name="item[shipment_method]">
                    <option value="">---</option>
                    <option value="未定">未定</option>
                    <option value="らくらくメルカリ便">らくらくメルカリ便</option>
                    <option value="ゆうメール">ゆうメール</option>
                    <option value="レターパック">レターパック</option>
                    <option value="普通郵便(定形、定形外)">普通郵便(定形、定形外)</option>
                    <option value="クロネコヤマト">クロネコヤマト</option>
                    <option value="ゆうパック">ゆうパック</option>
                    <option value="クリックポスト">クリックポスト</option>
                    <option value="ゆうパケット">ゆうパケット</option>
                  </select>
                </div>`
      var add2 =`<div class="shipment-method">
                  <div class="select-delivery-add__shipment-method">
                    <h2>配送の方法</h2>
                    <span>必須</span>
                  </div>
                  <select class="select-tab" name="item[shipment_method]">
                    <option value="">---</option>
                    <option value="未定">未定</option>
                    <option value="クロネコヤマト">クロネコヤマト</option>
                    <option value="ゆうパック">ゆうパック</option>
                    <option value="ゆうメール">ゆうメール</option>
                  </select>
                </div>`
      $('.shipment-method').empty()

      if (selected == "") {
        $('.shipment-method').empty()
      } else if (selected == "送料込み(出品者負担)"){
        $('.select-delivery-add-area').append(add1)
      } else if (selected == "着払い(購入者負担)") {
        $('.select-delivery-add-area').append(add2)
      }
    })
  })

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

