Return-Path: <cgroups+bounces-13537-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIg/GZAMfGkEKQIAu9opvQ
	(envelope-from <cgroups+bounces-13537-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:42:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A38B6392
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71EF73011580
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D933122A;
	Fri, 30 Jan 2026 01:42:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A1C13B;
	Fri, 30 Jan 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737355; cv=none; b=VIAub+H91GTndxzi+3prvgCz2upqn+YpWNsVDsW81og7GCWDSSN30SG1Dn/nGQwA//8SLqoXnzFOV5QznqTw5wb3dK0+fGcG/xhfdlcdv6hxxiZN/pONTFALVtHjx3dWRN2hvQz6qxG7huf/WjAwNw/FxE8gmiSiMpuOyEHjcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737355; c=relaxed/simple;
	bh=NPUCxz1YRJ1pSZ7W/K2EAv+EUbWbKOVgpYyasTAt08A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5EoKpS9aJAcduBCvM2vfW6Av1gNSxJdnzrTG1ZG+EeLHIDspCxxc1n6XLdVADfdwi3If36+ApDgGapoDDXqbNwVhOkLCAngI+dYsjYOtq+qPkbTaJRRW5otAR3r0ksO0QiZdMv3pLUQhUHsqet1FPeAZVIiKWgQm5ele+yMbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f2Jdm4wnMzYQv59;
	Fri, 30 Jan 2026 09:41:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 88E954056E;
	Fri, 30 Jan 2026 09:42:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgD3ovOCDHxpAq5lFg--.50107S2;
	Fri, 30 Jan 2026 09:42:28 +0800 (CST)
Message-ID: <7a67b419-1f94-441d-9d15-66dce03f9268@huaweicloud.com>
Date: Fri, 30 Jan 2026 09:42:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 2/2] cgroup/cpuset: Introduce a new top level
 isolcpus_update_mutex
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-3-longman@redhat.com>
 <08c3fad6-b881-4089-b081-bde6efbafbd2@huaweicloud.com>
 <a6f6a5f6-ca71-424d-a56f-96a896a151ae@redhat.com>
 <11d8ff97-74e5-440e-b56a-af590da5a3f6@huaweicloud.com>
 <80842353-e054-4c70-a560-f67401c5b4a2@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <80842353-e054-4c70-a560-f67401c5b4a2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3ovOCDHxpAq5lFg--.50107S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rGryfGFW5ZF4fKFy3Jwb_yoWxAw4fpr
	95KFWxtrW5Jr1kCw17tr1DWry8tw4UJ3WUXrn3JFy8JFZFyF1Fvr40qrn09ry5WrZ3Cr42
	vFn0q3y7Zr1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13537-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A38B6392
X-Rspamd-Action: no action



