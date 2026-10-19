cask "simreel" do
  version "0.2.0"
  sha256 "5a7295aa6e6f1e21abc6c1214d28086c5ada778d67c8f5422468050c6d7c6005"

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
