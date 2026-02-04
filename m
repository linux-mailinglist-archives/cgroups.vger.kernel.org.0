Return-Path: <cgroups+bounces-13653-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D0HJ8HPgmk8cAMAu9opvQ
	(envelope-from <cgroups+bounces-13653-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:49:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F58E19B1
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27FE93008C11
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004B34E746;
	Wed,  4 Feb 2026 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCQo1LBZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVMoyMtD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF82337105
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180542; cv=none; b=J8VHI06WBfs1KsyO0mrUNXXsYs3uiv99mQMD/LG0bnaVyJLCGphU6eso6/Qok2jrEjL6pDkgEq6kyJDMEjUQyGeAwgeN5JN6NPp+czkx7k4PSGSElqQ+q8rUd/glgjhblWCFCL3fVb2MrNoHidm1PNuXJb8egYKC9dxmQCZUlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180542; c=relaxed/simple;
	bh=+czzITXfo7mastxUUGo/aH9kzFCTW8TcppL4zk1k7Fc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MIIgN6RT2q8yQea8DIx1cQ1SrTV2yCKVx12IJe5wDl9miXrSXq7XkcO1xnSHe9X7NOLWr9oJ2nIIRwMxA7sqGHRCMPNODdyfutRuI/5vih3dT05CYxqzgFfTFoooK7AjKLaWsZbMnv7h5Mq5O/aObsCsEn3/Kkz8LYkSKDtx9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCQo1LBZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVMoyMtD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770180541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/2+xTfIjtGMBVQrmAcGgdqv6JTdvdwaafvX4/TR3+8=;
	b=cCQo1LBZqlfjBkg4gysCS+BbhYlcka2gDJoi2JuvkfbXxdd/Bpd6wjuYKxmiAgsRiEGPXt
	tK37x7QkPkqEibximlxDIrePo/KVWkJ9u1T7iiI3fBd2groycbG3xoiil4McpbR6gJL8k+
	wAXzbHToa49myNxKFS+Fe/xTKJO1fa0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-T_iGybBkNxygWedja39d8w-1; Tue, 03 Feb 2026 23:49:00 -0500
X-MC-Unique: T_iGybBkNxygWedja39d8w-1
X-Mimecast-MFC-AGG-ID: T_iGybBkNxygWedja39d8w_1770180539
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5014ad65e3eso23642371cf.1
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 20:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770180539; x=1770785339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/2+xTfIjtGMBVQrmAcGgdqv6JTdvdwaafvX4/TR3+8=;
        b=iVMoyMtDP2bIkLDMvS9EqhP2HTWpRqs2UX3PlcEJsIXMKrJFQDKv0t0X1inkwI1EnJ
         qNPbGc5p5brkXgaH3xK8OSLaDCohQ716rlQAto9AEf7SG7sGy6f0AAM5bsvyaop2TuTn
         Steg2sRjFL95gVqNiRO9BR1R6De5ts5FCFwWjPMNzNx5104RRYpFppckOtz0syAtnpe2
         OtS4a0ifC3JRDY1Hf7IhNWT0VzmwXEOKGBhPhLCdZkytYokZ/ansm0E3lOKgW1WoSEgd
         n6g2GnHvptwbVqMUlnam57BSLuQtSZKTpNohmtfIUN2jIZL6OCZO0O33Ucy41PvmRKRr
         Ofbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770180539; x=1770785339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/2+xTfIjtGMBVQrmAcGgdqv6JTdvdwaafvX4/TR3+8=;
        b=HJU7Obz6sl4Zyit/aCd0Mmq1kn6PC4vPMW2FW6KSBYT/mGFDOtx43TZVM5h/ucmqvd
         /4n/Ut3r36TmLdyGILLN2aRGimolQ/IkjY5rrXNhfMhHjf9IeGAUvxx4Wy1tPLMtwSGz
         gyIieQNOf0YTnCxCnDGNeLgRPaQV0+vrq48suwE8CPGp6PCrJU3U9EBtjH3sq76WtLd4
         1hbW/h4UMORwAL94DiLPW8il/dXH8F9xjvjYmj1jBrdYabT4I12Gqbp4wgQuI1/NjfGf
         DpvJHpjEqk5sWl1/EkmtwUdsvTM9anFSULd+iKcqqW80B9IIbWsBKehTAwknFFkJ6G3u
         himQ==
X-Gm-Message-State: AOJu0YyH1GbjasoKnobT6svKBOygnlGkelkJwwt+1duXdWNioa9KDOg0
	lZL5zNNAKl97Tap6TZKQrK46239TK3ip8CUCle23nWtZIYABUJyxjRCuAlQacYl8FLsR3jQP6al
	fXPCxmqppEgNhJ2KpqZC8DmpilrRZKacTdt0eC8pTELUha+obYI1k2xLnPoc=
X-Gm-Gg: AZuq6aJ02oeY89ViC4/Dn4dL33bxFkhge0iKcDpNG5a/FPF8W2XqP7Y6sj03mr5DPAQ
	xDnLZlW+giJTPUlFcYub8gBWRiSdJd7Kcqa7+s2TBX5eE9c9HhErCUOR6vL8lBQ0fYANDf0j10r
	SDuDMRrBvGcig2ssETcrYHHWDkWLTxqNUUncZeM2d3Hf0BMGjvuUoI5Bkmf2QAEFvSUh9/6nCpz
	jQILXa7gg8VoBC9ex7w8h0Q3HwYSo07R9vQvTl2eXN6YxPrW+zxF1Op6VT9nmHJYaucf9lvTyrl
	7NC46t0t3cbuUhoqdbEzWHzi9lS+PhRWslHp/4738YkNd5ZvwaMMOE9TxnFqY3sbqSt5Wg9Bdsm
	W85RsT7/S0Uq5rlm3PkKGAvtL4LjyyFTk9htcsm0G8E07QduWCGJtd5+/
X-Received: by 2002:a05:622a:11c9:b0:505:e529:11e9 with SMTP id d75a77b69052e-5060930a73cmr78411401cf.36.1770180539515;
        Tue, 03 Feb 2026 20:48:59 -0800 (PST)
X-Received: by 2002:a05:622a:11c9:b0:505:e529:11e9 with SMTP id d75a77b69052e-5060930a73cmr78411211cf.36.1770180539100;
        Tue, 03 Feb 2026 20:48:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d3cbb1sm11553216d6.55.2026.02.03.20.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 20:48:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cd44676f-ab39-4b59-8215-7986b5a3e21b@redhat.com>
Date: Tue, 3 Feb 2026 23:48:57 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 3/3] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
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
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-4-longman@redhat.com>
 <da771006-c1ca-435a-bdec-793e866a2b49@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <da771006-c1ca-435a-bdec-793e866a2b49@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13653-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35F58E19B1
