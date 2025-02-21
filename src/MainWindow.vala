/*
 * SPDX-License-Identifier: GPL-3.0
 * SPDX-FileCopyrightText: 2025 Cassidy James Blaede <c@ssidyjam.es>
 */

[GtkTemplate (ui = "/com/cassidyjames/vibes/ui/main.ui")]
public class MainWindow : Adw.ApplicationWindow {

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
        flowbox.child_activated.connect ((child) => {
            GLib.File? file = ((Gtk.Picture) child.child).get_file ();
            var portal = new Xdp.Portal.initable_new ();
            portal.set_wallpaper.begin (Xdp.parent_new_gtk (this), file.get_uri (), Xdp.WallpaperFlags.BACKGROUND, null, (obj, res) => {
                try {
                    portal.set_wallpaper.end (res);
                } catch (GLib.Error e) {
                    warning ("Failed to set wallpaper: %s", e.message);
                }
            });
        });
    }

    public void add_picture (string file_path) {
        Idle.add (() => {
            // FIXME: Annoyed that this is not seeming to work how I want.
            // Maybe need to generate a thumbnail of a fixed size? Probably…
            var picture = new Gtk.Picture.for_filename (file_path) {
                can_shrink = true,
                content_fit = Gtk.ContentFit.COVER,
                halign = Gtk.Align.CENTER,
                height_request = THUMB_HEIGHT,
                valign = Gtk.Align.CENTER,
                width_request = THUMB_WIDTH,
            };

            flowbox.append (picture);
            return false;
        }, GLib.Priority.DEFAULT);
    }

}
