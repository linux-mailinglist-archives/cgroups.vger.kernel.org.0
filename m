Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6F710BED
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjEYMVU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 May 2023 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYMVT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 May 2023 08:21:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079BA9
        for <cgroups@vger.kernel.org>; Thu, 25 May 2023 05:21:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QRnGJ59LHz4f3jq0
        for <cgroups@vger.kernel.org>; Thu, 25 May 2023 20:21:12 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
        by APP1 (Coremail) with SMTP id cCh0CgA3nSe3Um9kRmxfJg--.24518S2;
        Thu, 25 May 2023 20:21:12 +0800 (CST)
Message-ID: <acc00c94-8590-15d0-7903-7e5040d24ddc@huaweicloud.com>
Date:   Thu, 25 May 2023 20:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Bug report: Unable to handle kernel paging request at virtual
 address 00000000c0000010
Content-Language: en-US
To:     cuigaosheng <cuigaosheng1@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        longman@redhat.com, mathieu.poirier@linaro.org, tglx@linutronix.de,
        bristot@redhat.com, claudio@evidence.eu.com,
        luca.abeni@santannapisa.it, rostedt@goodmis.org,
        wangweiyang <wangweiyang2@huawei.com>
Cc:     cgroups@vger.kernel.org
References: <c0a63cf1-7487-5670-771b-5077a73be4c7@huawei.com>
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <c0a63cf1-7487-5670-771b-5077a73be4c7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3nSe3Um9kRmxfJg--.24518S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw1UAr4xKF4DGFW5WrW3ZFb_yoWDCw1fpF
        nYqry7ArZ5uw1vgw4rJryDurySq348C3WUGryrtFWYkrsrJryjvF4jgr1agFyfZFWvgF13
        KF4j9r4a9wnrtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

How about this solution? we stop task iteration when moving css_set to a
new list in rebind_subsystems(), patch is as bellow:


diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 567c547cf371..3f1557cb5758 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -47,6 +47,7 @@ struct kernel_clone_args;

 /* internal flags */
 #define CSS_TASK_ITER_SKIPPED		(1U << 16)
+#define CSS_TASK_ITER_STOPPED		(1U << 17)

 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f10cef511ffa..091c9a38d0c7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -240,6 +240,8 @@ static int cgroup_apply_control(struct cgroup *cgrp);
 static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
 static void css_task_iter_skip(struct css_task_iter *it,
 			       struct task_struct *task);
+static void css_task_iter_stop(struct css_task_iter *it,
+			       struct css_set *cset);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss);
@@ -889,6 +891,19 @@ static void css_set_skip_task_iters(struct css_set
*cset,
 		css_task_iter_skip(it, task);
 }

