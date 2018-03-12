<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <div v-for="(value, key) in json">
      <h2>{{ key }} </h2>
      <table>
        <tr v-for="item in value">
          <td>{{item.project_name}}</td>
          <td>{{item.created_at}}</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DeployList',
  data () {
    return {
      json: null,
      msg: 'Last Deploy'
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log('json is: ' + this.json)
    fetch('/static/deploys.json')
      .then(function (response) {
        return response.json()
      })
      .then((myJson) => {
        this.json = myJson
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
  text-align: center;
}
table {
  width: 45vw;
  margin-left: auto;
  margin-right: auto;
  border-collapse: collapse;
}

td {
  padding: .75rem;
  border-top: 1px solid #dee2e6;
}

a {
  color: #42b983;
}
</style>
