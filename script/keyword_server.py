import cgi
import nltk
import re
import string
import BaseHTTPServer
import urllib

class KeywordServer(BaseHTTPServer.BaseHTTPRequestHandler):
  def do_POST(s):
    ctype, pdict = cgi.parse_header(s.headers.getheader('content-type'))
    contentlength = string.atoi(s.headers.getheader('content-length')) 
    input_data = s.rfile.readline(contentlength)
    s.send_response(200)
    s.send_header("Content-type", "text/plain")
    s.end_headers()
    s.wfile.write(':'.join(get_keywords(urllib.unquote(input_data.strip('=')))))
    
def get_keywords(string):
  tags = nltk.pos_tag(nltk.word_tokenize(string))
  print tags
  keywords = []
  current = []
  for s in tags:
    word, tag = s
    if tag != 'NN' and tag != 'NNS':
      if len(current) > 0:
        keywords.append(' '.join(current))
        current = []
      continue
    current.append(re.sub('[^A-Za-z-]', '', word.lower()))
    if re.search('[^a-zA-Z-]', word):
      keywords.append(' '.join(current))
      current = []

  return keywords
  
# print get_keywords("When you stop at the bus stop, you should hail a bus.")
def main():
  server = BaseHTTPServer.HTTPServer(('localhost', 8000), KeywordServer)
  server.serve_forever()
  
if __name__ == '__main__':
  main()
