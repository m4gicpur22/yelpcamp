var express = require("express"),
        app = express(),
 bodyParser = require("body-parser"),
   mongoose = require("mongoose"),
   Campground = require("./models/campground"),
   Comment = require("./models/comment"),
   seedDB = require("./seed")

mongoose.connect("mongodb://localhost:27017/yelp_camp", {useNewUrlParser: true});
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");
seedDB();


app.get("/", function(req,res){
    res.render("landing");
});

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

app.post("/campgrounds", function(req, res){
    var name = req.body.name;
    var image = req.body.image;
    var desc = req.body.description;
    var newCampground = {name: name, image: image, description: desc}
    Campground.create(newCampground, function(err, newlyCreated){
        
        if(err){
            console.log(err);
        }else {
            res.redirect("/campgrounds");
        }
    });
    
});

app.get("/campgrounds/new", function(req,res){
    res.render("campgrounds/new");
});

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
//Comment routes
app.get("/campgrounds/:id/comments/new", function(req, res){
    Campground.findById(req.params.id, function(err, campground){
        if(err){
            console.log(err);
        }else{
            res.render("comments/new", {campground: campground});
        }
    })
    res.render("comments/new");
});

app.post("/campgrounds/:id/comments", function(req, res){
    Campground.findById(req.params.id, function(err, campground){
        if(err){
            console.log(err);
            res.redirect("/campgrounds");
        } else {
            Comment.create(req.body.comment, function(err, comment){
                if(err){
                    console.log(err);
                }else {
                    campground.comments.push(comment);
                    campground.save();
                    res.redirect('/campgrounds' + campground._id);
                }
            })
        }
    })
})

app.listen(process.env.PORT, process.env.IP, function(){
    console.log("YelpCamp Server has started!");
});