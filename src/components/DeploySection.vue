<template>
    <table>
      <tr v-for="item in sorted">
        <td>{{item.project_name}}</td>
        <td v-if="typeof (item.created_at) !== 'undefined'"><relative-time :time="Date.parse(item.created_at)">{{item.created_at}}</relative-time></td>
        <td v-else>No recent deploys</td>
      </tr>
    </table>
</template>

<script>
import "relative-time-vue-component";
export default {
  name: 'DeployList',
  data () {
    return {
      msg: 'Last Deploy'
    }
  },
  props: ['list'],
  computed: {
    sorted: function () {
      return this.list.sort(function (a, b) {
        if (a == b) return 0;
        if (a.created_at == undefined) return -1;
        if (b.created_at == undefined) return  1;
        return Date.parse(b.created_at) - Date.parse(a.created_at)
      })
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
