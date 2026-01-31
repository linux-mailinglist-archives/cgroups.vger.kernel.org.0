Return-Path: <cgroups+bounces-13578-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bRPYHJKMfmlkagIAu9opvQ
	(envelope-from <cgroups+bounces-13578-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:13:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2ADC450E
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EC8301AB81
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286B378803;
	Sat, 31 Jan 2026 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elE6xVbA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="im7jo4YX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB681314A7A
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769901196; cv=none; b=qL8hn8oHzcfBxZyLqlVHWVemBF5GAIoCZF/JEyVjz68MvGjNrleM7t5IZ2/cS3NZ+psqNXmBSLnUxHZk19tcFLTcQ9N7OOtcbwzUW9KGNd8O9c65GCB68LgjPetVFuqvfIPqSyGo69A25ZkheUAHHSHbSvLSLZ1qlUgW6cbHAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769901196; c=relaxed/simple;
	bh=DtEYf+/8dVGERPUSIP6nPLPLDmauxryQtSCXG9Agjn8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gqmKRKraIh9Yf+hwboZztJu6W0jnsRqWbE5SXWMIsOMrDCFsvUmF+ikW/CHYb+nSUsOTBJmroU6lYI0JjaniHrI61KAu+TbAnkGnSLif6REA4fUngbNIauHLDuMW5kKKIc/3RMPGPJbgrYEZ9GIok8h/OArltRmN+mjNpK5wLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elE6xVbA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=im7jo4YX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769901193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sf+9S76xELHSUmtw/UoSFJlDFF6KBx58ZpWb07Yd8Q=;
	b=elE6xVbAobnCXXfSsHEFJ/WJLSSXVb9ta0I+vC6nFjmOss25I0BdMoyXGnDjsLBTvJD+4L
	EBqvUK5A8L/3/BCSaitNuu5FaqGlgy+9QNJ3RY0Nbs6mU5bQLnZ5VTi3XhSQwOjLv3oQDd
	kA52cYI9pzab95Cioi61ryMnlYXHcIY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VCM42gEdMmCWONmvql86Eg-1; Sat, 31 Jan 2026 18:13:12 -0500
X-MC-Unique: VCM42gEdMmCWONmvql86Eg-1
X-Mimecast-MFC-AGG-ID: VCM42gEdMmCWONmvql86Eg_1769901192
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50335bd75bdso11904971cf.0
        for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769901192; x=1770505992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2sf+9S76xELHSUmtw/UoSFJlDFF6KBx58ZpWb07Yd8Q=;
        b=im7jo4YX4kOqYOWvJuUShfI1ddkxn5mjIcgAhaEJ8xNhpcQmEMZ8Gkk/BcAzZ/B9vB
         RRlvhFhpKReWJc9aKpTPxhuYaA74/5LDBL+YJhtaoBOaYosI14TdgUNq/7yBBKBTUvVq
         n60VqriRwYrDrCEt0XW2OqpLz1Bt1CnU9uKiwPGOrlpsjBpVQxOQb2l37Nt+Cg+CmdQx
         iVfKI48JuVoFJkf8ALZ6iSq/GUrvdYx3bHZgAQyQx+IN3FVRP+XphVrpPfhyYS44V+iS
         NuNi8+kTQBqhSsQqj9VQS3Hps36h1mnBPCqREvlthyiQ+/v/b2hV4HkKF6Zkjb8QKet6
         JK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769901192; x=1770505992;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sf+9S76xELHSUmtw/UoSFJlDFF6KBx58ZpWb07Yd8Q=;
        b=wWzCJ/PBsYBMPowMCD8YPNzMLgXCsSgbaatE8+s509F70WyGLBh4qPlbiVusWRB46N
         yadscNy+2KvhAvKTgOttFk8xv6AF7Pog12TSLW/v6BjFI2mv8LhSO/XI+siXm7e3UNZU
         pbmL8D5E2UE8GsNc1t1J6ek4kDZJO051hXwbTnTmFoj5jH4nxN23V4+rO1tc0jXtYCOJ
         4uBBhpGaqY3xy+iYzRVBLdZs0OMTUkraDIQZQoUyvpJJkAUglNvvfzcvyJSRWZzW2d7W
         53tl+mOpnoNvz6Dm4nvYxZWHcLzAzaCEGlhCLxW8FGBxlBmA7/gffzsNzLCiiA1fHJQC
         OZLg==
X-Gm-Message-State: AOJu0Yysl+As4EC5vV9hS13L4rt0bMDMm/S3/kBj0rSjRxfcy3SlqsNt
	qAdIPSk7Fv5K1jHLnF/g/cd2e2XGhRKQC5iLbOUIzrV/4K37xtm71i1DAAcNnqF1gUnREpyh+2c
	gEaaunfYExxnIq0T6U7xLxJu0CNhLjnKsaIwHjMq7nWnBq5ixSAACkLNJ/Qk=
X-Gm-Gg: AZuq6aKLpynrzd+SfSff7S3NFcjupEyFi1nzmrp+3CV1lQJAK3lM/pH4toQDc962CBX
	D6ohu36dymQUibV26TSp2T43uQ8sX3hZEV9x4EvSrAo1MMWxtnyYGz/+2d+47ZG+DSMStogV+6Z
	BZgHNr1pKDA+OEr2YygX6cp+lIT0opRLWY9/imzexD2qoZJ6rmD9olBGPbaMKLuiuGcyusweT4/
	dgkyRxI6BxqlqLC+3x8qRvrS/vBLZJimHrNcn7gW6ISDuOWFDBK3lE+3PI0+Sv4K+/yazHE8bcl
	cUtZ2tJW68YPPI3vKscTQgxBayiOIFJUG6Y6yojAM1rD8u8mCUnsGMcaPc4XjGvY9ZpXPDb48Z1
	1dlrNaz6nHr7BK8dt9RTWsYWf1m9/oFvduEv94YU0lHiJlIa1oYrY621p
X-Received: by 2002:ac8:5854:0:b0:501:4ff5:ae3 with SMTP id d75a77b69052e-505d2275ae3mr98375791cf.42.1769901191970;
        Sat, 31 Jan 2026 15:13:11 -0800 (PST)
X-Received: by 2002:ac8:5854:0:b0:501:4ff5:ae3 with SMTP id d75a77b69052e-505d2275ae3mr98375491cf.42.1769901191517;
        Sat, 31 Jan 2026 15:13:11 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm81204921cf.35.2026.01.31.15.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 15:13:11 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a2fc3448-dd5c-42fe-ac21-c8e1c10e94b4@redhat.com>
Date: Sat, 31 Jan 2026 18:13:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 2/2] cgroup/cpuset: Introduce a new top level
 cpuset_top_mutex
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
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-3-longman@redhat.com>
 <62022397-287c-4046-94de-058ff87ad728@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <62022397-287c-4046-94de-058ff87ad728@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13578-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2ADC450E
