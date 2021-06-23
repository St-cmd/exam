import axios from 'axios'

const http = axios.create({
  // axios 配置
  timeout: 60000,
  baseURL: 'http://localhost:6500/admin/api'
})

http.interceptors.response.use(res => {
  return res
}, err => {
  console.log(err.response.data)
  return Promise.reject(err)
})

export default http
