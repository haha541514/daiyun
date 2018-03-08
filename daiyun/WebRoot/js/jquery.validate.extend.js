/*******************************����¹���-���ò��validator��Ĭ�ϲ���*****************************************/
$.validator.setDefaults({
    /*�رռ�������ʱ��ʵʱУ��*/
    onkeyup: null,
    /*���У��ɹ����ִ�к���--�޸���ʾ���ݣ���Ϊ��ȷ��ʾ��Ϣ����µ���ʽ(Ĭ����valid)*/
    success: function(label){
        /*label��Ĭ����ȷ��ʽΪvalid����Ҫͨ��validClass�����ã�����������ӵ�������ʽ���ܱ����*/
        label.text('').addClass('valid');
    },
    /*��дУ��Ԫ�ػ�ý�����ִ�к���--����[1.�������Ԫ��ʱ�İ�����ʾ,2.У��Ԫ�صĸ�����ʾ]�������ܵ�*/
    onfocusin: function( element ) {
        this.lastActive = element;
        
        /*1.������ʾ����*/
        this.addWrapper(this.errorsFor(element)).hide();
        var tip = $(element).attr('tip');
        if(tip && $(element).parent().children(".tip").length === 0){
            $(element).parent().append("<label class='tip'>" + tip + "</label>");
        }
        
        /*2.У��Ԫ�صĸ�����ʾ*/
        $(element).addClass('highlight');

        // Hide error label and remove error class on focus if enabled
        if ( this.settings.focusCleanup ) {
            if ( this.settings.unhighlight ) {
                this.settings.unhighlight.call( this, element, this.settings.errorClass, this.settings.validClass );
            }
            this.hideThese( this.errorsFor( element ) );
        }
    },
    /*��дУ��Ԫ�ؽ����뿪ʱ��ִ�к���--�Ƴ�[1.��ӵİ�����ʾ,2.У��Ԫ�صĸ�����ʾ]*/
    onfocusout: function( element ) {
        /*1.������ʾ��Ϣ�Ƴ�*/
        $(element).parent().children(".tip").remove();

        /*2.У��Ԫ�ظ�����ʽ�Ƴ�*/
        $(element).removeClass('highlight');
        
        /*3.�滻����ע�͵�ԭʼ���룬�κ�ʱ�����뿪Ԫ�ض�����У�鹦��*/
        this.element( element );
        
        /*if ( !this.checkable( element ) && ( element.name in this.submitted || !this.optional( element ) ) ) {
            this.element( element );
        }*/
    }
});
/*******************************����ֶ�У��*****************************************/
$.validator.addMethod(
    "amtCheck",
    function(value, element){
        /*var dotPos = value.indexOf('.');
        return value > 0 && dotPos < 0 && (dotPos > 0 && value.substring(dotPos + 1) <= 2);*/
        
        return value && /^\d*\.?\d{0,2}$/.test(value);
    },
    "���������0��С��λ��������2λ"
);

