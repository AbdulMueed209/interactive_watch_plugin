📦 Watch Plugin for Oracle APEX
🔭 Overview

Watch is an Oracle APEX plugin that adds a real-time watch/clock component to your APEX applications.
It enables developers to easily include customizable analog clocks within APEX pages with minimal configuration.

This plugin integrates cleanly with Oracle APEX, supports timezone handling, and provides automatic updates, making it ideal for dashboards, monitoring pages, time-based displays, and interactive interfaces.

<img width="370" height="398" alt="image" src="https://github.com/user-attachments/assets/b02a9866-331f-4d03-9e5d-1a46d0f7d75c" />


🚀 Features

🕒 Real-time Clock Display
Shows hours, minutes, and seconds based on client/browser time or specified timezone.

🌍 Timezone Support
Can be configured to display time for different timezones dynamically.

📌 Easy Integration
Just install the plugin and use it in any region or form on your APEX page.

⚡ Responsive and Lightweight
Uses pure JavaScript and SVG to keep performance optimal.

🎨 Customizable Appearance
Supports analog styles, digital formats, and CSS styling.

📦 Installation

Import the plugin into your APEX application:

Shared Components → Plug-Ins → Import

Navigate to the page where you want to use the Watch.

Add a region and select the Watch plugin type.

Configure attributes such as timezone, size, and style.

🧠 Usage

Once installed:

Place the plugin region where the clock should appear.

Set optional attributes such as:

Timezone (e.g., Asia/Karachi)

Style Options (size, color, analog/digital)

Auto refresh interval

Run the page — the clock updates every second.

🛠 Requirements

Oracle APEX 24.2.11 (or higher)

ORDS deployed to serve APEX apps

JavaScript enabled in browser

💡 Tips

For timezone support, use standard IANA timezone identifiers (e.g., America/New_York).

Customize the clock styles with CSS in the page template or region attributes.

❤️ Contributing

Feel free to open issues or submit pull requests if you’d like to:

Add new styles (digital/analog variants)

Add localized formats

Improve timezone support

📄 License

This project is open-source under the MIT License.
