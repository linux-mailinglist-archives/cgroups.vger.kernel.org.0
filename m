Return-Path: <cgroups+bounces-13648-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKynFJengmmVXQMAu9opvQ
	(envelope-from <cgroups+bounces-13648-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 02:57:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0279E09C5
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A907730DD6EE
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347528853E;
	Wed,  4 Feb 2026 01:55:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CB274B58;
	Wed,  4 Feb 2026 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170147; cv=none; b=A6l4WtOBuVvkwLXaXLe5vjsrFCzyENa6oqDM0Yuh0POXEnEOXX7DDoLQLfTPLcNgeK07O5z2xXrTJLWxRxv0IyZ58RdBjJ8LxoxTkv7gfnTXibb4sq0j5ll0wUIGwFC/ax51jv6qXblfQUvwLdnjHh5vtS+u7b38FErkC510EF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170147; c=relaxed/simple;
	bh=frJZuKBk/KzEUk7LBg2BHiuol0DVdyJv92UMlN9wiQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oi7Sym+Wy7ewPJz7j5YxYYBhOzJnC7qfI2Ef5a+D97AHU0VYZdOSHMt4FmhRXnaLMDfBLDJWXGZVsOAHejMZwQm5QLtfWhrVvB93yC9YKeK7z0NJ1MItB+zC2/Um3nC6ADl/6fWZFKhdm5vP/Wi5jQeWB8xHkcvt755ZicTKgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f5NhY0SqbzYQtys;
	Wed,  4 Feb 2026 09:54:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CA0F4056D;
	Wed,  4 Feb 2026 09:55:41 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvcbp4JpZVS8GA--.7790S2;
	Wed, 04 Feb 2026 09:55:41 +0800 (CST)
Message-ID: <1264cf4a-0acd-475b-9f0a-57b816cdd504@huaweicloud.com>
Date: Wed, 4 Feb 2026 09:55:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 2/2] cgroup/cpuset: Introduce a new top level
 cpuset_top_mutex
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
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-3-longman@redhat.com>
 <62022397-287c-4046-94de-058ff87ad728@huaweicloud.com>
 <a2fc3448-dd5c-42fe-ac21-c8e1c10e94b4@redhat.com>
 <0c26006b-fe0f-4743-88d0-29b21fa82ee7@huaweicloud.com>
 <c8a56031-023d-4bbe-b7af-53e91c6d1dfc@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <c8a56031-023d-4bbe-b7af-53e91c6d1dfc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHNvcbp4JpZVS8GA--.7790S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rGr4kWF15Ar4UAw1DWrg_yoWxJFy5pr
	ZYgFyxtrW5Jr1xAw1Utr45Xry8t3yxJ3W7Xrn5GF18AFZIyF1Fvr4jqrna9FyUGrZ3A342
	vr90q3y7Z34DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.980];
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
	TAGGED_FROM(0.00)[bounces-13648-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: F0279E09C5
X-Rspamd-Action: no action



On 2026/2/3 2:29, Waiman Long wrote:
> On 2/1/26 8:11 PM, Chen Ridong wrote:
>>
>> On 2026/2/1 7:13, Waiman Long wrote:
>>> On 1/30/26 9:53 PM, Chen Ridong wrote:
>>>> On 2026/1/30 23:42, Waiman Long wrote:
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
>>>>> call housekeeping_update() without holding the cpus_read_lock() and
>>>>> cpuset_mutex. The current set of wq's flushed by housekeeping_update()
>>>>> may not have work functions that call cpus_read_lock() directly,
>>>>> but we are likely to extend the list of wq's that are flushed in the
>>>>> future. Moreover, the current set of work functions may hold locks that
>>>>> may have cpu_hotplug_lock down the dependency chain.
>>>>>
>>>>> One way to do that is to introduce a new top level cpuset_top_mutex
>>>>> which will be acquired first.  This new cpuset_top_mutex will provide
>>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>>
>>>> Introducing a new global lock warrants careful consideration. I wonder if we
>>>> could make all updates to isolated_cpus asynchronous. If that is feasible, we
>>>> could avoid adding a global lock altogether. If not, we need to clarify which
>>>> updates must remain synchronous and which ones can be handled asynchronously.
>>> Almost all the cpuset code are run with cpuset_mutex held with either
>>> cpus_read_lock or cpus_write_lock. So there is no concurrent access/update to
>>> any of the cpuset internal data. The new cpuset_top_mutex is aded to resolve the
>>> possible deadlock scenarios with the new housekeeping_update() call without
>>> breaking this model. Allow parallel concurrent access/update to cpuset data will
>>> greatly complicate the code and we will likely missed some corner cases that we
>> I agree with that point. However, we already have paths where isolated_cpus is
>> updated asynchronously, meaning parallel concurrent access/update is already
>> happening. Therefore, we cannot entirely avoid such scenarios, so why not keep
>> the locking simple(make all updates to isolated_cpus asynchronous)?
> 
> isolated_cpus should only be updated in isolated_cpus_update() where both
> cpuset_mutex and callback_lock are held. It can be read asynchronously if either
> cpuset_mutex or callback_lock is held. Can you show me the  places where this
> rule isn't followed?
> 

I was considering that since the hotplug path calls update_isolation_cpumasks
asynchronously, could other cpuset paths (such as setting CPUs or partitions)
also call update_isolation_cpumasks asynchronously? If so, the global
cpuset_top_mutex lock might be unnecessary. Note that isolated_cpus is updated
synchronously, while housekeeping_update is invoked asynchronously.

Just a thought for discussion, and I’d really appreciate your insights on this.

-- 
Best regards,
Ridong


