Return-Path: <cgroups+bounces-9688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C8AB42EE2
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 03:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0D93B30B4
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61421DE89A;
	Thu,  4 Sep 2025 01:35:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942C1547E7;
	Thu,  4 Sep 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949713; cv=none; b=RpaGGNrnYwt9KrdWKehkXUhtqcybbbwLtvuWVt4AGHOS+9rrGX6rng+yuLSNu1VqXDfWE2dLv9Tq/kig4QpaYxswKQliWLgf40YnHSzFxTwRJtxZ0mW78VXUG0QuK+s0qoLUVbD3G9YQ2eAO8+9+ih27gEHBxoyWN3i0BkbOgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949713; c=relaxed/simple;
	bh=6yrtPPFr+E/nS9K3FHUngzDWWF12ONwhXcwN7VTGjzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyjxYhM7hepDLuJ9K4lM9jQifdkI4c8PtmVU7ABDSi+sXjKnV09xgy+A1wElMGHOGNrSaWQw7Kdwsl5Qz4EtOWGUY5XtGn6+xjS4DOS7RJs1RPZvayH5EPFtO3U2uXnxyphzuA4deV9Dcnls9rn1O81Nw4OAvZ4TQPJpFUKHo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cHMVP218wzYQvMp;
	Thu,  4 Sep 2025 09:35:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF7591A0E14;
	Thu,  4 Sep 2025 09:35:07 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgCHRXvK7Lho6_ApBQ--.21754S2;
	Thu, 04 Sep 2025 09:35:07 +0800 (CST)
Message-ID: <0b05c2fa-d8b3-42d5-a924-3f4f12abb1b2@huaweicloud.com>
Date: Thu, 4 Sep 2025 09:35:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Waiman Long <llong@redhat.com>, Yi Tao <escape@linux.alibaba.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <9a085dcd-be41-4244-a35e-014e0a1d0fd6@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <9a085dcd-be41-4244-a35e-014e0a1d0fd6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHRXvK7Lho6_ApBQ--.21754S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWUWry8Gr4kJw43tF1kKrg_yoWfZF48pF
	n7Ary7J3y5C3WkWr18tayjvFyrGw48W3WUGr18J3W8Ar12yrnYqr1UZry0gry5AFZ7Gr17
	tr15Zr4UuF4Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/3 21:14, Waiman Long wrote:
> 
> On 9/3/25 7:11 AM, Yi Tao wrote:
>> As computer hardware advances, modern systems are typically equipped
>> with many CPU cores and large amounts of memory, enabling the deployment
>> of numerous applications. On such systems, container creation and
>> deletion become frequent operations, making cgroup process migration no
>> longer a cold path. This leads to noticeable contention with common
>> process operations such as fork, exec, and exit.
>>

We are facing the same issue.

