# accel-dance-party

Visualize the beat at which people at a party are dancing to using their phones' accelerometers.

This hack was whipped together at [Code+Beats](http://codeandbeats.com).

### To set up:

    # with node/npm, gulp, and bower installed globally
    npm install
    bower install
    gulp

### To run tests:

    # with mocha installed globally
    npm test

### To run server:

    npm start
    # optionally, to run on privileged port 80
    # sudo NODE_PORT=80 npm start

Then, with a mobile device, navigate to `http://[IP_ADDRESSS]/` and start dancing.

On the server or any other computer, pull up navigate to `http://[IP_ADDRESSS]/visualize.html` to show everyone's beats.
