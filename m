Return-Path: <cgroups+bounces-17854-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iv8SMLaIV2rOWQAAu9opvQ
	(envelope-from <cgroups+bounces-17854-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:18:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6582F75E94F
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 15:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="gQNfz/n4";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17854-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17854-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AC0A304CD40
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94983E557F;
	Wed, 15 Jul 2026 13:15:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB9420493;
	Wed, 15 Jul 2026 13:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121300; cv=none; b=IDZa+Rz5HVHi4Ygik1RI+/lpz5ajikSCnnA2KSZMlu5ZGrmQxSeH5zbDsR4fMl6NbpfQkIy30qHqyWnjMzE4BaVolWsn39FyPduIDDBwRjxy5olHljaqN0JOQK6MQ7QSsXOcnoF/QbWG0bDga6fpbnmWh6lnLUYUFWmJk1dcVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121300; c=relaxed/simple;
	bh=wXWIOmQlAFsKQKh7NGu1MYJbt/eXwjt3MreYNkIAk7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHb+ihwbkwzCvh9s5KdA+BL8xhzDVdiw4/+9tMBdhU/ZZHj/vBZrYv9z4fmJetgbsZhBoJeuuyc8mv5isB5ekxb0MxEcBskx74nBWyI/K+oYg3P/Ap//s1mIeCYXE3DTQGqWDac7+NxjmUj36nF0DvHdQ/bXRNeyExb0hwY3vZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQNfz/n4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230F21F000E9;
	Wed, 15 Jul 2026 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784121299;
	bh=vM2dkF/6lSWo/swXz9lDfkksfM0DbUYYsHFUpZl+IKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gQNfz/n4GrHbrVnvIgE2OgeJCJJpUZ0ZBqZufkO6fvqW5Se77tNKewsBgZD/gpLKw
	 JGKciVFxEzfEslsNGysyRVW8RK/F1V/zPxlErEOezScbMjUbt8YpIo3K2A7BZFECdf
	 8HsJ6IVlKkA3c4aVgoM3uBIQYD/Je3wLfTrnZ0q9hzDP/uDmD5OwL5QRLGRG2vp+p4
	 ydiBCToxDIHDkoao24Nwh5wQVW+gIH4WSsWLjZ4BZTG0me1TUDGmc0v9NaRtK8it0A
	 xeTwzvdnny3Bm7oCxnh5tmaXhQrvqNlGk0yeNERqr4guHDUyMzA/agMzf1HPHhz0Yd
	 gCHZAswKY3DFg==
Message-ID: <ada7bf29-1bd2-4de0-bf3c-0916f0ce512f@kernel.org>
Date: Wed, 15 Jul 2026 15:14:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
 <20260715-spin-trylock-followup-v3-1-fc4d246f705d@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260715-spin-trylock-followup-v3-1-fc4d246f705d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jackmanb@google.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-17854-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6582F75E94F
X-Rspamd-Action: no action

On 7/15/26 13:03, Brendan Jackman wrote:
> As discussed in the linked patch, the there is some inconsistency between
> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
> used in the public API it seems to have more mindshare so do that.
> 
> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
> 
> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d3@google.com/
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index af63558391345..c2da85e69a0f8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -90,7 +90,7 @@ typedef int __bitwise fpi_t;
>  #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
>  
>  /* Free the page without taking locks. Rely on trylock only. */
> -#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
> +#define FPI_NOLOCK		((__force fpi_t)BIT(2))
>  
>  /* free_pages_prepare() has already been called for page(s) being freed. */
>  #define FPI_PREPARED		((__force fpi_t)BIT(3))
> @@ -1419,7 +1419,7 @@ static __always_inline bool __free_pages_prepare(struct page *page,
>  	page_table_check_free(page, order);
>  	pgalloc_tag_sub(page, 1 << order);
>  
> -	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
> +	if (!PageHighMem(page) && !(fpi_flags & FPI_NOLOCK)) {
>  		debug_check_no_locks_freed(page_address(page),
>  					   PAGE_SIZE << order);
>  		debug_check_no_obj_freed(page_address(page),
> @@ -1558,7 +1558,7 @@ static void free_one_page(struct zone *zone, struct page *page,
>  	struct llist_head *llhead;
>  	unsigned long flags;
>  
> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>  		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>  			add_page_to_zone_llist(zone, page, order);
>  			return;
> @@ -1569,7 +1569,7 @@ static void free_one_page(struct zone *zone, struct page *page,
>  
>  	/* The lock succeeded. Process deferred pages. */
>  	llhead = &zone->trylock_free_pages;
> -	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
> +	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_NOLOCK))) {
>  		struct llist_node *llnode;
>  		struct page *p, *tmp;
>  
> @@ -2882,7 +2882,7 @@ static bool free_frozen_page_commit(struct zone *zone,
>  	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
>  		pcp->free_count += (1 << order);
>  
> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>  		/*
>  		 * Do not attempt to take a zone lock. Let pcp->count get
>  		 * over high mark temporarily.
> @@ -2979,7 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
>  		migratetype = MIGRATE_MOVABLE;
>  	}
>  
> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
> +	if (unlikely((fpi_flags & FPI_NOLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
>  		     && (in_nmi() || in_hardirq()))) {
>  		add_page_to_zone_llist(zone, page, order);
>  		return;
> @@ -3002,7 +3002,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
>  
>  void free_frozen_pages_nolock(struct page *page, unsigned int order)
>  {
> -	__free_frozen_pages(page, order, FPI_TRYLOCK);
> +	__free_frozen_pages(page, order, FPI_NOLOCK);
>  }
>  
>  /*
> @@ -5399,7 +5399,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>  	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
>  		__free_frozen_pages(page, order,
> -				    alloc_flags & ALLOC_NOLOCK ? FPI_TRYLOCK : 0);
> +				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
>  		page = NULL;
>  	}
>  
> @@ -5522,7 +5522,7 @@ EXPORT_SYMBOL(__free_pages);
>   */
>  void free_pages_nolock(struct page *page, unsigned int order)
>  {
> -	___free_pages(page, order, FPI_TRYLOCK);
> +	___free_pages(page, order, FPI_NOLOCK);
>  }
>  
>  /**
> 


