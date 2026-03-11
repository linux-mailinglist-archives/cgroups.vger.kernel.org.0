Return-Path: <cgroups+bounces-14753-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EADrDnL2sGmHpAIAu9opvQ
	(envelope-from <cgroups+bounces-14753-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 05:58:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF525C1BA
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 05:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C2E31021EF
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD030F7EF;
	Wed, 11 Mar 2026 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbp4mhfo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271C2EFDA6
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205071; cv=none; b=Pye9eFDKQ55iBb0wYGXWg9AJGpXGi1Wln62xbVvMN1EMZf46g5TAN3F0VFdK5jjfLVnXu+XtpcsAl+xQsvYChd0dA7j6ZMN4qg567YUj6ANTCfcbYxRibuNC+3REmAGL05F+K6sZnLFc9JmaOue/2k9pV37Wysd24XRqanDASUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205071; c=relaxed/simple;
	bh=hP55Zf1wN5RB5crPQCCe5lc1Q7D93TirDOcJ0PERq48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWrXhQI01XF7OKzGh4kcxc76UV4x9OznIFm9G+wPLeVNpmn9lc9VRH1A+ddToitfzorCd572RkPCiuNWAiOO22sjdIbVD0FzKLSgdQOhW/uueXYc5aFzQULNHo3G2QYefe/CKq+y2aAdLHCXj939IjTOjB/AlZ6Ic8wApT5vH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbp4mhfo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6076b8c2-c198-442d-974f-b3084a0cd1b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773205068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3GKruKazSJqdxffywFhZhbdqtqrnzIQRTyoTECkXVo=;
	b=sbp4mhfoNFMO/ByBa4DmfjKKiA8zcPlX7AW9UF/OTfNksyWsS2ot7SrdPIb22cwO09a4xr
	EL+cfpi3wKA0WxxPXvqO6jYyxaK7cO4EbbyqMIhO647x4QAgjJLZ7LiHDz2wfu4NiZa/Ef
	ScU0Q4SPXXS0QqHFyUuN4BLAsDwFpjE=
Date: Wed, 11 Mar 2026 12:57:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Alexei Starovoitov <ast@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hui Zhu <hui.zhu@linux.dev>, JP Kobryn <inwardvessel@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Geliang Tang <geliang@kernel.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Rientjes
 <rientjes@google.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AFDF525C1BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14753-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/8/26 2:24 AM, Shakeel Butt wrote:
> Over the last couple of weeks, I have been brainstorming on how I would go
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, with a
> focus on existing challenges and issues. This proposal outlines the high-level
> direction. Followup emails and patch series will cover and brainstorm the
> mechanisms (of course BPF) to achieve these goals.
>
> Memory cgroups provide memory accounting and the ability to control memory usage
> of workloads through two categories of limits. Throttling limits (memory.max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memory
> pressure.
>
> Challenges
> ----------
>
> - Workload owners rarely know their actual memory requirements, leading to
>    overprovisioned limits, lower utilization, and higher infrastructure costs.
>
> - Throttling limit enforcement is synchronous in the allocating task's context,
>    which can stall latency-sensitive threads.
>
> - The stalled thread may hold shared locks, causing priority inversion -- all
>    waiters are blocked regardless of their priority.
>
> - Enforcement is indiscriminate -- there is no way to distinguish a
>    performance-critical or latency-critical allocator from a latency-tolerant
>    one.
>
> - Protection limits assume static working sets size, forcing owners to either
>    overprovision or build complex userspace infrastructure to dynamically adjust
>    them.
>
> Feature Wishlist
> ----------------
>
> Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.
>
> Per-Memcg Background Reclaim
>
> In the new memcg world, with the goal of (mostly) eliminating direct synchronous
> reclaim for limit enforcement, provide per-memcg background reclaimers which can
> scale across CPUs with the allocation rate.

This sounds like a very useful approach. I have a few questions I'm 
thinking through:

How would you approach implementing this background reclaim? I'm imagining
something like asynchronous memory.reclaim operations - is that in line
with your thinking?

And regarding cold page identification - do you have a preferred approach?
I'm curious what the most practical way would be to accurately identify
which pages to reclaim.

Would be great to hear your perspective.



