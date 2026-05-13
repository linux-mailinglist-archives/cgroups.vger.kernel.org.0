Return-Path: <cgroups+bounces-15902-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA0bBZq6BGplNQIAu9opvQ
	(envelope-from <cgroups+bounces-15902-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:53:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A480D5385FD
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD20311653A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC04DC52E;
	Wed, 13 May 2026 17:41:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8A4C9559
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694094; cv=none; b=EZ1Yx73k11YcTM9U+EXQ2gIMrdhLYM7+Du07eumQ3lT0snTyRxsolvTvFh5HGbqhmtn4StpwYZcTiARw3ohP0tFDkjroUWs2UTqRlxIql3DFEv6vIMYXySCQOGEzBURTeXbutwFMQEFfknYCi4Ai8oDnJBxw/ba688MEn1mAUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694094; c=relaxed/simple;
	bh=Vr7/Xrv0tMa9g8fmuVhFX2qs3sgA07gCpOAcDwK3QMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnEylaLYWCz1ICRsr2uyD3iDS9E16ufh61jQr6kphazy8vZfJaLaLJ84T7SxYlGkXnVvcXX9OnjhV8pItg149TYWy/d+u7tzkVHF7GA90P9hKpjxhZ0hxLwj++Sj1B7i5FrlraqeXkES++C+4VUgJ0K5904zVbjOVuXFkcfcuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 14 May 2026 02:26:29 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 14 May 2026 02:26:29 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v3 04/12] mm, swap: add support for stable large
 allocation in swap cache directly
Message-ID: <agS0RbXpVMcYMI3g@yjaykim-PowerEdge-T330>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com>
X-Rspamd-Queue-Id: A480D5385FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15902-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 02:16:48PM +0800, Kairui Song via B4 Relay wrote:
...
>  static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
>  					   struct mempolicy *mpol, pgoff_t ilx,
>  					   struct swap_iocb **plug, bool readahead)
>  {
> -	struct swap_info_struct *si = __swap_entry_to_info(entry);
>  	struct folio *folio;
>  
>  	/* Check the swap cache again for readahead path. */
> @@ -594,16 +700,12 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
>  	if (folio)
>  		return folio;
> -	/* Skip allocation for unused and bad swap slot for readahead. */
> -	if (!swap_entry_swapped(si, entry))
> -		return NULL;
> -

Hello Kairui

With the swap_entry_swapped() check gone, the swap_cache_get_folio()
above the do-while is now just a duplicate of the loop's first
iteration. Might as well drop it (and the now-stale "again for readahead
path" comment) here.

Best regrads
Youngjun Park

>  	do {
>  		folio = swap_cache_get_folio(entry);
>  		if (folio)
>  			return folio;
>  
> -		folio = swap_cache_alloc_folio(entry, gfp, mpol, ilx);
> +		folio = swap_cache_alloc_folio(entry, gfp, 0, NULL, mpol, ilx);
>  	} while (IS_ERR(folio) && PTR_ERR(folio) == -EEXIST);

