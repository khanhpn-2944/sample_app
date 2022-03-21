$("#micropost_image").bind("change", () => {
  let size_in_megabytes = this.files[0].size / 1024 / 1024;
  if (size_in_megabytes > Settings.const.image_size) {
    alert(I18n.t("shared.micropost_form.image_alert"));
  }
});
