from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import json
from datetime import datetime
import os
from werkzeug.utils import secure_filename
import math


with open('config.json', 'r') as c:
    params = json.load(c)["params"]
local_server = True
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.secret_key = 'A-Really_secret_key'
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='587',
    MAIL_USE_TLS=True,
    MAIL_USERNAME= params['gmail_user'],
    MAIL_PASSWORD= params['gmail_password']
)
mail = Mail(app)
if local_server:
    app.config["SQLALCHEMY_DATABASE_URI"] = params['local_uri']
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params['prod_uri']
db = SQLAlchemy(app)


class Contacts(db.Model):
    # sno, name, email, ph_number, msg, date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    ph_number = db.Column(db.String, nullable=False)
    msg = db.Column(db.String, nullable=False)
    date = db.Column(db.String)


class Posts(db.Model):
    # sno, name, email, ph_number, msg, date
    sno = db.Column(db.Integer, primary_key=True)
    img_file = db.Column(db.String)
    title = db.Column(db.String, nullable=False)
    tag_line = db.Column(db.String, nullable=False)
    slug = db.Column(db.String, nullable=False)
    content = db.Column(db.String, nullable=False)
    posted_by = db.Column(db.String, nullable=False)
    date = db.Column(db.String)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil((len(posts))/int(params['no_of_posts']))
    # [0:params['no_of_posts']]

    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    #Pagination Logic
    #First
    if page == 1:
        prev = '#'
        next_page = "/?page=" + str(page + 1)
    elif page == last:
        prev = "/?page=" + str(page - 1)
        next_page = '#'
    else:
        prev = "/?page=" + str(page - 1)
        next_page = "/?page=" + str(page + 1)
    # previous = #
    # next = page + 1
    # #Middle
    # previous = page - 1
    # next = page + 1
    # #Last
    # previous = page - 1
    # next = #

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next_page)


@app.route("/about")
def about():
    return render_template('about.html', params=params)


@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":           # Add Entry of data to the database
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        # sno, name, email, ph_number, msg, date
        entry = Contacts(name=name, email=email, ph_number=phone, msg=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message(f'New message from {name}', sender=email, recipients=params['gmail_user'], body=message + "\n"+ phone)

    return render_template('contact.html', params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()

    return render_template('post.html', params=params, post=post)


@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():

    if 'user' in session and session['user'] == params['admin_id']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        user_password = request.form.get('pass')    # Redirect to admin panel
        if username == params['admin_id'] and user_password == params['admin_password']:
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html', params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_id']:
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            posted_by = request.form.get('name')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno == '0':
                post = Posts(title=box_title, slug=slug, content=content, posted_by=posted_by, tag_line=tline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.posted_by = posted_by
                post.tag_line= tline
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/' + sno)

        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post)


@app.route("/uploader", methods=["GET", "POST"])
def uploader():
    if 'user' in session and session['user'] == params['admin_id']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return redirect('/dashboard')


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_id']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


app.run(debug=True)
