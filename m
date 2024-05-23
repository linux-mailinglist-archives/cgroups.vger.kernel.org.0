Return-Path: <cgroups+bounces-2984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404CE8CCEB1
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717A51C217AB
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AC13CA99;
	Thu, 23 May 2024 08:57:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D013C9DC
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454654; cv=none; b=qYwdygRV0oxoVPEzCuTEH44YoYZtMLpyejnn7IlQ4zs2zd5sf13RdKz/lW6miGtwh4womMQeFlpn5U4MxWow1Xly7tIybEe2ZpDIPvXC4XtAoEsB1ry9CR5MTWmnxo86dbydRO7EDqTR2Ltd1r9SlffZgEj1MAkrNZEJ6dHGKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454654; c=relaxed/simple;
	bh=IYPQbTShoyucfvKHYBVUia9Ap2OgO+MoSeAHZ42w1eU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=K0sdw+75u6Ia/6/Sta5Tn+nI4lt8jftP5HCnDnfv5BEaYHWtlebw5D1Fm+k2mE80tD4M25uGQqvqeXNXVaUl3/6j4HBdFiwXlC+uWCgThTIDgD3Prh69vRUpzQUSEPvahWj3P9FFFjDhNfXlepNNLZQeyiB64TDQp+CARRnH8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlMQv4h3lzwPXR;
	Thu, 23 May 2024 16:53:43 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 19D491401E9;
	Thu, 23 May 2024 16:57:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 May 2024 16:57:22 +0800
Message-ID: <da794fd1-562a-4e75-b79f-fc4067aa1941@huawei.com>
Date: Thu, 23 May 2024 16:57:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
To: Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox
	<willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
 <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
Content-Language: en-US
In-Reply-To: <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/22 3:29, Shakeel Butt wrote:
> On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
>> On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
>>> The page_memcg() only called by mod_memcg_page_state(), so squash it to
>>> cleanup page_memcg().
>>
>> This isn't wrong, except that the entire usage of memcg is wrong in the
>> only two callers of mod_memcg_page_state():
>>
>> $ git grep mod_memcg_page_state
>> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
>> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
>> mm/vmalloc.c:           mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
>> mm/vmalloc.c:                   mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
>>
>> The memcg should not be attached to the individual pages that make up a
>> vmalloc allocation.  Rather, it should be managed by the vmalloc
>> allocation itself.  I don't have the knowledge to poke around inside
>> vmalloc right now, but maybe somebody else could take that on.
> 
> Are you concerned about accessing just memcg or any field of the
> sub-page? There are drivers accessing fields of pages allocated through
> vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
> pages should be split rather than compound").

Maybe Matthew want something shown below, move the memcg MEMCG_VMALLOC 
stat update from per-page to per-vmalloc-allocation? It should be speed 
up the statistic after conversion.

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e4a631ec430b..89f115623124 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -55,6 +55,9 @@ struct vm_struct {
  	unsigned long		size;
  	unsigned long		flags;
  	struct page		**pages;
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup	*objcg;
+#endif
  #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
  	unsigned int		page_order;
  #endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3aa2dc88a8..3e28c382f604 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3001,6 +3001,49 @@ static inline void set_vm_area_page_order(struct 
vm_struct *vm, unsigned int ord
  #endif
  }

+#ifdef CONFIG_MEMCG_KMEM
+static void vmalloc_memcg_alloc_hook(struct vm_struct *area, gfp_t gfp,
+				     int nr_pages)
+{
+	struct obj_cgroup *objcg;
+
+	if (!memcg_kmem_online() || !(gfp & __GFP_ACCOUNT))
+		return;
+
+	objcg = get_obj_cgroup_from_current();
+	if (objcg)
+		return;
+
+	area->objcg = objcg;
+
+	rcu_read_lock();
+	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_VMALLOC, nr_pages);
+	rcu_read_unlock();
+}
+
+static void vmalloc_memcg_free_hook(struct vm_struct *area)
+{
+	struct obj_cgroup *objcg = area->objcg;
+
+	if (!objcg)
+		return;
+
+	rcu_read_lock();
+	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_VMALLOC, -area->nr_pages);
+	rcu_read_unlock();
+
+	obj_cgroup_put(objcg);
+}
+#else
+static void vmalloc_memcg_alloc_hook(struct vm_struct *area, gfp_t gfp,
+				     int nr_pages)
+{
+}
+static void vmalloc_memcg_free_hook(struct vm_struct *area)
+{
+}
+#endif
+
  /**
   * vm_area_add_early - add vmap area early during boot
   * @vm: vm_struct to add
@@ -3338,7 +3381,6 @@ void vfree(const void *addr)
  		struct page *page = vm->pages[i];

  		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
  		/*
  		 * High-order allocs for huge vmallocs are split, so
  		 * can be freed as an array of order-0 allocations
@@ -3347,6 +3389,7 @@ void vfree(const void *addr)
  		cond_resched();
  	}
  	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
+	vmalloc_memcg_free_hook(vm);
  	kvfree(vm->pages);
  	kfree(vm);
  }
@@ -3643,12 +3686,7 @@ static void *__vmalloc_area_node(struct vm_struct 
*area, gfp_t gfp_mask,
  		node, page_order, nr_small_pages, area->pages);

  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-	if (gfp_mask & __GFP_ACCOUNT) {
-		int i;
-
-		for (i = 0; i < area->nr_pages; i++)
-			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
-	}
+	vmalloc_memcg_alloc_hook(area, gfp_mask, area->nr_pages);

  	/*
  	 * If not enough pages were obtained to accomplish an

