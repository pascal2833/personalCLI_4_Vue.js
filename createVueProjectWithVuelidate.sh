#!/usr/bin/env bash
#
# Shell to create a basic vue projet.
# We have to pass te folder name when call this file
#

#shell in /usr/bin/

echo "Necessary to pass in first parameter name of the folder"
routeToProjets=/home/pascal/workSpace/www-dev/public/
cd $routeToProjets

npm install -g vue-cli
vue init webpack $1

# Enter in the new project folder
cd $1

npm install

basicComplements=axios vuex
basicAndValidateComplements=axios vuelidate vuex
allComplements=axios d3 lodash material-design-icons moment vuelidate vuetify vuex

# Usually, I only want these basic complements, not the others.
npm install $basicComplements

# Install sass loader (not in CLI by default):
npm install -D node-sass sass-loader

# ----- Create folder for vueX, with actions, mutations (et index) et state et store. ------- #
cd src
mkdir vuex
cd vuex
mkdir actions mutations

# actions:
cd actions
cat <<EOF >index.js
// export { dataFromSearch } from './dataFromSearch'
EOF

# Mutations:
cd ../mutations
cat <<EOF >index.js
// export { saveResponseData } from './saveResponseData'
EOF

cd ..

# store.js:
cat <<EOF >store.js
import * as actions from './actions/'
import * as mutations from './mutations/'
import { state } from './state'

export default {
	state,
	mutations: {
		...mutations
	},
	actions: {
		...actions
	},
	getters: {
	}
}
EOF

# state.js:
cat <<EOF >state.js
export const state = {
	// clubsData: clubsData
}
EOF

# Create correct index.html
cd ../..
rm index.html
cat <<EOF >index.html

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<!--Only if mobile adapt needing:-->
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<style type="text/css">
			html { box-sizing: border-box; }
			*
			::before,
			::after {
				box-sizing: inherit
			}
			body {
				margin: 0;
				padding: 0;
			}
		</style>
		<title>Super title!!!</title>
	</head>
	<body>
		<div id="app"></div>
		<!-- built files will be auto injected -->
	</body>
</html>
EOF

cd src

# ------- Others necessary things: ---------- #

# Adapt App.vue:
rm App.vue
cat <<EOF >App.vue

<template>
	<div id="app" class="app">
		<router-view/>
	</div>
</template>

<script>
export default {
	name: 'App'
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped src="./app.scss"></style>
EOF

# Create app.scss:
cat <<EOF >app.scss
@import "assets/vars-and-mixins";

.app {
	font-size: calc(16px + 6 * ((100vw - 320px) / 680));
}
EOF

# Adapt main.js:
rm main.js

cat <<EOF >main.js
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App'
import router from './router'
import vuexStore from './vuex/store'

Vue.config.productionTip = false
Vue.use(Vuex)

const store = new Vuex.Store(vuexStore)
/* eslint-disable no-new */
// let router = null

// router = configRouter(VueRouter)
new Vue({
	el: '#app',
	store,
	router,
	template: '<App/>',
	components: {App}
})
EOF

# Delete HelloWorld.vue:
rm components/HelloWorld.vue

# Adapt router/index.js:
rm router/index.js
cd router

cat <<EOF >index.js
import Vue from 'vue'
import Router from 'vue-router'
import Home from '../components/Home/Home'

Vue.use(Router)
export default new Router({
	routes: [
		{
			path: '/',
			name: 'Home',
			component: Home
		}
	]
})
EOF

# Create Home page component:
cd ../components
mkdir Home; cd Home

cat <<EOF >Home.vue
<template>
	<div class="home">
	</div>
</template>

<script>

export default {
	name: 'Home'
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped src="./home.scss"></style>
EOF

# --------- Create basic structure / sass and styles in gnal: --------- #

# app.scss created when App.vue created (will contain the global styles application).

# Create home.scss:
cat <<EOF >home.scss
.home {
}
EOF

# Create vars and mixins file:
cd ../../assets

cat <<EOF >vars-and-mixins.scss
// --------------- General : --------------- //
EOF

# ----------- Create basic / git: ---------- #

	# .gitignore done by CLI, keep this default one.
cd ../..
git init
git add .
git commit -am "First commit"
git branch develop; git checkout develop

# Start the application:
npm run dev
