# It was maintained in https://github.com/Homebrew/homebrew-core/blob/master/Formula/kompose.rb
# However, this version will only download the release from official repo
# See: https://git.io/fpjD5
class Kompose < Formula
  desc "Go from Docker Compose to Kubernetes"
  homepage "https://github.com/kubernetes/kompose"


  url "https://github.com/kubernetes/kompose/archive/v1.26.1.zip"
  # mirror "https://xxx/v1.18.0/v1.18.0.zip"
  sha256 "6c19865fa7abe6a346afd9e258956877c6d60cd881f3c96f93654095c265965b"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/kubernetes"
    ln_s buildpath, buildpath/"src/github.com/kubernetes/kompose"
    system "make", "bin"
    bin.install "kompose"

    output = Utils.popen_read("#{bin}/kompose completion bash")
    (bash_completion/"kompose").write output

    output = Utils.popen_read("#{bin}/kompose completion zsh")
    (zsh_completion/"_kompose").write output
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kompose version")
  end

end

__END__
