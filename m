Return-Path: <cgroups+bounces-12648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33ECDBA0D
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6717B30092F6
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6824A069;
	Wed, 24 Dec 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p1E6RkpV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188D2F6903
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562741; cv=none; b=Ht7uX5yKjsxGq/5dlEH43pYOU7/JacNxOExkgY3jrEnLzE+RExFm3IB3HGj2EEmqPvbIJI7m6vSotpEKXmOk/ST0vb1PvqrpdB7N4hIH/QD0dkLxMxqSMWR9Amqnepra9l//wxf+6PVbdmB+fkBDyC8mOxLlYWOi7OQ8Haa1Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562741; c=relaxed/simple;
	bh=huNQhEu5rZ/hU+dlMTpyy1NWbIjCTZKvCtjUHjzuMls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htVtodKLF9XQAGeEssUWzNvFGybvYffIdBXstS/r2EQ8swS1rcYNO/GNGKcOWpFYivocN6jOMKhVmQkt0ycJJJnpivHjDPbfOg/A5nIdmUa7x2tLv3hOv3QWUL0LwzESr3P7ZaQGsiFTtt7L6GnfCHXP1NoGJonvjoO3qlBkr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p1E6RkpV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 23:51:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766562726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/lDtdAtPPF7+SDKZunXkwp0QGMQGfz/2ok/wwdNYJA=;
	b=p1E6RkpVDglhbWVaBwVBhlcUeupT2wNmuGapdOD/namnR8Lvq6ZA1qkD9FWmc+nXxU9wxY
	OSuA8MtNUOu4xs9hYttlTvaMlfS66Z7JYEyCsrlcLHM41/KqM9+Mfm4wd5Z/8neYsPDKpJ
	tMP0qkOCdq6P479gciE9KIrCirgPZs8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: damon: get memcg reference before access
Message-ID: <peusxpenpbjdnhr5nkgvqtiuuofmc6khsxsxxvj3k3eyledkft@kgvgid53zbbg>
References: <20251224034527.3751306-1-shakeel.butt@linux.dev>
 <20251224052148.68796-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224052148.68796-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 23, 2025 at 09:21:47PM -0800, SeongJae Park wrote:
> On Tue, 23 Dec 2025 19:45:27 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > The commit b74a120bcf507 ("mm/damon/core: implement
> > DAMOS_QUOTA_NODE_MEMCG_USED_BP") added accesses to memcg structure
> > without getting reference to it. This is unsafe. Let's get the reference
> > before accessing the memcg.
> 
> Thank you for catching and fixing this!
> 
> Nit.  On the subject, could we use 'mm/damon/core:' prefix instead of 'memcg:
> damon:' for keeping the file's commit log subjects consistent?

Done.

> 
> > 
> > Fixes: b74a120bcf507 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
> 
> I was firsty thinking we might need to Cc: stable@.  But I realized the broken
> commit has merged into 6.19-rc1.  So Cc: stable@ is not needed.
> 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Other than the tirivial subject prefix inconsistency, looks good to me.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
>

Thanks.

> > ---
> >  mm/damon/core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4ad5f290d382..89982e0229f0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2051,13 +2051,15 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  
> >  	rcu_read_lock();
> >  	memcg = mem_cgroup_from_id(goal->memcg_id);
> > -	rcu_read_unlock();
> > -	if (!memcg) {
> > +	if (!memcg || !mem_cgroup_tryget(memcg)) {
> 
> For this part, I was thinking '!memcg' part seems not technically needed
> because mem_cgroup_tryget() does the check.  But I think that's just trivial,
> so this also looks good to me.
> 

Hmm !memcg check inside mem_cgroup_tryget() is a weird one. It makes
mem_cgroup_tryget() to return true for NULL parameter. We can not use
mem_cgroup_tryget() as is alone here.

