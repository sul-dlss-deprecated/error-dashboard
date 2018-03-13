<template>
  <div id="app">
    <tabs>
      <tab name="Error list">
        <ErrorList/>
      </tab>
      <tab name="Deploys">
        <DeployList/>
      </tab>
    </tabs>
  </div>
</template>

<script>
import ErrorList from './components/ErrorList'
import DeployList from './components/DeployList'
import {Tabs, Tab} from 'vue-tabs-component';
export default {
  name: 'App',
  components: {
    ErrorList,
    DeployList,
    Tabs,
    Tab
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}

.filters {
  margin: 1em 0em 2em 0em;
}

table {
  width: 100%;
  border-collapse: collapse;
}

td {
  padding: .75rem;
  border-top: 1px solid #dee2e6;
}

a {
  color: #42b983;
}

.tabs-component {
  min-width: 40em;
  width: 50vw;
  margin-left: auto;
  margin-right: auto;
}
.tabs-component-tabs {
  border: solid 1px #ddd;
  border-radius: 6px;
  margin-bottom: 5px;
}

@media (min-width: 700px) {
  .tabs-component-tabs {
    border: 0;
    align-items: stretch;
    display: flex;
    justify-content: flex-start;
    margin-bottom: -1px;
  }
}

.tabs-component-tab {
  color: #999;
  font-size: 14px;
  font-weight: 600;
  margin-right: 0;
  list-style: none;
}

.tabs-component-tab:not(:last-child) {
  border-bottom: dotted 1px #ddd;
}

.tabs-component-tab:hover {
  color: #666;
}

.tabs-component-tab.is-active {
  color: #000;
}

.tabs-component-tab.is-disabled * {
  color: #cdcdcd;
  cursor: not-allowed !important;
}

@media (min-width: 700px) {
  .tabs-component-tab {
    background-color: #fff;
    border: solid 1px #ddd;
    border-radius: 3px 3px 0 0;
    margin-right: .5em;
    transform: translateY(2px);
    transition: transform .3s ease;
  }

  .tabs-component-tab.is-active {
    border-bottom: solid 1px #fff;
    z-index: 2;
    transform: translateY(0);
  }
}

.tabs-component-tab-a {
  align-items: center;
  color: inherit;
  display: flex;
  padding: .75em 1em;
  text-decoration: none;
}

.tabs-component-panels {
  padding: 1em 0;
}

@media (min-width: 700px) {
  .tabs-component-panels {
    border-top-left-radius: 0;
    background-color: #fff;
    border: solid 1px #ddd;
    border-radius: 0 6px 6px 6px;
    box-shadow: 0 0 10px rgba(0, 0, 0, .05);
    padding: 1em 2em;
  }
}

</style>
