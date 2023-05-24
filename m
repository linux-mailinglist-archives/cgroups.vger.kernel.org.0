Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80DA70F5F9
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjEXMNn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 08:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMNm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 08:13:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87E130
        for <cgroups@vger.kernel.org>; Wed, 24 May 2023 05:13:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QR94c6H1CzLpvK;
        Wed, 24 May 2023 20:10:40 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 20:13:36 +0800
From:   cuigaosheng <cuigaosheng1@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <longman@redhat.com>,
        <cuigaosheng1@huawei.com>, <mathieu.poirier@linaro.org>,
        <dietmar.eggemann@arm.com>, <tglx@linutronix.de>,
        <bristot@redhat.com>, <claudio@evidence.eu.com>,
        <longman@redhat.com>, <luca.abeni@santannapisa.it>,
        <rostedt@goodmis.org>, Xiujianfeng <xiujianfeng@huawei.com>,
        wangweiyang <wangweiyang2@huawei.com>
Subject: Bug report: Unable to handle kernel paging request at virtual address
 00000000c0000010
CC:     <cgroups@vger.kernel.org>
Message-ID: <c0a63cf1-7487-5670-771b-5077a73be4c7@huawei.com>
Date:   Wed, 24 May 2023 20:13:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi,everybody

There is a bug in the mainline code(https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git -b master).