X-Rspamd-Action: no action

On 2/3/26 9:44 PM, Chen Ridong wrote:
>
> On 2026/2/3 4:11, Waiman Long wrote:
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
>> call housekeeping_update() without holding the cpus_read_lock() and
>> cpuset_mutex. The current set of wq's flushed by housekeeping_update()
>> may not have work functions that call cpus_read_lock() directly,
>> but we are likely to extend the list of wq's that are flushed in the
>> future. Moreover, the current set of work functions may hold locks that
>> may have cpu_hotplug_lock down the dependency chain.
>>
>> One way to do that is to defer the housekeeping_update() call after
>> the current cpuset critical section has finished without holding
>> cpus_read_lock. For cpuset control file write, this can be done by
>> deferring it using task_work right before returning to userspace.
>>
>> To enable mutual exclusion between the housekeeping_update() call and
>> other cpuset control file write actions, a new top level cpuset_top_mutex
>> is introduced. This new mutex will be acquired first to allow sharing
>> variables used by both code paths. However, cpuset update from CPU
>> hotplug can still happen in parallel with the housekeeping_update()
>> call, though that should be rare in production environment.
>>
>> As cpus_read_lock() is now no longer held when
>> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
>> directly.
>>
>> The lockdep_is_cpuset_held() is also updated to check the new
>> cpuset_top_mutex.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c        | 103 +++++++++++++++++++++++++++-------
>>   kernel/sched/isolation.c      |   4 +-
>>   kernel/time/timer_migration.c |   3 +-
>>   3 files changed, 86 insertions(+), 24 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e98a2e953392..d2f51f40f87e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -65,14 +65,28 @@ static const char * const perr_strings[] = {
>>    * CPUSET Locking Convention
>>    * -------------------------
>>    *
>> - * Below are the three global locks guarding cpuset structures in lock
>> + * Below are the four global/local locks guarding cpuset structures in lock
>>    * acquisition order:
>> + *  - cpuset_top_mutex
>>    *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
>>    *  - cpuset_mutex
>>    *  - callback_lock (raw spinlock)
>>    *
>> - * A task must hold all the three locks to modify externally visible or
>> - * used fields of cpusets, though some of the internally used cpuset fields
>> + * As cpuset will now indirectly flush a number of different workqueues in
>> + * housekeeping_update() to update housekeeping cpumasks when the set of
>> + * isolated CPUs is going to be changed, it may be vulnerable to deadlock
>> + * if we hold cpus_read_lock while calling into housekeeping_update().
>> + *
>> + * The first cpuset_top_mutex will be held except when calling into
>> + * cpuset_handle_hotplug() from the CPU hotplug code where cpus_write_lock
>> + * and cpuset_mutex will be held instead. The main purpose of this mutex
>> + * is to prevent regular cpuset control file write actions from interfering
>> + * with the call to housekeeping_update(), though CPU hotplug operation can
>> + * still happen in parallel. This mutex also provides protection for some
>> + * internal variables.
>> + *
>> + * A task must hold all the remaining three locks to modify externally visible
>> + * or used fields of cpusets, though some of the internally used cpuset fields
>>    * and internal variables can be modified without holding callback_lock. If only
>>    * reliable read access of the externally used fields are needed, a task can
>>    * hold either cpuset_mutex or callback_lock which are exposed to other
>> @@ -100,6 +114,7 @@ static const char * const perr_strings[] = {
>>    * cpumasks and nodemasks.
>>    */
>>   
>> +static DEFINE_MUTEX(cpuset_top_mutex);
>>   static DEFINE_MUTEX(cpuset_mutex);
>>   
>>   /*
>> @@ -111,6 +126,8 @@ static DEFINE_MUTEX(cpuset_mutex);
>>    *
>>    * CSCB: Readable by holding either cpuset_mutex or callback_lock. Writable
>>    *	 by holding both cpuset_mutex and callback_lock.
>> + *
>> + * T:	 Read/write-able by holding the cpuset_top_mutex.
>>    */
>>   
>>   /*
>> @@ -135,6 +152,13 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
>>    */
>>   static bool		isolated_cpus_updating;	/* RWCS */
>>   
>> +/*
>> + * Copy of isolated_cpus to be processed by housekeeping_update()
>> + */
>> +static cpumask_var_t	isolated_hk_cpus;	/* T */
>> +static bool		isolcpus_twork_queued;	/* T */
>> +
>> +
>>   /*
>>    * A flag to force sched domain rebuild at the end of an operation.
>>    * It can be set in
>> @@ -298,6 +322,7 @@ void lockdep_assert_cpuset_lock_held(void)
>>    */
>>   void cpuset_full_lock(void)
>>   {
>> +	mutex_lock(&cpuset_top_mutex);
>>   	cpus_read_lock();
>>   	mutex_lock(&cpuset_mutex);
>>   }
>> @@ -306,12 +331,13 @@ void cpuset_full_unlock(void)
>>   {
>>   	mutex_unlock(&cpuset_mutex);
>>   	cpus_read_unlock();
>> +	mutex_unlock(&cpuset_top_mutex);
>>   }
>>   
>>   #ifdef CONFIG_LOCKDEP
>>   bool lockdep_is_cpuset_held(void)
>>   {
>> -	return lockdep_is_held(&cpuset_mutex);
>> +	return lockdep_is_held(&cpuset_top_mutex);
>>   }
>>   #endif
>>   
> void cpuset_lock(void)
> {
> 	mutex_lock(&cpuset_mutex);
> }
>
> void cpuset_unlock(void)
> {
> 	mutex_unlock(&cpuset_mutex);
> }
>
> void lockdep_assert_cpuset_lock_held(void)
> {
> 	lockdep_assert_held(&cpuset_mutex);
> }
>
> A potential issue is that lockdep_is_cpuset_held() only checks cpuset_top_mutex.
> In the call chain below, only cpuset_mutex is acquired:
>
> rebuild_sched_domains_cpuslocked ---only cpuset_mutex is acquired
> rebuild_sched_domains_locked
> partition_sched_domains
> dl_rebuild_rd_accounting
> dl_rebuild_rd_accounting
> dl_update_tasks_root_domain
> dl_add_task_root_domain
> dl_get_task_effective_cpus
> housekeeping_cpumask
> housekeeping_dereference_check
> if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
>
> Since lockdep_is_cpuset_held() validates cpuset_top_mutex rather than
> cpuset_mutex, could this lead to false lockdep warnings?

Right, it should check for either cpuset_mutex or cpuset_top_mutex.

Thanks,
Longman


