Return-Path: <cgroups+bounces-13524-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPKSFjjOe2l4IgIAu9opvQ
	(envelope-from <cgroups+bounces-13524-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 22:16:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78488B4898
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67E7C3002913
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75AC2EB5A6;
	Thu, 29 Jan 2026 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfSy4ib5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oGfkt/vX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95D1E5B70
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721393; cv=none; b=ZdaKfe1lfpSygUcEVl2N5DIwsuo4M6Ub2aBduRdopeCDdT2v7gjwjS7oWkUDqc2dP3gP/BaeyyVMeKbEaK/RlmOQZ3qSHCew9dyvTz/xtN2e9oMAU3UNXWqOeHYNuMkrTwZ/05Qf/Ua9n9EkZL/zdQxj3kQ6STrOkqIG2kxjL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721393; c=relaxed/simple;
	bh=H5q/NMUO5HBilpHqiI8W/GgeX6KSRBcuD3xZF9DIc/w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CKjmv/kX1vjbWHP3GEeXziAL73bIZNMWWkwC2XvUollCd7ZGJF3lVgxaXWzk3CN0IriDHQ9IpyOOlesfagKWfdtFXTthL6aalVjQzTZ3av2/nDWYUsUxcLUx1WGwjUlokIsVm/SJazgyP6308Wc+bBCgSKbqjCQ4oq3wGyOF3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfSy4ib5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oGfkt/vX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769721391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXHnk3hH54f4btn//z/52twaEW5WoT4FbDzBsy0ygcQ=;
	b=RfSy4ib57FsTlAVuQt2u1W/1Ee89BsR3icw/BfXnx4g+lWrbVgxXkZkqUT6g6rXIIPi1Lp
	PKVuVES/JrlTKq9NDa7daSwbY7qXeSbBJyUZ34m/+MlP0Q6YlHOIVfMLXe0RN4pDSyAgBe
	pidDLnCjfnkpx38aE0nkU8p+L4PFgRQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-cERvOTusOhiJxwyvbUOrqQ-1; Thu, 29 Jan 2026 16:16:29 -0500
X-MC-Unique: cERvOTusOhiJxwyvbUOrqQ-1
X-Mimecast-MFC-AGG-ID: cERvOTusOhiJxwyvbUOrqQ_1769721389
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50340e2b4dfso75291961cf.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769721389; x=1770326189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXHnk3hH54f4btn//z/52twaEW5WoT4FbDzBsy0ygcQ=;
        b=oGfkt/vXQy1KePBWVaF5hiJ0+Q5mOQSszJ6XYaottbxgbtNopJ/1Lk7fWdTBl4g4f6
         7u1LwbPTsrg/amKcVbkeo4qy6EBved7Mw50Ohz6NNNGGR9Q7O1fbDG1PDVNyG5cAQR3o
         87hJLa/BqPJIP6FlP12WiNaDOY4CvUViAdrDMxOTB4ibPnKKCmBG6f9acxXM0jXHB3f/
         n2yynCcUAx14Gpryyt0u1hTNd9EMQYIzcttzLxkFGwjFxQ1mR6nIFZ/+++aZgFrngpgO
         3iZztG5sx3YQdNnnLNTFJ3/f/V0mWUuv25/1o57KyMXRl+OU53DAnW4Oj0FSzLesX0Sa
         DAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721389; x=1770326189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXHnk3hH54f4btn//z/52twaEW5WoT4FbDzBsy0ygcQ=;
        b=v3++dJKNoqC6Ya9P+7uR3PRr1I6zfaOSugauwxRmwxfV2hqIzqpGqqul5LP7+yHg7A
         OI5jLpFlyMqvn0bysjfcXOecgaOOisSc6Au0G5D55a+95WU/St7lmO3zGiE1Q6f+3UzA
         zc8qMmMjwpdxPIDP3rN+i3hmPtIF2FuWeuFjQnjppthOcX78MOaYB+CSkuqyLf5FsXHP
         yxbViBE9To/AYy2k8skWQEm2HW3NenRbbjcZt7tMSAIApYKpcpFeviFwDWYM0me+Meye
         1OWpnamlVQfm0vlbMsNfU73gNKHuL8pT0rMe46nlfXPIZfwJzXSlpybJXSyUCdw9rO7F
         IbVw==
X-Gm-Message-State: AOJu0Yyc2zSW4xCF4gOPViG/ySA49f5+u2BNnEnWy+MYt1eo55c3rwqT
	5+YA3auZM2ezHVdKaaNdW/xT6PrONte0IwxnzL9eOxkVmJ3/f3DpZr6ysDdG3DrgtDgStMz1X/U
	Ng+iDFu3jZY3LfJIAIjiaINId/fxG4Xy0tpzSaP+fxtAK6DWgBhxG90JqjHE=
X-Gm-Gg: AZuq6aI32Y0ZqpwghIr4prRId4oUZXzJ2vaFB3Rh1vXZZtOH2W66UG9B2nGuFiz/gzD
	U+Ep7MfaxPwRgBtJ6U5fb/En9dL2cfyyKwxnsroq80swPxw5jfbxf6pJjFN2vwqWH2XtyJyEWW7
	bMdWb2yNc8O2rgrBJXFDZXdFaaetS6CY1II8ckknurmzCKktg6bgqakzuL/34I9/UU/L4tXDVVI
	jlvDHJbB749OCJhRqGiPaXlxHAgah7so3JocWBDpUwivCYVZ5IcdQal9d84I3oS7VSFgcQOsyAg
	jIr/DLUtO0NDCSn3NomnR0g8cS6fdmEvsUVN8ZkZsC5LbBNCj9slsJVbcwZfmifNrJTR5n/0IEl
	GtL2FoPd7G1XNu4KSSRfCNIv/H9QEOgnapRUiVAxxuD/k2JTGrS/jrD26
X-Received: by 2002:ac8:5950:0:b0:4f1:de1c:dfa8 with SMTP id d75a77b69052e-505d2190592mr14168551cf.19.1769721388905;
        Thu, 29 Jan 2026 13:16:28 -0800 (PST)
X-Received: by 2002:ac8:5950:0:b0:4f1:de1c:dfa8 with SMTP id d75a77b69052e-505d2190592mr14168251cf.19.1769721388497;
        Thu, 29 Jan 2026 13:16:28 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm44985986d6.55.2026.01.29.13.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 13:16:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a6f6a5f6-ca71-424d-a56f-96a896a151ae@redhat.com>
Date: Thu, 29 Jan 2026 16:16:26 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 2/2] cgroup/cpuset: Introduce a new top level
 isolcpus_update_mutex
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <08c3fad6-b881-4089-b081-bde6efbafbd2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-13524-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78488B4898
X-Rspamd-Action: no action

