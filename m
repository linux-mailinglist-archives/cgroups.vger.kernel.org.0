Return-Path: <cgroups+bounces-16175-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CIhMDRPD2orJAYAu9opvQ
	(envelope-from <cgroups+bounces-16175-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:30:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D905AB0DE
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72E0A302CD8F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BC385D73;
	Thu, 21 May 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nn0RhuLt"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9BC356772;
	Thu, 21 May 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383792; cv=none; b=eLiP+29zHZmg9NiMWbs2QuRtr24u6/witv++cVDkTm9K6zEgt0WG/DaeIoXfEZXJXI/64DTBfa3BTFKQMqIsDcOANBeCUccfoFBJtmL7M0AOWSjFx5bCA6haeqwtGg55rdLy/znFl5QtLzK/Ll3vjLJdyZbXA63A0crbDdHNXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383792; c=relaxed/simple;
	bh=unCOtkOJHen8QuSgfWhY245dfUHtUhG81v6pc4tzHPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEL0wFzfprn/syPiqV1cYbBi7AzzUOu/ydcrz+dwIeg0j1AzdR+Sq4UMhwOGxoGzFXyiRKdHIQ6sD/GD8ds+cnjKJ2j0A5RiNIcy82UTnEpNwqFtrW4PJvxzrF1snyr3Aq5iVd4oB2yjaob/sUrJ3mEhyJOtgDWKt07Z1BtG6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nn0RhuLt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AsXEHk+wQ7EGCCKqWRMSIo2T9JwmFiZUhbTO9jKUkLI=; b=nn0RhuLtF6x1IqTDzwqxrszFR1
	S5BMrxn7FiuJefdfEamPy626eRtCy/cjSwjhhTggzIDf+vpm94pxLm6sWGVCbQbj9sX03KhxUJaNo
	xlNiurB8Vl5IvaQM4tiNAccVKVDMdlFBDk7uZ73CsiaI3LKz4t9FIBJKRoDp28GTgdP9AHy51vhVz
	oM/WJThW8mOqhG1ahrXSEpDLS+7Vo62RRPY1dK/0OwQgkZcgf34ozedDH18FjFyPf8zzEGiUXoxnW
	b1hu64aN0DCh10sgRg1uYnY/1HDPNDAv3K9gI48bZWYKcUVPqRjyzC2koJmJBwSL+F7xlapU8ln5W
	BDuucjKg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ70P-00000008bea-2tAW;
	Thu, 21 May 2026 17:16:21 +0000
Date: Thu, 21 May 2026 13:16:18 -0400
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
Subject: Re: [PATCH v4 1/8] mm: list_lru: lock_list_lru_of_memcg() cannot
 return NULL if !skip_empty
Message-ID: <cw6jle5lxrujsrp6c7djldwwsnwxh42avxy2j6lbpcjxhosyml@7k7clowspzx4>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
 <20260521150330.1955924-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521150330.1955924-2-hannes@cmpxchg.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16175-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,infradead.org:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 03D905AB0DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/21 11:02AM, Johannes Weiner wrote:
> skip_empty is only for the shrinker to abort and skip a list that's
> empty or whose cgroup is being deleted.
> 
> For list additions and deletions, the cgroup hierarchy is walked
> upwards until a valid list_lru head is found, or it will fall back to
> the node list. Acquiring the lock won't fail. Remove the NULL checks
> in those callers.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  mm/list_lru.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index dd29bcf8eb5f..d3619961a7ac 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -165,8 +165,6 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
>  	struct list_lru_one *l;
>  
>  	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
> -	if (!l)
> -		return false;
>  	if (list_empty(item)) {
>  		list_add_tail(item, &l->list);
>  		/* Set shrinker bit if the first element was added */
> @@ -204,9 +202,8 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
>  {
>  	struct list_lru_node *nlru = &lru->node[nid];
>  	struct list_lru_one *l;
> +
>  	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
> -	if (!l)
> -		return false;
>  	if (!list_empty(item)) {
>  		list_del_init(item);
>  		l->nr_items--;
> -- 
> 2.54.0
> 

