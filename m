Return-Path: <cgroups+bounces-9762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF5B46617
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BA356813C
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7E2FCBEA;
	Fri,  5 Sep 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2KycOcQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE82F3C02
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108536; cv=none; b=oFv7Mb/ZueLESGeIo1mBGe65tbUkEWXNAejH3PMFxD8vib1sSjZgof4+zlZq4Aq5RIoXYvBfdA8ZYMzvXhXy/LXg1phaG9rVdBsBSDY076ivGqHXSU1FlS8eQL45MCK97ZBwz3Uxhap7ScBpJfTfWhJ/EmcqSMu5bM3JJMMIkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108536; c=relaxed/simple;
	bh=B9tHNEOeLaWdDARduEz/Vc9qdH2m8+ssRhq+4XnxwEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xpk4WsXarj2T1c5P2oxX6LrnqO+Q6SToebvKbWW/OUiW2DbMScMwvnP9BN/0A5FTHny4XnYu7fTZDWFqAS59mxs/R8HwwLL3jm0FIWJLjjZzacqLbh0EOiGHE5pNn+gvo2f/DLA7+kjdL8EItPvb2ao9NU6+DXMVV+aI393YwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2KycOcQ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757108532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdQSZQn4Ae0lf5/FOhW87b1E1rxb0mDC0qFKSsqhQ4I=;
	b=t2KycOcQC6+Wj1X+FCLqCY3UI+yAR/kc8EnpBUKQbcoiI3YaZw2E1d0/VODIOXL7PgHDxn
	cx8ZeTr9MJKBB+M9Js3cGU4Q+EWNRrxXAo2+/JlZABHc0nnNHLckybReBlDjxAcxjFpJGM
	v9oWfeEywqHvK8z6TmlnCITZK8pSRzs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Muchun Song <muchun.song@linux.dev>,  Alexei Starovoitov
 <ast@kernel.org>,  Peilin Ye <yepeilin@google.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  bpf@vger.kernel.org,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org,  Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
In-Reply-To: <mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
	(Shakeel Butt's message of "Fri, 5 Sep 2025 14:31:13 -0700")
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
	<87y0qsa95d.fsf@linux.dev>
	<mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
Date: Fri, 05 Sep 2025 14:42:01 -0700
Message-ID: <87ecska85y.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>> > Generally memcg charging is allowed from all the contexts including NMI
>> > where even spinning on spinlock can cause locking issues. However one
>> > call chain was missed during the addition of memcg charging from any
>> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
>> > cgroup_file_notify().
>> >
>> > The possible function call tree under cgroup_file_notify() can acquire
>> > many different spin locks in spinning mode. Some of them are
>> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
>> > just skip cgroup_file_notify() from memcg charging if the context does
>> > not allow spinning.
>> 
>> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
>> like a bit deal, but OOM events can be way more important.
>> 
>> Should we instead preserve the event (e.g. as a pending_event_mask) and
>> raise it on the next occasion / from a different context?
>>
>
> Thanks for the review. For now only MAX can happen in non-spinning
> context. All others only happen in process context. Maybe with BPF OOM,
> OOM might be possible in a different context (is that what you are
> thinking?). I think we can add the complexity of preserving the event
> when the actual need arise.

No, I haven't thought about any particular use case, just a bit
worried about silently dropping some events. It might be not an issue
now, but might be easy to miss a moment when it becomes a problem.

So in my opinion using some delayed delivery mechanism is better
than just dropping these events.

