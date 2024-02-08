document.addEventListener('DOMContentLoaded', function() {
const timelineData = [
    {
        date: 'January 2020 - Present',
        title: 'Network Infrastructure Engineer - Verizon',
        description: [
            'Delivered tier 1 and tier 2 escalation assistance for network, telecommunications, and security incidents; used an internal ticketing system to facilitate resolutions provided by Field Engineers and Central Office Technicians, maintaining 97% first-time resolution.',
            'Fine-tuned traffic management strategies using multi-protocol label switching and resource reservation protocol traffic engineering; efficiently allocating bandwidth to dynamically changing network conditions.',
            'Collaborated with management to design an on-the-job training manual for Associate Network Engineers.',
            'Performed BPON to GPON Optical Light Terminal decommissions and migrations.'
        ].join('\n')
    },
    {
        date: 'October 2017 - January 2020',
        title: 'Fios Technician - Verizon',
        description: [
            'Conducted on-site assessments to determine technical requirements and troubleshoot issues with Fios equipment',
            'Implemented network configurations and installed Fios broadband, TV, and phone services',
            'Collaborated with customers to educate them on Fios products, services, and troubleshooting techniques',
            'Performed ride-along training with new hire employees to demonstrate best practices',
            'Ensured compliance with safety protocols and company guidelines during installations and maintenance tasks'
        ].join('\n')
    },
    {
        date: 'November 2012 - January 2017',
        title: 'Retail Program Manager - AT&T',
        description: [
            'Improved inventory management in locations by requiring Store Managers to be involved in the inventory management process, while monitoring support staff. Resulting in an ROI of 14% reduction in shrink within 7 months.',
            'Traveled to store locations to perform mock audits, consisting of cash counts, inventory management, and documentation review to increase overall audit scores to 81% for the market.',
            'Championed device trade-in program initiatives to accelerate revenue by partnering with Federal/State/Local/Small business teams to reduce electronic waste by trading devices in for store credit towards billing and accessory purchases; increasing revenue stream by 300% in the first year implemented.'
        ].join('\n')
    },
    {
        date: 'October 2007 - November 2012',
        title: 'Retail Sales Manager, III - AT&T',
        company: 'AT&T',
        description: [
            'Led retail location to top retail location in Washington/Baltimore market in 2011, 2012, placing us top 2% of the company.',
            'Leveraged small business relationships, and entered into partnerships with State/Local sales teams to process sales orders in location and deliver same-day delivery of devices.',
            'Managed a diverse team of sales consultants, assistant managers, and inventory specialists for 5 years.',
            'Installed operations-focused initiatives in-store to improve audit scores; hired new inventory specialists to reduce shrink by focusing on proper merchandising and inventory management.'
        ].join('\n')
    }
    
    
];

    const timeline = document.getElementById('timeline');

    timelineData.forEach((item, index) => {
        let entry = document.createElement('div');
        entry.classList.add('timeline-entry');
        entry.setAttribute('id', 'entry-' + index);

        let dot = document.createElement('div');
        dot.classList.add('timeline-dot');

        let date = document.createElement('div');
        date.textContent = item.date;
        date.classList.add('timeline-date');

        let content = document.createElement('div');
        content.classList.add('timeline-content');
        content.setAttribute('id', 'content-' + index);

        let title = document.createElement('h3');
        title.textContent = item.title;

        let description = document.createElement('p');
        description.textContent = item.description;
        description.style.display = 'none'; // Initially hide the description

        // Click event to toggle the description visibility
        entry.addEventListener('click', function() {
            description.style.display = description.style.display === 'none' ? 'block' : 'none';
        });

        content.appendChild(title);
        content.appendChild(description);

        entry.appendChild(dot);
        entry.appendChild(date);
        entry.appendChild(content);

        timeline.appendChild(entry);
    });
});
