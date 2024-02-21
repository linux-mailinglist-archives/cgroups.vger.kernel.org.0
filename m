Return-Path: <cgroups+bounces-1724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403685D4EF
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F461C238EA
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D13EA8C;
	Wed, 21 Feb 2024 09:50:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29C64CC6;
	Wed, 21 Feb 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509039; cv=none; b=jpVT2yzH1eliLWPJtzdRHH/i7eTL256y9rSrerR1VaXUFYhqG+LEpDNl16szoFhTYpi65lWFWMIm3guydrYiXcyIf5L7KlE08XkceV1zkDjzF48KDhbL4hgyc/eqCeEpqscWfNShaL3CPQt89u01qIGmDJt7J2CawXG2I6Tbihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509039; c=relaxed/simple;
	bh=kP+69lggN24+/u7AHL8nNpSMUDvoOVAEHGVt3fccQBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u5rkBekSNdjY7QPQ8/b8VzjeVXTOBI4LycF4VqxLCxd++I6117jmAV1R48kyPAVvqxcKaZkmYxSFZQjNBzD45dgn/p9wlkFOgso+ohgHvtyp5/Rt2BqIB6PPfYxZzpDN+YqQRiHmh+7dgOgoGu14sv3Bv0PwApfr2NlcvnNUqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfrxL2KXZz1FKs7;
	Wed, 21 Feb 2024 17:45:42 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 0625C1402CA;
	Wed, 21 Feb 2024 17:50:34 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 21 Feb
 2024 17:50:33 +0800
Message-ID: <5436af7a-26d4-7c04-466a-7163d5a26040@huawei.com>
Date: Wed, 21 Feb 2024 17:50:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Wang Weiyang
	<wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <ZdW2gMajIw_cUN2-@tiehlicka>
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ZdW2gMajIw_cUN2-@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100002.china.huawei.com (7.185.36.164)


On 2024/02/21 16:38, Michal Hocko wrote:
> On Wed 21-02-24 16:18:01, GONG, Ruiqi wrote:
>> commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> 
> I think it would be good to mention that this is only a partial backport
> and also explain why to do a partial rather than the full one.
>

Okay. I think to fix this problem we should add refcnt relation between
memcg and stock, and since higher versions have achieved this, maybe
it's better to use the same code and align with them. So I put a "commit
xxx upstream" here, as requested in kernel docs[1]. So yes it's a
partial backport as we only need the stock part.

[1]:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#stable-kernel-rules

