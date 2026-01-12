Return-Path: <cgroups+bounces-13087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8CD14506
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4835301FD8C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A2378D6F;
	Mon, 12 Jan 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJTfQrEh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D042356BA
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238438; cv=none; b=cbz8bhF0T/nDmdXhNAAqNVLXmAEQK+cZs6MGgFoeVupY1w+6V3QcXj+cJCOYn9D75Px7GS0f+b0D4x2qmlv9EQt5bx2/Fq0LwDX5exjGo9OCxB64peXG2L1HoPQOwTs1mgZyRdD4R57bnc/2+IjR7SolgVclia8p4tLvLLgNv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238438; c=relaxed/simple;
	bh=G2IOEptJb+N9S5CIMi+pPDzdQ8B9C9Eux8fbR2TZ9bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRpVZDIhYCkztNosFj4A+L+aA6rtyZUvodmtVFp9lZTx9fe4YsMv0MP8nuOhzHEkVEvkotCy0qHOhUsYhLrQuXbEY6kPBwTn+JQJqH+37du8XmFDKwyYGkqigHWqpBuSaTdr8Xk5ytqR1vp7pEAooei9VpnrCydmuAoMeu3vtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJTfQrEh; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768238423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKO5SxjQcWY3bTQexM6OeVasUC8f3l9ufW1wNbb+WHs=;
	b=BJTfQrEhGjvsVklGhhozrhVJ9BkY1WKH2fzBMWKZ+bIikMAJi63QcFx8rvYjSViFuYu5Nh
	IJhlCiSiKL3yCk0EvkuaOdaUX95AH+O32tIAowqrS4s1G9tuXzps54MNdnbqUngpvNlbIK
	4/aRPyEofh/08VUzsjXhOAXZl/LU/gQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
In-Reply-To: <aWULOvXrN0acG97Y@google.com> (Matt Bobrowski's message of "Mon,
	12 Jan 2026 14:54:50 +0000")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<aWULOvXrN0acG97Y@google.com>
Date: Mon, 12 Jan 2026 09:20:13 -0800
Message-ID: <87ecnusq7m.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matt Bobrowski <mattbobrowski@google.com> writes:

> On Mon, Oct 27, 2025 at 04:17:09PM -0700, Roman Gushchin wrote:
>> Introduce a bpf struct ops for implementing custom OOM handling
>> policies.
>>
>> ...
>>
>> +#ifdef CONFIG_MEMCG
>> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
>> +	for (memcg = oc->memcg; memcg; memcg = parent_mem_cgroup(memcg)) {
>> +		bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
>> +		if (!bpf_oom_ops)
>> +			continue;
>> +
>> +		/* Call BPF OOM handler */
>> +		ret = bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
>> +		if (ret && oc->bpf_memory_freed)
>> +			goto exit;
>
> I have a question about the semantics of oc->bpf_memory_freed.
>
> Currently, it seems this flag is used to indicate that a BPF OOM
> program has made forward progress by freeing some memory (i.e.,
> bpf_oom_kill_process()), but if it's not set, it falls back to the
> default in-kernel OOM killer.
>
> However, what if forward progress in some contexts means not freeing
> memory? For example, in some bespoke container environments, the
> policy might be to catch the OOM event and handle it gracefully by
> raising the memory.limit_in_bytes on the affected memcg. In this kind
> of resizing scenario, no memory would be freed, but the OOM event
> would effectively be resolved.

I'd say we need to introduce a special kfunc which increases the limit
and sets bpf_memory_freed. I think it's important to maintain safety
guarantee, so that a faulty bpf program is not leading to the system
being deadlocked on memory.

Thanks!

