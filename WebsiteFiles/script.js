// script.js

document.addEventListener('DOMContentLoaded', function () {
    // Dummy data for employment history (replace with your actual data)
    const employmentData = [
        { year: '2022', position: 'Web Developer', company: 'Company A' },
        { year: '2019', position: 'Front-end Developer', company: 'Company B' },
        // Add more entries as needed
    ];

    const employmentTimeline = document.getElementById('employment-timeline');

    // Populate employment timeline dynamically
    employmentData.forEach(entry => {
        const timelineEvent = document.createElement('div');
        timelineEvent.classList.add('timeline-event');

        const eventContent = document.createElement('div');
        eventContent.classList.add('timeline-event-content');
        eventContent.innerHTML = `<p>${entry.year}</p><p>${entry.position} at ${entry.company}</p>`;

        timelineEvent.appendChild(eventContent);
        employmentTimeline.appendChild(timelineEvent);
    });
});