+/*
+ * @cset is moving to other list, it's not safe to continue the iterator,
+ * because the cset_head and css_pos of css_task_iter does not make sense
+ * for the new list.
+ */
+static void css_set_stop_iters(struct css_set *cset)
+{
+	struct css_task_iter *it, *pos;
+
+	list_for_each_entry_safe(it, pos, &cset->task_iters, iters_node)
+		css_task_iter_stop(it, cset);
+}
+
 /**
  * css_set_move_task - move a task from one css_set to another
  * @task: task being moved
@@ -1861,9 +1876,11 @@ int rebind_subsystems(struct cgroup_root
*dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;

 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		hash_for_each(css_set_table, i, cset, hlist) {
+			css_set_stop_iters(cset);
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+		}
 		spin_unlock_irq(&css_set_lock);

 		if (ss->css_rstat_flush) {
@@ -4866,6 +4883,15 @@ static void css_task_iter_skip(struct
css_task_iter *it,
 	}
 }

+static void css_task_iter_stop(struct css_task_iter *it,
+			       struct css_set *cset)
+{
+	lockdep_assert_held(&css_set_lock);
+
+	WARN_ONCE(it->cur_cset != cset, "invalid cur_set\n");
+	it->flags |= CSS_TASK_ITER_STOPPED;
+}
+
 static void css_task_iter_advance(struct css_task_iter *it)
 {
 	struct task_struct *task;
@@ -4969,6 +4995,9 @@ struct task_struct *css_task_iter_next(struct
css_task_iter *it)

 	spin_lock_irq(&css_set_lock);

+	if (it->flags & CSS_TASK_ITER_STOPPED)
+		goto unlock;
+
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
 		css_task_iter_advance(it);
@@ -4980,6 +5009,7 @@ struct task_struct *css_task_iter_next(struct
css_task_iter *it)
 		css_task_iter_advance(it);
 	}

+unlock:
 	spin_unlock_irq(&css_set_lock);

 	return it->cur_task;



On 2023/5/24 20:13, cuigaosheng wrote:
> 
> Hi,everybody
> 
> There is a bug in the mainline
> code(https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git -b master).
> 
> The bug's call trace as follows:
>> refcount_t: addition on 0; use-after-free.
>>   WARNING: CPU: 1 PID: 342 at lib/refcount.c:25
>> refcount_warn_saturate+0xa0/0x148
>>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>>   Workqueue: events cpuset_hotplug_workfn
>>   Call trace:
>>    refcount_warn_saturate+0xa0/0x148
>>    __refcount_add.constprop.0+0x5c/0x80
>>    css_task_iter_advance_css_set+0xd8/0x210
>>    css_task_iter_advance+0xa8/0x120
>>    css_task_iter_next+0x94/0x158
>>    update_tasks_root_domain+0x58/0x98
>>    rebuild_root_domains+0xa0/0x1b0
>>    rebuild_sched_domains_locked+0x144/0x188
>>    cpuset_hotplug_workfn+0x138/0x5a0
>>    process_one_work+0x1e8/0x448
>>    worker_thread+0x228/0x3e0
>>    kthread+0xe0/0xf0
>>    ret_from_fork+0x10/0x20
>>   ---[ end trace 0000000000000000 ]---
>>   ------------[ cut here ]------------
>>   refcount_t: underflow; use-after-free.
>>   WARNING: CPU: 1 PID: 342 at lib/refcount.c:28
>> refcount_warn_saturate+0xf4/0x148
>>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>>   Workqueue: events cpuset_hotplug_workfn
>>   Call trace:
>>    refcount_warn_saturate+0xf4/0x148
>>    put_css_set_locked+0x80/0x98
>>    css_task_iter_end+0x70/0x160
>>    update_tasks_root_domain+0x68/0x98
>>    rebuild_root_domains+0xa0/0x1b0
>>    rebuild_sched_domains_locked+0x144/0x188
>>    cpuset_hotplug_workfn+0x138/0x5a0
>>    process_one_work+0x1e8/0x448
>>    worker_thread+0x228/0x3e0
>>    kthread+0xe0/0xf0
>>    ret_from_fork+0x10/0x20
>>   ---[ end trace 0000000000000000 ]---
>>   process 10324 (cpuhotplug_do_s) no longer affine to cpu1
>>   psci: CPU1 killed (polled 0 ms)
>>   Unable to handle kernel paging request at virtual address
>> 00000000c0000010
>>   Internal error: Oops: 0000000096000004 [#1] SMP
>>   Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.79 12/28/2022
>>   Workqueue: cgroup_destroy css_free_rwork_fn
>>   Call trace:
>>    cgroup_apply_control_disable+0xb0/0x1f8
>>    rebind_subsystems+0x20c/0x548
>>    cgroup_destroy_root+0x64/0x240
>>    css_free_rwork_fn+0x18c/0x1a8
>>    process_one_work+0x1e8/0x448
>>    worker_thread+0x178/0x3e0
>>    kthread+0xe0/0xf0
>>    ret_from_fork+0x10/0x20
>>   Code: 91012842 8b020f62 f9400453 b4000293 (f9400a60)
>>   SMP: stopping secondary CPUs
>>   Starting crashdump kernel...
> This bug occurs in concurrency scenarios, In the hotplug,
> update_tasks_root_domain will
> iterate over all tasks on the cpuset/root domain, the code as follows:
>> static void update_tasks_root_domain(struct cpuset *cs)
>> {
>>          struct css_task_iter it;
>>          struct task_struct *task;
>>
>>          css_task_iter_start(&cs->css, 0, &it); // hold css_set_lock
>> in css_task_iter_start
>>                  ... //nolock time1: don't hold css_set_lock
>>          while ((task = css_task_iter_next(&it))) // hold css_set_lock
>> in css_task_iter_next
>>                  dl_add_task_root_domain(task); //nolock time2: don't
>> hold css_set_lock
>>
>>          css_task_iter_end(&it);
>> }
> The cgroup.e_csets will be traversed through css_task_iter, and
> it->cset_head will record
> the head of the e_cset list that is currently traversed, we will hold
> css_set_lock in
> css_task_iter_start or in css_task_iter_next, but we don't always hold
> the css_set_lock,
> such as "nolock time1" and "nolock time2" in the code comments above.
> 
> During the time without css_set_lock in update_tasks_root_domain, if
> it->cur_cset(current css_set)
> is migrated to another list, such as:
>> int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>> {
>>      ...
>>       spin_lock_irq(&css_set_lock);
>>       hash_for_each(css_set_table, i, cset, hlist)
>>          list_move_tail(&cset->e_cset_node[ss->id],
>> &dcgrp->e_csets[ss->id]);
>>      spin_unlock_irq(&css_set_lock);
>>      ...
>> }
> The bug will be triggered. As follows:
> 
> #1> in css_task_iter_start(), it->cset_head =
> &css->cgroup->e_csets[css->ss->id]; list A
> #2> in css_task_iter_next(&it), it->cur_cset=nodeA，return task
> #3> move nodeA to listB, for example:
> rebind_subsystems(),list_move_tail(nodeA, listB),then nodeA->next = headB
> #4> next css_task_iter_next, new = nodeA->next == headB
> #5> headB is not a valid css_set, but now new != it->cset_head(nodeA),
> so headB will be referred to as a valid css_set
> #6> get_css_set(headB), refcount warning
> 
> The following changes will increase the probability of this bug being
> triggered:
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e4ca2dd2b764..120e0c23517f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -66,6 +66,7 @@
>>   #include <linux/mutex.h>
>>   #include <linux/cgroup.h>
>>   #include <linux/wait.h>
>> +#include <linux/delay.h>
>>
>>   DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>>   DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
>> @@ -1073,8 +1074,10 @@ static void update_tasks_root_domain(struct
>> cpuset *cs)
>>
>>          css_task_iter_start(&cs->css, 0, &it);
>>
>> -       while ((task = css_task_iter_next(&it)))
>> +       while ((task = css_task_iter_next(&it))) {
>> +               udelay(1000 * 10);
>>                  dl_add_task_root_domain(task);
>> +       }
>>
>>          css_task_iter_end(&it);
>>   }
> 
> We can trigger this bug with ltp test
> cases(https://github.com/linux-test-project/ltp/blob/master/runtest/controllers):
> 
> step 1: create a process to execute the following usecases:
> cpuhotplug02 cpuhotplug02.sh -c 1 -l 1
> cpuhotplug03 cpuhotplug03.sh -c 1 -l 1
> cpuhotplug04 cpuhotplug04.sh -l 1
> cpuhotplug05 cpuhotplug05.sh -c 1 -l 1 -d /tmp
> cpuhotplug06 cpuhotplug06.sh -c 1 -l 1
> cpuhotplug07 cpuhotplug07.sh -c 1 -l 1 -d /usr/src/linux
> 
> step 2: create another process to execute the following usecases:
> cpuset_base_ops cpuset_base_ops_testset.sh
> cpuset_inherit cpuset_inherit_testset.sh
> cpuset_exclusive cpuset_exclusive_test.sh
> cpuset_hierarchy cpuset_hierarchy_test.sh
> cpuset_syscall cpuset_syscall_testset.sh
> cpuset_sched_domains cpuset_sched_domains_test.sh
> cpuset_load_balance cpuset_load_balance_test.sh
> cpuset_hotplug cpuset_hotplug_test.sh
> cpuset_memory cpuset_memory_testset.sh
> 
> Looking forward to your reply.
> 
> Thanks.
> 
> 

