Return-Path: <cgroups+bounces-3886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5F93B90B
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5991F230F9
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271213C833;
	Wed, 24 Jul 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3TFtiyh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61226AF5
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859175; cv=none; b=roC3CCopTdFrzoXLdUL61xxhZh1KF+5D+OdEoAys4lRavyFDQdyowt8KySunFLQh3bk2LSDkFqGCdpPiXnyBJt/8k89M+GBcCXSVj/8byxpSPnFwR+Dj94qQzpbegSjQ9HrL0v4Zbtn9RWgBdqpzyddR+EdZDDms5TZaYBWFHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859175; c=relaxed/simple;
	bh=SXiCqdO/Q98jobb36wsBRD0eV2r5KncKEuIST4K1KxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLHVFPL8xq7fKn+oSIIprY4ZXpERfFC+SidGjC8vM0hB/aJZmODZuGE90GeJd0QlMGVE1ce8UWc+GqPAycdYkzEOrWqZqRlCj9djQGT287dzTujhda4KWIaYiOMGTQAusJdmc0vCR4mltpo7rnBAszfC+o0Uj6SMgCPCUSRtokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3TFtiyh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 15:12:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721859170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZyW0buDXzvb59iAMbU2bFvjOmyyCJHIAXcW1zZC4yo=;
	b=Y3TFtiyhDd2ZRfscCVpQ5cz3eLtdGo/ZhotLsVCv/ga2Wx9R5Q2S2fHjetDR+SUeqrrWAJ
	RNNnAs5VzNM+1MTgQKp7spp9qbYr6vj2DQpM5Bl+pdLwR4AC8JeHNQs+fRFL7UM0ipcft/
	QyyA9FZadVOAkX+rPsXlVGZ9kvfBKps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-ID: <jd5t5vk46rsw2b4ao3jndmbs7jnrypbgvf3kl4i46f52khcaku@ev35pffodsyy>
References: <20240724095307.81264-1-songmuchun@bytedance.com>
 <610dc6fa-6681-4c9e-bffb-ef6d299dd169@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610dc6fa-6681-4c9e-bffb-ef6d299dd169@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 05:20:09PM GMT, Vlastimil Babka (SUSE) wrote:
> On 7/24/24 11:53 AM, Muchun Song wrote:
> > The obj_cgroup_memcg() is supposed to safe to prevent the returned
> > memory cgroup from being freed only when the caller is holding the
> > rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> > ignore thoes conditions when users call some upper APIs which call
> > obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> > the link below). So it is better to add lockdep assertion to
> > obj_cgroup_memcg() to find those issues ASAP.
> > 
> > Because there is no user of obj_cgroup_memcg() holding objcg_lock
> > to make the returned memory cgroup safe, do not add objcg_lock
> > assertion (We should export objcg_lock if we really want to do).
> > Additionally, this is some internal implementation detail of memcg
> > and should not be accessible outside memcg code.
> > 
> > Some users like __mem_cgroup_uncharge() do not care the lifetime
> > of the returned memory cgroup, which just want to know if the
> > folio is charged to a memory cgroup, therefore, they do not need
> > to hold the needed locks. In which case, introduce a new helper
> > folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> > could eliminate a memory access of objcg->memcg for kmem, actually,
> > a really small gain.
> > 
> > Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > v2:
> >  - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
> > 
> >  include/linux/memcontrol.h | 20 +++++++++++++++++---
> >  mm/memcontrol.c            |  6 +++---
> >  2 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index fc94879db4dff..742351945f683 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
> >   * After the initialization objcg->memcg is always pointing at
> >   * a valid memcg, but can be atomically swapped to the parent memcg.
> >   *
> > - * The caller must ensure that the returned memcg won't be released:
> > - * e.g. acquire the rcu_read_lock or css_set_lock.
> > + * The caller must ensure that the returned memcg won't be released.
> >   */
> >  static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> >  {
> > +	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_is_held(&cgroup_mutex));
> 
> Maybe lockdep_assert_once() would be a better fit?
> 

So something like:
	lockdep_assert_once(rcu_read_lock_held() || lockdep_is_held(&cgroup_mutex));


