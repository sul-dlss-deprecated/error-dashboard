<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>
export default {
  name: 'ErrorList',
  data () {
    return {
      json: null,
      msg: 'Errors go here'
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log('json is: ' + this.json)
    fetch('/top-errors.json')
      .then((response) => {
        this.json = response.json()
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
