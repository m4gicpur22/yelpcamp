var express = require("express"),
        app = express(),
 bodyParser = require("body-parser"),
   mongoose = require("mongoose"),
   passport = require("passport"),
   LocalStrategy = require("passport-local"),
   Campground = require("./models/campground"),
   methodoverride = require("method-override"),
   Comment = require("./models/comment"),
   User = require("./models/user"),
   seedDB = require("./seed")
   

mongoose.connect("mongodb://localhost:27017/yelp_camp", {useNewUrlParser: true});
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");
app.use(express.static(__dirname+ "/public"));
seedDB();


app.use(require("express-session")({
    secret: "Once again Rusty wins cutest dog!",
    resave: false,
    saveUninitialized: false
}));

app.use(passport.initialize());
app.use(passport.session());
passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

app.use(function(req, res, next){
    res.locals.currentUser = req.user;
    next();
});

//Landing Page Route
app.get("/", function(req,res){
    res.render("landing");
});
//Camoground Home Page route 
app.get("/campgrounds", function(req,res){
    Campground.find({}, function(err, campgrounds){
        if(err){
            console.log(err);
        }
        else {
            res.render("campgrounds/index", {campgrounds:campgrounds});
        }
    });
});

//New form for creating new campgrounds route
app.get("/campgrounds/new", isLoggedIn, function(req,res){
    res.render("campgrounds/new");
});
//Post route and creating new campgrounds
app.post("/campgrounds",isLoggedIn, function(req, res){
    var name = req.body.name;
    var image = req.body.image;
    var desc = req.body.description;
    var author = {
        id: req.user._id,
        username: req.user.username
    }
    var newCampground = {name: name, image: image, description: desc, author: author}
    Campground.create(newCampground, function(err, newlyCreated){
        
        if(err){
            console.log(err);
        }else {
            res.redirect("/campgrounds");
        }
    });
    
});

//More info route and page for campgrounds
app.get("/campgrounds/:id", function(req, res){
    
    Campground.findById(req.params.id).populate("comments").exec(function(err, foundCampground){
        if(err){
            console.log(err);
        }else {
            console.log(foundCampground);
            res.render("campgrounds/Show", {campground: foundCampground});
        }
    });
    
});
//Edit Info for campgrounds route
app.get("/campgrounds/:id/edit",checkCampgroundOwner, function(req ,res){
    
    if(req.isAuthenticated()){
        
    Campground.findById(req.params.id, function(err, foundCampground) {
            if(err){
            res.redirect("/campgrounds")
            }
            else{
            if(foundCampground.author.id.equals(req.user._id)){
                res.render("campgrounds/edit", {campground: foundCampground});
            }
            else
            console.log("Do not have permission to do that!")
            }
        });
        }
        else 
        {
        console.log("Need to be logged in to that!")
        }
    
    

});
//Post route for editing routes
app.put("/campgrounds/:id", function(req, res){
    
        Campground.findByIdAndUpdate(req.params.id, req.body.campground, function(err, updatedCampground){
            if(err){
                res.redirect("/campgrounds");
            } else {
                res.redirect("/campgrounds/" + req.params.id);
            }
        });
});

//Comment routes
app.get("/campgrounds/:id/comments/new", isLoggedIn, function(req, res){
    Campground.findById(req.params.id, function(err, campground){
        if(err){
            console.log(err);
        }
        else{
            res.render("comments/new", {campground: campground});
        }
    })
    
});
//Post route for creating new comments form
app.post("/campgrounds/:id/comments",isLoggedIn, function(req, res){
    Campground.findById(req.params.id, function(err, campground){
        if(err){
            console.log(err);
            res.redirect("/campgrounds");
        } else {
            Comment.create(req.body.comment, function(err, comment){
                if(err){
                    console.log(err);
                }else {
                    comment.author.id = req.user._id;
                    comment.author.username = req.user.username;
                    comment.save();
                    
                    campground.comments.push(comment);
                    campground.save();
                    res.redirect('/campgrounds/' + campground._id);
                }
            });
        }
    });
})

app.delete("/:id",checkCampgroundOwner, function(req ,res){
    
    Campground.findByIdAndRemove(req.params.id, function(err){
        if(err)
        {
            res.redirect("/campgrounds");   
        }
        else {
            res.redirect("/campgrounds");
        }
    });
});

//AUTH ROUTES

app.get("/register", function(req, res){
    res.render("register");
});

app.post("/register", function(req, res){
    User.register(new User({username: req.body.username}), req.body.password, function(err, user){
        if(err){
            console.log(err);
            return res.render("register")
        }
        passport.authenticate("local")(req, res, function(){
            res.redirect("/campgrounds");
        });
    });
});

app.get("/login", function(req ,res){
    res.render("login");
});

app.post("/login", passport.authenticate("local", 
    {
        successRedirect: "/campgrounds",
        failureRedirect: "/login"
    }), function(req, res){
});

app.get("/logout", function(req, res){
    req.logout();
    res.redirect("/campgrounds");
});

function isLoggedIn(req, res, next){
    if(req.isAuthenticated()){
        return next();
    }
    res.redirect("/login");
}

// function checkCampgroundOwner(){
    
// }

app.listen(3000, process.env.IP, function(){
    console.log("YelpCamp Server has started!")
});