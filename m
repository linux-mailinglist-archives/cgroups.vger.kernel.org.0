Return-Path: <cgroups+bounces-12738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B81FECDE394
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33473007FC1
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 02:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E199C1FDE39;
	Fri, 26 Dec 2025 02:12:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7946202F7C;
	Fri, 26 Dec 2025 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715130; cv=none; b=KtrarE9XB+LS6QzOdGCXt20Zb+LlQ6eQrI6/pGubjqJlGWKk3ZrdZg2izS6DOvupIceuQ5VbP6S5YBJ2RxqRb47bfPlgT/ZwW9G16IQOicR7oU36K16lYJUcQM4Dh9vuCS5WwT/Ut/lcjciUA0EBhEaPL5QPmSOSUGpueK7DScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715130; c=relaxed/simple;
	bh=6AKE4E+uFrbEFaz18ddJi4FraTJ5wNSgM9jX9E31BTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO2XXI5Ylz6Qk0O+fCwHD8e4dd9b62pkbSHLiHwRw/orw4zpEgf5ejZWDsbZ3VDk9scVGi3NiSqy1MyRH1MVZHhtA7AXT31lkdcWcMjXUk1K84R+mcDg/JnslXDfPHzUkI+ZRu4dUhHVVGyQVB7zxDOaGuYVIxp9exbNqIzCmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcpy15H9JzYQtm4;
	Fri, 26 Dec 2025 10:11:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 083C040571;
	Fri, 26 Dec 2025 10:12:03 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vbx7k1p_fwCBg--.54121S2;
	Fri, 26 Dec 2025 10:12:02 +0800 (CST)
Message-ID: <8354b8b7-2d94-431b-b60a-6a744ab7ca06@huaweicloud.com>
Date: Fri, 26 Dec 2025 10:12:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/28] mm: memcontrol: prevent memory cgroup release in
 count_memcg_folio_events()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA35vbx7k1p_fwCBg--.54121S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrWw45WFW3WFyDXryftFb_yoW8AF4fpF
	sxGwn8Ar48JrW7urnxK3W7Z3yfZ3yvgrsIyFWIkw1fZFyaqw1UGay7Kw1Yq3y5ArWIkF1x
	Xa1Y9rnrWayjqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/17 15:27, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in count_memcg_folio_events().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/memcontrol.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bc526e0d37e0b..69c4bcfb3c3cd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -974,10 +974,15 @@ void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  static inline void count_memcg_folio_events(struct folio *folio,
>  		enum vm_event_item idx, unsigned long nr)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct mem_cgroup *memcg;
>  
> -	if (memcg)
> -		count_memcg_events(memcg, idx, nr);
> +	if (!folio_memcg_charged(folio))
> +		return;
> +
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
> +	count_memcg_events(memcg, idx, nr);
> +	rcu_read_unlock();
>  }
>  
>  static inline void count_memcg_events_mm(struct mm_struct *mm,

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


