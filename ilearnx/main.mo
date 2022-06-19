import Types "./types";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";

shared({ caller = initializer }) actor class() = Ilearnx {
    private var tracks = HashMap.HashMap<Text, Types.Track>(100, Text.equal, Text.hash);
    private var courses = HashMap.HashMap<Text, Types.Course>(500, Text.equal, Text.hash);
    private var topics = HashMap.HashMap<Text, Types.Topic>(1000, Text.equal, Text.hash);
    private var assignments =HashMap.HashMap<Text, Types.Assignment>(5000, Text.equal, Text.hash);

    public query func getTrack(title: Text): async ?Types.Track {
        switch(tracks.get(title)){
            case null {
            };
            case (?track) {
                
                let new_track: Types.FullTrack =   
            };
        };
    };

    public shared({caller}) func addTrack(title: Text): async ?Bool {
        switch(tracks.get(title)) {
            case null {
                let track: Types.Track = {title=title; courses=[]; final_project=[]};
                tracks.put(title, track);
                true;
            };
            case (?t) {
                false;
            }
        };
    };

    // private func updateTrack(title: Text, courses: [Text], final_project: [Text]): async () {
    //     let track: Types.Track = {title=title; courses=courses; final_project=final_project};
    //     tracks.put(title, track);
    // };

    public shared({caller}) func addCourse(trackTitle: Text, courseTitle: Text): async ?Bool {
        switch(tracks.get(trackTitle)){
            case null {
                false;
            case (?track) {
                let newCourses = Array.append<Text>(track.courses, [courseTitle]);
                let newTrack: Types.Track = {title=track.title; courses=newCourses; final_project=track.final_project};
                tracks.put(trackTitle, newTrack);   
                true;
            };
        };
    };

    public shared({caller}) func addTopic(courseTitle: Text, title: Text, objectives: [Text], intro: Text, resources: [Text]): async ?Bool {
        switch(courses.get(courseTitle)){
            case null {
                false;
            };
            case (?course) {
                let newTopics = Array.append<Text>(course.topics, [title]);
                let newTopic: Types.Topic = {title=title; objectives=objectives; intro=intro; resources=resources; assignments=assignments};
                let newCourse: Types.Course = {title=course.title; topics=newTopics; projects=course.projects};
                topics.put(title, newTopic);
                courses.put(courseTitle, newCourse);  
                true;
            };
        };
    };

    public shared({caller}) func addFinalProject(trackTitle: Text, projectTitle: Text, projectDetails: Text): async ?Bool {
        switch(tracks.get(trackTitle)){
            case null {
                false
            };
            case (?track) {
                let {title; courses; final_project} = track;
                let newProjects = Array.append<Text>(final_project, [projectTitle]);
                let newTrack: Types.Track = {title=title; courses=courses; final_project=newProjects};
                let newProject: Types.Assignment = {title=projectTitle; details=projectDetails};
                assignments.put(projectTitle, newProject);
                tracks.put(trackTitle, newTrack);
                true;
            };
        };
    };
    
    public shared({caller}) func addAssignment(topicTitle: Text, assignmentTitle: Text, assignmentDetails: Text): async () {
        switch(topics.get(topicTitle)){
            case null {
            };
            case (?topic) {
                let newAssignments = Array.append<Text>(topic.assignments, [assignmentTitle]);
                let newTopic: Types.Topic = {title=topic.title; objectives=topic.objectives; intro=topic.intro; resources=topic.resources; assignments=newAssignments};
                let newAssignment: Types.Assignment = {title=assignmentTitle; details=assignmentDetails};
                assignments.put(assignmentTitle, newAssignment);
                topics.put(topicTitle, newTopic);   
            };
        };
    };
};

