import Vue from 'vue'
import VueRouter from 'vue-router'

import CategoryCreate from '@/views/Category/Create.vue'
import CategoryList from '@/views/Category/List.vue'

import ChoiceQuestionCreate from '@/views/ChoiceQuestion/Create.vue'
import ChoiceQuestionList from '@/views/ChoiceQuestion/List.vue'

import MultipleChoiceQuestionCreate from '@/views/MultipleChoiceQuestion/Create.vue'
import MultipleChoiceQuestionList from '@/views/MultipleChoiceQuestion/List.vue'

import JudgedQuestionCreate from '@/views/JudgedQuestion/Create.vue'
import JudgedQuestionList from '@/views/JudgedQuestion/List.vue'

import DiscussQuestionCreate from '@/views/DiscussQuestion/Create.vue'
import DiscussQuestionList from '@/views/DiscussQuestion/List.vue'

import FileCreate from '@/views/FilePage/Create.vue'
import FileList from '@/views/FilePage/List.vue'

import AdminCreate from '@/views/AdminInfo/Create.vue'
import AdminList from '@/views/AdminInfo/List.vue'

// 按需引入
const Login = () => import('@/views/Login') // 登录页
const Admin = () => import('@/views/admin') // admin主页

// const ChoiceQuestionCreate = () => { '@/views/ChoiceQuestion/Create.vue' }
// const ChoiceQuestionList = () => { '@/views/ChoiceQuestion/List.vue' }
// const FileCreate = () => { '@/views/FilePage/Create.vue' }
// const FileList = () => { '@/views/FilePage/List.vue' }
// const AdminCreate = () => { '@/views/AdminInfo/Create.vue' }
// const AdminList = () => { '@/views/AdminInfo/List.vue' }

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/admin',
    name: 'Admin',
    component: Admin,
    children: [
      { path: 'category/create', component: CategoryCreate },
      { path: 'category/edit/:id', component: CategoryCreate, props: true },
      { path: 'category/list', component: CategoryList },

      { path: 'choiceQuestion/create', component: ChoiceQuestionCreate },
      { path: 'choiceQuestion/edit/:id', component: ChoiceQuestionCreate, props: true },
      { path: 'choiceQuestion/list', component: ChoiceQuestionList },

      { path: 'multipleChoiceQuestion/create', component: MultipleChoiceQuestionCreate },
      { path: 'multipleChoiceQuestion/edit/:id', component: MultipleChoiceQuestionCreate, props: true },
      { path: 'multipleChoiceQuestion/list', component: MultipleChoiceQuestionList },

      { path: 'judgedQuestion/create', component: JudgedQuestionCreate },
      { path: 'judgedQuestion/edit/:id', component: JudgedQuestionCreate, props: true },
      { path: 'judgedQuestion/list', component: JudgedQuestionList },

      { path: 'discussQuestion/create', component: DiscussQuestionCreate },
      { path: 'discussQuestion/edit/:id', component: DiscussQuestionCreate, props: true },
      { path: 'discussQuestion/list', component: DiscussQuestionList },

      { path: 'filePage/create', component: FileCreate },
      { path: 'filePage/list', component: FileList },

      { path: 'adminInfo/create', component: AdminCreate },
      { path: 'adminInfo/edit/:id', component: AdminCreate, props: true },
      { path: 'adminInfo/list', component: AdminList }
    ]
  }
]

const router = new VueRouter({
  mode: 'history', // 去#号
  routes
})

export default router
