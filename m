Return-Path: <cgroups+bounces-9295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C58B2E08E
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB5A17F453
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A9B35A2A1;
	Wed, 20 Aug 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuCHCwzO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27F2BEC28;
	Wed, 20 Aug 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702014; cv=none; b=cNXQTEqCsiSSazZ+kWnVe1KekoxJXW+ZOOLhrXuQaXn9SRh5Q7YJfKIN78HRR27sn4VUBxJAIt+2EalWwUMUAtI1U9S4TVO3qj0NcpsQsy8OKYrR7obxQY62Bt3/HovT5zp5uefulYly3FLvEevIbi+ckLw55yB9Nb27zJI3fY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702014; c=relaxed/simple;
	bh=5VGDh1deFiHXVnIppXw95FTI+vfIah2j7mM90eoiq7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSmhgZc+9mGClk3a39KvJ3xYq5kuez8gpJa26xgadsGpuz1OjXv/jka4zRUOE7De4RufIb12n8sBl/q/gxbnl03z36E9ZIQYXIRxUOdQHKiX7G6a/p/lsEhcI6N0G0Me5/1ZXCBx/dkS91t0vdLHY0VbAf2xBtLtUXFfflsAGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuCHCwzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EC3C4CEE7;
	Wed, 20 Aug 2025 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702014;
	bh=5VGDh1deFiHXVnIppXw95FTI+vfIah2j7mM90eoiq7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PuCHCwzOkC+TBoUD7rnBo3Wg1ej0Od39GERmYmfaz6tHGalTfP+RfciJl+qNjgu5z
	 TPSNNyzZEBYYDwgxAvb4rqNf7gjt04mViK0eISjRBas7drErS9Gfe/VpMU9Lp5r4nl
	 w1kzGAQbEwksJDLWMQAxnunKieLdJpwYwm55uhOVgyJ2Qlnb69fdLeMH5olssKVHjZ
	 Nv3WjN6tXI9clLIVHWceMZzaXouR5DaamwVzFRFfmdlJLv8RyMgAeO3sIrmzcnntbQ
	 BRU/v73nkMORi/iT3oTf40wQKLhPxQZOZgHToNWtTpJQtUCbdQv3BV71uNpQD5ac6m
	 HIdM6uf+VRD0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE423383BF4E;
	Wed, 20 Aug 2025 15:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 00/10] net-memcg: Gather memcg code under
 CONFIG_MEMCG.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175570202351.267477.6309911387508861679.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 15:00:23 +0000
References: <20250815201712.1745332-1-kuniyu@google.com>
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 ncardwell@google.com, pabeni@redhat.com, willemb@google.com,
 matttbe@kernel.org, martineau@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 akpm@linux-foundation.org, mkoutny@suse.com, tj@kernel.org, horms@kernel.org,
 geliang@kernel.org, muchun.song@linux.dev, almasrymina@google.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 20:16:08 +0000 you wrote:
> This series converts most sk->sk_memcg access to helper functions
> under CONFIG_MEMCG and finally defines sk_memcg under CONFIG_MEMCG.
> 
> This is v5 of the series linked below but without core changes
> that decoupled memcg and global socket memory accounting.
> 
> I will defer the changes to a follow-up series that will use BPF
> to store a flag in sk->sk_memcg.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
    https://git.kernel.org/netdev/net-next/c/68889dfd547b
  - [v5,net-next,02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
    https://git.kernel.org/netdev/net-next/c/1068b48ed108
  - [v5,net-next,03/10] tcp: Simplify error path in inet_csk_accept().
    https://git.kernel.org/netdev/net-next/c/e2afa83296bb
  - [v5,net-next,04/10] net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
    https://git.kernel.org/netdev/net-next/c/9d85c565a7b7
  - [v5,net-next,05/10] net: Clean up __sk_mem_raise_allocated().
    https://git.kernel.org/netdev/net-next/c/bd4aa2337374
  - [v5,net-next,06/10] net-memcg: Introduce mem_cgroup_from_sk().
    https://git.kernel.org/netdev/net-next/c/f7161b234f2e
  - [v5,net-next,07/10] net-memcg: Introduce mem_cgroup_sk_enabled().
    https://git.kernel.org/netdev/net-next/c/43049b0db038
  - [v5,net-next,08/10] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
    https://git.kernel.org/netdev/net-next/c/bb178c6bc085
  - [v5,net-next,09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
    https://git.kernel.org/netdev/net-next/c/b2ffd10cddde
  - [v5,net-next,10/10] net: Define sk_memcg under CONFIG_MEMCG.
    https://git.kernel.org/netdev/net-next/c/bf64002c94fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



