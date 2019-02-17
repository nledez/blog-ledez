---
title: ANAVI Light Controller, Sonoff-Tasmota & Domoticz in a boat
lang: en
layout: post
permalink: /iot/anavi-light-controller-sonoff-tasmota-domoticz-in-a-boat/
categories:
  - iOT
tags:
  - iOT
  - ESP
  - Domoticz
excerpt_separator: <!--more-->
---

I already have a [Domoticz](https://domoticz.com/) install with [Sonoff](https://www.itead.cc/smart-home/sonoff-wifi-wireless-switch-1.html) stuff & [Tasmota firmware](https://github.com/arendst/Sonoff-Tasmota).

I manage power for:
- My [Octopi](https://octoprint.org/)
- My 3d printer

But webcam doesn't work during the night. I have an [ANAVI Light Controller](https://www.crowdsupply.com/anavi-technology/light-controller) to fix this.

I want this in Domoticz:

![Use in Domoticz]({{ site.url }}/images/2019/02/17/domoticz_use.png)

<!--more-->

If you want the same, you can do it with this configuration:

Open “Configuration” / “Configure module” it must look like this:

![Configure module]({{ site.url }}/images/2019/02/17/tasmota_config_module.png)

In Domoticz configure a MQTT Gateway, search on the Internet to find out how to do it.

![MQTT Gateway in Domoticz]({{ site.url }}/images/2019/02/17/domoticz_mqtt_gateway.png)

Now click on "Create Virtual Sensors"

![Create Virtual Sensors]({{ site.url }}/images/2019/02/17/domoticz_create_virtual_sensor.png)

Now available in devices view:

![Create Virtual Sensors]({{ site.url }}/images/2019/02/17/domoticz_create_virtual_sensor.png)

Note the "Idx" for later and return to Tasmota configuration "Configure Domoticz" part:

![Configure Domoticz]({{ site.url }}/images/2019/02/17/tasmota_config_domoticz.png)

Put the "Idx" from Domoticz into "Idx 1".

Now you can change state and color in Domoticz:

![Use in Domoticz]({{ site.url }}/images/2019/02/17/domoticz_use.png)

And voilà!
