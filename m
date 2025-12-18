Return-Path: <cgroups+bounces-12502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC806CCBE72
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3805B304C65A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7979633D6C0;
	Thu, 18 Dec 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="i1ycgD8O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B65334C20
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062860; cv=none; b=c6dkk5rdMTK49mRng2IdbS+R/hOWkC08T/VXj//sp6fMP+ft11G0FSVTDTBiZlIUbMexIVx2c58dGK5q305xuRNv0YJUOqY7rVvJeHQipTI18NvyzYOP3i8XX4GmhguSjnPaNzh/ttEKq4ekWrPiUGNzTBSmqs+F/IuCHD3TI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062860; c=relaxed/simple;
	bh=l8ozMIzwIt2g0HTicS4Uf8JKRpy3GZKapc/hx+niZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS1kKwMjg75X4QFQ52fryrgnTz0GigBLBzVn2tDbEQXrr/0l3p3zK6pdQ0mfdWKV7Gs70TQx2PpD1bQ1urPO1LVhDgmmnaFsAdL0UKtkOhPk6rZcWne8ZPJdsg9LtY6EvMEpqXxiyhzrHxJmD9/C6VlvXE3HBPgfnwWK3jNrK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=i1ycgD8O; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b602811a01so69792685a.2
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766062856; x=1766667656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eyZ4aAJQTuFKnA4DRtBfOSsfoPJif64nSNk4YyPQ9Ro=;
        b=i1ycgD8O6XJpZbAHDwxjwvGsxHqbf72BrIqiZY3A3xqt6+mvKGtv2JmTHgUvwk2/Up
         OFGDUQj2+tHSwk3yYpSmg/L4LyrXBIqoeEK7aQjLGxNm/rbofRVMTTW3nIUETol2UUcz
         U+FTdBwgAOjQvFaKlDvDaiJ00lZRfQiHOZA4XMXnTvjPtYrWkK5cpCKMzZgjeVB12i8t
         97GLJHDlqJiFjBlMYJ1XvZMnDj5gVVSJZI+Wu+E8Qy4gUHXlGdCekb624RkDfDQUaPLn
         Zmt73nDaQSY4KQivCIXTd58Kv3nJfvwOo6KBGG+L+P4xyEc1x6Gi+Dy2lcbnhjN7dIlz
         +JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766062856; x=1766667656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyZ4aAJQTuFKnA4DRtBfOSsfoPJif64nSNk4YyPQ9Ro=;
        b=qCNGx/iYj86Ih+ng+zqNVhWnQnTcUUsmxJuAHFzCQM1c8nNRwId9fhGxe/dpSbcKyz
         SE+zaE2TEAO6oRkwH8OM+ahrdm/q7EOMC4owJImQlVEEjCTyrKUItKKmv9EgATnCqR/q
         HnL5Ohj3w4VlnCswPqG6+szhOj+cwF92AFf9lUtanyZBte0X+ZvzyRZx+8mwmFiv6c5g
         N90/41jfdJMToiEQbyX22MzRu8SE2NkL1dPsY7newyvRBYUZ1kUm63loXZ7gtSmNy+wx
         9cZoLYNkGy8CmgGsFQ1tGn0NbVQo3tAcmuZRQybRR1kvH8f0Go1ehenTOn09eOuxgjR/
         Jx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDzC0lJzU4cc6j6kQamgKKBv1VMtSJ2ShyFjci8t98HssCgBsG52J727vNeY9JLblfxAUeMfAr@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgzB0MTsQVY6Z4nyJ5bC5Tbaq7+RUAVuYmPSeC7pGHbn+pIgj
	0LDbgLYYhDzzcfTFuvLsRvZFv1YOb9/tAhDGCGgutOnzXNFKDY+pB2mDv8Zt6T5gn4E=
X-Gm-Gg: AY/fxX4df7HJTNEqGTKwG05ctqDCVP16k4midFiEOEHTIElXLrop8ArMp1RP9vF0oQ8
	HgiBlG2KNAhj0LY/svXTKqus4TrJXcE7ES6SNbDThjQBnkG5Sre6/V/a/EGt0Ic7rE5E7EyiJde
	T42Nt7J1c0hDozbol3H7dEE0IFtIn6epzF9FleSw1Bbb376/NwbrxrqxyDVDeTV5dv3RPqMNCly
	JVRgUIFXD+F+9wqz1nHeWTwijhE00f8M9KTMQhUW2px0gEIfnW7JjKmttS7bQMXf3tQEsgfna1k
	5ozx6TXOEE/Pw2pz/RnVPHFj/PGoYwxK9dZKOQpXpN6fY/QYZuF733aso/khGJz0/2KhMLOC4jd
	w/ltguYxQwnnCzVBmxw3c3XsBhFQ2nsRWEIkSzqkl91k45swnEIrupC4UgGVRNG0TEx0ikTYW57
	VRPSnMFVf9EcevcbmGJoxJ
X-Google-Smtp-Source: AGHT+IG6q+Bxs2SFIn60tS6Ai7tNXLIL/tEA/j0R5OH5fPvCoMnlyzZLehM9/wUFoyArtHFrlTTFZA==
X-Received: by 2002:a05:620a:4010:b0:8a2:ef8:348c with SMTP id af79cd13be357-8bb399d9747mr2950051085a.2.1766062851153;
        Thu, 18 Dec 2025 05:00:51 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089eda7sm15995056d6.34.2025.12.18.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:00:50 -0800 (PST)
Date: Thu, 18 Dec 2025 08:00:46 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 23/28] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <aUP6_o9WqPv8Y7d-@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:47PM +0800, Qi Zheng wrote:
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
> ---
>  include/linux/memcontrol.h | 26 ++++++++-----------
>  mm/compaction.c            | 29 ++++++++++++++++-----
>  mm/memcontrol.c            | 53 +++++++++++++++++++-------------------
>  3 files changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 69c4bcfb3c3cd..85265b28c5d18 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -740,7 +740,11 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>   * folio_lruvec - return lruvec for isolating/putting an LRU folio
>   * @folio: Pointer to the folio.
>   *
> - * This function relies on folio->mem_cgroup being stable.
> + * The user should hold an rcu read lock to protect lruvec associated with
> + * the folio from being released. But it does not prevent binding stability
> + * between the folio and the returned lruvec from being changed to its parent
> + * or ancestor (e.g. like folio_lruvec_lock() does that holds LRU lock to
> + * prevent the change).

Can you please make this separate paragraphs to highlight the two
distinct modes of access? Something like this:

Call with rcu_read_lock() held to ensure the lifetime of the returned
lruvec. Note that this alone will NOT guarantee the stability of the
folio->lruvec association; the folio can be reparented to an ancestor
if this races with cgroup deletion.

Use folio_lruvec_lock() to ensure both lifetime and stability of the
binding. Once a lruvec is locked, folio_lruvec() can be called on
other folios, and their binding is stable if the returned lruvec
matches the one the caller has locked. Useful for lock batching.

Everything else looks good to me.

Thanks for putting so much effort into making these patches clean,
well-documented, and the series so easy to review!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