>> To alleviate the contention between cgroup process migration and
>> operations like process fork, this patch modifies lock to take the write
>> lock on signal_struct->group_rwsem when writing pid to
>> cgroup.procs/threads instead of holding a global write lock.
>>
>> Cgroup process migration has historically relied on
>> signal_struct->group_rwsem to protect thread group integrity. In commit
>> <1ed1328792ff> ("sched, cgroup: replace signal_struct->group_rwsem with
>> a global percpu_rwsem"), this was changed to a global
>> cgroup_threadgroup_rwsem. The advantage of using a global lock was
>> simplified handling of process group migrations. This patch retains the
>> use of the global lock for protecting process group migration, while
>> reducing contention by using per thread group lock during
>> cgroup.procs/threads writes.
>>
>> The locking behavior is as follows:
>>
>> write cgroup.procs/threads  | process fork,exec,exit | process group migration
>> ------------------------------------------------------------------------------
>> cgroup_lock()               | down_read(&g_rwsem)    | cgroup_lock()
>> down_write(&p_rwsem)        | down_read(&p_rwsem)    | down_write(&g_rwsem)
>> critical section            | critical section       | critical section
>> up_write(&p_rwsem)          | up_read(&p_rwsem)      | up_write(&g_rwsem)
>> cgroup_unlock()             | up_read(&g_rwsem)      | cgroup_unlock()
>>
>> g_rwsem denotes cgroup_threadgroup_rwsem, p_rwsem denotes
>> signal_struct->group_rwsem.
>>
>> This patch eliminates contention between cgroup migration and fork
>> operations for threads that belong to different thread groups, thereby
>> reducing the long-tail latency of cgroup migrations and lowering system
>> load.
> Do you have any performance numbers to showcase how much performance benefit does this change provide?

Yes, I would like this performance data as well.

>> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
>> ---
>>   include/linux/cgroup-defs.h     |  2 ++
>>   include/linux/sched/signal.h    |  4 +++
>>   init/init_task.c                |  3 ++
>>   kernel/cgroup/cgroup-internal.h |  6 ++--
>>   kernel/cgroup/cgroup-v1.c       |  8 ++---
>>   kernel/cgroup/cgroup.c          | 56 ++++++++++++++++++++-------------
>>   kernel/fork.c                   |  4 +++
>>   7 files changed, 55 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 6b93a64115fe..8e0fdad8a440 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -838,6 +838,7 @@ struct cgroup_of_peak {
>>   static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>>   {
>>       percpu_down_read(&cgroup_threadgroup_rwsem);
>> +    down_read(&tsk->signal->group_rwsem);
>>   }
>>     /**
>> @@ -848,6 +849,7 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>>    */
>>   static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>>   {
>> +    up_read(&tsk->signal->group_rwsem);
>>       percpu_up_read(&cgroup_threadgroup_rwsem);
>>   }
>>   diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 1ef1edbaaf79..86fbc99a9174 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -226,6 +226,10 @@ struct signal_struct {
>>       struct tty_audit_buf *tty_audit_buf;
>>   #endif
>>   +#ifdef CONFIG_CGROUPS
>> +    struct rw_semaphore group_rwsem;
>> +#endif
>> +
>>       /*
>>        * Thread is the potential origin of an oom condition; kill first on
>>        * oom
>> diff --git a/init/init_task.c b/init/init_task.c
>> index e557f622bd90..0450093924a7 100644
>> --- a/init/init_task.c
>> +++ b/init/init_task.c
>> @@ -27,6 +27,9 @@ static struct signal_struct init_signals = {
>>       },
>>       .multiprocess    = HLIST_HEAD_INIT,
>>       .rlim        = INIT_RLIMITS,
>> +#ifdef CONFIG_CGROUPS
>> +    .group_rwsem    = __RWSEM_INITIALIZER(init_signals.group_rwsem),
>> +#endif
>>       .cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
>>       .exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
>>   #ifdef CONFIG_POSIX_TIMERS
>> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
>> index b14e61c64a34..572c24b7e947 100644
>> --- a/kernel/cgroup/cgroup-internal.h
>> +++ b/kernel/cgroup/cgroup-internal.h
>> @@ -249,8 +249,10 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
>>     int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>>                  bool threadgroup);
>> -void cgroup_attach_lock(bool lock_threadgroup);
>> -void cgroup_attach_unlock(bool lock_threadgroup);
>> +void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup,
>> +            bool global);
>> +void cgroup_attach_unlock(struct task_struct *tsk, bool lock_threadgroup,
>> +              bool global);
>>   struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>>                            bool *locked)
>>       __acquires(&cgroup_threadgroup_rwsem);
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index 2a4a387f867a..3e5ead8c5bc5 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>>       int retval = 0;
>>         cgroup_lock();
>> -    cgroup_attach_lock(true);
>> +    cgroup_attach_lock(NULL, true, true);
>>       for_each_root(root) {
>>           struct cgroup *from_cgrp;
>>   @@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>>           if (retval)
>>               break;
>>       }
>> -    cgroup_attach_unlock(true);
>> +    cgroup_attach_unlock(NULL, true, true);
>>       cgroup_unlock();
>>         return retval;
>> @@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>>         cgroup_lock();
>>   -    cgroup_attach_lock(true);
>> +    cgroup_attach_lock(NULL, true, true);
>>         /* all tasks in @from are being moved, all csets are source */
>>       spin_lock_irq(&css_set_lock);
>> @@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>>       } while (task && !ret);
>>   out_err:
>>       cgroup_migrate_finish(&mgctx);
>> -    cgroup_attach_unlock(true);
>> +    cgroup_attach_unlock(NULL, true, true);
>>       cgroup_unlock();
>>       return ret;
>>   }
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 312c6a8b55bb..4e1d80a2741f 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -2480,21 +2480,31 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
>>    * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
>>    * CPU hotplug is disabled on entry.
>>    */
>> -void cgroup_attach_lock(bool lock_threadgroup)
>> +void cgroup_attach_lock(struct task_struct *tsk,
>> +                   bool lock_threadgroup, bool global)
>>   {
>>       cpus_read_lock();
>> -    if (lock_threadgroup)
>> -        percpu_down_write(&cgroup_threadgroup_rwsem);
>> +    if (lock_threadgroup) {
>> +        if (global)
>> +            percpu_down_write(&cgroup_threadgroup_rwsem);
>> +        else
>> +            down_write(&tsk->signal->group_rwsem);
>> +    }
>>   }
> 
> tsk is only used when global is false. So you can eliminate the redundant global argument and use
> the presence of tsk to indicate which lock to take.
> 
> Cheers,
> Longman
> 

-- 
Best regards,
Ridong


