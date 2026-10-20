cask "simreel" do
  version "0.3.0"
  sha256 "42ac4d745f732f8d96fd5f0330c20dd98d77e3b61bf65d551f069792c60946b4"

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
