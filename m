Return-Path: <cgroups+bounces-16583-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k7EODNxAH2rRjAAAu9opvQ
	(envelope-from <cgroups+bounces-16583-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 22:45:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520E631DA1
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 22:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="syh/dB1E";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16583-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16583-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B923073FBA
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2237EFFE;
	Tue,  2 Jun 2026 20:37:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF037DE84;
	Tue,  2 Jun 2026 20:37:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432629; cv=none; b=dd3O6dnIbaHgl6WB0wYAo9zHRGUHjULpiLceDzcrT0/BfpLsx8/hKapsP5kf/B3HZSgD1fKr6QHWnJw5wp5ierqcszjARvAAeLjFHkkrXsOXnq3lEPqvhH9kpBn/z53pzd3To7kGI0wBHg0B52NFNsKFYQ5auCJglC4ti22IxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432629; c=relaxed/simple;
	bh=O1rAUejDHDgfdnLQmGGCPXUd52eBDWEuCSfY1iQbmjc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B3AfDg1PqT41ixHsTZI5p4GQKraBsN84Tmc9X0kUcJ0OmWVAtt7Hyy538QitK6IozEjGrAamBKpIB63pB/ba+vDOBO6pQWuiGa8IseamIXocywJvT+3JCXWxrP1oS/10ufC3sAmf/9BMnAf2qwN13O53Q/axxQFYQq/wZxtJsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=syh/dB1E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152EB1F00893;
	Tue,  2 Jun 2026 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780432627;
	bh=+i6QVlrk9KIwFEZhpsKIC890QBmDvw0SsLedgmaGYs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=syh/dB1EW+9SWFgHZbUvo/EUL4RkLrCLodacuueVZmydHJsnt91C8Iw4O01J/tcJ1
	 yp+YEy/RYVdEnLv1TC3ckLEQpOKlgNf8WjYIVSlvgaeKES+5ITABh6XGCz5sBgmo1p
	 K7V4uTlNEL7gKItw1AKMDTl5LEmtliP6m7TSpWRg=
Date: Tue, 2 Jun 2026 13:37:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, ljs@kernel.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, qi.zheng@linux.dev, yosry.ahmed@linux.dev,
 ziy@nvidia.com, liam@infradead.org, usama.arif@linux.dev, kas@kernel.org,
 vbabka@kernel.org, ryncsn@gmail.com, zaslonko@linux.ibm.com,
 gor@linux.ibm.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 npache@redhat.com, ryan.roberts@arm.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Johannes Weiner
 <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when
 queues drain
Message-Id: <20260602133706.d737a82858d1cf89870521b1@linux-foundation.org>
In-Reply-To: <20260602043453.67597-1-lance.yang@linux.dev>
References: <20260602043453.67597-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:wangkefeng.wang@huawei.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16583-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org,cmpxchg.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp,linux-foundation.org:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9520E631DA1

On Tue,  2 Jun 2026 12:34:53 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> From: Lance Yang <lance.yang@linux.dev>
> 
> deferred_split_count() returns the raw list_lru count. When the per-memcg,
> per-node list is empty, that count is 0.
> 
> That skips scanning, but it does not tell memcg reclaim that the shrinker
> is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
> count callback reports SHRINK_EMPTY.
> 
> Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
> cleared once the queue has drained.
> 
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/huge_memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 72f6caf0fec6..62d598290c3b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	return list_lru_shrink_count(&deferred_split_lru, sc);
> +	unsigned long count;
> +
> +	count = list_lru_shrink_count(&deferred_split_lru, sc);
> +	return count ?: SHRINK_EMPTY;
>  }
>  
>  static bool thp_underused(struct folio *folio)

Should this be handled as a fix against hannes's "mm: switch deferred
split shrinker to list_lru"?

