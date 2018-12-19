# It was maintained in https://github.com/Homebrew/homebrew-core/blob/master/Formula/kompose.rb
# However, this version will only download the release from official repo
class Kompose < Formula
  desc "Go from Docker Compose to Kubernetes"
  homepage "https://github.com/kubernetes/kompose"


  url "https://github.com/kubernetes/kompose/releases/download/v1.17.0/kompose-darwin-amd64.tar.gz"
  # mirror "https://xxx/v1.17.0/kompose-darwin-amd64.tar.gz"
  sha256 "4e409aeedea1be57e2f6613586d1b04aa2d97e9bceaea7cd1e36e744c54bafdc"


  def install
    mkdir_p buildpath/"bin"
    ln_s buildpath/"kompose-darwin-amd64", buildpath/"bin/kompose"
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
