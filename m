Return-Path: <cgroups+bounces-14100-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DKbN5kFmmnhXwMAu9opvQ
	(envelope-from <cgroups+bounces-14100-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 20:20:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605416DA99
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 20:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638E3303AB7E
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E033148B7;
	Sat, 21 Feb 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swclrahg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r32vS3kN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00065307AF0
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771701639; cv=none; b=AYfl8z4L1ddlZdIGupYyxZtb18PpoTxOl0KPJ4FWJEksNLTKE0CxdiCJ73wTKOcu+bepqei2ny53oibn6n8eWiwSpJzI3tZMBe+CLVdtCRBEoyiIYx/GlYPjxGrm3Jy7e4LqngdBc4iN4EmmXl9INpRrVMqRz+Gj4jqmC5BPyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771701639; c=relaxed/simple;
	bh=8jodMxSYMhH21UpEqHnnNIJ0E6phiC4qkaSAKDTUN2Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uFT7Ha0n/BFf87Z36aLJzXguJluQWLY8NB+Z3QVarSypTIXki1qFA02QAaIEHm74d/9yXS/rbBHNJep/TbrHKQ6k5chaATapSc7Y4hEMOlLqXJKm4FGa/83BqYRAgVSbReaJcqaVwr68i6NNjyhX3eZijhe1xK0maNSi7x+uYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Swclrahg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r32vS3kN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771701635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMraccUJlRaK+6D4VwSMsOXOH8o6PaEGu4ABazkAYhc=;
	b=SwclrahgWLx0LtdiPsP7KuXH4Anetog2X8Yg/yFhNcA+xaKkjonjh1W2y2iWGpXWMBuxTW
	LAMoOGbvpBfY1oiRoEhGYCXDEZyrFagN74MsCW/DOvfngNWNKIDFM0Mqdus3g1JO6RNfee
	BdC90Wl6xHYJxYYJnrimk4+hrPbHERE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-kZMdM_5HOzuWkfEDgfAJ7A-1; Sat, 21 Feb 2026 14:20:34 -0500
X-MC-Unique: kZMdM_5HOzuWkfEDgfAJ7A-1
X-Mimecast-MFC-AGG-ID: kZMdM_5HOzuWkfEDgfAJ7A_1771701634
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb5359e9d3so2875855985a.2
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771701634; x=1772306434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMraccUJlRaK+6D4VwSMsOXOH8o6PaEGu4ABazkAYhc=;
        b=r32vS3kN6y99H1N5+wgLzRLN8oguO8hXLgdNXA5i5CMxPmoMMQ00gPyVbME26jUSnp
         Y6LjZQtbaw9Lnxf7MCy2Pvex1Pao3hKnbr9axi2ljz8hZSL1fFEjx69rO722A25Gu5V7
         Qf5GX7uI6ETyL83vk/boExte3eHUZle+6lvy1mgdy/I7hEp4vLxR9me06/r4mtkQCeER
         DkNDAIjbXGfGAJ7DeifevInl4vd3XIW8f06xYR+oPP/+NZNBMryaog8xSDaAOMeKkK+H
         h0ZmzTbiNi+eds/f0WcuseqamP+1SoaD4iOv7HMYKlddERNYh75wqWS5+jwUdiEtf5Hx
         VIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771701634; x=1772306434;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMraccUJlRaK+6D4VwSMsOXOH8o6PaEGu4ABazkAYhc=;
        b=xBBCqQvFLAl1Fz2oJY1pb9vQ8aoyHOR1iljLlYB503MTYpszU+6bFLxluTrUDLe4Pc
         pHFMC2XcQYwMwyLELxUDlJwNOK7pwYWn8dHDE13YOG2UzFAOQnEejAlEmJeHlf4vowA9
         1/rkfyZ6h+YTgI/juOsv09VVEMeHhTSt6LONhssqybtFq3A+hDYjZ2Kz/lAon7FWah3Z
         IxZSiCDHHp9o6mR3dXVyoScJUqxqTzvWQ6B8eedJ58Aks53BRiUhF+mwXQLftJ10ot30
         UrzWu3nM+i7F0+YnfN5tF6xJFLTvpA1+ErkbrM5jZBZoSeMizc2mZDuH9R19pOrXAQod
         nzQg==
X-Gm-Message-State: AOJu0Yxtwra6GuV7ielu4NecrjBtQ/sfljoUGMSdfw9kb2p25Kl6t8yz
	rT5xsndLYXW+beL1RqTbwyHm2v0b0HoB6yuXDx9cOz1Q/t4WV+obQYuim/WyF42OyzLurWynbFT
	j6A4oOCb3Sfs8M7/ZPbz3SEvjVbukwQTGj7mE7JN64ZpTa5avENlS3F0j5Mw=
X-Gm-Gg: AZuq6aIJQPCewU/GgAOZrDLx+g8yydJyTV8XZJUqDYwKd34Gn7g+nyDj0wVSKFcxw+V
	OSThhwOHIQxOw8lFEUFEwSwpmeYkJFP12YR5l7YC1axktvWz7Eu99O1ybdYHPWPCkf5au+Z3XQK
	lvGaIkzPZcZN0ql4M8Vn+MV5f9p3btuaIfOSdiLH7wD9jNbcscOdTPBYyzUuJKeAKOZzZOISKnc
	mZ+Xohuuy1qVQLXtMeBFDFm2JEx6j4jFlgbLHn6lfCIdz+RtD4Wq2r6f/7S7oZiarjnt5Nu+RS8
	fjCKONvlHo6amclnCbN5heALMzDqmU8P5oRrFXzQ5BmFOnhqO0yu6aO/+d0DfUKK/wl6WI5AdKQ
	saKEk94mfdckLTaXU0424ULlcAzfx6v/SpECODzPDNvKOSj6p3PLgzlX5EIW3QlHlNI+4
X-Received: by 2002:a05:620a:2905:b0:8c7:8b8:e0ac with SMTP id af79cd13be357-8cb8c9e62afmr486450385a.12.1771701633663;
        Sat, 21 Feb 2026 11:20:33 -0800 (PST)
X-Received: by 2002:a05:620a:2905:b0:8c7:8b8:e0ac with SMTP id af79cd13be357-8cb8c9e62afmr486446885a.12.1771701633172;
        Sat, 21 Feb 2026 11:20:33 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0614fbsm288082385a.17.2026.02.21.11.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 11:20:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <19ed2ed3-908e-421a-89a9-773e7f98524f@redhat.com>
Date: Sat, 21 Feb 2026 14:20:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] cgroup/cpuset: Call housekeeping_update() without
 holding cpus_read_lock
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260212164640.2408295-1-longman@redhat.com>
 <20260212164640.2408295-6-longman@redhat.com>
 <a98d730d-7a18-4e37-8aab-0376e813e649@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <a98d730d-7a18-4e37-8aab-0376e813e649@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14100-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8605416DA99
