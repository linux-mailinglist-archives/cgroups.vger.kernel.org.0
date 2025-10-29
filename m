Return-Path: <cgroups+bounces-11311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E9C18252
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CE91A275E1
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F3A2ED16D;
	Wed, 29 Oct 2025 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DruSDcLg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4662EA157
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707560; cv=none; b=RUB7qd78dve0/PFKMVF7UmSQgsbZoilEeqB8POtoVyZnxQt2+S1YrW3+Ej1O2QOfWar9Hz08S7IcRHOKjD3n+ldrY9uh+mFJKJlDtjfwJzXbTQjO1//1Sij4WL81UHFiNcEEaCsakobph1x7F/zWcoUXvLspWK+z/anOM9vMLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707560; c=relaxed/simple;
	bh=hytguSx1VQCNNuHx835HgjhxZYkwWh6Hhjo1p4lF9Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUMDpFq3QTSQbOvRe6+8VbOKeTPHNsJ+Oxw5zwbgn2hxnHQ2sy+2NYuUz10tlAB1tx9wChhzqJYxPkd0VwuLHsukLPTCUxaBaZjhhXCa/CfYrXkNZZWC3E1y11ad6wDH/1Hv4/pWfvEnY3Tr8Oz7x3cIgbp0tn9qX5FcVMHZsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DruSDcLg; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8892c17-5161-4e27-9fdb-70e2e5c53f2c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761707555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8U2/SRrzdo4Rwp5cpioI5+15rE47Gvkhsrn4dsdPbQM=;
	b=DruSDcLgKCqasjSORgvtKLccMIgUgAw9AbnSQzVZDb1mLkpujqTjHHUBMYj1SRcHgLqZN9
	a2itK2hbxjSdRqD/XLybZHvtRP3ZIxiDA0D4Mrwv0f5/H4OsJIm8AfJOem4Es5HcY7726o
	G2rmoLCw0O5hZNmyy2+zlbFzAnWtuFw=
Date: Wed, 29 Oct 2025 11:12:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: Eliminate Dying Memory Cgroup
To: Harry Yoo <harry.yoo@oracle.com>,
 syzbot ci <syzbot+cie7d8f1fc805fcd7a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com,
 cgroups@vger.kernel.org, chengming.zhou@linux.dev, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 muchun.song@linux.dev, nphamcs@gmail.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, songmuchun@bytedance.com, weixugc@google.com,
 yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <69012e79.050a0220.3344a1.03ee.GAE@google.com> <aQFeMG8WEvrWaNf0@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aQFeMG8WEvrWaNf0@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry,

On 10/29/25 8:22 AM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 01:58:33PM -0700, syzbot ci wrote:
>> syzbot ci has tested the following series
>>
>> [v1] Eliminate Dying Memory Cgroup
>> https://lore.kernel.org/all/cover.1761658310.git.zhengqi.arch@bytedance.com
>> * [PATCH v1 01/26] mm: memcontrol: remove dead code of checking parent memory cgroup
>> * [PATCH v1 02/26] mm: workingset: use folio_lruvec() in workingset_refault()
>> * [PATCH v1 03/26] mm: rename unlock_page_lruvec_irq and its variants
>> * [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
>> * [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for non-kmem case
>> * [PATCH v1 06/26] mm: memcontrol: return root object cgroup for root memory cgroup
>> * [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
>> * [PATCH v1 08/26] buffer: prevent memory cgroup release in folio_alloc_buffers()
>> * [PATCH v1 09/26] writeback: prevent memory cgroup release in writeback module
>> * [PATCH v1 10/26] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
>> * [PATCH v1 11/26] mm: page_io: prevent memory cgroup release in page_io module
>> * [PATCH v1 12/26] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
>> * [PATCH v1 13/26] mm: mglru: prevent memory cgroup release in mglru
>> * [PATCH v1 14/26] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
>> * [PATCH v1 15/26] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
>> * [PATCH v1 16/26] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
>> * [PATCH v1 17/26] mm: workingset: prevent lruvec release in workingset_refault()
>> * [PATCH v1 18/26] mm: zswap: prevent lruvec release in zswap_folio_swapin()
>> * [PATCH v1 19/26] mm: swap: prevent lruvec release in swap module
>> * [PATCH v1 20/26] mm: workingset: prevent lruvec release in workingset_activation()
>> * [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
>> * [PATCH v1 22/26] mm: vmscan: prepare for reparenting traditional LRU folios
>> * [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
>> * [PATCH v1 24/26] mm: memcontrol: refactor memcg_reparent_objcgs()
>> * [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
>> * [PATCH v1 26/26] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
>>
>> and found the following issue:
>> WARNING in folio_memcg
>>
>> Full report is available here:
>> https://ci.syzbot.org/series/0d48a77a-fb4f-485d-9fd6-086afd6fb650
>>
>> ***
>>
>> WARNING in folio_memcg
>>
>> tree:      mm-new
>> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
>> base:      b227c04932039bccc21a0a89cd6df50fa57e4716
>> arch:      amd64
>> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> config:    https://ci.syzbot.org/builds/503d7034-ae99-44d1-8fb2-62e7ef5e1c7c/config
>> C repro:   https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/c_repro
>> syz repro: https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/syz_repro
>>
>> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
>> exFAT-fs (loop0): failed to load alloc-bitmap
>> exFAT-fs (loop0): failed to recognize exfat type
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 obj_cgroup_memcg include/linux/memcontrol.h:380 [inline]
>> WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 folio_memcg+0x148/0x1c0 include/linux/memcontrol.h:434
> 
> This is understandable as the code snippet was added fairly recently
> and is easy to miss during rebasing.

My mistake, I should recheck it.

> 
> #syz test
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a341814468b9..738d914e5354 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -896,11 +896,14 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>   	 * to the active LRU list in the case.
>   	 */
>   	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
> +		rcu_read_lock();
>   		if (!mem_cgroup_zswap_writeback_enabled(
>   					folio_memcg(page_folio(page)))) {
> +			rcu_read_unlock();
>   			comp_ret = comp_ret ? comp_ret : -EINVAL;
>   			goto unlock;
>   		}
> +		rcu_read_unlock();
>   		comp_ret = 0;
>   		dlen = PAGE_SIZE;
>   		dst = kmap_local_page(page);

LGTM, will do in the next version.

Thanks!

> 