On 2026/1/30 9:35, Waiman Long wrote:
> On 1/29/26 7:56 PM, Chen Ridong wrote:
>>
>> On 2026/1/30 5:16, Waiman Long wrote:
>>> On 1/29/26 3:01 AM, Chen Ridong wrote:
>>>> On 2026/1/28 12:42, Waiman Long wrote:
>>>>> The current cpuset partition code is able to dynamically update
>>>>> the sched domains of a running system and the corresponding
>>>>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>>>>> "isolcpus=domain,..." boot command line feature at run time.
>>>>>
>>>>> The housekeeping cpumask update requires flushing a number of different
>>>>> workqueues which may not be safe with cpus_read_lock() held as the
>>>>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>>>>> which have locking dependency with cpus_read_lock() down the chain. Below
>>>>> is an example of such circular locking problem.
>>>>>
>>>>>     ======================================================
>>>>>     WARNING: possible circular locking dependency detected
>>>>>     6.18.0-test+ #2 Tainted: G S
>>>>>     ------------------------------------------------------
>>>>>     test_cpuset_prs/10971 is trying to acquire lock:
>>>>>     ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at:
>>>>> touch_wq_lockdep_map+0x7a/0x180
>>>>>
>>>>>     but task is already holding lock:
>>>>>     ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>>> cpuset_partition_write+0x85/0x130
>>>>>
>>>>>     which lock already depends on the new lock.
>>>>>
>>>>>     the existing dependency chain (in reverse order) is:
>>>>>     -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>>>>     -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>>>>     -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>>>>     -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>>>>     -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>>>>
>>>>>     Chain exists of:
>>>>>       (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>>>>>
>>>>>     5 locks held by test_cpuset_prs/10971:
>>>>>      #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at:
>>>>> ksys_write+0xf9/0x1d0
>>>>>      #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at:
>>>>> kernfs_fop_write_iter+0x260/0x5f0
>>>>>      #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at:
>>>>> kernfs_fop_write_iter+0x2b6/0x5f0
>>>>>      #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at:
>>>>> cpuset_partition_write+0x77/0x130
>>>>>      #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>>> cpuset_partition_write+0x85/0x130
>>>>>
>>>>>     Call Trace:
>>>>>      <TASK>
>>>>>        :
>>>>>      touch_wq_lockdep_map+0x93/0x180
>>>>>      __flush_workqueue+0x111/0x10b0
>>>>>      housekeeping_update+0x12d/0x2d0
>>>>>      update_parent_effective_cpumask+0x595/0x2440
>>>>>      update_prstate+0x89d/0xce0
>>>>>      cpuset_partition_write+0xc5/0x130
>>>>>      cgroup_file_write+0x1a5/0x680
>>>>>      kernfs_fop_write_iter+0x3df/0x5f0
>>>>>      vfs_write+0x525/0xfd0
>>>>>      ksys_write+0xf9/0x1d0
>>>>>      do_syscall_64+0x95/0x520
>>>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> To avoid such a circular locking dependency problem, we have to
>>>>> call housekeeping_update() without holding the cpus_read_lock()
>>>>> and cpuset_mutex. One way to do that is to introduce a new top level
>>>>> isolcpus_update_mutex which will be acquired first if the set of isolated
>>>>> CPUs may have to be updated. This new isolcpus_update_mutex will provide
>>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>>
>>>>> As cpus_read_lock() is now no longer held when
>>>>> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
>>>>> directly.
>>>>>
>>>>> The lockdep_is_cpuset_held() is also updated to check the new
>>>>> isolcpus_update_mutex.
>>>>>
>>>> I worry about the issue:
>>>>
>>>> CPU1                CPU2
>>>> rmdir
>>>> css->ss->css_killed(css);
>>>> cpuset_css_killed
>>>>                  __update_isolation_cpumasks
>>>>                  cpuset_full_unlock
>>>> css->flags |= CSS_DYING;
>>>> css_clear_dir(css);
>>>> ...
>>>> // offline and free do not
>>>> // get isolcpus_update_mutex
>>>> cpuset_css_offline
>>>> cpuset_css_free
>>>>                  cpuset_full_lock
>>>>                  ...
>>>>                  // UAF?
>>>>
>> Hi, Longman,
>>
>> In this patch, I noticed that cpuset_css_offline and cpuset_css_free do not
>> acquire the isolcpus_update_mutex. This could potentially lead to a UAF issue.
>>
>>> That is the reason why I add a new top-level isolcpus_update_mutex.
>>> cpuset_css_killed() and the update_isolation_cpumasks()'s unlock/lock sequence
>>> will have to acquire this isolcpus_update_mutex first.
>>>
>> However, simply adding isolcpus_update_mutex to cpuset_css_killed and
>> update_isolation_cpumasks may not be sufficient.
>>
>> As I mentioned, the path that calls __update_isolation_cpumasks may first
>> acquire isolcpus_update_mutex and cpuset_full_lock, but once cpuset_css_killed
>> is completed, it will release the “full” lock and then attempt to reacquire it
>> later. During this intermediate period, the cpuset may have already been freed,
>> because cpuset_css_offline and cpuset_css_free do not currently acquire the
>> isolcpus_update_mutex.
> 
> You are right that acquisition of the new isolcpus_update_mutex should be in all
> the places where cpuset_full_lock() is acquired. Will update the patch to do
> that. That should eliminate the risk.
> 

I suggest that putting isolcpus_update_mutex into cpuset_full_lock, since this
function means that all the locks needed have been acquired.

void cpuset_full_lock(void)
{
	mutex_lock(&isolcpus_update_mutex);
	cpus_read_lock();
	mutex_lock(&cpuset_mutex);
}

void cpuset_full_unlock(void)
{
	mutex_unlock(&cpuset_mutex);
	cpus_read_unlock();
	mutex_unlock(&isolcpus_update_mutex);
}

In the __update_isolation_cpumasks function, we can pair:

```
	...
	mutex_unlock(&cpuset_mutex);
	cpus_read_unlock();
	... Actions
	cpus_read_lock();
	mutex_lock(&cpuset_mutex);
	...
```

-- 
Best regards,
Ridong


