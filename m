Return-Path: <cgroups+bounces-12539-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92203CD24AF
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8620730133E5
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9FB25291B;
	Sat, 20 Dec 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qe1wjWu2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E61339A4
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766192755; cv=none; b=W2wZUUDtOFwXngwks5sbPFMIImK2bWzZMPjLuAQ1S/thNl/fGWyesKhkkUKBb0+1DXVTfGDh+B/qTGoNo94H9djVCNuVM5P26TarHVFzqa++5ustjCYz24PDThNc2gTv1/G1IpEi+ReU/BgtYEuW1r0YYQ7uLhBnieb2z0ntjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766192755; c=relaxed/simple;
	bh=KuBuGtA9JnzerTFUirXElRi17VPPi50gkE59HyXQOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1kdmX2eizchFdbx8wMTo8wnUxjKpQN2ec6VYBov18n9jTgWvDBaha9L7zrpUS2z326xYNoRUqNrajzu+pGgbZaOUTQ1azoPvzZQh0GrRCZIL2kwJHUKR2DaGiVtbLBSzhoEpT6FDIlTzAd9agwHG6xUt2UxFXDBFWHUEbaDB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qe1wjWu2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 17:05:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766192735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfLNkGCAF0+g8Lnr0ESMOHhXlA4+J+E6HZL9gx3I48E=;
	b=qe1wjWu2ZXycHOf1GXkHnl23q0KLg38QouBXIGvd0M4pC0ZD1tOXAcRAy/uCkYXh7k+F6S
	jzTMdMkhcwzirSsBRSGQdDpXSmVum6lYJpYCGuCq9VBSVJWi82V1pnaHZ9LJf9neFzCR30
	dSW6yj6SFyHQQ9w18Pu8Ntm+7hwh0gQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 15/28] mm: memcontrol: prevent memory cgroup release
 in mem_cgroup_swap_full()
Message-ID: <hvta76slujbvyb4av4cgipcevd7jctjrq2tmyw2pwpynfpjytg@ihr3aqp2brzq>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:39PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in mem_cgroup_swap_full().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 131f940c03fa0..f2c891c1f49d5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5267,17 +5267,21 @@ bool mem_cgroup_swap_full(struct folio *folio)
>  	if (do_memsw_account())
>  		return false;
>  
> -	memcg = folio_memcg(folio);
> -	if (!memcg)
> +	if (!folio_memcg_charged(folio))
>  		return false;
>  
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
>  	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>  		unsigned long usage = page_counter_read(&memcg->swap);
>  
>  		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
> -		    usage * 2 >= READ_ONCE(memcg->swap.max))
> +		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
> +			rcu_read_unlock();
>  			return true;
> +		}
>  	}
> +	rcu_read_unlock();
>  
>  	return false;
>  }

How about the following?


 bool mem_cgroup_swap_full(struct folio *folio)
 {
 	struct mem_cgroup *memcg;
+	bool ret = false;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (vm_swap_full())
 		return true;
-	if (do_memsw_account())
-		return false;
 
-	if (!folio_memcg_charged(folio))
-		return false;
+	if (do_memsw_account() || !folio_memcg_charged(folio))
+		return ret;
 
 	rcu_read_lock();
 	memcg = folio_memcg(folio);
@@ -5277,13 +5276,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
 		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
-			rcu_read_unlock();
-			return true;
+			ret = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 

Anyways LGTM.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

