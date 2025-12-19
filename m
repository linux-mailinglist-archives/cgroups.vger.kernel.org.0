Return-Path: <cgroups+bounces-12526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62545CCE3E2
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 03:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61F7F305F306
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07621B9D2;
	Fri, 19 Dec 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bomkr5sk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D54A35
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110218; cv=none; b=bayLQASTOSmvq2rLw/xWJ+0yyn/849dPh/AMTtJOwlc/UZ6oYBaS5QPujGUwZHXbVEySAN+JaExFu1FD8S3zB+G3o6WmMjq55lDRkgAhzfvk/Nd+BB7ChLBe+HS3giLDlOKvKFk8GiCuqe/2H5TqGEBvU5vXebSigE9jIqZ+6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110218; c=relaxed/simple;
	bh=drDjiYxtaEN1fzuZy5AJ1UdSyiXsTSlvR4fGC4asHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmW69IHlQq6t0k+iNUdwp56PJhIY1NGUstlvQRQ3+9pxZlSaKxHsfsakO1W68QfzWIdX0XwPnRMIGoonaNUkeXoLnBh9e8dvebiKy3uU6vReEl1W/qh471H58UvUry1pcCKuu/RYq3/faB4EmnLOkbqWJFwG9/rQMOfa6MR1G70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bomkr5sk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 18:09:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766110199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XU/sltETz4db1d6NIyN/LIXo1b6za3STnrY0+ajqCb8=;
	b=bomkr5ske46dcXHXoPOJ77r8YbOhDox6UbCohl7xofxLl3s2EIboOt1KronjtFal1wVRXR
	01z5ic3jRvUzKY6eJNDlVojgMovkW02GkCCudTHFvM+j1kduHbwCF8oHNdIysmtOW5bfV7
	3zE1pyON8/35o35q8rr774DIdHh4IfU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 08/28] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <ot5kji77yk6sqsjhe3fm4hufryovs7in4bivwu6xplqc4btar3@ngl5r7clogkr>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMkYlK1KhtD5ky6@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMkYlK1KhtD5ky6@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 04:45:06PM -0500, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:32PM +0800, Qi Zheng wrote:
> > From: Muchun Song <songmuchun@bytedance.com>
> > 
> > In the near future, a folio will no longer pin its corresponding
> > memory cgroup. To ensure safety, it will only be appropriate to
> > hold the rcu read lock or acquire a reference to the memory cgroup
> > returned by folio_memcg(), thereby preventing it from being released.
> > 
> > In the current patch, the rcu read lock is employed to safeguard
> > against the release of the memory cgroup in get_mem_cgroup_from_folio().
> > 
> > This serves as a preparatory measure for the reparenting of the
> > LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/memcontrol.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 21b5aad34cae7..431b3154c70c5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
> >   */
> >  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
> >  {
> > -	struct mem_cgroup *memcg = folio_memcg(folio);
> > +	struct mem_cgroup *memcg;
> >  
> >  	if (mem_cgroup_disabled())
> >  		return NULL;
> >  
> > +	if (!folio_memcg_charged(folio))
> > +		return root_mem_cgroup;
> > +
> >  	rcu_read_lock();
> > -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> > -		memcg = root_mem_cgroup;
> > +retry:
> > +	memcg = folio_memcg(folio);
> > +	if (unlikely(!css_tryget(&memcg->css)))
> > +		goto retry;
> 
> So starting in patch 27, the tryget can fail if the memcg is offlined,

offlined or on its way to free? It is css_tryget() without online.

> and the folio's objcg is reparented concurrently. We'll retry until we
> find a memcg that isn't dead yet. There's always root_mem_cgroup.
> 
> It makes sense, but a loop like this begs the question of how it is
> bounded. I pieced it together looking ahead. Since this is a small
> diff, it would be nicer to fold it into 27. I didn't see anything in
> between depending on it, but correct me if I'm wrong.

I agree to fold it in the patch where it is needed. Currently at this
point in series I don't see how css_tryget() can fail here.

> 
> Minor style preference:
> 
> 	/* Comment explaining the above */
> 	do {
> 		memcg = folio_memcg(folio);
> 	} while (!css_tryget(&memcg->css));

