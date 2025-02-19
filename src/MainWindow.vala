/*
 * SPDX-License-Identifier: GPL-3.0
 * SPDX-FileCopyrightText: 2025 Cassidy James Blaede <c@ssidyjam.es>
 */

[GtkTemplate (ui = "/com/cassidyjames/vibes/ui/main.ui")]
public class MainWindow : Adw.ApplicationWindow {
    // FIXME: Obvs this is terrible; consider ALL of this code a throw-away
    // proof of concept to play with the UI :)
    private const string[] WALLPAPERS = {
        "photo-1464491965784-a12f0f70642b.jpg",
        "photo-1470209595850-551a2d564b09.jpg",
        "photo-1470698416516-70c8af45a6b6.jpg",
        "photo-1474971947157-c74e142a326c.jpg",
        "photo-1475724017904-b712052c192a.jpg",
        "photo-1475817712127-ef4cd1556aff.jpg",
        "photo-1476390290743-c2eefe11aa35.jpg",
        "photo-1477322524744-0eece9e79640.jpg",
        "photo-1477570919400-3daf71ede383.jpg",
        "photo-1477907961416-f44287c1ef83.jpg"
    };

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
        foreach (string wallpaper in WALLPAPERS) {

            // FIXME: Annoyed that this is not seeming to work how I want.
            // Maybe need to generate a thumbnail of a fixed size? Probably…
            var picture = new Gtk.Picture.for_resource ("/com/cassidyjames/vibes/wallpapers/" + wallpaper) {
                can_shrink = true,
                content_fit = Gtk.ContentFit.COVER,
                halign = Gtk.Align.CENTER,
                height_request = THUMB_HEIGHT,
                valign = Gtk.Align.CENTER,
                width_request = THUMB_WIDTH,
            };

            flowbox.append (picture);
        }

    }
}