X-Rspamd-Action: no action


On 1/30/26 9:53 PM, Chen Ridong wrote:
>
> On 2026/1/30 23:42, Waiman Long wrote:
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
>> One way to do that is to introduce a new top level cpuset_top_mutex
>> which will be acquired first.  This new cpuset_top_mutex will provide
>> the need mutual exclusion without the need to hold cpus_read_lock().
>>
> Introducing a new global lock warrants careful consideration. I wonder if we
> could make all updates to isolated_cpus asynchronous. If that is feasible, we
> could avoid adding a global lock altogether. If not, we need to clarify which
> updates must remain synchronous and which ones can be handled asynchronously.

Almost all the cpuset code are run with cpuset_mutex held with either 
cpus_read_lock or cpus_write_lock. So there is no concurrent 
access/update to any of the cpuset internal data. The new 
cpuset_top_mutex is aded to resolve the possible deadlock scenarios with 
the new housekeeping_update() call without breaking this model. Allow 
parallel concurrent access/update to cpuset data will greatly complicate 
the code and we will likely missed some corner cases that we have to fix 
in the future. We will only do that if cpuset is in a critical 
performance path, but it is not. It is not just isolated_cpus that we 
are protecting, all the other cpuset data may be at risk if we don't 
have another top level mutex to protect them.

Cheers,
Longman


