from flask import Flask, render_template

# Method 1
# import urllib3
# http = urllib3.PoolManager()
# url = "https://my-tf-cerberus-bucket09112022.s3.us-west-2.amazonaws.com/home.html"
# resp = http.request('GET', url)
# Method 2
import urllib.request

app = Flask(__name__)

@app.route("/")
def home():
    # return render_template("home.html")
    # Method 1
    # return render_template(resp)
    # Method 2
    return render_template(urllib.request.urlopen("https://my-tf-cerberus-bucket09112022.s3.us-west-2.amazonaws.com/home.html"))
    
# @app.route("/about")
# def about():
#     return render_template("about.html")
    
if __name__ == "__main__":
    app.run(debug=True)