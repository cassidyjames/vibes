/*
 * SPDX-License-Identifier: GPL-3.0
 * SPDX-FileCopyrightText: 2025 Cassidy James Blaede <c@ssidyjam.es>
 */

[GtkTemplate (ui = "/com/cassidyjames/vibes/ui/main.ui")]
public class MainWindow : Adw.ApplicationWindow {
    // FIXME: Obvs this is terrible; consider ALL of this code a throw-away
    // proof of concept to play with the UI :)
    private const string RESOURCE_ROOT = "/com/cassidyjames/vibes/wallpapers/";

    private const int THUMB_HEIGHT = 180;
    private const int THUMB_WIDTH = 320;

    public MainWindow (Adw.Application app) {
        Object (
            application: app
        );
    }

    [GtkChild]
    unowned Gtk.FlowBox flowbox;

    construct {
        try {
            foreach (string wallpaper in GLib.resources_enumerate_children (RESOURCE_ROOT, GLib.ResourceLookupFlags.NONE)) {
                // FIXME: Annoyed that this is not seeming to work how I want.
                // Maybe need to generate a thumbnail of a fixed size? Probably…
                var picture = new Gtk.Picture.for_resource (RESOURCE_ROOT + wallpaper) {
                    can_shrink = true,
                    content_fit = Gtk.ContentFit.COVER,
                    halign = Gtk.Align.CENTER,
                    height_request = THUMB_HEIGHT,
                    valign = Gtk.Align.CENTER,
                    width_request = THUMB_WIDTH,
                };
    
                flowbox.append (picture);
            }
        } catch (GLib.Error e) {
            // TODO: Properly handle this
            print (e.message);
        }
    }
}
