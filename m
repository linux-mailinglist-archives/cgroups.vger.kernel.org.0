Return-Path: <cgroups+bounces-9118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DBB23DFE
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 03:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3581AA1F00
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD491BCA0E;
	Wed, 13 Aug 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b19C3ZI4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475F42AB0
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050297; cv=none; b=DHuW4Do7ADnG0eRRVbjfG09cI9hIoze3yrEBO9LsyRUiwitczWZ9xUiX5O7oGL6OptFb5kH/tWjMhcTdowTjgKHAZ2zWSu8WTio0C0QwNl6NLcUfMN46zm0G/bFeorn4TjgKnrJ+HotaAABZkfJKXtdCe/YhRGpgEiupDlGHTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050297; c=relaxed/simple;
	bh=zfD3nlYZmda+fmVBH+ZVr3UweVz63/j+5hOxerpkJRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9JqyMHiX/sy1KJWNhnhmaXTleQCslf7nvOZnR4WjAEx3QUR+PuKzOk1hTbClHHBa4xoGBIGH5bNzXwCPtvXM6kXQurUKwAf1CPnOJpqv6f0BoLMuMbSFV2AnZ/K5dNxc1z/wcomXw9f2Y8QXba6vd889LzR7KS74nj4vavRbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b19C3ZI4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755050283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfD3nlYZmda+fmVBH+ZVr3UweVz63/j+5hOxerpkJRM=;
	b=b19C3ZI45eU9CsKS6W3M7BSUx5OnTlbb/tM3WLPlW06jtKgYmEyV2HjadKqkdJ3Et1Q3NY
	3+edrvJ0V9oUkrqMqx5IW5xtDQpqd5K70mnW2Rn4vJj8uMMfBfFJC8vd294TZXLMx1uyk/
	nmdKcABr6WF8PtoemF+njSNYCP6Jh8A=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  =?utf-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,  Tejun Heo <tj@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Mina Almasry <almasrymina@google.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  netdev@vger.kernel.org,
  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
In-Reply-To: <20250812175848.512446-13-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 12 Aug 2025 17:58:30 +0000")
References: <20250812175848.512446-1-kuniyu@google.com>
	<20250812175848.512446-13-kuniyu@google.com>
Date: Tue, 12 Aug 2025 18:57:55 -0700
Message-ID: <87ldnooue4.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>
> When running under a non-root cgroup, this memory is also charged to the
> memcg as "sock" in memory.stat.
>
> Even when a memcg controls memory usage, sockets of such protocols are
> still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
>
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>
> In reality, this assumption does not always hold, and processes that
> belong to the root cgroup or opt out of memcg can consume memory up to
> the global limit, becoming a noisy neighbour.
>
> Let's decouple memcg from the global per-protocol memory accounting if
> it has a finite memory.max (!= "max").

I think you can't make the new behavior as the new default, simple because
it might break existing setups. Basically anyone who is using memory.max
will suddenly have their processes being opted out of the net memory
accounting. Idk how many users are actually relying on the network
memory accounting, but I believe way more than 0.

So I guess a net sysctl/some other knob is warranted here, with the old
behavior being the default.

Thanks

