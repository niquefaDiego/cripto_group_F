new Vue({
  el: '#appEncrypt',
  data: {
    message: '',
    encrypted: ''
  },
  methods: {
    encryptMessage: function() {
      this.$http.get('http://jsonplaceholder.typicode.com/users', function(data, status, request){
        if(status == 200)
        {
          this.users = data;
        }
      });
      this.encrypted = this.message.split('').reverse().join('')
    }
  }
});

new Vue({
  el: '#appDecrypt',
  data: {
    'encrypted': '',
    'message': ''
  },
  methods: {
    decryptMessage: function() {
      this.message = this.encrypted.split('').reverse().join('')
    }
  }
});
