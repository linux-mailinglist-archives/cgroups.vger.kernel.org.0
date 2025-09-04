Return-Path: <cgroups+bounces-9694-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10219B43171
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F9B3A7F0B
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A666192D97;
	Thu,  4 Sep 2025 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BcKJMdOk"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C521BC3F;
	Thu,  4 Sep 2025 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962003; cv=none; b=NcYPGIlIiwoNjMhM9Eom603PbN6UgDIuNz+OFu2gbM1zjVaRPqIv9HEaiHRbt+nRJn/Kw/3K/TZoNF3oMh828Hnd6XTSIPJOfYB0hwhuil7GPCuAtkq1AHeOpvWnKZQkBiIOGo2ugVcqIN3BmOrjGOf+ZT+swHCz+8mDmuXW5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962003; c=relaxed/simple;
	bh=OsYs5YgR1uVSR0r3q7vYyGUkjridwnN2SCJtldbCjdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q78/Fp4YY5fzAbwcHffyiFzqTmwA5trjuFT+C5gggdUfI/bQ1IZOCQaW2lKL47RgDc35tyyPwB4RRyfOvyO4GpiAGQmzZUCE/aBNLjyncnIWRS1dP1VSpeqY2rnbaGDqR5StVVAzhh2+5K2QoQO8i9ZoQWitG8L7h6gVkfF9ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BcKJMdOk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756961993; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5ZP8662ZyHGOsu/Tce92GPj98qBnP78Dph4ax6/4C28=;
	b=BcKJMdOk9GUv1j0tC3EbevkM2VkPsLXsrAxmErgcJdarjEzjIK4SnpV0EWG3RIN3uETWOIn5ONXiiPjjZb7/gmXKRdsOCAr0JlyhgDEL7UokIqRHV4P21RNOKY1UcxikgMzcOZrMGcRlKYq1Z+IGlDrgg6UPPcyUh82hVMH841E=
