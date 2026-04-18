Return-Path: <cgroups+bounces-15356-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d4dnKViP42lWIgEAu9opvQ
	(envelope-from <cgroups+bounces-15356-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 16:04:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B2421459
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956A1300F5F5
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A36384256;
	Sat, 18 Apr 2026 14:03:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA76382F01
	for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521007; cv=none; b=rZt9XO39KsVO/U3qkKv9JWQpgzxxaunDygIg/eQNBGt+vJLg8rQUSzi0qeBzk/gaCS/te+p/mnSLfAfuqWGfTPpHgNJZQunZeVCKQamgoMpufiM5jnG+4YT2UEKh4l3ntLnTgZv3/66N0d0Z4rpdMq7m1DybL8cFHBDf8+hZMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521007; c=relaxed/simple;
	bh=P4zMOxcJIq64DsotD8stHNlEpFpwgp5wccgZpRFgPjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULdTb8IiSq1IPyl9LR5OE9RYzNN+pFJs2QFEOW7TvP4Z6ZeP/1M+2opZ31r41oDFkaqEde6ndu3pjJRMoWOKk7uaudxFb+Xx06gdxl7iNJ2c1gNQk3tod99cPHQldCo6sVIc577DKOg+v+kpaFw4v1pDlue3EvuYgpmyfb9G9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 18 Apr 2026 23:03:22 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 18 Apr 2026 23:03:22 +0900
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
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 09/11] mm/memcg, swap: store cgroup id in cluster
 table directly
Message-ID: <aeOPKlF4qAdM2oMH@yjaykim-PowerEdge-T330>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
 <20260417-swap-table-p4-v2-9-17f5d1015428@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-swap-table-p4-v2-9-17f5d1015428@tencent.com>
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
	TAGGED_FROM(0.00)[bounces-15356-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A5B2421459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> +		if (IS_ENABLED(CONFIG_MEMCG) && !memcg_table) {
> +			swap_table_free(table);
> +			return -ENOMEM;
> +		}

Hi Kairui,

Nit: 
(Just a readability nit. purely my preference, feel free to ignore.)
the checks around swap_memcg_table_alloc() reduce to two
equivalent forms of the same memcg success/failure question:

(!IS_ENABLED(CONFIG_MEMCG) || memcg_table)   /* success */
(IS_ENABLED(CONFIG_MEMCG) && !memcg_table)   /* failure */

A macro for the failure side would let the call sites read as plain
positive/negative:

#define SWAP_MEMCG_TABLE_ALLOC_FAILED(t) \
	(IS_ENABLED(CONFIG_MEMCG) && !(t))

SWAP_MEMCG_TABLE_ALLOC_FAILED(memcg_table)     /* failure */
!SWAP_MEMCG_TABLE_ALLOC_FAILED(memcg_table)    /* success */

Equivalently, the same macro can be expressed by splitting on
CONFIG_MEMCG.

#ifdef CONFIG_MEMCG
#define SWAP_MEMCG_TABLE_ALLOC_FAILED(t)  (!(t))
#else
#define SWAP_MEMCG_TABLE_ALLOC_FAILED(t)  (0)
#endif

What do you think?

Thanks,
Youngjun Park

