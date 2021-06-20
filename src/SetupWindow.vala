/*
 * Copyright (c) 2021 The Photostat Project
 *
 * This file is part of Photostat.
 *
 * Photostat is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Photostat is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Photostat. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Abdallah "Abdallah-Moh" Mohammad <abdullah_mam1@icloud.com>
 *              Rajdeep "Suzie97" Singha <singharajdeep97@gmail.com>
 */

public class Photostat.SetupWindow : Gtk.Window {

    public SetupWindow (Photostat.Application photostat_app) {
        Object (
            height_request: 700,
            resizable: false,
            width_request: 950,
            window_position: Gtk.WindowPosition.CENTER_ALWAYS
        );

        // Handle dragging the entire widget
        button_press_event.connect ((event) => {
            if (event.button == Gdk.BUTTON_PRIMARY) {
                begin_move_drag ((int) event.button, (int) event.x_root, (int) event.y_root, event.time);
                return true;
            }
            return false;
        });
    }

    construct {
        get_style_context ().add_class ("rounded");
        build_ui ();
    }

    private void build_ui () {
        var headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        headerbar.get_style_context ().add_class ("flat");
        headerbar.get_style_context ().add_class ("default-decoration");

        set_titlebar (headerbar);

        var main_grid = new Gtk.Grid () {
            hexpand = true,
            margin = 0
        };

        headerbar.set_custom_title (main_grid);

        var app_icon = new Gtk.Image () {
            gicon = new ThemedIcon ("application-default-icon"),
            pixel_size = 128
        };

        var new_document_icon = new Gtk.Image () {
            gicon = new ThemedIcon ("document-new")
        };

        var file_manager_icon = new Gtk.Image () {
            gicon = new ThemedIcon ("system-file-manager")
        };

        var title_label = new Gtk.Label ("Photostat") {
            justify = Gtk.Justification.CENTER,
            hexpand = true
        };
        title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

        var subtitle_label = new Gtk.Label ("The Linux Photo Editing Tool") {
            justify = Gtk.Justification.CENTER,
            hexpand = true
        };
        subtitle_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        var options = new Gtk.Grid () {
            expand = true,
            margin = 12,
            orientation = Gtk.Orientation.VERTICAL,
            halign = Gtk.Align.CENTER,
            margin_top = 24
        };

        var empty_project_button = new Granite.Widgets.WelcomeButton (new_document_icon,
            "Create a new empty document", "Start working on a new image from scratch");

        empty_project_button.button_press_event.connect ((event) => {
            var window = new Photostat.Window (application as Photostat.Application);
            window.show_all ();
            destroy ();
            return false;
        });

        var file_dialog_button = new Granite.Widgets.WelcomeButton (file_manager_icon,
            "Browse images on your computer", "Open and edit an image file from your system");

        options.add (empty_project_button);
        options.add (file_dialog_button);

        var content = new Gtk.Grid () {
            expand = true,
            margin = 12,
            orientation = Gtk.Orientation.VERTICAL,
            valign = Gtk.Align.CENTER
        };

        content.add (app_icon);
        content.add (title_label);
        content.add (subtitle_label);
        content.add (options);

        add (content);
    }
}
