import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Nat "mo:base/Nat";


actor NewEvent{
  type EventId = Nat;

  type Event = {
    id: EventId;
    convener: Convener; 
    venue: Venue;
    season: Season;
  };

  type Convener = {
    name: Text;
    gender: Gender;
    occupation: Text;
  };

  type Gender = {
    #Male;
    #Female;
    #Others;
  };

  type Venue ={
    #Stadium;
    #Garden;
    #Beach;
    #Hall;
  };

  type Season = {
    #Summer;
    #Winter
  };

  // create event DB and init to 0
  var eventDB = Buffer.Buffer<Event>(0);
  var nextEventId: EventId = 1;

  // register an event
  public func registerEvent(event: Event): async Text{
    let newEvent = {
      id = nextEventId;
      convener = event.convener;
      venue = event.venue;
      season = event.season;
    };

    let _ = eventDB.add(newEvent);
    nextEventId += 1;
    return "Event has been added with ID #" # Nat.toText(newEvent.id);
  };

  // number of events
  public query func noOfEvents(): async Nat {
    return eventDB.size();
  };

  //query all events
   public query func getAllEvents(): async ?Event {
    let events = Buffer.toArray(eventDB);
    for (event in events.vals()) {
      return ?event;
    };
    return null;
  };

  // query event by season
  public query func getEventsBySeason(season: Season): async ?Event {
    let events = Buffer.toArray(eventDB);
    for (event in events.vals()) {
      if(event.season == season) {
        return ?event; 
      };  
    };
    return null;
  };

  // query event by venue
  public query func getEventsByVenue(venue: Venue): async ?Event {
    let events = Buffer.toArray(eventDB);
    for (event in events.vals()) {
      if(event.venue == venue) {
        return ?event; 
      };  
    };
    return null;
  };

   // query event by id
  public query func getEventsById(id: Nat): async ?Event {
    let events = Buffer.toArray(eventDB);
    for (event in events.vals()) {
      if(event.id == id) {
        return ?event; 
      };  
    };
    return null;
  };

  // query event by gender of convener
   public query func getEventsByConvenerGender(gender: Gender): async [Event] {
    let events = Buffer.toArray(eventDB);
    return Array.filter<Event>(events, func (event) : Bool {
      event.convener.gender == gender
    });
  };

  //query event by name of convener  
  public query func getEventsByConvenerName(name: Text): async [Event] {
    let events = Buffer.toArray(eventDB);
    return Array.filter<Event>(events, func (event) : Bool {
      event.convener.name == name;
    });
  };

  //query event by occupation of convener  
  public query func getEventsByConvenerOccupation(occupation: Text): async [Event] {
    let events = Buffer.toArray(eventDB);
    return Array.filter<Event>(events, func (event) : Bool {
      event.convener.occupation == occupation;
    });
  };
  

};
