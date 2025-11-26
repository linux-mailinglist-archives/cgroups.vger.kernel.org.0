Return-Path: <cgroups+bounces-12203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F183C87DDC
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A61E3B2279
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4030BBA3;
	Wed, 26 Nov 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BrbkkfWY"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624A800
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125390; cv=none; b=vA4Z1TzE+H2BFQRz9V5Dh0AFx4+WzwSrj7qmWsmUe7NcFl6G9+6C7pBgesP/X9rIONSG9Sb9wEWlLiOVDvnDF1EVtiU1bDYfunGCZEUuK7a6EXibVnNyqJbTcq/F7eVYyNyWw1lSwB9mY57jsO7JJKr1dhEbM8EOfn3S535q0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125390; c=relaxed/simple;
	bh=fD3hfo8OYSfdmXmreFkB4jWz4VPVqv6n/3eyy0P3pmE=;
	h=References:To:Subject:In-Reply-To:From:Date:Content-Type:
	 Mime-Version:Cc:Message-Id; b=AcDfw7Z+urMhzECTphSLtDXqb2RzYN1DlaK2/l7X4IOo/hYLzDWBocW0v6+eiPK8/IvOV/VhKwNavWpqnSgaIBFABei39aVE0Kby+7V8x3hxJxeP2+dPghSEM2oN7Oq8KjLgNLcjz9RLZi4orS46BtWazrJDf+kHAROPEOeOX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BrbkkfWY; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1764125374; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UnzWgwkKcFm0gU3oBGsqS8ePUelMPsY6QLSmu1dv/sA=;
 b=BrbkkfWYa2fAd1HS0Q5g0vSA5Cz9j0XaeL7CLGQmDmeWDNj1w04DEQBhwnUrkXbAXLA41J
 PVfDBoFMDY2i2VWLVR258v1abbzud35z1qjLN3VF5sc1awCCHMf5nmUTPGR5S0SoY/EvUn
 eFx3VrU1OoMyDNssGzl5o8qjeUJgmxjcECg1qS3K+DTEUlPut1eeMMPA61BPuQbnrKfEYx
 UFGd2Vt2Tu/tPfjVLA84mxsPbiAo7vDXFLJv6f1dYvKC7nsXKnbSejRyxHbk+c4Y0IVkv7
 mR/d+HIp2sSxxKXzcsBslCGc3qtmTiuwTTxNGCdnXJFNq49vbGPKYDciUPG4cA==
X-Original-From: Qi Zheng <zhengqi.arch@bytedance.com>
References: <20251126020435.1511637-1-chenridong@huaweicloud.com>
Content-Transfer-Encoding: 7bit
To: "Chen Ridong" <chenridong@huaweicloud.com>, <hannes@cmpxchg.org>, 
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, 
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, 
	<akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <axelrasmussen@google.com>, 
	<yuanchu@google.com>, <weixugc@google.com>
Subject: Re: [PATCH -next] memcg: Remove inc/dec_lruvec_kmem_state helpers
In-Reply-To: <20251126020435.1511637-1-chenridong@huaweicloud.com>
User-Agent: Mozilla Thunderbird
From: "Qi Zheng" <zhengqi.arch@bytedance.com>
Date: Wed, 26 Nov 2025 10:49:14 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+269266abc+f425e9+vger.kernel.org+zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>, 
	<chenridong@huawei.com>
Message-Id: <e8d2c5b3-eee2-46fd-9d67-422428bd8bf5@bytedance.com>

On 11/26/25 10:04 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The dec_lruvec_kmem_state helper is unused by any caller and can be safely
> removed. Meanwhile, the inc_lruvec_kmem_state helper is only referenced by
> shadow_lru_isolate, retaining these two helpers is unnecessary. This patch
> removes both helper functions to eliminate redundant code.

Make sense.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   include/linux/memcontrol.h | 10 ----------
>   mm/workingset.c            |  2 +-
>   2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d35390f9892a..0651865a4564 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1452,16 +1452,6 @@ struct slabobj_ext {
>   #endif
>   } __aligned(8);
>   
> -static inline void inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
> -{
> -	mod_lruvec_kmem_state(p, idx, 1);
> -}
> -
> -static inline void dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
> -{
> -	mod_lruvec_kmem_state(p, idx, -1);
> -}
> -
>   static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
>   {
>   	struct mem_cgroup *memcg;
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 892f6fe94ea9..e9f05634747a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -749,7 +749,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>   	if (WARN_ON_ONCE(node->count != node->nr_values))
>   		goto out_invalid;
>   	xa_delete_node(node, workingset_update_node);
> -	inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
> +	mod_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM, 1);
>   
>   out_invalid:
>   	xa_unlock_irq(&mapping->i_pages);

