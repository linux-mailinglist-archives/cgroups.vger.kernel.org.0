Return-Path: <cgroups+bounces-13510-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOe+AJ9De2l+DAIAu9opvQ
	(envelope-from <cgroups+bounces-13510-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 12:25:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C59AF956
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42739300D0D1
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D9387343;
	Thu, 29 Jan 2026 11:25:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC87387367;
	Thu, 29 Jan 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685914; cv=none; b=ccNNKYIwBWgGDUSBMEUZle2MrwTfjK2CNkwrgVfeBemjt7BOesAk7MxQ/m00oMIo2GlmqvgkTnhHpgupLMqSbhZiwjoJwi3s5dhLVffZAXUBZKaPzhHS72jLQ31ilmeEeiYrwpZAi0J7smcnqtJLdTqfnQuvLciONesIYRz20Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685914; c=relaxed/simple;
	bh=gSlM5fKODS3EGnzlc//cLksKqzPV5YOhNmRuCzjzjOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXyDsD9bCRRLFuO6N/+bEmzoJYUfxDAJLM4aINaAr7TukYr7OIxJ3Ok5QEXinxC807UKeKYxg8NVJlfPkSYw7onbtpZaGdyVObFcvR0Lqh5rOUm5uuicM0Ee76X+F6nW8D4rlDSniN54yHtaAbSrrNPb0r0usBtbtzL+YluE/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f1xcX14V0zYQv1Q;
	Thu, 29 Jan 2026 19:24:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 049854056B;
	Thu, 29 Jan 2026 19:25:07 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDXhfaOQ3tp9fodFg--.5236S2;
	Thu, 29 Jan 2026 19:25:03 +0800 (CST)
Message-ID: <bfba09cf-89d8-4ec1-9299-7128d79569ff@huaweicloud.com>
Date: Thu, 29 Jan 2026 19:25:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 0/7] Introduce heat-level memcg reclaim
To: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 ryncsn@gmail.com
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260120134256.2271710-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXhfaOQ3tp9fodFg--.5236S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7WF18tFykKryfCw1ftFb_yoW5ZF4Upa
	93Wasxtan5AF15Aan7ZayUWr4fZrn7Gw13XF90gry8ArnxAFyvqr1Ikw4rZFWDCrWxJry7
	XrW293WDWF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-13510-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.959];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C59AF956
X-Rspamd-Action: no action



On 2026/1/20 21:42, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced to improve scalability during
> global reclaim, but it only supports gen lru global reclaim and its
> implementation has become complex. Moreover, it has caused performance
> regressions when dealing with a large number of memory cgroups [1].
> 
> Previous attempts to remove memcg LRU by switching back to iteration
> implementation brought performance regression [3].
> 
> This series introduces a per-memcg heat level mechanism for reclaim,
> aiming to unify gen lru and traditional LRU global reclaim. The core
> idea is to track per-node per-memcg reclaim state, including heat,
> last_decay, and last_refault. Three reclaim heat levels are defined:
> cold, warm, and hot. Cold memcgs are reclaimed first; only if cold
> memcgs cannot reclaim enough pages, warm memcgs become eligible for
> reclaim. Hot memcgs are reclaimed last.
> 
> While the heat level design can be applied to all memcg reclaim scenarios,
> this series takes a conservative approach and initially applies it only
> to global reclaim. The first few patches introduce the heat level
> infrastructure and apply it to traditional LRU global reclaim. The
> subsequent patches gradually migrate gen lru global reclaim to the
> heat-level-based approach, with the final patch combining shrink_many
> into shrink_node_memcgs to complete the transition.
> 
> Performance results show significant improvements:
> 
> Traditional LRU results (2-hour run of test [2]):
> Throughput (number of requests)         before     after        Change
> Total                                   1,734,169  2,353,717    +35%
> 
> Gen LRU results (24-hour run of test [2]):
> Throughput (number of requests)         before     after        Change
> Total                                   22,879,701 25,331,956   +10%
> 
> The performance tests are based on next branch commit:
> commit ef0d146624b0 ("Add linux-next specific files for 20251219")
> 
> This series has been rebased on next-20260119:
> commit d08c85ac8894 ("Add linux-next specific files for 20260119")
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
> [3] https://lore.kernel.org/lkml/20251224073032.161911-1-chenridong@huaweicloud.com/
> 
> Chen Ridong (7):
>   vmscan: add memcg heat level for reclaim
>   mm/mglru: make calls to flush_reclaim_state() similar for MGLRU and
>     non-MGLRU
>   mm/mglru: rename should_abort_scan to lru_gen_should_abort_scan
>   mm/mglru: extend lru_gen_shrink_lruvec to support root reclaim
>   mm/mglru: combine shrink_many into shrink_node_memcgs
>   mm/mglru: remove memcg disable handling from lru_gen_shrink_node
>   mm/mglru: remove memcg lru
> 
>  Documentation/mm/multigen_lru.rst |  30 --
>  include/linux/memcontrol.h        |   7 +
>  include/linux/mmzone.h            |  89 -----
>  mm/memcontrol-v1.c                |   6 -
>  mm/memcontrol.c                   |   7 +-
>  mm/mm_init.c                      |   1 -
>  mm/vmscan.c                       | 547 ++++++++++++------------------
>  7 files changed, 231 insertions(+), 456 deletions(-)
> 

Hi, Johannes and Shakeel,

I would appreciate it if you could share your thoughts on this series.

-- 
Best regards,
Ridong


