Return-Path: <cgroups+bounces-9792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857EB4976A
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3565E1C2651B
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07C3148B0;
	Mon,  8 Sep 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLOjI2W1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAB30EF8F
	for <cgroups@vger.kernel.org>; Mon,  8 Sep 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353198; cv=none; b=Y/PZvU7ErMnkq5O3/FRpOZr0dhHqkR1u3SI0wdHx5rcXInGxHVoXfnhZXRPshEJ9fNBqECpAm6PxIs+D+Qsf+OYLOgnW6PDrsF3mNBZFj/tUKEEkdVUXxifliOFO53B8OcRctQslkX+NeRwHrx0Z5htCgfIsQGK+5dBUghUh+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353198; c=relaxed/simple;
	bh=JoWi8nGHQU+I4OzfANUxVdRq2qzgBDOqAugwz0fW6AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOiB3zsJQ9qYlrlkEiwoN5YThI18RTDcE6l2Z08my8GxQ79i2Qx7bhACqBunH94RqAN4fXzk799pIQfFvAM68ectiBtm8TJpwDxycltvxLFhO/AOqu99DIdsDGRoK5Y7gS/5hC+Y5dEsPiUh/8RcZxp9z/iyF27huc1rSLdlSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLOjI2W1; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 10:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757353193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UqG1+1cfzn6SRqfp+y4ls9je7NnsECHyQJszT61fGcM=;
	b=ZLOjI2W1TsnO+n+7Msg21yOwuialHG5Vd0MmH0abjFtTCfZ3QMyzLoEnQTRKlrQwkqV+kk
	C6APWTp9lt1ST7AUs4vBXG67D5ERA6iCOLd/ctnisLUuvCqViq2DHM6M/ihnFFV/MFmvtl
	6SY8zJVbkuDu4au4nxL0QF6VsJbbklM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezhepguqkxag@wolz4r2fazu2>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aL6htMt-jHAaCGLv@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL6htMt-jHAaCGLv@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 11:28:20AM +0200, Michal Hocko wrote:
> On Fri 05-09-25 13:16:06, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> 
> > ---
> >  include/linux/memcontrol.h | 23 ++++++++++++++++-------
> >  mm/memcontrol.c            |  7 ++++---
> >  2 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 9dc5b52672a6..054fa34c936a 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -993,22 +993,25 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
> >  	count_memcg_events_mm(mm, idx, 1);
> >  }
> >  
> > -static inline void memcg_memory_event(struct mem_cgroup *memcg,
> > -				      enum memcg_memory_event event)
> > +static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> > +					enum memcg_memory_event event,
> > +					bool allow_spinning)
> >  {
> >  	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> >  			  event == MEMCG_SWAP_FAIL;
> >  
> >  	atomic_long_inc(&memcg->memory_events_local[event]);
> 
> Doesn't this involve locking on 32b? I guess we do not care all that
> much but we might want to bail out early on those arches for
> !allow_spinning
> 

I am prototyping irq_work based approach and if that looks good then we
might not need to worry about 32b at all.

