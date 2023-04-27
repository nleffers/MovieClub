export default function authHeader() {
  const sessionId = localStorage.getItem('sessionId')

  if (sessionId) {
    return { 'X-AUTH-SESSION-ID': sessionId }
  } else {
    return {}
  }
}
