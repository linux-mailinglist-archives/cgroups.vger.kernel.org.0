Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74953E0C2A
	for <lists+cgroups@lfdr.de>; Thu,  5 Aug 2021 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhHEBo4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 21:44:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhHEBo4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 21:44:56 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GgBCQ5NF3zck0d;
        Thu,  5 Aug 2021 09:41:06 +0800 (CST)
Received: from [10.174.179.25] (10.174.179.25) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:44:40 +0800
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Roman Gushchin <guro@fb.com>, <vdavydov.dev@gmail.com>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com> <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz> <YQlPiLY0ieRb704V@cmpxchg.org>
 <YQpNtfjl0rHH8Mgf@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6f64a114-eb95-39c2-c779-ac77d2becccb@huawei.com>
Date:   Thu, 5 Aug 2021 09:44:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YQpNtfjl0rHH8Mgf@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/8/4 16:20, Michal Hocko wrote:
> On Tue 03-08-21 10:15:36, Johannes Weiner wrote:
> [...]
>> git history shows we tried to remove it once:
>>
>> commit 8521fc50d433507a7cdc96bec280f9e5888a54cc
>> Author: Michal Hocko <mhocko@suse.cz>
>> Date:   Tue Jul 26 16:08:29 2011 -0700
>>
>>     memcg: get rid of percpu_charge_mutex lock
>>
>> but it turned out that the lock did in fact protect a data structure:
>> the stock itself. Specifically stock->cached:
>>
>> commit 9f50fad65b87a8776ae989ca059ad6c17925dfc3
>> Author: Michal Hocko <mhocko@suse.cz>
>> Date:   Tue Aug 9 11:56:26 2011 +0200
>>
>>     Revert "memcg: get rid of percpu_charge_mutex lock"
>>
>>     This reverts commit 8521fc50d433507a7cdc96bec280f9e5888a54cc.
>>
>>     The patch incorrectly assumes that using atomic FLUSHING_CACHED_CHARGE
>>     bit operations is sufficient but that is not true.  Johannes Weiner has
>>     reported a crash during parallel memory cgroup removal:
>>
>>       BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>>       IP: [<ffffffff81083b70>] css_is_ancestor+0x20/0x70
>>       Oops: 0000 [#1] PREEMPT SMP
>>       Pid: 19677, comm: rmdir Tainted: G        W   3.0.0-mm1-00188-gf38d32b #35 ECS MCP61M-M3/MCP61M-M3
>>       RIP: 0010:[<ffffffff81083b70>]  css_is_ancestor+0x20/0x70
>>       RSP: 0018:ffff880077b09c88  EFLAGS: 00010202
>>       Process rmdir (pid: 19677, threadinfo ffff880077b08000, task ffff8800781bb310)
>>       Call Trace:
>>        [<ffffffff810feba3>] mem_cgroup_same_or_subtree+0x33/0x40
>>        [<ffffffff810feccf>] drain_all_stock+0x11f/0x170
>>        [<ffffffff81103211>] mem_cgroup_force_empty+0x231/0x6d0
>>        [<ffffffff811036c4>] mem_cgroup_pre_destroy+0x14/0x20
>>        [<ffffffff81080559>] cgroup_rmdir+0xb9/0x500
>>        [<ffffffff81114d26>] vfs_rmdir+0x86/0xe0
>>        [<ffffffff81114e7b>] do_rmdir+0xfb/0x110
>>        [<ffffffff81114ea6>] sys_rmdir+0x16/0x20
>>        [<ffffffff8154d76b>] system_call_fastpath+0x16/0x1b
>>
>>     We are crashing because we try to dereference cached memcg when we are
>>     checking whether we should wait for draining on the cache.  The cache is
>>     already cleaned up, though.
>>
>>     There is also a theoretical chance that the cached memcg gets freed
>>     between we test for the FLUSHING_CACHED_CHARGE and dereference it in
>>     mem_cgroup_same_or_subtree:
>>
>>             CPU0                    CPU1                         CPU2
>>       mem=stock->cached
>>       stock->cached=NULL
>>                                   clear_bit
>>                                                             test_and_set_bit
>>       test_bit()                    ...
>>       <preempted>             mem_cgroup_destroy
>>       use after free
>>
>>     The percpu_charge_mutex protected from this race because sync draining
>>     is exclusive.
>>
>>     It is safer to revert now and come up with a more parallel
>>     implementation later.
>>
>> I didn't remember this one at all!
> 
> Me neither. Thanks for looking that up!
> 
>> However, when you look at the codebase from back then, there was no
>> rcu-protection for memcg lifetime, and drain_stock() didn't double
>> check stock->cached inside the work. Hence the crash during a race.
>>
>> The drain code is different now: drain_local_stock() disables IRQs
>> which holds up rcu, and then calls drain_stock() and drain_obj_stock()
>> which both check stock->cached one more time before the deref.
>>
>> With workqueue managing concurrency, and rcu ensuring memcg lifetime
>> during the drain, this lock indeed seems unnecessary now.
>>
>> Unless I'm missing something, it should just be removed instead.
> 
> I do not think you are missing anything. We can drop the lock and
> simplify the code. The above information would be great to have in the
> changelog.
> 

Am I supposed to revert this with the above information in the changelog and add
Suggested-by for both of you?

Many thanks.

> Thanks!
> 

