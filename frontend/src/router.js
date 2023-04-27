import { createRouter, createWebHistory } from 'vue-router'

const Home = () => import('./components/home/HomePage.vue')
const Login = () => import('./components/user/LoginPage.vue')
const MyAccount = () => import('./components/user/UserAccount.vue')
const UserProfilePage = () => import('./components/user/UserProfilePage.vue')
const EditUserProfilePage = () => import('./components/user/EditUserProfilePage.vue')
const Movie = () => import('./components/movie/MoviePage.vue')
const Search = () => import('./components/search/SearchPage.vue')
const MovieVideos = () => import('./components/movie/MovieVideos.vue')
const Person = () => import('./components/person/PersonPage.vue')

const loginGuard = (to, from, next) => {
  if (isLoggedIn()) {
    next()
  } else {
    next({ name: 'login_path' })
  }
}

const badLink = (to, from, next) => {
  const rootPathArgs = { name: 'root_path' }
  next(rootPathArgs)
}

const isLoggedIn = () => {
  return !!localStorage.getItem('sessionId')
}

const routes = [
  {
    path: '/',
    component: Home,
    name: 'root_path',
    beforeEnter: loginGuard
  },
  {
    path: '/login',
    component: Login,
    name: 'login_path'
  },
  {
    path: '/my_account',
    component: MyAccount,
    name: 'my_account_path',
    beforeEnter: loginGuard
  },
  {
    path: '/user_profile/:id',
    component: UserProfilePage,
    name: 'user_profile_path',
    beforeEnter: loginGuard,
    props: true
  },
  {
    path: '/user_profile/:id/edit',
    component: EditUserProfilePage,
    name: 'edit_user_profile_path',
    beforeEnter: loginGuard,
    props: true
  },
  {
    path: '/movie/:id',
    component: Movie,
    name: 'movie_path',
    beforeEnter: loginGuard,
    props: true
  },
  {
    path: '/search',
    component: Search,
    name: 'search_path',
    beforeEnter: loginGuard,
    props: route => ({ query: route.query.query })
  },
  {
    path: '/movie/:movieId/videos',
    component: MovieVideos,
    name: 'movie_videos_path',
    beforeEnter: loginGuard,
    props: true
  },
  {
    path: '/person/:id',
    component: Person,
    name: 'person_path',
    beforeEnter: loginGuard,
    props: true
  },
  {
    path: '/*',
    name: '404_path',
    beforeEnter: badLink
  }
]

const router = createRouter({
  linkExactActiveClass: 'active',
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  next()
})

export default router
