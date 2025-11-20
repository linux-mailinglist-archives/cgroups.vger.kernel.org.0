Return-Path: <cgroups+bounces-12112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C02C73058
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 04CD829FA6
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E93101AD;
	Thu, 20 Nov 2025 09:07:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D377301482;
	Thu, 20 Nov 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629678; cv=none; b=uS6B1HaHR87BE17H8CSXpANcmv0MiJWSizuvnbpB2U803SrakxODWhPVkD/8vmHXgv8/j9zAKZ+UQGyX2p1ZxakfeWgruXrDUdzwFO8Tzc2NHGb0tHIHfSt9G4rZlwcVYokvqTUILdYsn5hkeaNm/1iriE5ey7sNdbkRF5Z4NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629678; c=relaxed/simple;
	bh=syXXEA1sesMjpLuWaTo/ef+m+i7L1E1is19+ply3miQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhC8Q/RoTA6iG4bZzQWJl+9yXLpF7m18MnYo6jk/txAGM3jQsOAOKrzAafIN+IIzn4CT3/xlHzocJCgcmcQw5LkUAngjkWck1Eq0bD0QHUxQgAMY440ermUqIXgflJDlr9wMbAtQO/tlgXG0XeajG/TP6OR9gWZ4tai5X0pwLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBstN0nz5zYQv5F;
	Thu, 20 Nov 2025 17:07:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA2FE1A0BE0;
	Thu, 20 Nov 2025 17:07:49 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgC3YXhk2h5pdWOOBQ--.29493S2;
	Thu, 20 Nov 2025 17:07:49 +0800 (CST)
Message-ID: <0d78a4cf-0973-4874-ab6a-978621a17068@huaweicloud.com>
Date: Thu, 20 Nov 2025 17:07:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/26] mm: memcontrol: remove dead code of checking
 parent memory cgroup
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <b13ff669bc3f52922e97fa0cc99e54df05585810.1761658310.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <b13ff669bc3f52922e97fa0cc99e54df05585810.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3YXhk2h5pdWOOBQ--.29493S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4kAw1xtF1kAw15tw4xWFg_yoW8trW5pF
	sxKa4UJay5Ar4UZF1aka1DZa4Sya1fta15Crn7J3WxXrnaqw1jqry7Kw1xCrZ8CFyfXrWY
	qF4qv3W8Kr45AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/28 21:58, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Since the no-hierarchy mode has been deprecated after the commit:
> 
>   commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").
> 
> As a result, parent_mem_cgroup() will not return NULL except when passing
> the root memcg, and the root memcg cannot be offline. Hence, it's safe to
> remove the check on the returned value of parent_mem_cgroup(). Remove the
> corresponding dead code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/memcontrol.c | 5 -----
>  mm/shrinker.c   | 6 +-----
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 93f7c76f0ce96..d5257465c9d75 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3339,9 +3339,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  		return;
>  
>  	parent = parent_mem_cgroup(memcg);
> -	if (!parent)
> -		parent = root_mem_cgroup;
> -
>  	memcg_reparent_list_lrus(memcg, parent);
>  
>  	/*
> @@ -3632,8 +3629,6 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>  			break;
>  		}
>  		memcg = parent_mem_cgroup(memcg);
> -		if (!memcg)
> -			memcg = root_mem_cgroup;
>  	}
>  	return memcg;
>  }
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 4a93fd433689a..e8e092a2f7f41 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -286,14 +286,10 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  {
>  	int nid, index, offset;
>  	long nr;
> -	struct mem_cgroup *parent;
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>  	struct shrinker_info *child_info, *parent_info;
>  	struct shrinker_info_unit *child_unit, *parent_unit;
>  
> -	parent = parent_mem_cgroup(memcg);
> -	if (!parent)
> -		parent = root_mem_cgroup;
> -
>  	/* Prevent from concurrent shrinker_info expand */
>  	mutex_lock(&shrinker_mutex);
>  	for_each_node(nid) {

LGTM.

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


