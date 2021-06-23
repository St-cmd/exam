import Vue from 'vue'
import VueRouter from 'vue-router'
import Index from '@/views/Index.vue'
import login from '@/views/login.vue'
import register from '@/views/register.vue'
import Me from '../views/view/Me.vue'
import Exercise from '../views/view/Exercise.vue'
import ChoiceQuestion from '../views/view/ChoiceQuestion.vue'
import JudgedQuestion from '../views/view/JudgedQuestion.vue'
import MultiplechoiceQuestion from '../views/view/MultiplechoiceQuestion.vue'
import DiscussQuestion from '../views/view/DiscussQuestion.vue'
import Wrong from '../views/view/Wrong.vue'
import Chapter from '../views/view/Chapter.vue'
import Recomand from '../views/view/same/Recomand.vue'
import AboutTest from '../views/view/my/AboutTest.vue'
import MyInfo from '../views/view/my/MyInfo.vue'
import Help from '../views/view/my/Help.vue'
import Exam from '../views/view/Exam.vue'
import ExamDetail from '../views/view/ExamDetail.vue'
import WrongList from '../views/view/WrongList.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'login',
    component: login
  },
  {
    path: '/user',
    name: 'Index',
    component: Index,
    meta: { allowBack: false },
    children: [
      {
        path: '',
        name: 'Exercise',
        component: Exercise
      },
      {
        path: 'Exercise',
        name: 'Exercise',
        component: Exercise
      },
      {
        path: 'Me',
        name: 'Me',
        component: Me
      }
    ]
  },
  {
    path: '/ChoiceQuestion',
    name: 'ChoiceQuestion',
    component: ChoiceQuestion
  },
  {
    path: '/ChoiceQuestion/:id',
    name: 'ChoiceQuestion',
    component: ChoiceQuestion,
    props: true
  },
  {
    // 错题
    path: '/ChoiceQuestion/Wrong/:wid',
    name: 'ChoiceQuestion',
    component: ChoiceQuestion,
    props: true
  },
  {
    // 错题
    path: '/ChoiceQuestion/:item',
    name: 'ChoiceQuestion',
    component: ChoiceQuestion,
    props: true
  },
  {
    path: '/JudgedQuestion',
    name: 'JudgedQuestion',
    component: JudgedQuestion
  },
  {
    path: '/JudgedQuestion/:id',
    name: 'JudgedQuestion',
    component: JudgedQuestion,
    props: true
  },
  {
    // 错题
    path: '/JudgedQuestion/Wrong/:wid',
    name: 'JudgedQuestion',
    component: JudgedQuestion,
    props: true
  },
  {
    // 错题
    path: '/JudgedQuestion/:item',
    name: 'JudgedQuestion',
    component: JudgedQuestion,
    props: true
  },
  {
    path: '/MultiplechoiceQuestion',
    name: 'MultiplechoiceQuestion',
    component: MultiplechoiceQuestion
  },
  {
    path: '/MultiplechoiceQuestion/:id',
    name: 'MultiplechoiceQuestion',
    component: MultiplechoiceQuestion,
    props: true
  },
  {
    // 错题
    path: '/MultiplechoiceQuestion/Wrong/:wid',
    name: 'MultiplechoiceQuestion',
    component: MultiplechoiceQuestion,
    props: true
  },
  {
    // 错题
    path: '/MultiplechoiceQuestion/:item',
    name: 'MultiplechoiceQuestion',
    component: MultiplechoiceQuestion,
    props: true
  },
  {
    path: '/DiscussQuestion',
    name: 'DiscussQuestion',
    component: DiscussQuestion
  },
  {
    path: '/DiscussQuestion/:id',
    name: 'DiscussQuestion',
    component: DiscussQuestion,
    props: true
  },
  {
    // 错题
    path: '/DiscussQuestion/Wrong/:wid',
    name: 'DiscussQuestion',
    component: DiscussQuestion,
    props: true
  },
  {
    // 错题
    path: '/DiscussQuestion/:item',
    name: 'DiscussQuestion',
    component: DiscussQuestion,
    props: true
  },
  {
    path: '/Wrong',
    name: 'Wrong',
    component: Wrong
  },
  {
    path: '/Chapter',
    name: 'Chapter',
    component: Chapter
  },
  {
    path: '/WrongList',
    name: 'WrongList',
    component: WrongList
  },
  {
    path: '/Recomand/:id',
    name: 'Recomand',
    component: Recomand
  },
  {
    path: '/login',
    name: 'login',
    component: login
  },
  {
    path: '/register',
    name: 'register',
    component: register
  },
  {
    path:'/AboutTest',
    name:'AboutTest',
    component:AboutTest
  },
  {
    path:'/MyInfo',
    name:'MyInfo',
    component:MyInfo
  },
  {
    path:'/Help',
    name:'Help',
    component:Help
  },
  {
    path:'/Exam',
    name:'Exam',
    component:Exam
  },
  {
    path: '/ExamDetail/:id',
    name: 'ExamDetail',
    component: ExamDetail,
    props: true
  }
]

const router = new VueRouter({
  routes
})

// 全局守卫
router.beforeEach((to,from,next)=>{
  if(to.path=='/login' || to.path=='/register'){
    next()
    return
  }
  // 必须登录之后在进行操作
  let arr = document.cookie.match(new RegExp('(^| )username=([^;]*)(;|$)'))
  let userInfo = undefined
  if (arr != null) {
    userInfo = unescape(arr[2])
  }
  if(userInfo){
    next()
    return
  }
  next('/login')
})

export default router