>> There was a kernel panic happened on an in-house environment running
>> 3.10, and the same problem was reproduced on 4.19:
>>
>> general protection fault: 0000 [#1] SMP PTI
>> CPU: 1 PID: 2085 Comm: bash Kdump: loaded Tainted: G             L    4.19.90+ #7
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> RIP: 0010 drain_all_stock+0xad/0x140
>> Code: 00 00 4d 85 ff 74 2c 45 85 c9 74 27 4d 39 fc 74 42 41 80 bc 24 28 04 00 00 00 74 17 49 8b 04 24 49 8b 17 48 8b 88 90 02 00 00 <48> 39 8a 90 02 00 00 74 02 eb 86 48 63 88 3c 01 00 00 39 8a 3c 01
>> RSP: 0018:ffffa7efc5813d70 EFLAGS: 00010202
>> RAX: ffff8cb185548800 RBX: ffff8cb89f420160 RCX: ffff8cb1867b6000
>> RDX: babababababababa RSI: 0000000000000001 RDI: 0000000000231876
>> RBP: 0000000000000000 R08: 0000000000000415 R09: 0000000000000002
>> R10: 0000000000000000 R11: 0000000000000001 R12: ffff8cb186f89040
>> R13: 0000000000020160 R14: 0000000000000001 R15: ffff8cb186b27040
>> FS:  00007f4a308d3740(0000) GS:ffff8cb89f440000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffe4d634a68 CR3: 000000010b022000 CR4: 00000000000006e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  mem_cgroup_force_empty_write+0x31/0xb0
>>  cgroup_file_write+0x60/0x140
>>  ? __check_object_size+0x136/0x147
>>  kernfs_fop_write+0x10e/0x190
>>  __vfs_write+0x37/0x1b0
>>  ? selinux_file_permission+0xe8/0x130
>>  ? security_file_permission+0x2e/0xb0
>>  vfs_write+0xb6/0x1a0
>>  ksys_write+0x57/0xd0
>>  do_syscall_64+0x63/0x250
>>  ? async_page_fault+0x8/0x30
>>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>> Modules linked in: ...
>>
>> It is found that in case of stock->nr_pages == 0, the memcg on
>> stock->cached could be freed due to its refcnt decreased to 0, which
>> made stock->cached become a dangling pointer. It could cause a UAF
>> problem in drain_all_stock() in the following concurrent scenario. Note
>> that drain_all_stock() doesn't disable irq but only preemption.
>>
>> CPU1                             CPU2
>> ==============================================================================
>> stock->cached = memcgA (freed)
>>                                  drain_all_stock(memcgB)
>>                                   rcu_read_lock()
>>                                   memcg = CPU1's stock->cached (memcgA)
>>                                   (interrupted)
>> refill_stock(memcgC)
>>  drain_stock(memcgA)
>>  stock->cached = memcgC
>>  stock->nr_pages += xxx (> 0)
>>                                   stock->nr_pages > 0
>>                                   mem_cgroup_is_descendant(memcgA, memcgB) [UAF]
>>                                   rcu_read_unlock()
>>
>> This problem is, unintenionally, fixed at 5.9, where commit 1a3e1f40962c
>> ("mm: memcontrol: decouple reference counting from page accounting")
>> adds memcg refcnt for stock. Therefore affected LTS versions include
>> 4.19 and 5.4.
>>
>> For 4.19, memcg's css offline process doesn't call drain_all_stock(). so
>> it's easier for the released memcg to be left on the stock. For 5.4,
>> although mem_cgroup_css_offline() does call drain_all_stock(), but the
>> flushing could be skipped when stock->nr_pages happens to be 0, and
>> besides the async draining could be delayed and take place after the UAF
>> problem has happened.
>>
>> Fix this problem by adding (and decreasing) memcg's refcnt when memcg is
>> put onto (and removed from) stock, just like how commit 1a3e1f40962c
>> ("mm: memcontrol: decouple reference counting from page accounting")
>> does. After all, "being on the stock" is a kind of reference with
>> regards to memcg. As such, it's guaranteed that a css on stock would not
>> be freed.
> 
> What does prevent from the following?
> 
> refill_stock(memcgC)		drain_all_stock(memcgB)
>   drain_stock(memcgA)		  rcu_read_lock()
>     css_put(old->css)		  memcgA = stock->cached
>                                   mem_cgroup_is_descendant(memcgA, memcgB) UAF
>     stock->cached = NULL
> 

I think it's not a problem since refill_stock() has disabled irq before
calling drain_stock():

refill_stock(memcgC)
  local_irq_save
  drain_stock(memcgA)
    css_put(old->css)
    <1>
    stock->cached = NULL
  local_irq_restore
  <2>

And since css_put(old->css) is an RCU free, memcgA would not be freed at
<1> as it's still in grace period. The actual release of memcgA could
happen only after irq is enabled (at <2>).

And for CPU2, the access to stock->cached in drain_all_stock() is
protected by rcu_read_lock(), so from stock->cached we get either NULL,
or a memcgA that is still not freed.

Please correct me if I have some wrong understanding to RCU.

>>
>> Cc: stable@vger.kernel.org      # 4.19 5.4
>> Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>  mm/memcontrol.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 5a366cf79821..8c04296df1c7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2015,6 +2015,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>>  {
>>  	struct mem_cgroup *old = stock->cached;
>>  
>> +	if (!old)
>> +		return;
>> +
>>  	if (stock->nr_pages) {
>>  		page_counter_uncharge(&old->memory, stock->nr_pages);
>>  		if (do_memsw_account())
>> @@ -2022,6 +2025,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>>  		css_put_many(&old->css, stock->nr_pages);
>>  		stock->nr_pages = 0;
>>  	}
>> +
>> +	css_put(&old->css);
>>  	stock->cached = NULL;
>>  }
>>  
>> @@ -2057,6 +2062,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>  	stock = this_cpu_ptr(&memcg_stock);
>>  	if (stock->cached != memcg) { /* reset if necessary */
>>  		drain_stock(stock);
>> +		css_get(&memcg->css);
>>  		stock->cached = memcg;
>>  	}
>>  	stock->nr_pages += nr_pages;
>> -- 
>> 2.25.1
>>
> 

