Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5964F70B338
	for <lists+cgroups@lfdr.de>; Mon, 22 May 2023 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjEVCaK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 May 2023 22:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEVCaJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 May 2023 22:30:09 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 19:30:05 PDT
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E6FA
        for <cgroups@vger.kernel.org>; Sun, 21 May 2023 19:30:05 -0700 (PDT)
Message-ID: <9a60d198-8c0a-9287-7c87-f129197d76f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684722196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHYDEvtNUWQuWC8UlRB684xx3KqIVrHp5jpKfKK7/Rs=;
        b=mLyJnuISRSOn7JYqLqW/9fffUHnxwZ4K7bCP+b0RJL95YYS1JYBp5ZsMaS0AwQVeAWju4W
        SC1S9MehptXFK2pfj2KorF/IIHgYcRUs4pZoV7UKnfk+Epe/orgRxJQ3AgyAcIsVrtpP4s
        Uqz7Q5wSm5fpZD87c040T+aK3PV/eno=
Date:   Mon, 22 May 2023 10:23:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in
 cgroup_transfer_tasks()
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Zhao Gongyi <zhaogongyi@bytedance.com>
References: <20230517074545.2045035-1-qi.zheng@linux.dev>
 <75E872A8-652F-40B0-80D0-378569E77775@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <75E872A8-652F-40B0-80D0-378569E77775@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/5/17 15:51, Muchun Song wrote:
> 
> 
>> On May 17, 2023, at 15:45, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The commit 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock()
>> deadlock") fixed the deadlock between cgroup_threadgroup_rwsem and
>> cpus_read_lock() by introducing cgroup_attach_{lock,unlock}() and removing
>> cpus_read_{lock,unlock}() from cpuset_attach(). But cgroup_transfer_tasks()
>> was missed and not handled, which will cause th following warning:
>>
>> WARNING: CPU: 0 PID: 589 at kernel/cpu.c:526 lockdep_assert_cpus_held+0x32/0x40
>> CPU: 0 PID: 589 Comm: kworker/1:4 Not tainted 6.4.0-rc2-next-20230517 #50
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>> Workqueue: events cpuset_hotplug_workfn
>> RIP: 0010:lockdep_assert_cpus_held+0x32/0x40
>> <...>
>> Call Trace:
>>   <TASK>
>>   cpuset_attach+0x40/0x240
>>   cgroup_migrate_execute+0x452/0x5e0
>>   ? _raw_spin_unlock_irq+0x28/0x40
>>   cgroup_transfer_tasks+0x1f3/0x360
>>   ? find_held_lock+0x32/0x90
>>   ? cpuset_hotplug_workfn+0xc81/0xed0
>>   cpuset_hotplug_workfn+0xcb1/0xed0
>>   ? process_one_work+0x248/0x5b0
>>   process_one_work+0x2b9/0x5b0
>>   worker_thread+0x56/0x3b0
>>   ? process_one_work+0x5b0/0x5b0
>>   kthread+0xf1/0x120
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>   </TASK>
>>
>> So just use the cgroup_attach_{lock,unlock}() helper to fix it.
>>
>> Fixes: 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock")
>> Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks. And hi Tejun, Can this patch be applied?

> 
> Thanks.
> 

-- 
Thanks,
Qi
