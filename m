Return-Path: <cgroups+bounces-6098-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BAA0AF7B
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 07:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1567816392D
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9CD231A50;
	Mon, 13 Jan 2025 06:52:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73415231C88;
	Mon, 13 Jan 2025 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736751124; cv=none; b=qleQ4ShBoUzechJq3W/f293HfDGG4iTzmDkIY3i22IU6yyaxJpNDEwmUcD95vZSpP0XjHWJ67yZM5vQUloyB7de6W6Lbaq5GaRpg/XjeE9HufXgVhdTse8PCwOBpTVTRYPCoT7cnCxyWvESGiR+fIGW/qmgzKPRtzxgiMsVSZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736751124; c=relaxed/simple;
	bh=FqcPUiDjsYz400ZPUQn1W6RtMNo/tDZbZ0txwWjo5Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSzkXa54p06A9W3f3k0ZVVL2Bz9ZhxWUq2uPx+zDyOZX98ijRFQ1iNW5DZDchsC2kS/HZeDECtAIXfBc4oQP72JHpJKFm8xqN/xR1aBeR1aXZgLQXTngxUH1pQrPNNGS6XeagSnsO8cCf4UgMTok5x6biKdFvwTpRJ00M2n+AVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YWjbX2bsWz4f3js9;
	Mon, 13 Jan 2025 14:51:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A9B3D1A084C;
	Mon, 13 Jan 2025 14:51:56 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAninoLuIRnfO5AAw--.40643S2;
	Mon, 13 Jan 2025 14:51:56 +0800 (CST)
Message-ID: <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
Date: Mon, 13 Jan 2025 14:51:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
 mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, handai.szj@taobao.com, rientjes@google.com,
 kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAninoLuIRnfO5AAw--.40643S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rKF4fKF13ZrW3GFyUJrb_yoWrCry8pF
	yDCa1UKws5Jry5Xr12yryYvF1fJw48Ca1UJr47tr15Cr17KwnrJr17Gr15Jrn5AFWavF12
	yFn0vw1Igr4YvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/1/6 16:45, Vlastimil Babka wrote:
> On 12/24/24 03:52, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
> 
> +CC RCU
> 
>> A soft lockup issue was found in the product with about 56,000 tasks were
>> in the OOM cgroup, it was traversing them when the soft lockup was
>> triggered.
>>
>> watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [VM Thread:1503066]
>> CPU: 2 PID: 1503066 Comm: VM Thread Kdump: loaded Tainted: G
>> Hardware name: Huawei Cloud OpenStack Nova, BIOS
>> RIP: 0010:console_unlock+0x343/0x540
>> RSP: 0000:ffffb751447db9a0 EFLAGS: 00000247 ORIG_RAX: ffffffffffffff13
>> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffffffff
>> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000247
>> RBP: ffffffffafc71f90 R08: 0000000000000000 R09: 0000000000000040
>> R10: 0000000000000080 R11: 0000000000000000 R12: ffffffffafc74bd0
>> R13: ffffffffaf60a220 R14: 0000000000000247 R15: 0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f2fe6ad91f0 CR3: 00000004b2076003 CR4: 0000000000360ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  vprintk_emit+0x193/0x280
>>  printk+0x52/0x6e
>>  dump_task+0x114/0x130
>>  mem_cgroup_scan_tasks+0x76/0x100
>>  dump_header+0x1fe/0x210
>>  oom_kill_process+0xd1/0x100
>>  out_of_memory+0x125/0x570
>>  mem_cgroup_out_of_memory+0xb5/0xd0
>>  try_charge+0x720/0x770
>>  mem_cgroup_try_charge+0x86/0x180
>>  mem_cgroup_try_charge_delay+0x1c/0x40
>>  do_anonymous_page+0xb5/0x390
>>  handle_mm_fault+0xc4/0x1f0
>>
>> This is because thousands of processes are in the OOM cgroup, it takes a
>> long time to traverse all of them. As a result, this lead to soft lockup
>> in the OOM process.
>>
>> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
>> function per 1000 iterations. For global OOM, call
>> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
>>
>> Fixes: 9cbb78bb3143 ("mm, memcg: introduce own oom handler to iterate only over its own threads")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/memcontrol.c | 7 ++++++-
>>  mm/oom_kill.c   | 8 +++++++-
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 65fb5eee1466..46f8b372d212 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>>  {
>>  	struct mem_cgroup *iter;
>>  	int ret = 0;
>> +	int i = 0;
>>  
>>  	BUG_ON(mem_cgroup_is_root(memcg));
>>  
>> @@ -1169,8 +1170,12 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>>  		struct task_struct *task;
>>  
>>  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
>> -		while (!ret && (task = css_task_iter_next(&it)))
>> +		while (!ret && (task = css_task_iter_next(&it))) {
>> +			/* Avoid potential softlockup warning */
>> +			if ((++i & 1023) == 0)
>> +				cond_resched();
>>  			ret = fn(task, arg);
>> +		}
>>  		css_task_iter_end(&it);
>>  		if (ret) {
>>  			mem_cgroup_iter_break(memcg, iter);
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 1c485beb0b93..044ebab2c941 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -44,6 +44,7 @@
>>  #include <linux/init.h>
>>  #include <linux/mmu_notifier.h>
>>  #include <linux/cred.h>
>> +#include <linux/nmi.h>
>>  
>>  #include <asm/tlb.h>
>>  #include "internal.h"
>> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
>>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>>  	else {
>>  		struct task_struct *p;
>> +		int i = 0;
>>  
>>  		rcu_read_lock();
>> -		for_each_process(p)
>> +		for_each_process(p) {
>> +			/* Avoid potential softlockup warning */
>> +			if ((++i & 1023) == 0)
>> +				touch_softlockup_watchdog();
> 
> This might suppress the soft lockup, but won't a rcu stall still be detected?

Yes, rcu stall was still detected.
For global OOM, system is likely to struggle, do we have to do some
works to suppress RCU detete?

Best regards,
Ridong

> 
>>  			dump_task(p, oc);
>> +		}
>>  		rcu_read_unlock();
>>  	}
>>  }
> 


