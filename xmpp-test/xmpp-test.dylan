module: xmpp-test
synopsis: 
author: 
copyright: 

define function main(name :: <string>, #rest strings)
//  format-out("%=\n", prefix("foo:bar"));
//  format-out("%=\n", real-name("foo:bar"));
/*
  let jid = make(<jid>, domain: "foo");
  format-out("%=, %=, %=\n", jid.node, jid.domain, jid.resource);

  jid := make(<jid>, node: "a", domain: "b", resource: "c");
  format-out("%=, %=, %=\n", jid.node, jid.domain, jid.resource);

  jid := as(<jid>, "a@b/c");
  format-out("%=, %=, %=\n", jid.node, jid.domain, jid.resource);

  jid := as(<jid>, "a@b");
  format-out("%=, %=, %=\n", jid.node, jid.domain, jid.resource);
    
  jid := as(<jid>, "b");
  format-out("%=, %=, %=\n", jid.node, jid.domain, jid.resource);  
    
  format-out("%=\n", as(<string>, make(<jid>, domain: "b")));
  format-out("%=\n", as(<string>, make(<jid>, node: "a", domain: "b")));
  format-out("%=\n", as(<string>, make(<jid>, node: "a", domain: "b", resource: "c")));
  format-out("%=\n", as(<string>, make(<jid>, domain: "b", resource: "c")));
  
  format-out("%=\n", begin
                        as(<jid>, "b") = make(<jid>, domain: "b");
                      end);
  format-out("%=\n", begin
                        as(<jid>, "a@b") = make(<jid>, node: "a", domain: "b");
                      end);
  format-out("%=\n", begin
                        as(<jid>, "a@b/c") = make(<jid>, node: "a", domain: "b", resource: "c");
                      end);
  format-out("%=\n", begin
                        as(<jid>, "b/c") = make(<jid>, domain: "b", resource: "c");
                      end);

  let presence = make(<presence>);
  format-out("%=\n", presence);

  presence.type := #"foobar";
  format-out("%=\n", presence);
  
  presence.type := #"error";
  format-out("%=\n", presence);
  format-out("%=\n", presence.type);
  format-out("%=\n", presence.x);
  
  presence.show := "foobar";
  format-out("%=\n", presence);

  presence.show := "chat";
  format-out("%=\n", presence);

  presence.show := "dnd";
  format-out("%=\n", presence);
  format-out("%=\n", presence.show);

  
  format-out("%=\n", presence.status);
  presence.status := "Foo-Bar <3";
  format-out("%=\n", presence);
  format-out("%=\n", presence.status);

  presence.priority := 1;
  format-out("%=\n", presence); 
  format-out("%=\n", presence.priority);
  
  presence.to := make(<jid>, node: "alice", domain: "jabber.ccc.de", resource: "dylan");
  presence.from := "bob";  
  presence.id := "2342";

  let answer = answer(presence);
  format-out("%s %s %s\n", presence.to, presence.from, presence.id);
  format-out("%s %s %s\n", answer.to, answer.from, answer.id); 
  format-out("%=\n", presence);
  format-out("%=\n", answer);
    
  let foo = make(<element>, name: "foo1");
  let foo2 = make(<element>, name: "foo1");
  add-element(foo2, make(<element>, name: "foo2"));
  add-attribute(foo2, make(<attribute>, name: "a", value: "1"));
  add-attribute(foo2, make(<attribute>, name: "b", value: "2"));
  add-attribute(foo2, make(<attribute>, name: "c", value: "3"));
  add-attribute(foo, make(<attribute>, name: "d", value: "4"));
  add-attribute(foo, make(<attribute>, name: "a", value: "0"));
  format-out("%=\n", foo);
  format-out("%=\n", foo2);
  import-element(foo, foo2);
  format-out("%=\n", foo);

  let message = make(<message>, to: presence.to, body: "Hello, World"); 
  format-out("%=\n", message);

  let presence = make(<presence>);
  let presence-x = make(<x>);
  add-element(presence, presence-x);
  format-out("%=\n", presence.x);
  format-out("%=\n", object-class(presence.x));
  
  let presence = make(<presence>);
  let presence-x = make(<element>, name: "x");
  add-element(presence, presence-x);
  format-out("%=\n", presence.x);
  format-out("%=\n", object-class(presence.x));

  add-namespace(presence, "jabber:foo"); 
  format-out("%=\n", presence);

  let foobar = make(<element>, name: "foobar");
  add-attribute(foobar, make(<attribute>, name: "a", value: "1"));
  add-attribute(foobar, make(<attribute>, name: "a", value: "2"));
  format-out("%=\n", foobar);
  add-element(foobar, make(<element>, name: "foo"));
  add-element(foobar, make(<element>, name: "foo2"));
  add-element(foobar, make(<element>, name: "foo2"));
  add-element(foobar, make(<element>, name: "foo"));
  remove-element(foobar, "foo");
  format-out("%=\n", foobar);
  remove-element(foobar, "foo2", count: 1);
  format-out("%=\n", foobar);

  let iq = make(<iq>);
  format-out("%=\n", iq);
  iq.vcard := make(<element>, name: "vCard");
  format-out("%=\n", object-class(iq.vcard));
  iq.vcard := make(<vcard>);
  format-out("%=\n", object-class(iq.vcard));
  iq.query := make(<element>, name: "query");
  format-out("%=\n", object-class(iq.query));
  iq.query := make(<query>);
  format-out("%=\n", object-class(iq.query));
                    
  let iq2 = make(<iq>, vcard: make(<vcard>));
  format-out("%=\n", iq);

  let m = make(<message>);
  add-element(m, make(<element>, name: "foo1"));
  add-element(m, make(<element>, name: "foo2"));
  m.body := "Whooha!";
  m.subject := "Simple Test";
  format-out("%=\n", m);
  normalize(m);
  format-out("%=\n", m);

  let foo-stanza = make(<message>);
  let xxx = make(<element>, name: "x");
  add-element(foo-stanza, xxx);
  format-out("%=\n", object-class(first(foo-stanza.node-children)));
  format-out("%=\n", object-class(first(elements(foo-stanza, "x"))));

  let test-table = make(<table>);
  test-table[#"x"] := <x>;
  format-out("%=\n", test-table[#"x"]);
  let foox = #"x";
  format-out("%=\n", object-class(make(test-table[foox])));

  let superfluous-jid = make(<jid>, node: "turbo24prg", domain: "jabber.ccc.de", resource: "marvin");
  let cool-query = make-query(type: #"get", to: superfluous-jid);
  format-out("%=\n", cool-query);

  format-out("%=\n", make-authentication(make(<jid>, node: "turbo24prg", domain: "jabber.ccc.de"), "1337"));
  format-out("%=\n", make-authentication(superfluous-jid, "1337"));
  format-out("%=\n", make-registration(username: "turbo24prg", password: "foobar"));
  format-out("%=\n", make-registration(username: "turbo24prg"));
  format-out("%=\n", make-vcard(to: superfluous-jid));

  let ns-test = make(<element>, name: "foo:bar");
  add-attribute(ns-test, make(<attribute>, name: "xml:lang", value: "blah"));
  format-out("%=\n", ns-test);
 
  let stream = make(<xmpp-stream>);
  
  stream.version := "1.0";
  format-out("%=\n", stream);
  stream.version := "0.9";
  format-out("%=\n", stream);
  stream.version := make(<version>, major: 1, minor: 0);
  format-out("%=\n", stream);
  
  stream.version := "1.0";
  format-out("%= %= %=\n", stream.version, stream.version.major, stream.version.minor);
  stream.version := "0.9";
  format-out("%= %= %=\n", stream.version, stream.version.major, stream.version.minor);
  stream.version := "1";
  format-out("%= %= %=\n", stream.version, stream.version.major, stream.version.minor);

  let stream-error = make(<xmpp-stream-error>);
  stream-error.description := "Uff! Don't know?!";
  stream-error.condition := #"server-shutdown";
  format-out("%=\n", stream-error); 
  stream-error.condition := #"system-shutdown";
  format-out("%=\n", stream-error);
  stream-error.condition := #"policy-violation";
  stream-error.description := #f;
  format-out("%=\n", stream-error);

  let stanza-error = make(<xmpp-stanza-error>);
  stanza-error.description := "Boo!";
  stanza-error.type := #"continue"; 
  stanza-error.condition := #"unexpected-request";
  format-out("%=\n", stanza-error);

  let intl-message = make(<message>, body: "Dies ist ein Test.", to: superfluous-jid, language: "de");
  add-body(intl-message, "This is a test.", language: "en");
  add-body(intl-message, "C'est une test.", language: "fr");
  format-out("%=\n", intl-message);

  let test-document :: <document> = parse-document("<foo>Blub</foo>");
  format-out("%=\n", object-class(test-document.root));
  format-out("%=\n", test-document.node-children);

  let test-document :: <document> = parse-document("<foo>Blub</foo><foo2>Blob</foo2>");
  format-out("%=\n", object-class(test-document.root));
  format-out("%=\n", test-document.node-children);
  
*/

  let callback1 = make(<callback>, reference: #"default", priority: 3, handler: method (client, message)
    format-out("CCC (1) %= %=\n", client, message);
    if (message.body)
      send(client, make(<message>, to: message.from, type: #"chat", body: concatenate("You said: '", message.body, "'")));
    end if;
    #f;
  end);
/*
  let callback2 = make(<callback>, reference: #"default", priority: 2, handler: method (client, element)
    format-out("CCC (2) %= %=\n", client, element);
    #t;
  end);

  let callback3 = make(<callback>, reference: #"default", priority: 1, handler: method (client, element)
    format-out("CCC (3) %= %=\n", client, element);
    #f;
  end);
*/
  let client = make(<xmpp-client>, jid: make(<jid>, node: "dylan", domain: "pentabarf.org", resource: "xmpp"));

  add-callback(client, <message>, callback1);
//  add!(client.message-callbacks, callback1);
//  add!(client.message-callbacks, callback2);
//  add!(client.message-callbacks, callback3);
  
  let stream = make(<xmpp-stream>, to: client.jid.domain);
    
  block()
    if (~ connect(client, host: "benkstein.net", port: 4222))
      exit-application(1);
    end if;     
    format-out("Connected to xmpp server at %s port: %d\n", 
      client.socket.remote-host.host-name,
      client.socket.remote-port);
    authenticate(client, "test", #f);
    send(client, make(<presence>, priority: 23));
//    send(client, make(<message>, to: "ghul@jabber.org", type: #"chat", body: "This is turbot speaking, your friendly JabberBot written in Dylan."));
//    send(client, make(<message>, to: "ghul@jabber.org", type: #"chat", body: "I'll echo everything you say!"));
//    let result = send(client, make(<message>, to: "dylan@pentabarf.org/Psi", body: "This is turbot speaking."), awaits-result?: #t);
//    format-out("### (X3) %=\n", result);
//    while (#t)
//      sleep(23);
//    end while;

    join-thread(client.listener);
    disconnect(client);
    format-out("Connection closed.  Bye\n");
  cleanup
    disconnect(client);
  exception (condition :: <condition>)
    format-out("xmpp-test: Error: %=\n", condition);
  end block;
/*
  let foobar42 = make(<foo-stanza>);
  format-out("foo-id :: %=\n", object-class(foobar42.foo-id), foobar42.foo-id);
  foobar42.foo-id := "test";
  format-out("foo-id :: %=\n", object-class(foobar42.foo-id), foobar42.foo-id);

  format-out("foo-to :: %=\n", object-class(foobar42.foo-to), foobar42.foo-to);
  foobar42.foo-to := make(<jid>, node: "foo", domain: "bar");  
  format-out("foo-to :: %=\n", object-class(foobar42.foo-to), foobar42.foo-to);
  foobar42.foo-to := "foo@bar";
  format-out("foo-to :: %=\n", object-class(foobar42.foo-to), foobar42.foo-to);

  format-out("foo-type :: %=\n", object-class(foobar42.foo-type), foobar42.foo-type);
  foobar42.foo-type := #"test";
  format-out("foo-type :: %=\n", object-class(foobar42.foo-type), foobar42.foo-type);
  
  format-out("foo-language :: %=\n", object-class(foobar42.foo-language), foobar42.foo-language);
  foobar42.foo-language := "de";
  format-out("foo-language :: %=\n", object-class(foobar42.foo-language), foobar42.foo-language);

  format-out("foobar42 = %=\n", foobar42);
*/
  exit-application(0);
end function main;


// Invoke our main() function.
main(application-name(), application-arguments());
