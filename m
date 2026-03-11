Return-Path: <cgroups+bounces-14777-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L1WK1ngsWngGgAAu9opvQ
	(envelope-from <cgroups+bounces-14777-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 22:36:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111A26A797
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 22:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794DC303F477
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDB33D6EE;
	Wed, 11 Mar 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WTIWSTrJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC131F9A3;
	Wed, 11 Mar 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264979; cv=none; b=B3bjmMw1Gp5xOZyGM7rVpSKJaaDGgIzeUgVkZCDv/j+iNQmskaQ/yTL6VBj8IhKqK7zDT7FMA/j+03r5AXMAYLHNw0lgCunnhOuZIlN4xW8DSNC3qVNVRiNkamAyG152lBw/vOcefF4XMpJFheO4/RoitcB9eNttK3fS1OSDjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264979; c=relaxed/simple;
	bh=g8SZ11jzjBJsPzGm6q4EByRc1LqT5tmqbviCSXS4o24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzoGWgvzQNrGnt+93WenZnZ1zRMWz83LnncIDQ69XmmGwvH/I/BG1WPQs821ZuJy4YrHY32lsxu6S45oCSQTDAyBsUL5gO2CdXH0SmkV0idfNK1g1559ChNCfArwKov/yb6Dv/fTqHhM6KE5qEqMyb7veEdyT5AFEcx2F4UDATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WTIWSTrJ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Mar 2026 14:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773264975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Telfpf5ptlGpB/om4pC5uPZFX+x6oNBegoretK0UrkE=;
	b=WTIWSTrJNE/IH8KAHN4q6P27nFGK3ez/6AduhtafzWVM2kHwhzgvWyg3lqR4of8XKkrgfW
	m8ZXwdWVbuDEouJn7z57FXHM0Opn/jUXqzyxQkSBC1o0LeZRCQaovR0fruTt9ZtvQXY8JG
	yfdxyedVzx8yQu1uB/i8i2YiG4TwzV0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Thelen <gthelen@google.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hui Zhu <hui.zhu@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Muchun Song <muchun.song@linux.dev>, Geliang Tang <geliang@kernel.org>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	David Rientjes <rientjes@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
Message-ID: <abHWslV0KmjF7x80@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
 <CAHH2K0ZBJV1peAZVZC9Lm=rFRzSfxsvbrxRjyB=+0xkHGRcdLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHH2K0ZBJV1peAZVZC9Lm=rFRzSfxsvbrxRjyB=+0xkHGRcdLA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14777-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9111A26A797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, Mar 11, 2026 at 12:29:45AM -0700, Greg Thelen wrote:
> On Sat, Mar 7, 2026 at 10:24 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> >
> 
> Very interesting set of topics. A few more come to mind.

Thanks.

> 
> I've wondered about preallocating memory or guaranteeing access to
> physical memory for a job. Memcg has max limits and min protections,
> but no preallocation (i.e. no conceptual memcg free list). So if a job
> is configured with 1GB min workingset protection that only ensures 1GB
> won't be reclaimed, not that 1GB can be allocated in a reasonable
> amount of time. This isn't just a job startup problem: if a page is
> freed with MADV_DONTNEED a subsequent pgfault may require a lot of
> time to handle, even if usage is below min.

This is indeed correct i.e. protection limits protect the workload from external
reclaim but does not provide any gurantee on allocating memory in a reasonable
cheap way (without triggering reclaim/compaction). This is one of the challenge
to implement userspace oom-killer in an aggressively overcommitted environment.

However to me providing memory allocation guarantees is more of a system level
feature and orthogonal to memcg. And I see your next para is about that :)

Anyways I think if we keep system memory utilization below some value and
guarantee there is always some free memory (this can be done by having common
ancestor of all workloads and ancestor has a limit or node controller maintains
the condition that the sum of limits of all top level cgroups is below some
percentage of total memory) then we might not need memcg free list or similar
mechanisms (most of the time, I think).

> 
> Initial allocation policies are controlled by mempolicy/cpuset. Should
> we continue to keep allocation policies and resource accounting
> separate? It's a little strange that memcg can (1) cap max usage of
> tier X memory, and (2) provide minimum protection for tier X usage,
> but has no influence on where memory is initially allocated?

I think I understand your point but I think the implementation would be too
messy. This is orthogonal to the proposal but I would say a good topic for
LSFMMBPF if you want to lead the discussion.

