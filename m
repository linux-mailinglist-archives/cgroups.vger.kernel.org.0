Return-Path: <cgroups+bounces-9763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38AB46627
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792C01D236A1
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE78287253;
	Fri,  5 Sep 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AsvpR/nI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA23286412
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109036; cv=none; b=aH4kuK09rm2pvv6qXuUSSQ6RMfsH8RizLi3oihWl1YUcvbLVYs+DoPu5jTydsG/CLH8iSU/FdqPtdXjVMpqdFqv08mZRLbWOU/xzKiJUEQg8Y6KHhGQB0r/EtjSuD63/VK4yUXnd4f96Bx5HDTdIYtqbJ8cVTNJNQT7AFgpZ3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109036; c=relaxed/simple;
	bh=S/UWDnpTMWsqhx4sgrCQxMtbVj0rwQvQhDuX/DmBFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW+N/3IodElr70lAL+29JRvCVtMcO/0jWJxMaJbQj/w/u/GhfQMWoWrujyRzeMeEFlxBogE+2HBj3LUmU3fCG8IG0guslW/e/9AOMGhW6BiTd+/3Hnw31FlO85PKSEjQpoMEk9Ybx05qm8WlF/fDAfTYneuP8gX8iOxmu/yrvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AsvpR/nI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:50:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757109022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+4lbkYAVJItZbl2lUeNDlNahLiQUZCJiaL54ViPkiY=;
	b=AsvpR/nIzurNpoIFa6XwntMf4OD07BIqdrNjj5pHASfxQjM6hDQZxoKF+RNqMmjRn+bwxD
	QavQmwYEnsXt2x7J0YcXG8R67lsjb9n5gKD4blTaP7+Qk9IW5ox/72XJLYPBLhcvy0J3Vq
	6nEtKlfioHa8Yera73WK9RMGQRYsHEE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <6bcjnhdsbyfmlua2x7olz6w3gheejfatnrtn5qu7ls5svegrok@zeatti7whrnq>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <87y0qsa95d.fsf@linux.dev>
 <mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
 <87ecska85y.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecska85y.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 02:42:01PM -0700, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
> >> Shakeel Butt <shakeel.butt@linux.dev> writes:
> >> 
> >> > Generally memcg charging is allowed from all the contexts including NMI
> >> > where even spinning on spinlock can cause locking issues. However one
> >> > call chain was missed during the addition of memcg charging from any
> >> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> >> > cgroup_file_notify().
> >> >
> >> > The possible function call tree under cgroup_file_notify() can acquire
> >> > many different spin locks in spinning mode. Some of them are
> >> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> >> > just skip cgroup_file_notify() from memcg charging if the context does
> >> > not allow spinning.
> >> 
> >> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
> >> like a bit deal, but OOM events can be way more important.
> >> 
> >> Should we instead preserve the event (e.g. as a pending_event_mask) and
> >> raise it on the next occasion / from a different context?
> >>
> >
> > Thanks for the review. For now only MAX can happen in non-spinning
> > context. All others only happen in process context. Maybe with BPF OOM,
> > OOM might be possible in a different context (is that what you are
> > thinking?). I think we can add the complexity of preserving the event
> > when the actual need arise.
> 
> No, I haven't thought about any particular use case, just a bit
> worried about silently dropping some events. It might be not an issue
> now, but might be easy to miss a moment when it becomes a problem.
> 

Only the notification can be dropped and not the event (i.e. we are
still incrementing the counters). Also for MAX only but I got your
point.

> So in my opinion using some delayed delivery mechanism is better
> than just dropping these events.

Let me see how doing this irq_work looks like and will update here.

