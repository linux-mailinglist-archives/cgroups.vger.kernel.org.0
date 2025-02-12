Return-Path: <cgroups+bounces-6519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014EA321EF
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A322C3A4F0D
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E92205E0C;
	Wed, 12 Feb 2025 09:19:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45C205ADD;
	Wed, 12 Feb 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351974; cv=none; b=Lk9XKLNY0+nGAyw77aiHcrJJCpzxIu0HALM2WVdN8Blz9/+V6NWTPO7iUcX+jCRS7PETth5+u8+W3IoxuWJwWbXyveWIra0nFrLp5/OWGgi3l02/ePSTSoWILuoK8hpShd37UXy4bmFikr7lBm5WwuO3HRQRYZf5ErEc8TDhbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351974; c=relaxed/simple;
	bh=jpOWBulwYQ53gAr+Iy22IOavyE7bRa1HhEDDp3/WP9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkwE9huEkTvVVuP+R2DLeX+M3SotXUtnm+01DbcORCEGL+OOmrQ8ifOOrd2CxKgFOJKHubESiOUh5j3gFgkordhOb1C89yIbSvuvSTPfTo/A03sa1aiwg/50NBGFnH0DCZlOKGKt8q4pKKB/u687duKtn1Qvi8OEdzr8pQsRzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YtCRr4Vmlz4f3jqP;
	Wed, 12 Feb 2025 17:19:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AA0401A1527;
	Wed, 12 Feb 2025 17:19:20 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCH2cOUZ6xnMMlNDg--.39805S2;
	Wed, 12 Feb 2025 17:19:18 +0800 (CST)
Message-ID: <d264a73e-966f-4890-9e23-88d476f0fc81@huaweicloud.com>
Date: Wed, 12 Feb 2025 17:19:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com, paulmck@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
 <Z6xig5sLNpFVFU2T@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z6xig5sLNpFVFU2T@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCH2cOUZ6xnMMlNDg--.39805S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4fKFWDXw4Uur1DCryDZFb_yoW8tFWDpF
	WDC3WUKan8JF15Zw17ZryIvFy2q3yrZF48tF9rt34rZrs0qrn2krW0kr4Ygr95ZFWag3W0
	vFs0gFn3JrWYq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/2/12 16:57, Michal Hocko wrote:
> On Wed 12-02-25 02:57:07, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Unlike memcg OOM, which is relatively common, global OOM events are rare
>> and typically indicate that the entire system is under severe memory
>> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
>> process") added the touch_softlockup_watchdog in the global OOM handler to
>> suppess the soft lockup issues. However, while this change can suppress
>> soft lockup warnings, it does not address RCU stalls, which can still be
>> detected and may cause unnecessary disturbances. Simply remove the
>> modification from the global OOM handler.
>>
>> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
> 
> But this is not really fixing anything, is it? While this doesn't
> address a potential RCU stall it doesn't address any actual problem.
> So why do we want to do this?
> 


[1]
https://lore.kernel.org/cgroups/0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com/

As previously discussed, the work I have done on the global OOM is 'half
of the job'. Based on our discussions, I thought that it would be best
to abandon this approach for global OOM. Therefore, I am sending this
patch to revert the changes.

Or just leave it?

Best regards,
Ridong

>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/oom_kill.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 25923cfec9c6..2d8b27604ef8 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -44,7 +44,6 @@
>>  #include <linux/init.h>
>>  #include <linux/mmu_notifier.h>
>>  #include <linux/cred.h>
>> -#include <linux/nmi.h>
>>  
>>  #include <asm/tlb.h>
>>  #include "internal.h"
>> @@ -431,15 +430,10 @@ static void dump_tasks(struct oom_control *oc)
>>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>>  	else {
>>  		struct task_struct *p;
>> -		int i = 0;
>>  
>>  		rcu_read_lock();
>> -		for_each_process(p) {
>> -			/* Avoid potential softlockup warning */
>> -			if ((++i & 1023) == 0)
>> -				touch_softlockup_watchdog();
>> +		for_each_process(p)
>>  			dump_task(p, oc);
>> -		}
>>  		rcu_read_unlock();
>>  	}
>>  }
>> -- 
>> 2.34.1
> 


