Return-Path: <cgroups+bounces-12541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696ACD24D0
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7DD3023543
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DDA24A049;
	Sat, 20 Dec 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a8y3Ty2n"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4824C06A
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766193120; cv=none; b=GF3vy2ok45haebUJ0FNWb37pNyJPM390cC/jGHsqDNgLRa7PcfkJBj3Q9t+Fw2l5PAP5DOHM55keDeadwi+B5gImjrKUKrDzsF2DrYjFst6Ke2h7Ydvr7RiNMwf7zUlLGI76zxOyEAbvSELLKhYbqa9QdO1eTe4JgXxnSZvZD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766193120; c=relaxed/simple;
	bh=XNwOZRHCPNq8KGN1au8gwGibu7Ap52gzvt5LNyPZ6HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDpZ21GK+pmcJ/KZjznfts6kD4z7+vHgxNFgJuBI7hUMBFip56YIqiQWwr79/PptBDr1dNyWAsRcpN1UoqGQ44a/DdcwQ2nCygwwbd/EK6STGZ8BV3+vYddZI6/36qHwRnqRfazvuhJ4W/NUrxDuDwvhyjtKrXnrdXl215hBPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a8y3Ty2n; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 17:11:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766193106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvnodBTMRcGcxBVyqTPRhAjsSomVlkq7CG7vke7msug=;
	b=a8y3Ty2ne5jeTurW+9OC7NBn+BoMlmeDdprm7CiX2wYMZocn4luhcpPYTLExt8+wVR1aZp
	+4DP/BgB2+008fvKxfR8rXTh9KlUsjaqBMBzGQn00H6KFBpZ0gRvmQcJ2GR+Q2YGDhbCyI
	h4gqXvj53U2sfa1zPP2SVlKfpfCDZNA=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 17/28] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
Message-ID: <ejywj2fho37z4zdtgvryxzsztgtdrfop4ekenee4fewholyugq@xrbvtg5ui3ty>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMuRfPVxkfccdmp@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMuRfPVxkfccdmp@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 05:27:17PM -0500, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:41PM +0800, Qi Zheng wrote:
> > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > In the near future, a folio will no longer pin its corresponding memory
> > cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> > lock or acquire a reference to the memory cgroup returned by
> > folio_memcg(), thereby preventing it from being released.
> > 
> > In the current patch, the rcu read lock is employed to safeguard against
> > the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
> > 
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/huge_memory.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 12b46215b30c1..b9e6855ec0b6a 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1154,13 +1154,25 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
> >  
> >  static struct deferred_split *folio_split_queue_lock(struct folio *folio)
> >  {
> > -	return split_queue_lock(folio_nid(folio), folio_memcg(folio));
> > +	struct deferred_split *queue;
> > +
> > +	rcu_read_lock();
> > +	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
> > +	rcu_read_unlock();
> 
> Ah, the memcg destruction path is acquiring the split queue lock for
> reparenting. Once you have it locked, it's safe to drop the rcu lock.

Qi, please add the above explanation in a comment and with that:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

