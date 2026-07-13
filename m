Return-Path: <cgroups+bounces-17703-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3tIPER+9VGqLqQMAu9opvQ
	(envelope-from <cgroups+bounces-17703-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:25:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6617C749C45
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sN6l9GTE;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17703-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17703-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84FDA3006D66
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212B3E2AB7;
	Mon, 13 Jul 2026 10:25:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52635F61A
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938328; cv=none; b=JrEkPndNq68dxXZMr4R3r4qqC2hIH1Uu17UEvddr9EDKxP6inf5j+dJdyvDxijwfAXqEB8uFRGZGnoIcd92klTnDlgDE3FSgeXpAdeAvbkqR5LgjCN+D5NGHsC4kYr9sEsyCHZL13DH3tP1wCHL3ulRWSAQdY2FNAwSc/cY9Mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938328; c=relaxed/simple;
	bh=o6tUKgiv8fjikrdP2007YLNMEiKDcpVQzLNUXlpXokk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IRkz0psZA5YTpWeHCMTuejYsllIxOGG6R9/B7xOiECPLJKo+M2nVOL4RaPySLw2o2HFHhN1dLAHOE9K3Oa7kdhYvaJ5cznftmW4NzJBrvRu8ZUpFSl54Bhce2kYYdiCNkRVB0edKv+1fvC1adwJ3KLIQWsnH3cE0V1zb/77Xk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sN6l9GTE; arc=none smtp.client-ip=95.215.58.180
Message-ID: <e24b7c7d-27d6-4bd6-9746-37d9b9b34297@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783938324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bis2MuGXWFD5TpnswdWqxFN7wnvNbqtWSAdebpKoWII=;
	b=sN6l9GTEytX0lp2CAY/Anp4qUSVkuPKf2U4INDn4nV90Pn732VdVEz8fSkZiKY6lYnxSm7
	Pl2JoorWdT9H4F4J0460Qmjlx7fMD67LccUIuQ47d2Nuwe1T76Rtdrqjr1pgClyVxHdrFx
	uekrnxwt0gZbZ1eg4AJkuRe/gMoHXg0=
Date: Mon, 13 Jul 2026 18:25:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: factor out memcg kmem uncharge sequence
To: Guopeng Zhang <guopeng.zhang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17703-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6617C749C45



在 2026/7/13 17:03, Guopeng Zhang 写道:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> The kmem-uncharge sequence (mod_memcg_state(MEMCG_KMEM) +
> memcg1_account_kmem + conditional memcg_uncharge) is duplicated verbatim
> in obj_cgroup_release() and drain_obj_stock_slot(). Factor it into a
> small memcg_uncharge_kmem() helper. The reference get/put stays at the
> call sites, as they differ.
> 
> No functional change.
Acked-by: Tao Cui <cuitao@kylinos.cn>
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  mm/memcontrol.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 22f55aeb94f3..86acfe55a201 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -137,6 +137,14 @@ bool mem_cgroup_kmem_disabled(void)
>  
>  static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
>  
> +static void memcg_uncharge_kmem(struct mem_cgroup *memcg, unsigned int nr_pages)
> +{
> +	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
> +	memcg1_account_kmem(memcg, -nr_pages);
> +	if (!mem_cgroup_is_root(memcg))
> +		memcg_uncharge(memcg, nr_pages);
> +}
> +
>  static void obj_cgroup_release(struct percpu_ref *ref)
>  {
>  	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> @@ -172,10 +180,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  		struct mem_cgroup *memcg;
>  
>  		memcg = get_mem_cgroup_from_objcg(objcg);
> -		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
> -		memcg1_account_kmem(memcg, -nr_pages);
> -		if (!mem_cgroup_is_root(memcg))
> -			memcg_uncharge(memcg, nr_pages);
> +		memcg_uncharge_kmem(memcg, nr_pages);
>  		mem_cgroup_put(memcg);
>  	}
>  
> @@ -3329,10 +3334,7 @@ static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
>  
>  			memcg = get_mem_cgroup_from_objcg(old);
>  
> -			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
> -			memcg1_account_kmem(memcg, -nr_pages);
> -			if (!mem_cgroup_is_root(memcg))
> -				memcg_uncharge(memcg, nr_pages);
> +			memcg_uncharge_kmem(memcg, nr_pages);
>  
>  			css_put(&memcg->css);
>  		}


