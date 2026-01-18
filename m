Return-Path: <cgroups+bounces-13292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18AD391FD
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B30730123D9
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E414A62B;
	Sun, 18 Jan 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sdCeKnJJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DF200C2
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768697175; cv=none; b=BeR9lN2f99pRhQID3MVJmh9IcyRx5d7N3N1EHu0tmOR598QdIpxwLV8KvyKivxEF+bEPsRmeezqooKcsfqPSZoBswQffGYbOOyAf5AkJh3igSk6MyFK0sK6nRRmORTpjLZ7bQgD7UO9tYl+XbMj2CUFiCXnlJhaqQZ/8psEmMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768697175; c=relaxed/simple;
	bh=nrbhCpghapFjF/r8AVKnl+nGaLX8SoDc2Q5wOdStEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OroZzx7SFf9htk1wvktl0s1T+ke1FV0DAJiHTu+KDdC6CSWTmd7ezNe2pWF6FygByPk5pYp9N/jzrCi5QNrc4hLV3H6vkIeJTRTjEraURagtcl9fuFML/JaZZgOncJ+p81abXSnSyjsNMCkm+8ftJ9IrPR3SDciffEShAdDh2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sdCeKnJJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 16:46:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768697171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l47ZvY/hwfvNnl4jWoQ7pv1llIdAqhn4iZv/kumEeH8=;
	b=sdCeKnJJvkgZFYFRMSdpNBNmk71Maj3t2PEoh9kra/jMVAbvFmJrYTWCL//s/aS35q+Fli
	YztFVArxSxj4F/GEh/tIuAJcxqsJvH1Ka5aC+kPn2CpyF8B/nWBduZoFPErZMybYizwyGa
	eGUKlzcKVc0qKohqoudSvIMpHhkA3iY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <y2ffln6h57xb6rx6nf56wbd7uafhdswlvivjzuydzckplg3s4z@lyoihmhamwb5>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:51PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The following diagram illustrates how to ensure the safety of the folio
> lruvec lock when LRU folios undergo reparenting.
> 
> In the folio_lruvec_lock(folio) function:
> ```
>     rcu_read_lock();
> retry:
>     lruvec = folio_lruvec(folio);
>     /* There is a possibility of folio reparenting at this point. */
>     spin_lock(&lruvec->lru_lock);
>     if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>         /*
>          * The wrong lruvec lock was acquired, and a retry is required.
>          * This is because the folio resides on the parent memcg lruvec
>          * list.
>          */
>         spin_unlock(&lruvec->lru_lock);
>         goto retry;
>     }
> 
>     /* Reaching here indicates that folio_memcg() is stable. */
> ```
> 
> In the memcg_reparent_objcgs(memcg) function:
> ```
>     spin_lock(&lruvec->lru_lock);
>     spin_lock(&lruvec_parent->lru_lock);
>     /* Transfer folios from the lruvec list to the parent's. */
>     spin_unlock(&lruvec_parent->lru_lock);
>     spin_unlock(&lruvec->lru_lock);
> ```
> 
> After acquiring the lruvec lock, it is necessary to verify whether
> the folio has been reparented. If reparenting has occurred, the new
> lruvec lock must be reacquired. During the LRU folio reparenting
> process, the lruvec lock will also be acquired (this will be
> implemented in a subsequent patch). Therefore, folio_memcg() remains
> unchanged while the lruvec lock is held.
> 
> Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
> after the lruvec lock is acquired, the lruvec_memcg_debug() check is
> redundant. Hence, it is removed.
> 
> This patch serves as a preparation for the reparenting of LRU folios.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