X-Rspamd-Action: no action


On 2/13/26 2:47 AM, Chen Ridong wrote:
> Hi Longman:
>
> On 2026/2/13 0:46, Waiman Long wrote:
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
>> The lockdep_is_cpuset_held() is also updated to return true if either
>> cpuset_top_mutex or cpuset_mutex is held.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c        | 99 ++++++++++++++++++++++++++++++++---
>>   kernel/sched/isolation.c      |  4 +-
>>   kernel/time/timer_migration.c |  4 +-
>>   3 files changed, 93 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 48b7f275085b..c6a97956a991 100644
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
>> @@ -135,6 +152,18 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
>>    */
>>   static bool		isolated_cpus_updating;	/* RWCS */
>>   
>> +/*
>> + * Copy of isolated_cpus to be passed to housekeeping_update()
>> + */
>> +static cpumask_var_t	isolated_hk_cpus;	/* T */
>> +
>> +/*
>> + * Flag to prevent queuing more than one task_work to the same cpuset_top_mutex
>> + * critical section.
>> + */
>> +static bool		isolcpus_twork_queued;	/* T */
>> +
>> +
>>   /*
>>    * A flag to force sched domain rebuild at the end of an operation.
>>    * It can be set in
>> @@ -301,20 +330,24 @@ void lockdep_assert_cpuset_lock_held(void)
>>    */
>>   void cpuset_full_lock(void)
>>   {
>> +	mutex_lock(&cpuset_top_mutex);
>>   	cpus_read_lock();
>>   	mutex_lock(&cpuset_mutex);
>>   }
>>   
>>   void cpuset_full_unlock(void)
>>   {
>> +	isolcpus_twork_queued = false;
> This is odd.
>
>>   	mutex_unlock(&cpuset_mutex);
>>   	cpus_read_unlock();
>> +	mutex_unlock(&cpuset_top_mutex);
>>   }
>>   
>>   #ifdef CONFIG_LOCKDEP
>>   bool lockdep_is_cpuset_held(void)
>>   {
>> -	return lockdep_is_held(&cpuset_mutex);
>> +	return lockdep_is_held(&cpuset_mutex) ||
>> +	       lockdep_is_held(&cpuset_top_mutex);
>>   }
>>   #endif
>>   
>> @@ -1338,6 +1371,28 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>   	return false;
>>   }
>>   
>> +/*
>> + * housekeeping_update() will only be called if isolated_cpus differs
>> + * from isolated_hk_cpus. To be safe, rebuild_sched_domains() will always
>> + * be called just in case there are still pending sched domains changes.
>> + */
>> +static void isolcpus_tworkfn(struct callback_head *cb)
>> +{
>> +	bool update_hk = true;
>> +
>> +	guard(mutex)(&cpuset_top_mutex);
>> +	scoped_guard(spinlock_irq, &callback_lock) {
>> +		if (cpumask_equal(isolated_hk_cpus, isolated_cpus))
>> +			update_hk = false;
>> +		else
>> +			cpumask_copy(isolated_hk_cpus, isolated_cpus);
>> +	}
>> +	if (update_hk)
>> +		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus) < 0);
>> +	rebuild_sched_domains();
>> +	kfree(cb);
>> +}
>> +
>>   /*
>>    * update_isolation_cpumasks - Update external isolation related CPU masks
>>    *
>> @@ -1346,15 +1401,42 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>    */
>>   static void update_isolation_cpumasks(void)
>>   {
>> -	int ret;
>> +	struct callback_head *twork_cb;
>>   
>>   	if (!isolated_cpus_updating)
>>   		return;
>> +	else
>> +		isolated_cpus_updating = false;
>> +
>> +	/*
>> +	 * CPU hotplug shouldn't set isolated_cpus_updating.
>> +	 *
>> +	 * To have better flexibility and prevent the possibility of deadlock,
>> +	 * we defer the housekeeping_update() call to after the current cpuset
>> +	 * critical section has finished. This is done via the synchronous
>> +	 * task_work which will be executed right before returning to userspace.
>> +	 *
>> +	 * update_isolation_cpumasks() may be called more than once in the
>> +	 * same cpuset_mutex critical section.
>> +	 */
>> +	lockdep_assert_held(&cpuset_top_mutex);
>> +	if (isolcpus_twork_queued)
>> +		return;
>>   
>> -	ret = housekeeping_update(isolated_cpus);
>> -	WARN_ON_ONCE(ret < 0);
>> +	twork_cb = kzalloc(sizeof(struct callback_head), GFP_KERNEL);
>> +	if (!twork_cb)
>> +		return;
>>   
>> -	isolated_cpus_updating = false;
>> +	/*
>> +	 * isolcpus_tworkfn() will be invoked before returning to userspace
>> +	 */
>> +	init_task_work(twork_cb, isolcpus_tworkfn);
>> +	if (task_work_add(current, twork_cb, TWA_RESUME)) {
>> +		kfree(twork_cb);
>> +		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
>> +	} else {
>> +		isolcpus_twork_queued = true;
>> +	}
>>   }
>>   
> Actually, I find this function quite complex, with numerous global
> variables to maintain.
>
> I'm considering whether we can simplify it. Could we just call
> update_isolation_cpumasks() at the end of update_prstate(),
> update_cpumask(), and update_exclusive_cpumask()?
>
> i.e.
>
> static void update_isolation_cpumasks(void)
> {
> 	struct callback_head twork_cb
>
> 	if (!isolated_cpus_updating)
> 		return;
> 	task_work_add(...)
> 	isolated_cpus_updating = false;
> }
>
> static int update_prstate(struct cpuset *cs, int new_prs)
> {
> 	...
> 	free_tmpmasks(&tmpmask);
> 	update_isolation_cpumasks();
> 	return 0;
> }
>
> For rebuilding scheduling domains, we could rebuild them during the
> set operation only when force_sd_rebuild = true and
> !isolated_cpus_updating. Otherwise, the rebuild would be deferred
> and performed only once in isolcpus_tworkfn().

Yes, the v5 series make the code more complex, so now I am reverting 
back to a more simple way.

Cheers,
Longman


