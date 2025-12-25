Return-Path: <cgroups+bounces-12691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CBCDD420
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 04:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52AF63019B87
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C787258EF3;
	Thu, 25 Dec 2025 03:45:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29675748F;
	Thu, 25 Dec 2025 03:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634330; cv=none; b=ZS8A6g2lSr0Bascxhv/z7ihW7YruBRJiOGr31PWW8gSUAoPAnyf2QhQaeIM54qQSzw0LnASg/z/3eN2/SnlxiByy0XwgLVONf0QurOxCQVxGjXwD/g5vTI0B1oTXt1F96liqSwTxfo5QfQ/CBVh/Sk5U40s70BM3QeIDpE8VhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634330; c=relaxed/simple;
	bh=rvHde9+auq9oQHsbKTeZhAVMVWlvxdT2qKuht1mvrbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2ayLenaJI9WO6DeJOiu7RiyG03En+g/KXWyDEM8BgsgPbk+PU6o0VUXZfsE3OQ+dBwevIXFCwPClLpzbwzJF1kUh8pYguqSCbd1m5/NaYdl5Hk0dIQva4jL8v83d25ThJAQy+mnNUZRCPzMUGLckFFBNfyYk0n6kcx7dqxeWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcF4V0FBKzKHMJh;
	Thu, 25 Dec 2025 11:44:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C516340588;
	Thu, 25 Dec 2025 11:45:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXBvdNs0xpIrWSBQ--.52398S2;
	Thu, 25 Dec 2025 11:45:18 +0800 (CST)
Message-ID: <9c0be55d-0b02-4f39-a871-3ce495e32a87@huaweicloud.com>
Date: Thu, 25 Dec 2025 11:45:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXBvdNs0xpIrWSBQ--.52398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw45tF43Ar47GFy5ur43GFg_yoW5CFWfpa
	nrWryakr4rJw4agrZrWw4DW343Ga4DKFW3trW7uF4ft3WfWr13K3WYkr1YgrW3J348Zr13
	ZwnIgrn7Zay0qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/12/17 15:27, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> After refactoring the move_folios_to_lru(), its caller no longer needs to
> hold the lruvec lock, the disabling IRQ is only for __count_vm_events()
> and __mod_node_page_state().
> 

nit:
For shrink_inactive_list(), shrink_active_list() and evict_folios(), IRQ disabling is only needed
for __count_vm_events() and __mod_node_page_state().

I think it can be clearer.

> On the PREEMPT_RT kernel, the local_irq_disable() cannot be used. To
> avoid using local_irq_disable() and reduce the critical section of
> disabling IRQ, make all callers of move_folios_to_lru() use IRQ-safed
> count_vm_events() and mod_node_page_state().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 28d9b3af47130..49e5661746213 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2021,12 +2021,12 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  
>  	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
>  					stat.nr_demoted);
> -	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> +	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
>  	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, nr_reclaimed);
> +		count_vm_events(item, nr_reclaimed);
>  	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> +	count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
>  
>  	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
>  					nr_scanned - nr_reclaimed);
> @@ -2171,10 +2171,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	nr_activate = move_folios_to_lru(lruvec, &l_active);
>  	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
>  
> -	__count_vm_events(PGDEACTIVATE, nr_deactivate);
> +	count_vm_events(PGDEACTIVATE, nr_deactivate);
>  	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
>  
> -	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> +	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>  
>  	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
>  	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
> @@ -4751,9 +4751,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
>  	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, reclaimed);
> +		count_vm_events(item, reclaimed);
>  	count_memcg_events(memcg, item, reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
> +	count_vm_events(PGSTEAL_ANON + type, reclaimed);
>  
>  	spin_unlock_irq(&lruvec->lru_lock);
>  

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