Received: from 30.221.148.63(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnERHUW_1756961992 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 12:59:52 +0800
Message-ID: <fe7f1030-e817-4574-b2a0-e4ad4d301984@linux.alibaba.com>
Date: Thu, 4 Sep 2025 12:59:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <9a085dcd-be41-4244-a35e-014e0a1d0fd6@redhat.com>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <9a085dcd-be41-4244-a35e-014e0a1d0fd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/3 21:14, Waiman Long 写道:
>
> On 9/3/25 7:11 AM, Yi Tao wrote:
>> As computer hardware advances, modern systems are typically equipped
>> with many CPU cores and large amounts of memory, enabling the deployment
>> of numerous applications. On such systems, container creation and
>> deletion become frequent operations, making cgroup process migration no
>> longer a cold path. This leads to noticeable contention with common
>> process operations such as fork, exec, and exit.
>>
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
>> write cgroup.procs/threads  | process fork,exec,exit | process group 
>> migration
>> ------------------------------------------------------------------------------ 
>>
>> cgroup_lock()               | down_read(&g_rwsem)    | cgroup_lock()
>> down_write(&p_rwsem)        | down_read(&p_rwsem)    | 
>> down_write(&g_rwsem)
>> critical section            | critical section       | critical section
>> up_write(&p_rwsem)          | up_read(&p_rwsem)      | 
>> up_write(&g_rwsem)
>> cgroup_unlock()             | up_read(&g_rwsem)      | cgroup_unlock()
>>
>> g_rwsem denotes cgroup_threadgroup_rwsem, p_rwsem denotes
>> signal_struct->group_rwsem.
>>
>> This patch eliminates contention between cgroup migration and fork
>> operations for threads that belong to different thread groups, thereby
>> reducing the long-tail latency of cgroup migrations and lowering system
>> load.
> Do you have any performance numbers to showcase how much performance 
> benefit does this change provide?
Yes, here is the simulation test setup and results.

Machine Configuration:
Architecture: x86_64
CPU op-mode(s): 32-bit, 64-bit
Byte Order: Little Endian
CPU(s): 192
On-line CPU(s) list: 0-191
Thread(s) per core: 2
Core(s) per socket: 48
Socket(s): 2 NUMA node(s): 2
Vendor ID: GenuineIntel
BIOS Vendor ID: Intel(R) Corporation
CPU family: 6
Model: 143
Model name: Intel(R) Xeon(R) Platinum 8475B
BIOS Model name: Intel(R) Xeon(R) Platinum 8475B
NUMA node0 CPU(s): 0-47,96-143
NUMA node1 CPU(s): 48-95,144-191

Test Program 1: cgroup_attach, four threads each write to cgroup.procs 
every 10ms,
simulating frequent cgroup process migrations.
Test Program 2: stress-ng or UnixBench, used to generate CPU and 
fork-intensive workloads.

Terminal 1: taskset -ac 0-47 ./cgroup_attach
Terminal 2: taskset -ac 48-95 stress-ng --cpu 48 --forkheavy 4

Use bpftrace to monitor the latency of cgroup1_procs_write.
Without the patch: The tail latency is 30ms
With the patch:The tail latency is 16μs.

Replace stress-ng with UnixBench to evaluate fork performance:

Terminal 2: taskset -ac 48-95 ./Run spawn

Without the patch: Multi-CPU score =15753.9

With the patch: Multi-CPU score = 17111.2

We can observe that the latency of cgroup process migration has been 
significantly
reduced, and the performance of process forking has improved.

In production environments running big data computing workloads, without 
this patch,
we observed a large number of processes entering the uninterruptible 
sleep (D) state
due to contention on `cgroup_threadgroup_rwsem`. With the patch applied, 
the system
load average has decreased.

cgroup_attach.c
```
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <fcntl.h>
#include <string.h>

#define NUM_THREADS 4
#define SLEEP_US 10000  // 10ms
#define CGROUP_ROOT "/sys/fs/cgroup/cpu"

pid_t gettid() {
     return syscall(SYS_gettid);
}


void* thread_func(void* arg) {
     char dirname[256];
     char procs_file[256];
     int fd;
     pid_t child_pid;
     FILE* file;

     pid_t tid = gettid();

     snprintf(dirname, sizeof(dirname), "%s/test-%d", CGROUP_ROOT, tid);
     snprintf(procs_file, sizeof(procs_file), "%s/cgroup.procs", dirname);

     if (mkdir(dirname, 0755) != 0) {
         perror(dirname);
         pthread_exit(NULL);
     }

     printf("thread %d:  cgroup dir %s\n", tid, dirname);


     while (1) {
         child_pid = fork();

         if (child_pid < 0) {
             perror("fork");
             continue;
         }

         if (child_pid == 0) {
             usleep(SLEEP_US);
             exit(0);
         }

         fd = open(procs_file, O_WRONLY);
         if (fd < 0) {
             perror("open cgroup.procs");
         } else {
             char pid_str[16];
             int len = snprintf(pid_str, sizeof(pid_str), "%d\n", 
child_pid);
             if (write(fd, pid_str, len) < 0) {
                 perror("write cgroup.procs");
             }
             close(fd);
         }
         close(fd);
         waitpid(child_pid, NULL, NULL);
         usleep(SLEEP_US);
     }

     pthread_exit(NULL);
}

int main() {
     pthread_t threads[NUM_THREADS];
     int i;

     for (i = 0; i < NUM_THREADS; i++) {
         if (pthread_create(&threads[i], NULL, thread_func, NULL) != 0) {
             perror("pthread_create");
             break;
         }
     }

     for (i = 0; i < NUM_THREADS; i++) {
         pthread_join(threads[i], NULL);
     }

     return 0;
}

```

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
>>   static inline void cgroup_threadgroup_change_begin(struct 
>> task_struct *tsk)
>>   {
>>       percpu_down_read(&cgroup_threadgroup_rwsem);
>> +    down_read(&tsk->signal->group_rwsem);
>>   }
>>     /**
>> @@ -848,6 +849,7 @@ static inline void 
>> cgroup_threadgroup_change_begin(struct task_struct *tsk)
>>    */
>>   static inline void cgroup_threadgroup_change_end(struct task_struct 
>> *tsk)
>>   {
>> +    up_read(&tsk->signal->group_rwsem);
>>       percpu_up_read(&cgroup_threadgroup_rwsem);
>>   }
>>   diff --git a/include/linux/sched/signal.h 
>> b/include/linux/sched/signal.h
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
>>        * Thread is the potential origin of an oom condition; kill 
>> first on
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
>>       .cred_guard_mutex = 
>> __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
>>       .exec_update_lock = 
>> __RWSEM_INITIALIZER(init_signals.exec_update_lock),
>>   #ifdef CONFIG_POSIX_TIMERS
>> diff --git a/kernel/cgroup/cgroup-internal.h 
>> b/kernel/cgroup/cgroup-internal.h
>> index b14e61c64a34..572c24b7e947 100644
>> --- a/kernel/cgroup/cgroup-internal.h
>> +++ b/kernel/cgroup/cgroup-internal.h
>> @@ -249,8 +249,10 @@ int cgroup_migrate(struct task_struct *leader, 
>> bool threadgroup,
>>     int cgroup_attach_task(struct cgroup *dst_cgrp, struct 
>> task_struct *leader,
>>                  bool threadgroup);
>> -void cgroup_attach_lock(bool lock_threadgroup);
>> -void cgroup_attach_unlock(bool lock_threadgroup);
>> +void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup,
>> +            bool global);
>> +void cgroup_attach_unlock(struct task_struct *tsk, bool 
>> lock_threadgroup,
>> +              bool global);
>>   struct task_struct *cgroup_procs_write_start(char *buf, bool 
>> threadgroup,
>>                            bool *locked)
>>       __acquires(&cgroup_threadgroup_rwsem);
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index 2a4a387f867a..3e5ead8c5bc5 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct 
>> *from, struct task_struct *tsk)
>>       int retval = 0;
>>         cgroup_lock();
>> -    cgroup_attach_lock(true);
>> +    cgroup_attach_lock(NULL, true, true);
>>       for_each_root(root) {
>>           struct cgroup *from_cgrp;
>>   @@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct 
>> *from, struct task_struct *tsk)
>>           if (retval)
>>               break;
>>       }
>> -    cgroup_attach_unlock(true);
>> +    cgroup_attach_unlock(NULL, true, true);
>>       cgroup_unlock();
>>         return retval;
>> @@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, 
>> struct cgroup *from)
>>         cgroup_lock();
>>   -    cgroup_attach_lock(true);
>> +    cgroup_attach_lock(NULL, true, true);
>>         /* all tasks in @from are being moved, all csets are source */
>>       spin_lock_irq(&css_set_lock);
>> @@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, 
>> struct cgroup *from)
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
>>    * write-locking cgroup_threadgroup_rwsem. This allows ->attach() 
>> to assume that
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
> tsk is only used when global is false. So you can eliminate the 
> redundant global argument and use the presence of tsk to indicate 
> which lock to take.
>
> Cheers,
> Longman


