Return-Path: <cgroups+bounces-8102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E126FAB11FB
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 13:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C124E519D
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B928F528;
	Fri,  9 May 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qudJN6VU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07D227EA1;
	Fri,  9 May 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789279; cv=none; b=BbqZSgGMJkL9lnJt4D8J5cGiUJxWZzeU5cYgwEOmyTxS8zeYr8zoVvjwNA3UEQ0jyQ7KrWJ+QjEt5h1JP2xLC41KrBajAdP7LjKhOLj9NsjsgRedwFE164L8ivxx284TZZcpcvuT7PX2BSMDJU88CW815B9E8NE449+oJAuiMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789279; c=relaxed/simple;
	bh=KTZKRIgBq5nNS9OGoTtD4NOVf0JN9GUbYI5KLF1xKW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IghGgGH2cFjx+KEgIVQtWso99gOS8eJ8M52tcu4tvD3AFHu+tQchE9rakVdlp+Oc6g//VrHI7aASkoUcOCB0B9vuhUOFn23WpjEWJLaLDp51A3kU28MLZa0//pN+nSxjYXhS0tsYgtjGP7DwEPgx+PqfBSgCpXcNU2sIKnY9OZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qudJN6VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32648C4CEE4;
	Fri,  9 May 2025 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746789279;
	bh=KTZKRIgBq5nNS9OGoTtD4NOVf0JN9GUbYI5KLF1xKW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qudJN6VUIgZLKX8SJvPhrQbrnWE5EMiHv92usyOpExWyIZqv8HylNQ6l9Kz3TnhDX
	 Qz3FMTUuOw7N4bFXGMdLnGNZBogGiSQMaR9j+1nnDd+UyrMwjT4e3Db6F8sHdo8b3W
	 HerD37NClhpjWMXuxCIOZSLbqxhieD+Do6+/Z3K12AjKDcGRYlwERBIWc/GGyWG5Mn
	 kLr2QDV43uZ0RAPNm5uWhXwsKbXf56UzoFg1YA9peclDi8i9QRx6PVnmJvVQBbCBNi
	 sJ1req3jhP7fLmyWLAWSGgAsaeCetNxVcUu4mYdk0woYAAn+eT+WoFAiGv5VZecczu
	 err/ehb1mJP/A==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Joel Savitz <jsavitz@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Minor namespace code simplication
Date: Fri,  9 May 2025 13:14:32 +0200
Message-ID: <20250509-lecken-erdreich-a321c3b13180@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508184930.183040-1-jsavitz@redhat.com>
References: <20250508184930.183040-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=brauner@kernel.org; h=from:subject:message-id; bh=KTZKRIgBq5nNS9OGoTtD4NOVf0JN9GUbYI5KLF1xKW8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTIPp6Vu2KDyW4J8Tlb/s7mzcsSvPal+lKwk4Zm3r9KW 3Uu86PfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiG8/w3yvPaJFPlUPMRv5r qYce/We/594c4HRJe0vLxF/OZsY7lRj+Z15awVmYNyulhlfKtEA++Xyy2LwzvLLZfXxMyh+nxmT yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 May 2025 14:49:28 -0400, Joel Savitz wrote:
> The two patches are independent of each other. The first patch removes
> unnecssary NULL guards from free_nsproxy() and create_new_namespaces()
> in line with other usage of the put_*_ns() call sites. The second patch
> slightly reduces the size of the kernel when CONFIG_CGROUPS is not
> selected.
> 
> Joel Savitz (2):
>   kernel/nsproxy: remove unnecessary guards
>   include/cgroup: separate {get,put}_cgroup_ns no-op case
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/2] kernel/nsproxy: remove unnecessary guards
      https://git.kernel.org/vfs/vfs/c/5caa2d89b7f1
[2/2] include/cgroup: separate {get,put}_cgroup_ns no-op case
      https://git.kernel.org/vfs/vfs/c/79fb8d8d93e4