The bug's call trace as follows:
> refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 1 PID: 342 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x148
>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>   Workqueue: events cpuset_hotplug_workfn
>   Call trace:
>    refcount_warn_saturate+0xa0/0x148
>    __refcount_add.constprop.0+0x5c/0x80
>    css_task_iter_advance_css_set+0xd8/0x210
>    css_task_iter_advance+0xa8/0x120
>    css_task_iter_next+0x94/0x158
>    update_tasks_root_domain+0x58/0x98
>    rebuild_root_domains+0xa0/0x1b0
>    rebuild_sched_domains_locked+0x144/0x188
>    cpuset_hotplug_workfn+0x138/0x5a0
>    process_one_work+0x1e8/0x448
>    worker_thread+0x228/0x3e0
>    kthread+0xe0/0xf0
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   refcount_t: underflow; use-after-free.
>   WARNING: CPU: 1 PID: 342 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>   Workqueue: events cpuset_hotplug_workfn
>   Call trace:
>    refcount_warn_saturate+0xf4/0x148
>    put_css_set_locked+0x80/0x98
>    css_task_iter_end+0x70/0x160
>    update_tasks_root_domain+0x68/0x98
>    rebuild_root_domains+0xa0/0x1b0
>    rebuild_sched_domains_locked+0x144/0x188
>    cpuset_hotplug_workfn+0x138/0x5a0
>    process_one_work+0x1e8/0x448
>    worker_thread+0x228/0x3e0
>    kthread+0xe0/0xf0
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>   process 10324 (cpuhotplug_do_s) no longer affine to cpu1
>   psci: CPU1 killed (polled 0 ms)
>   Unable to handle kernel paging request at virtual address 00000000c0000010
>   Internal error: Oops: 0000000096000004 [#1] SMP
>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>   Workqueue: cgroup_destroy css_free_rwork_fn
>   Call trace:
>    cgroup_apply_control_disable+0xb0/0x1f8
>    rebind_subsystems+0x20c/0x548
>    cgroup_destroy_root+0x64/0x240
>    css_free_rwork_fn+0x18c/0x1a8
>    process_one_work+0x1e8/0x448
>    worker_thread+0x178/0x3e0
>    kthread+0xe0/0xf0
>    ret_from_fork+0x10/0x20
>   Code: 91012842 8b020f62 f9400453 b4000293 (f9400a60)
>   SMP: stopping secondary CPUs
>   Starting crashdump kernel...
This bug occurs in concurrency scenarios, In the hotplug, update_tasks_root_domain will
iterate over all tasks on the cpuset/root domain, the code as follows:
> static void update_tasks_root_domain(struct cpuset *cs)
> {
>          struct css_task_iter it;
>          struct task_struct *task;
>
>          css_task_iter_start(&cs->css, 0, &it); // hold css_set_lock in css_task_iter_start
>                  ... //nolock time1: don't hold css_set_lock
>          while ((task = css_task_iter_next(&it))) // hold css_set_lock in css_task_iter_next
>                  dl_add_task_root_domain(task); //nolock time2: don't hold css_set_lock
>
>          css_task_iter_end(&it);
> }
The cgroup.e_csets will be traversed through css_task_iter, and it->cset_head will record
the head of the e_cset list that is currently traversed, we will hold css_set_lock in
css_task_iter_start or in css_task_iter_next, but we don't always hold the css_set_lock,
such as "nolock time1" and "nolock time2" in the code comments above.

During the time without css_set_lock in update_tasks_root_domain, if it->cur_cset(current css_set)
is migrated to another list, such as:
> int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
> {
>      ...
>       spin_lock_irq(&css_set_lock);
>       hash_for_each(css_set_table, i, cset, hlist)
>          list_move_tail(&cset->e_cset_node[ss->id], &dcgrp->e_csets[ss->id]);
>      spin_unlock_irq(&css_set_lock);
>      ...
> }
The bug will be triggered. As follows:

#1> in css_task_iter_start(), it->cset_head = &css->cgroup->e_csets[css->ss->id]; list A
#2> in css_task_iter_next(&it), it->cur_cset=nodeA，return task
#3> move nodeA to listB, for example: rebind_subsystems(),list_move_tail(nodeA, listB),then nodeA->next = headB
#4> next css_task_iter_next, new = nodeA->next == headB
#5> headB is not a valid css_set, but now new != it->cset_head(nodeA), so headB will be referred to as a valid css_set
#6> get_css_set(headB), refcount warning

The following changes will increase the probability of this bug being triggered:
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e4ca2dd2b764..120e0c23517f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -66,6 +66,7 @@
>   #include <linux/mutex.h>
>   #include <linux/cgroup.h>
>   #include <linux/wait.h>
> +#include <linux/delay.h>
>
>   DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>   DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> @@ -1073,8 +1074,10 @@ static void update_tasks_root_domain(struct cpuset *cs)
>
>          css_task_iter_start(&cs->css, 0, &it);
>
> -       while ((task = css_task_iter_next(&it)))
> +       while ((task = css_task_iter_next(&it))) {
> +               udelay(1000 * 10);
>                  dl_add_task_root_domain(task);
> +       }
>
>          css_task_iter_end(&it);
>   }

We can trigger this bug with ltp test cases(https://github.com/linux-test-project/ltp/blob/master/runtest/controllers):

step 1: create a process to execute the following usecases:
cpuhotplug02 cpuhotplug02.sh -c 1 -l 1
cpuhotplug03 cpuhotplug03.sh -c 1 -l 1
cpuhotplug04 cpuhotplug04.sh -l 1
cpuhotplug05 cpuhotplug05.sh -c 1 -l 1 -d /tmp
cpuhotplug06 cpuhotplug06.sh -c 1 -l 1
cpuhotplug07 cpuhotplug07.sh -c 1 -l 1 -d /usr/src/linux

step 2: create another process to execute the following usecases:
cpuset_base_ops cpuset_base_ops_testset.sh
cpuset_inherit cpuset_inherit_testset.sh
cpuset_exclusive cpuset_exclusive_test.sh
cpuset_hierarchy cpuset_hierarchy_test.sh
cpuset_syscall cpuset_syscall_testset.sh
cpuset_sched_domains cpuset_sched_domains_test.sh
cpuset_load_balance cpuset_load_balance_test.sh
cpuset_hotplug cpuset_hotplug_test.sh
cpuset_memory cpuset_memory_testset.sh

Looking forward to your reply.

Thanks.


