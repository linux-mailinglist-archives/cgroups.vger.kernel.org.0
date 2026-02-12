Return-Path: <cgroups+bounces-13897-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB6xAgfxjWlw8wAAu9opvQ
	(envelope-from <cgroups+bounces-13897-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:25:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72412EE61
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC7B308AFC7
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2B21B9E2;
	Thu, 12 Feb 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lytg6Qp9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4C9R0cYy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lytg6Qp9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4C9R0cYy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D961C3F0C
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909852; cv=none; b=eZkABls5BfnwlfUxG2kyyZN8p7nDMdw6ZB5n0QJ9csJO2qUYK4ClERhOihtCT/+VhZ/TO+O6AlW+NOS/zaUAiZfGOLzKKfd8TK3zjTkxsjyIZol7HezALAEdJ/fImVnFXdUoOs1D13bKVCIq/gZCPYESC0YSwaSfpjSD9i+fEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909852; c=relaxed/simple;
	bh=Zfbdjm3hLdSMHssQVniemRNbLholv/Lc92T/ow8RZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eb25c9yGc4L4jVYWken01JTQ2UobCooT2eQifYXdqN8OhiJpPTx8Avi6/dsBWx1RG4rCfxCnZjV51w/D5z3+MRs5d+hrOAbbcVaZ/cTmtVKO998psATLCmmUolwaxFbbiSgKOVdhCGbk34pkc/uVEULN5WxRi8SDY6e/+eVTzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lytg6Qp9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4C9R0cYy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lytg6Qp9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4C9R0cYy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20D905BDB6;
	Thu, 12 Feb 2026 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770909849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F4SLcQ4z8GXHuyKxamRQrFsRBxtsMZ9MpcvRbYRiuiA=;
	b=Lytg6Qp9fMZWWfA68K6rS0nZ9tB6WIjlKhzihmPwAsKyRLUNufE6+vXl258+/L/nuGNOZH
	78aldcGJAIFPKUG+7Uzj0Ta7yUYceS0fiVjxX08JE3G+X3v5v4TYJyB9HGfq1t0BZzeM7Z
	k029c8F0mBtir5mOsrgONpZSDT7CRx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770909849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F4SLcQ4z8GXHuyKxamRQrFsRBxtsMZ9MpcvRbYRiuiA=;
	b=4C9R0cYywZzIR65rDSkiadbU1IYj33vAQw5u6/iQ6GolOz2eyv2lEEopqBUzsY14vfU//u
	6xMMLyDPayt0OMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770909849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F4SLcQ4z8GXHuyKxamRQrFsRBxtsMZ9MpcvRbYRiuiA=;
	b=Lytg6Qp9fMZWWfA68K6rS0nZ9tB6WIjlKhzihmPwAsKyRLUNufE6+vXl258+/L/nuGNOZH
	78aldcGJAIFPKUG+7Uzj0Ta7yUYceS0fiVjxX08JE3G+X3v5v4TYJyB9HGfq1t0BZzeM7Z
	k029c8F0mBtir5mOsrgONpZSDT7CRx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770909849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F4SLcQ4z8GXHuyKxamRQrFsRBxtsMZ9MpcvRbYRiuiA=;
	b=4C9R0cYywZzIR65rDSkiadbU1IYj33vAQw5u6/iQ6GolOz2eyv2lEEopqBUzsY14vfU//u
	6xMMLyDPayt0OMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C533EA62;
	Thu, 12 Feb 2026 15:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fhAMLZjwjWkeMQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 12 Feb 2026 15:24:08 +0000
Message-ID: <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
Date: Thu, 12 Feb 2026 16:24:08 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Content-Language: en-US
To: JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, mhocko@suse.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260212045109.255391-2-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13897-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,cmpxchg.org:email]
X-Rspamd-Queue-Id: 5F72412EE61
X-Rspamd-Action: no action

On 2/12/26 05:51, JP Kobryn wrote:
> It would be useful to see a breakdown of allocations to understand which
> NUMA policies are driving them. For example, when investigating memory
> pressure, having policy-specific counts could show that allocations were
> bound to the affected node (via MPOL_BIND).
> 
> Add per-policy page allocation counters as new node stat items. These
> counters can provide correlation between a mempolicy and pressure on a
> given node.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