On 1/29/26 3:01 AM, Chen Ridong wrote:
>
> On 2026/1/28 12:42, Waiman Long wrote:
>> The current cpuset partition code is able to dynamically update
>> the sched domains of a running system and the corresponding
>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>> "isolcpus=domain,..." boot command line feature at run time.
>>
>> The housekeeping cpumask update requires flushing a number of different
>> workqueues which may not be safe with cpus_read_lock() held as the
>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>> which have locking dependency with cpus_read_lock() down the chain. Below
>> is an example of such circular locking problem.
>>
>>    ======================================================
>>    WARNING: possible circular locking dependency detected
>>    6.18.0-test+ #2 Tainted: G S
>>    ------------------------------------------------------
>>    test_cpuset_prs/10971 is trying to acquire lock:
>>    ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180
>>
>>    but task is already holding lock:
>>    ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
>>
>>    which lock already depends on the new lock.
>>
>>    the existing dependency chain (in reverse order) is:
>>    -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>    -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>    -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>    -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>    -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>
>>    Chain exists of:
>>      (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>>
>>    5 locks held by test_cpuset_prs/10971:
>>     #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
>>     #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x260/0x5f0
>>     #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b6/0x5f0
>>     #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x77/0x130
>>     #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
>>
>>    Call Trace:
>>     <TASK>
>>       :
>>     touch_wq_lockdep_map+0x93/0x180
>>     __flush_workqueue+0x111/0x10b0
>>     housekeeping_update+0x12d/0x2d0
>>     update_parent_effective_cpumask+0x595/0x2440
>>     update_prstate+0x89d/0xce0
>>     cpuset_partition_write+0xc5/0x130
>>     cgroup_file_write+0x1a5/0x680
>>     kernfs_fop_write_iter+0x3df/0x5f0
>>     vfs_write+0x525/0xfd0
>>     ksys_write+0xf9/0x1d0
>>     do_syscall_64+0x95/0x520
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> To avoid such a circular locking dependency problem, we have to
>> call housekeeping_update() without holding the cpus_read_lock()
>> and cpuset_mutex. One way to do that is to introduce a new top level
>> isolcpus_update_mutex which will be acquired first if the set of isolated
>> CPUs may have to be updated. This new isolcpus_update_mutex will provide
>> the need mutual exclusion without the need to hold cpus_read_lock().
>>
>> As cpus_read_lock() is now no longer held when
>> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
>> directly.
>>
>> The lockdep_is_cpuset_held() is also updated to check the new
>> isolcpus_update_mutex.
>>
> I worry about the issue:
>
> CPU1				CPU2
> rmdir
> css->ss->css_killed(css);			
> cpuset_css_killed
> 				__update_isolation_cpumasks
> 				cpuset_full_unlock
> css->flags |= CSS_DYING;
> css_clear_dir(css);
> ...
> // offline and free do not
> // get isolcpus_update_mutex
> cpuset_css_offline
> cpuset_css_free
> 				cpuset_full_lock
> 				...
> 				// UAF?
>
That is the reason why I add a new top-level isolcpus_update_mutex. 
cpuset_css_killed() and the update_isolation_cpumasks()'s unlock/lock 
sequence will have to acquire this isolcpus_update_mutex first.

As long as all the possible paths (except CPU hotplug) that can call 
into update_isolation_cpumasks() has acquired isolcpus_update_mutex, it 
will block cpuset_css_killed() from completing. Note that I add a 
"lockdep_assert_held(&isolcpus_update_mutex);" in 
update_isolation_cpumasks().

Cheers,
Longman

>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c        | 79 ++++++++++++++++++++++++-----------
>>   kernel/sched/isolation.c      |  4 +-
>>   kernel/time/timer_migration.c |  3 +-
>>   3 files changed, 57 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 98c7cb732206..96390ceb5122 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -78,7 +78,7 @@ static cpumask_var_t	subpartitions_cpus;
>>   static cpumask_var_t	isolated_cpus;
>>   
>>   /*
>> - * isolated_cpus updating flag (protected by cpuset_mutex)
>> + * isolated_cpus updating flag (protected by isolcpus_update_mutex)
>>    * Set if isolated_cpus is going to be updated in the current
>>    * cpuset_mutex crtical section.
>>    */
>> @@ -223,29 +223,46 @@ struct cpuset top_cpuset = {
>>   };
>>   
>>   /*
>> - * There are two global locks guarding cpuset structures - cpuset_mutex and
>> - * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
>> - * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
>> - * structures. Note that cpuset_mutex needs to be a mutex as it is used in
>> - * paths that rely on priority inheritance (e.g. scheduler - on RT) for
>> - * correctness.
>> + * CPUSET Locking Convention
>> + * -------------------------
>>    *
>> - * A task must hold both locks to modify cpusets.  If a task holds
>> - * cpuset_mutex, it blocks others, ensuring that it is the only task able to
>> - * also acquire callback_lock and be able to modify cpusets.  It can perform
>> - * various checks on the cpuset structure first, knowing nothing will change.
>> - * It can also allocate memory while just holding cpuset_mutex.  While it is
>> - * performing these checks, various callback routines can briefly acquire
>> - * callback_lock to query cpusets.  Once it is ready to make the changes, it
>> - * takes callback_lock, blocking everyone else.
>> + * Below are the three global locks guarding cpuset structures in lock
>> + * acquisition order:
>> + *  - isolcpus_update_mutex (optional)
>> + *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
>> + *  - cpuset_mutex
>> + *  - callback_lock (raw spinlock)
>>    *
>> - * Calls to the kernel memory allocator can not be made while holding
>> - * callback_lock, as that would risk double tripping on callback_lock
>> - * from one of the callbacks into the cpuset code from within
>> - * __alloc_pages().
>> + * The first isolcpus_update_mutex should only be held if the existing set of
>> + * isolated CPUs (in isolated partition) or any of the partition states may be
>> + * changed when some cpuset control files are being written into. Otherwise,
>> + * it can be skipped. Holding isolcpus_update_mutex/cpus_read_lock or
>> + * cpus_write_lock will ensure mutual exclusion of isolated_cpus update.
>>    *
>> - * If a task is only holding callback_lock, then it has read-only
>> - * access to cpusets.
>> + * As cpuset will now indirectly flush a number of different workqueues in
>> + * housekeeping_update() when the set of isolated CPUs is going to be changed,
>> + * it may not be safe from the circular locking perspective to hold the
>> + * cpus_read_lock. So cpuset_full_lock() will be released before calling
>> + * housekeeping_update() and re-acquired afterward.
>> + *
>> + * A task must hold all the remaining three locks to modify externally visible
>> + * or used fields of cpusets, though some of the internally used cpuset fields
>> + * can be modified by holding cpu_hotplug_lock and cpuset_mutex only. If only
>> + * reliable read access of the externally used fields are needed, a task can
>> + * hold either cpuset_mutex or callback_lock.
>> + *
>> + * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
>> + * ensuring that it is the only task able to also acquire callback_lock and
>> + * be able to modify cpusets.  It can perform various checks on the cpuset
>> + * structure first, knowing nothing will change. It can also allocate memory
>> + * without holding callback_lock. While it is performing these checks, various
>> + * callback routines can briefly acquire callback_lock to query cpusets.  Once
>> + * it is ready to make the changes, it takes callback_lock, blocking everyone
>> + * else.
>> + *
>> + * Calls to the kernel memory allocator cannot be made while holding
>> + * callback_lock which is a spinlock, as the memory allocator may sleep or
>> + * call back into cpuset code and acquire callback_lock.
>>    *
>>    * Now, the task_struct fields mems_allowed and mempolicy may be changed
>>    * by other task, we use alloc_lock in the task_struct fields to protect
>> @@ -256,6 +273,7 @@ struct cpuset top_cpuset = {
>>    * cpumasks and nodemasks.
>>    */
>>   
>> +static DEFINE_MUTEX(isolcpus_update_mutex);
>>   static DEFINE_MUTEX(cpuset_mutex);
>>   
>>   /**
>> @@ -302,7 +320,7 @@ void cpuset_full_unlock(void)
>>   #ifdef CONFIG_LOCKDEP
>>   bool lockdep_is_cpuset_held(void)
>>   {
>> -	return lockdep_is_held(&cpuset_mutex);
>> +	return lockdep_is_held(&isolcpus_update_mutex);
>>   }
>>   #endif
>>   
>> @@ -1294,9 +1312,8 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>   static void __update_isolation_cpumasks(bool twork);
>>   static void isolation_task_work_fn(struct callback_head *cb)
>>   {
>> -	cpuset_full_lock();
>> +	guard(mutex)(&isolcpus_update_mutex);
>>   	__update_isolation_cpumasks(true);
>> -	cpuset_full_lock();
>>   }
>>   
>>   /*
>> @@ -1338,8 +1355,18 @@ static void __update_isolation_cpumasks(bool twork)
>>   		return;
>>   	}
>>   
>> +	lockdep_assert_held(&isolcpus_update_mutex);
>> +	/*
>> +	 * Release cpus_read_lock & cpuset_mutex before calling
>> +	 * housekeeping_update() and re-acquiring them afterward if not
>> +	 * calling from task_work.
>> +	 */
>> +	if (!twork)
>> +		cpuset_full_unlock();
>>   	ret = housekeeping_update(isolated_cpus);
>>   	WARN_ON_ONCE(ret < 0);
>> +	if (!twork)
>> +		cpuset_full_lock();
>>   
>>   	isolated_cpus_updating = false;
>>   }
>> @@ -3196,6 +3223,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   		return -EACCES;
>>   
>>   	buf = strstrip(buf);
>> +	mutex_lock(&isolcpus_update_mutex);
>>   	cpuset_full_lock();
>>   	if (!is_cpuset_online(cs))
>>   		goto out_unlock;
>> @@ -3226,6 +3254,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   		rebuild_sched_domains_locked();
>>   out_unlock:
>>   	cpuset_full_unlock();
>> +	mutex_unlock(&isolcpus_update_mutex);
>>   	if (of_cft(of)->private == FILE_MEMLIST)
>>   		schedule_flush_migrate_mm();
>>   	return retval ?: nbytes;
>> @@ -3329,6 +3358,7 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>>   	else
>>   		return -EINVAL;
>>   
>> +	guard(mutex)(&isolcpus_update_mutex);
>>   	cpuset_full_lock();
>>   	if (is_cpuset_online(cs))
>>   		retval = update_prstate(cs, val);
>> @@ -3502,6 +3532,7 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>>   {
>>   	struct cpuset *cs = css_cs(css);
>>   
>> +	guard(mutex)(&isolcpus_update_mutex);
>>   	cpuset_full_lock();
>>   	/* Reset valid partition back to member */
>>   	if (is_partition_valid(cs))
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 3b725d39c06e..ef152d401fe2 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -123,8 +123,6 @@ int housekeeping_update(struct cpumask *isol_mask)
>>   	struct cpumask *trial, *old = NULL;
>>   	int err;
>>   
>> -	lockdep_assert_cpus_held();
>> -
>>   	trial = kmalloc(cpumask_size(), GFP_KERNEL);
>>   	if (!trial)
>>   		return -ENOMEM;
>> @@ -136,7 +134,7 @@ int housekeeping_update(struct cpumask *isol_mask)
>>   	}
>>   
>>   	if (!housekeeping.flags)
>> -		static_branch_enable_cpuslocked(&housekeeping_overridden);
>> +		static_branch_enable(&housekeeping_overridden);
>>   
>>   	if (housekeeping.flags & HK_FLAG_DOMAIN)
>>   		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
>> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
>> index 6da9cd562b20..244a8d025e78 100644
>> --- a/kernel/time/timer_migration.c
>> +++ b/kernel/time/timer_migration.c
>> @@ -1559,8 +1559,6 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>>   	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>>   	int cpu;
>>   
>> -	lockdep_assert_cpus_held();
>> -
>>   	if (!works)
>>   		return -ENOMEM;
>>   	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
>> @@ -1570,6 +1568,7 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>>   	 * First set previously isolated CPUs as available (unisolate).
>>   	 * This cpumask contains only CPUs that switched to available now.
>>   	 */
>> +	guard(cpus_read_lock)();
>>   	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
>>   	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
>>   


