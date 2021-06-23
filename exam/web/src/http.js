import axios from 'axios'

const http = axios.create({
  // axios 配置
  timeout: 60000,
  baseURL: 'http://localhost:6500/web/api'
})

export default http