Are the numa_{hit,miss,etc.} counters insufficient? Could they be extended
in a way that would capture any missing important details? A counter per
policy type seems exhaustive, but then on one hand it might be not important
to distinguish beetween some of them, and on the other hand it doesn't track
the nodemask anyway.

> ---
>  include/linux/mmzone.h |  9 +++++++++
>  mm/mempolicy.c         | 30 ++++++++++++++++++++++++++++--
>  mm/vmstat.c            |  9 +++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fc5d6c88d2f0..762609d5f0af 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -255,6 +255,15 @@ enum node_stat_item {
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
>  	PGDEMOTE_PROACTIVE,
> +#ifdef CONFIG_NUMA
> +	PGALLOC_MPOL_DEFAULT,
> +	PGALLOC_MPOL_PREFERRED,
> +	PGALLOC_MPOL_BIND,
> +	PGALLOC_MPOL_INTERLEAVE,
> +	PGALLOC_MPOL_LOCAL,
> +	PGALLOC_MPOL_PREFERRED_MANY,
> +	PGALLOC_MPOL_WEIGHTED_INTERLEAVE,
> +#endif
>  #ifdef CONFIG_HUGETLB_PAGE
>  	NR_HUGETLB,
>  #endif
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 68a98ba57882..3c64784af761 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -217,6 +217,21 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
>  		new_iw[nid] /= iw_gcd;
>  }
>  
> +#define CHECK_MPOL_NODE_STAT_OFFSET(mpol) \
> +	BUILD_BUG_ON(PGALLOC_##mpol - mpol != PGALLOC_MPOL_DEFAULT)
> +
> +static enum node_stat_item mpol_node_stat(unsigned short mode)
> +{
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED);
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_BIND);
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_INTERLEAVE);
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_LOCAL);
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED_MANY);
> +	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_WEIGHTED_INTERLEAVE);
> +
> +	return PGALLOC_MPOL_DEFAULT + mode;
> +}
> +
>  int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
>  {
>  	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> @@ -2446,8 +2461,14 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  
>  	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
>  
> -	if (pol->mode == MPOL_PREFERRED_MANY)
> -		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
> +	if (pol->mode == MPOL_PREFERRED_MANY) {
> +		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
> +		if (page)
> +			__mod_node_page_state(page_pgdat(page),
> +					mpol_node_stat(MPOL_PREFERRED_MANY), 1 << order);
> +
> +		return page;
> +	}
>  
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>  	    /* filter "hugepage" allocation, unless from alloc_pages() */
> @@ -2472,6 +2493,9 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  			page = __alloc_frozen_pages_noprof(
>  				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
>  				nid, NULL);
> +			if (page)
> +				__mod_node_page_state(page_pgdat(page),
> +						mpol_node_stat(pol->mode), 1 << order);
>  			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
>  				return page;
>  			/*
> @@ -2484,6 +2508,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  	}
>  
>  	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
> +	if (page)
> +		__mod_node_page_state(page_pgdat(page), mpol_node_stat(pol->mode), 1 << order);
>  
>  	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
>  		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..74e0ddde1e93 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1291,6 +1291,15 @@ const char * const vmstat_text[] = {
>  	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
>  	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
>  	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
> +#ifdef CONFIG_NUMA
> +	[I(PGALLOC_MPOL_DEFAULT)]		= "pgalloc_mpol_default",
> +	[I(PGALLOC_MPOL_PREFERRED)]		= "pgalloc_mpol_preferred",
> +	[I(PGALLOC_MPOL_BIND)]			= "pgalloc_mpol_bind",
> +	[I(PGALLOC_MPOL_INTERLEAVE)]		= "pgalloc_mpol_interleave",
> +	[I(PGALLOC_MPOL_LOCAL)]			= "pgalloc_mpol_local",
> +	[I(PGALLOC_MPOL_PREFERRED_MANY)]	= "pgalloc_mpol_preferred_many",
> +	[I(PGALLOC_MPOL_WEIGHTED_INTERLEAVE)]	= "pgalloc_mpol_weighted_interleave",
> +#endif
>  #ifdef CONFIG_HUGETLB_PAGE
>  	[I(NR_HUGETLB)]				= "nr_hugetlb",
>  #endif


