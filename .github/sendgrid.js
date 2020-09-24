#! /usr/bin/env node

const fs = require('fs')
const sgMail = require('@sendgrid/mail')
sgMail.setApiKey(process.env.SENDGRID_API_KEY)

const filepath = process.env.DBT_LOG_PATH
const data = fs.readFileSync(filepath)
const msg = {
    to: process.env.SENDGRID_TO,
    from: process.env.SENDGRID_FROM,
    subject: `DBT run: ${process.env.DBT_RUN_STATE} for ${process.env.GITHUB_REPOSITORY}`,
    text: 'Hello plain world!',
    html: `
       <p>The results are in: <b>${process.env.DBT_RUN_STATE === "passed" ? "Oh yeah, the DBT run passed" : "Oh no. It's a fail. What happened?"}</b></p>
       <pre>${data.toString()}</pre>
       <p>View run details in your <a href="https://github.com/${process.env.GITHUB_REPOSITORY}/actions/runs/${process.env.GITHUB_RUN_ID}">${process.env.GITHUB_REPOSITORY}</a> repo.</p>
       `,
};

sgMail
.send(msg)
.then(() => console.log('Mail sent successfully'))
.catch(error => console.error(error.toString()));