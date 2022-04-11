/* window.vala
 *
 * Copyright 2022 Alex
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Easter {
	[GtkTemplate (ui = "/com/github/alexkdeveloper/easter/window.ui")]
	public class Window : Gtk.ApplicationWindow {
	    [GtkChild]
	    private unowned Gtk.Button start_browser;
		[GtkChild]
		private unowned Gtk.Entry year;
		[GtkChild]
		private unowned Gtk.Button calculate;
		[GtkChild]
		private unowned Gtk.Label result;

		public Window (Gtk.Application app) {
			Object (application: app);
			year.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
            year.icon_press.connect ((pos, event) => {
          if (pos == Gtk.EntryIconPosition.SECONDARY) {
              year.set_text("");
              year.grab_focus();
           }
        });
		calculate.clicked.connect(on_calculate);
		start_browser.clicked.connect(on_start_browser_clicked);
		add_shortcut();
		}
		private void on_calculate(){
		   if(year.get_text().strip().length == 0){
             alert("Enter the year number");
             year.grab_focus();
             return;
           }
             int y = int.parse(year.get_text());
             if(y <= 0){
                 alert("Please enter a valid year number");
                 year.grab_focus();
                 return;
             }
             int a = y % 19;
             int b = y % 4;
             int c = y % 7;
             int k = y / 100;
             int p = (13 + 8 * k) / 25;
             int q = k / 4;
             int M = (15 - p + k - q) % 30;
             int N = (4 + k - q) % 7;
             int d = (19 * a + M) % 30;
             int e = (2*b + 4*c + 6*d + N) % 7;
             int f = d + e;
             int g;
             string h;
             if(f <= 9){
                 g = 22 + d + e;
                 h = "March";
             }else{
                 g = d + e - 9;
                 h = "April";
             }
             if(d == 29 && e == 6){
                 g = 19;
             }else if(d == 28 && e == 6){
                 g = 18;
             }
             result.set_text(h+" "+g.to_string());
		}
        private void add_shortcut () {
           key_press_event.connect ((e) => {
           switch (e.keyval) {
              case Gdk.Key.KP_Enter:
                 if (e.state != 0) {
                    on_calculate();
                 }
                 break;
            }
            return false;
          });
        }
	    private void on_start_browser_clicked(){
            var start_browser_dialog = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL,Gtk.MessageType.QUESTION, Gtk.ButtonsType.OK_CANCEL, "Do you want to visit Wikipedia?");
            start_browser_dialog.set_title("Question");
            Gtk.ResponseType result = (Gtk.ResponseType)start_browser_dialog.run ();
            start_browser_dialog.destroy();
            if(result==Gtk.ResponseType.OK){
            try{
               Gtk.show_uri_on_window(this, "https://en.wikipedia.org/wiki/Easter", Gdk.CURRENT_TIME);
             }catch(Error e){
                alert("Error!\n"+e.message);
            }
          }
        }
		private void alert (string str){
          var dialog_alert = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, str);
          dialog_alert.set_title("Message");
          dialog_alert.run();
          dialog_alert.destroy();
       }
	}
}
