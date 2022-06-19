import Text "mo:base/Text";
import Float "mo:base/Float";

module {

    public type Course = {
        title: Text;
        topics: [Text];
        projects: [Text];
    };

    public type Track = {
        title: Text;
        courses: [Text];
        final_project: [Text];
    };

    public type Topic = {
        title: Text;
        objectives: [Text];
        intro: Text;
        // image: ?Blob;
        resources: [Text];
        assignments: [Text];
    };

    public type Assignment = {
        title: Text;
        details: Text;
        // image: ?Blob;
    };

    public type User = {
        id: Principal;
        enrolled: Text;
        progress: Float;
   };
}