Return-Path: <cgroups+bounces-16177-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEn0GVxPD2orJAYAu9opvQ
	(envelope-from <cgroups+bounces-16177-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:30:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64E5AB0FC
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5234430536DE
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C32384CED;
	Thu, 21 May 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TvW4VxNY"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9437DE97;
	Thu, 21 May 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383867; cv=none; b=nIfR9s8WOZIKnBqn4ub8AUU/RnZHE8rN37ajduWNPiodIWJdE1ZHfXHafYtDtmtUnvtOtSrzaTQr+o8ZNeZVZlqUwBNnlpHcxaHWTHzD4E0tSDY9M9Qdn6MiEg/bvKZUf/HI+i2FxYUC3JvdN2Jc/UNpboremiSVji9B3Tn6o7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383867; c=relaxed/simple;
	bh=Dcsm8sRzfpH7P2hNmElIyQZZkVLkLh257Vairc8ERaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9XV20K0oK19vpqqvenhu9d1mju4vOJz441lmEBtyqDms0Y/YwFE4zvHOxL0usvnMH26jD4mn76x4cX9cKoo+4XOus5EbVLGQtlsmPE07RI0xpledr+Mbflfzfb7xuFv5IidHmy9JP2pyhV3WsfUSEs/Sbx6AoV6zJagA5qLjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TvW4VxNY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uuz2S8ezS9r8v7TY5V+0JhTDDl3lzIZ4VZXXv/MWTDg=; b=TvW4VxNY1zCujZR5KM6s8///6Y
	3cRidQGrGu4ppzmn9pMNxb63DtXe22OP8+DYICHa1xHLjG9pGtJOq88eHb5RTvCx0ehUotuTQxwHU
	b3c1P4VQ9g7jMXmWIp6FIXuqvmAOM7JX6vLJp6GTZVz1iGS3xutc5SSpeI+9V4rufT1WGWx3uhjhM
	idEwOxheRyplFT+d7xZqN37d0B0R8UCZgo9ihP+r4kmITf+cky8Oq+2IeNuASZP4rB3x1cIMVKAoI
	Hhtzgfq6AbELPW3kSPWc8j0+HK8DT4Q8mJF4jpG8jOIlc2pmOv5vhKAT/lnTdhdsv2ZTlMuDmHf4+
	VUjdDOSQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ71i-00000008buJ-1MFp;
	Thu, 21 May 2026 17:17:42 +0000
Date: Thu, 21 May 2026 13:17:39 -0400
From: "Liam R . Howlett" <liam@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Kairui Song <ryncsn@gmail.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] mm: list_lru: move list dead check to
 lock_list_lru_of_memcg()
Message-ID: <aqihmycbhhj2uzzpq53wczbb3wg6yajpz4nuswzrkgzykbfrog@gsnlohrtkdnd>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
 <20260521150330.1955924-4-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521150330.1955924-4-hannes@cmpxchg.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16177-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liam@infradead.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,infradead.org:email,infradead.org:dkim,cmpxchg.org:email]
X-Rspamd-Queue-Id: 6E64E5AB0FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/21 11:02AM, Johannes Weiner wrote:
> Only the MEMCG variant of lock_list_lru() needs to check if there is a
> race with cgroup deletion and list reparenting. Move the check to the
> caller, so that the next patch can unify the lock_list_lru() variants.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  mm/list_lru.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 9a68177619bf..9da6fce19832 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -68,17 +68,12 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  	return &lru->node[nid].lru;
>  }
>  
> -static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
> +static inline void lock_list_lru(struct list_lru_one *l, bool irq)
>  {
>  	if (irq)
>  		spin_lock_irq(&l->lock);
>  	else
>  		spin_lock(&l->lock);
> -	if (unlikely(READ_ONCE(l->nr_items) == LONG_MIN)) {
> -		unlock_list_lru(l, irq);
> -		return false;
> -	}
> -	return true;
>  }
>  
>  static inline struct list_lru_one *
> @@ -90,9 +85,13 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  	rcu_read_lock();
>  again:
>  	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> -	if (likely(l) && lock_list_lru(l, irq)) {
> -		rcu_read_unlock();
> -		return l;
> +	if (likely(l)) {
> +		lock_list_lru(l, irq);
> +		if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
> +			rcu_read_unlock();
> +			return l;
> +		}
> +		unlock_list_lru(l, irq);
>  	}
>  	/*
>  	 * Caller may simply bail out if raced with reparenting or
> -- 
> 2.54.0
> 

