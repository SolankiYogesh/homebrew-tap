cask "simreel" do
  version "0.1.0"
  sha256 "34b8e41838d15d8c24737d8b85ed4d051db519768dd3492f52ddd922cdff6dec"

  url "https://github.com/SolankiYogesh/simreel/releases/download/v#{version}/SimReel-#{version}-arm64.dmg"
  name "SimReel"
  desc "Camera for the iOS Simulator: feed images, video, QR codes or a webcam to apps"
  homepage "https://solankiyogesh.github.io/simreel/"

  livecheck do
    url :url
    strategy :github_latest
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
