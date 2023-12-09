Return-Path: <cgroups+bounces-907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F180B143
	for <lists+cgroups@lfdr.de>; Sat,  9 Dec 2023 02:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A6E281B3B
	for <lists+cgroups@lfdr.de>; Sat,  9 Dec 2023 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADC80A;
	Sat,  9 Dec 2023 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfPuBcxS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB110E4;
	Sat,  9 Dec 2023 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5438CC433C9;
	Sat,  9 Dec 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084226;
	bh=TwH755jRSBgjNePpnuKfZBUcjeEnxds/A9k2QXRc5zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sfPuBcxSv38g+KaciI0+iSEi6g4OOVnaOapj+IVXXgpA4mlOr9HzguvDaJkihhNtR
	 bHl9i2ONac7KOMYBZOaco4VggVtAgXLLrQ0vyXRGrLu4dZphv22pXUzxKmaQCii8uu
	 8MWuHroJ/sIWwp6aWWt/4jup34P6UOFiwiqNltXF7EBcKTQY+Rs3gXy8n26sQLnhk0
	 yhF0Vd1Pg+wFUp2K04wPxS3MjjKK2klwHh0nZhhPFF1L+O9T/rFZL1+xa2pgFsCYyF
	 mpeGUpsYXE+hELyS6LBEum5Cp2Q/jWpEVQfJggBz+7Ihi+ACkJUODKs7SDsTtPTxc9
	 8l9kn1uzK0ERA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3876FDD4F1E;
	Sat,  9 Dec 2023 01:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support cgroup1
 non-attach case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208422622.13123.9169761894176806854.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:10:26 +0000
References: <20231206115326.4295-1-laoar.shao@gmail.com>
In-Reply-To: <20231206115326.4295-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org,
 cgroups@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Dec 2023 11:53:23 +0000 you wrote:
> In the current cgroup1 environment, associating operations between a cgroup
> and applications in a BPF program requires storing a mapping of cgroup_id
> to application either in a hash map or maintaining it in userspace.
> However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible to
> conveniently store application-specific information in cgroup-local storage
> and utilize it within BPF programs. Furthermore, enabling this feature for
> cgroup1 involves minor modifications for the non-attach case, streamlining
> the process.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
    https://git.kernel.org/bpf/bpf-next/c/73d9eb340d2b
  - [bpf-next,2/3] selftests/bpf: Add a new cgroup helper open_classid()
    https://git.kernel.org/bpf/bpf-next/c/f4199271dae1
  - [bpf-next,3/3] selftests/bpf: Add selftests for cgroup1 local storage
    https://git.kernel.org/bpf/bpf-next/c/a2c6380b17b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



