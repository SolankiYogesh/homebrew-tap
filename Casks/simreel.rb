cask "simreel" do
  version "0.2.1"
  sha256 "1cb95811317b20d214a5ba8b358af8c0791bf9087580d5e3388a9bb003cf711f"

  url "https://solankiyogesh.github.io/simreel/download/v#{version}/SimReel-#{version}-arm64.dmg"
  name "SimReel"
  desc "Camera for the iOS Simulator: feed images, video, QR codes or a webcam to apps"
  homepage "https://solankiyogesh.github.io/simreel/"

  livecheck do
    url "https://solankiyogesh.github.io/simreel/download/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "SimReel.app"
  binary "#{appdir}/SimReel.app/Contents/Helpers/simreel"

  # Release builds are signed ad hoc rather than notarized, so clear the quarantine flag
  # to let the app open without the "cannot be verified" prompt.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SimReel.app"]
  end

  caveats <<~EOS
    SimReel needs Xcode with the iOS Simulator installed.
    Open SimReel, then run your app in a simulator. Relaunch apps that were already running.

    The command-line tool is available as `simreel`.
  EOS
end
