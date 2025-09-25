Return-Path: <cgroups+bounces-10463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DEBA1D09
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 00:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7FA4E2510
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7DA322A1A;
	Thu, 25 Sep 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rjFAuv+v"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BD322539
	for <cgroups@vger.kernel.org>; Thu, 25 Sep 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839734; cv=none; b=EdvccCwfy5neckio5itEnUjwK9RnrUjRAeQI+KBfrBeaFCO50zfXmPqzk67zuI69UKjM1ASw8ViAjkFIMHpqwACSaKiZu/4ey9gB38bKiW55FaW9CLZ1/CQVkpQDUwaa1yaxeeuaiw6a/wFYQLWUAUNCXzOyOzJqxopQqVw7lTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839734; c=relaxed/simple;
	bh=qJdQGZQ3zDXQmmgOLYKHh8lTGrdY+5QRtfuuX46dBNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpxrIhceOsQQ6nbJlNBQO7zIS0bVu7P29Kl+JLlSq0VzvahfwlqDxe1yKAec3KAoqt76BoaDDgercytywkrwmM8qbB9uctHRAV584+NNWvnjVzQ6hMz46EtRtmcdXVyDh8hOcWuf2nZPWYftBdBXeGqVVA6PQPLhk5C/RvH5vEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rjFAuv+v; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Sep 2025 15:35:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758839730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkg5zckxQ8GP8jm1BEOp+9MhHJlmSLMqWWjnVJllXHw=;
	b=rjFAuv+vIIMF4ssQt7iSaVlPj42f/9JuK/CYoEfllfXBMH/2REL4+FHvtzF/DVKNZen3kW
	/hbHNQNKe8LTHEsW+5blhwoc8BpG/Tik53Ff8AgJSWsnzGN8OXRO1DKI2t48WnS5pyTKtO
	KOvRhKrcSCOigK4YnyWCa3/DEkMt/co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com, 
	harry.yoo@oracle.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
 <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
 <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 25, 2025 at 03:15:26PM -0700, Shakeel Butt wrote:
> On Thu, Sep 25, 2025 at 03:49:52PM -0400, Zi Yan wrote:
> > On 25 Sep 2025, at 15:35, David Hildenbrand wrote:
> > 
> > > On 25.09.25 08:11, Qi Zheng wrote:
> > >> Hi David,
> > >
> > > Hi :)
> > >
> > > [...]
> > >
> > >>>> +++ b/include/linux/mmzone.h
> > >>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
> > >>>>        spinlock_t split_queue_lock;
> > >>>>        struct list_head split_queue;
> > >>>>        unsigned long split_queue_len;
> > >>>> +    bool is_dying;
> > >>>
> > >>> It's a bit weird to query whether the "struct deferred_split" is dying.
> > >>> Shouldn't this be a memcg property? (and in particular, not exist for
> > >>
> > >> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
> > >> the protection of the split_queue_lock, otherwise the folio may be added
> > >> back to the deferred_split of child memcg.
> > >
> > > Is there no way to reuse the existing mechanisms, and find a way to have the shrinker / queue locking sync against that?
> > >
> > > There is also the offline_css() function where we clear CSS_ONLINE. But it happens after calling ss->css_offline(css);
> > 
> > I see CSS_DYING will be set by kill_css() before offline_css() is called.
> > Probably the code can check CSS_DYING instead.
> > 
> > >
> > > Being able to query "is the memcg going offline" and having a way to sync against that would be probably cleanest.
> > 
> > So basically, something like:
> > 1. at folio_split_queue_lock*() time, get folio’s memcg or
> >    its parent memcg until there is no CSS_DYING set or CSS_ONLINE is set.
> > 2. return the associated deferred_split_queue.
> > 
> 
> Yes, css_is_dying() can be used but please note that there is a rcu
> grace period between setting CSS_DYING and clearing CSS_ONLINE (i.e.
> reparenting deferred split queue) and during that period the deferred
> split THPs of the dying memcg will be hidden from shrinkers (which
> might be fine).

BTW if this period is not acceptable and we don't want to add is_dying
to struct deferred_split, we can use something similar to what list_lru
does in the similar situation i.e. set a special value (LONG_MIN) in its
nr_items variable. That is make split_queue_len a long and set it to
LONG_MIN during memcg offlining/reparenting.

