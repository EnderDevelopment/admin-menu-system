# Admin Menu System

A comprehensive admin menu system for FiveM servers.

## Features

- Teleport to waypoint
- Revive player
- Give item
- Kick player

## Requirements

- FiveM server
- ESX Framework
- MySQL

## Installation

1. Download the script.
2. Place the script in your FiveM server's resources folder.
3. Add `start admin-menu-system` to your server.cfg file.
4. Run the database.sql file to create the necessary database table.

## Usage

- Type `/adminmenu` in the chat to open the admin menu.

## Configuration

- Edit the `config.lua` file to change the command and permission settings.

## Permissions

- The admin menu is accessible to players with the 'admin' job.

## Commands

- `/adminmenu` - Opens the admin menu.

## Database

- The script logs admin commands to the `admin_menu` table in the database.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=admin-menu-system&utm_content=bottom) — describe it in one sentence and get the full source code.