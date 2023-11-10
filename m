Return-Path: <cgroups+bounces-324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4187E7D89
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E701C20A9C
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071F1DDC9;
	Fri, 10 Nov 2023 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrWgeazJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A981DA45;
	Fri, 10 Nov 2023 16:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D0A0C433C8;
	Fri, 10 Nov 2023 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699632023;
	bh=KH9bp3yzXKlaQ5NXA0sRIemhBh3Sql4091UMoxT916s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hrWgeazJip/QyHj3IANToBkohoVbxA1ciDtKf3LhQRvtDyt38CfA3wH5R0uFupsnD
	 FNhplE5Y3FCmW3eUb9lgugqHWflCAcmARKfzlHZ90dMeUDpppXy9e21L0TVGt4vH5U
	 Yd4BWCage3Fsgw4XCXVcO2TA9MiIk7tNN2bnEiGFnbRtTzZFzLucZZ/G8sy3o0O1uz
	 AAnfcrYtPN4IQ2DuiGzJ9453RPhkljH7AC2zsbQulOKd4F1HlKGxapL+MuT5vL5IWZ
	 brOxSWICNzCd3WeryL0KOat0U6+MXbKuUz0ki4qXQ6g10fgfEKOuji67MLjh8+xF9B
	 Eejhb6RbvS8iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 697BDE00083;
	Fri, 10 Nov 2023 16:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] compiler-gcc: Suppress -Wmissing-prototypes
 warning for all supported GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169963202342.12004.15203642381829601670.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 16:00:23 +0000
References: <20231106031802.4188-1-laoar.shao@gmail.com>
In-Reply-To: <20231106031802.4188-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: lkp@intel.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, daniel@iogearbox.net, hannes@cmpxchg.org,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, lizefan.x@bytedance.com, longman@redhat.com,
 martin.lau@linux.dev, mkoutny@suse.com, oe-kbuild-all@lists.linux.dev,
 oliver.sang@intel.com, sdf@google.com, sinquersw@gmail.com, song@kernel.org,
 tj@kernel.org, yonghong.song@linux.dev, yosryahmed@google.com, arnd@arndb.de,
 memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 Nov 2023 03:18:02 +0000 you wrote:
> The kernel supports a minimum GCC version of 5.1.0 for building. However,
> the "__diag_ignore_all" directive only suppresses the
> "-Wmissing-prototypes" warning for GCC versions >= 8.0.0. As a result, when
> building the kernel with older GCC versions, warnings may be triggered. The
> example below illustrates the warnings reported by the kernel test robot
> using GCC 7.5.0:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] compiler-gcc: Suppress -Wmissing-prototypes warning for all supported GCC
    https://git.kernel.org/bpf/bpf-next/c/689b097a06ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



