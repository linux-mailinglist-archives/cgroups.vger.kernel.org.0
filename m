Return-Path: <cgroups+bounces-13605-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLyZDVPtgGleCAMAu9opvQ
	(envelope-from <cgroups+bounces-13605-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 19:30:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E1D02F0
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 19:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A617A300CC35
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFD12E6CD0;
	Mon,  2 Feb 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gde7WOQL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pkgTkFYO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D22EC0A1
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056983; cv=none; b=sL3emATK4keo0fPQfv3NLXARdt5/ab2yAvsBDjeNRTqsQ/WJdrKTU6s8bJKehB7vUqt7e7hL1UV7MmGhtdrz4+EEj/rTOJbCizsgGo8E3YwKHpwUMeUgaHZ4Wvgm7L9rX2FFqwV5DvV99+erBcFvh9FKlmkmS/yzXXjMXLNx/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056983; c=relaxed/simple;
	bh=Cb2Eyh8arf/MeRSSAa5nOB4Xit1Y3bfK1KH37DtlQB0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t5fS3OKWTxSuu7chpUeNtnGbcvfDMIsQjDRw7hxoAHAFPu8dhrD4UZTdIB4jtjnaY2F0MUYD5EqIB4g/5vZFIVbEeuF7odih0yLVkOcDM7yEpKxOySIEa7LC42VbC//Z8YCMnDYchfjsa+TrHq2gjiNVKW8UNhV06ZKNgXh37BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gde7WOQL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pkgTkFYO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770056981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx0wPsGKpXCnpSrbS7/WgY/ofBJqsTs0t6eZejc2q4s=;
	b=Gde7WOQLXFezhQhbE49ckixBzk67YyQpg6JYNH9tkqaMs6svk2UixSz15s+MYeXMirH2gC
	TJeccDkobkmBEnCyfBmG0ESpvgdkZirac34L9Mr+r6Nx19/h3O7fh9dMuW+ccXaQkKwAfw
	xVAcl7h7E/latNOinCWGMzox06Mwdl0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-EecV_MOaMgatpcyl5FtBqg-1; Mon, 02 Feb 2026 13:29:40 -0500
X-MC-Unique: EecV_MOaMgatpcyl5FtBqg-1
X-Mimecast-MFC-AGG-ID: EecV_MOaMgatpcyl5FtBqg_1770056980
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8946f51b8c8so204551366d6.3
        for <cgroups@vger.kernel.org>; Mon, 02 Feb 2026 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770056979; x=1770661779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lx0wPsGKpXCnpSrbS7/WgY/ofBJqsTs0t6eZejc2q4s=;
        b=pkgTkFYOXtRFdDa2WYTXRPlmtvycR9Hiy3c2PcipyzQelihfaXqkPYtRV4WBjVlTGX
         fEVnNK85Wa8GA+iMyxtGoJMRQVzaMOK0ZV2FCaBB06jJQkrVPbmnXJVjXE4dtm8ciN2v
         CjKs3xyiL/6IlyYFXRra4GNwJ9IEspIoAjI0wfb+1nGnv+8erh0bkKGvGPAGfjns6BCO
         gyWgItQendnnaBkEmLgtI+7AIP68dQb3fpbFVCz1EZV3uCh8nH53nd3a5Fo0X6Ak80p3
         FUhvlYkHA+U39fq5yQTZd6kKdAmOn9hsApyA7eXp1qkwoChaqwm0x9GhRK8nQqW8AS5z
         U4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056979; x=1770661779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx0wPsGKpXCnpSrbS7/WgY/ofBJqsTs0t6eZejc2q4s=;
        b=pmek8+sIPBcdq9Aitr1JFV0c0rWmklyh083+1yCiGGe75do09v6rcnImeGn5hOpUi2
         hTV2vGLUemaqIw8m007v5hj6v+9ErWtDe2+5svJqiKjpfhB84xYmr1vJWcfOO+vq/WdY
         t+cIMGrJR2TJmz5IgMMLEFq27VhhB/puOTpOM+p3sWk6aZPp/wy0QNEBwbyUuAe2swHZ
         PICeKxIf+sBZq1lhsNs9V7amZC9TrVswwZ6KGDrMJPq76QEfRPh8h0rSaW7xmW713FPp
         oZs8B3ViNDwfm5le84bTCbSNwTcCQrPqDiBYaynfdMRmNYtmmkaWAnOx8tWhGqHHBSqc
         z3fw==
X-Gm-Message-State: AOJu0YzUM9lPGznqoPS9kQFL0d8hfsXaxO9Yj8MPWfOX1BFoU+dSBxdG
	j1osoKJ3pBSX0liqAwceepN1ZxOHZ9JVtvISw1V26FDuGrtgY+XZ8x7crL2AqShFmzb/bxuaxOM
	O4wpqyGG1wvaaxTZnddp6vZuvkkczmAesRNO4SLLOm3FTTV4/ctHJZRtw1B0=
X-Gm-Gg: AZuq6aK8dPUBsRQxoV0OJjNsZdfD3p+jbpDYIjzJpE4f+B93pCaT4feORM/SpAt85vt
	jdU0AqlFXr3kLXWXMppvRx36F5eblNJIO/dvkw3a3XXDRUos9iP43hX06JOYaC+f3L9s4foNu+I
	TA+u1XTi5zrS7rUoCnaE4wrB2uRKpCvQIX9iHxsdYYwHaX8sZvN2Zms9hYz4lbnqkWGoPvFhTt3
	6RQxWyZnZPEN8xRRGYq3A8u+vIKDmDQNbTRUv7/a/IfqQidirGqTaVOpjY1GcFu5kBLdm0kP1Mw
	zCIzQR5pZyE7IqLIWuAHV2u0bqT/PnTulbLEGmcJxcKYfnNGLTPP476SE4bDIYNwk3GhFRayosR
	jfkspR7Rh/DCK++jMD0M4qBIKxXX0Cr9mMKT1h3NWv+neWjKAQWfEUoPV
X-Received: by 2002:a05:6214:c2d:b0:890:8b82:4f31 with SMTP id 6a1803df08f44-894e9f40f6dmr201023186d6.10.1770056979507;
        Mon, 02 Feb 2026 10:29:39 -0800 (PST)
X-Received: by 2002:a05:6214:c2d:b0:890:8b82:4f31 with SMTP id 6a1803df08f44-894e9f40f6dmr201022696d6.10.1770056979036;
        Mon, 02 Feb 2026 10:29:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b8ec20sm1234132085a.19.2026.02.02.10.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:29:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c8a56031-023d-4bbe-b7af-53e91c6d1dfc@redhat.com>
Date: Mon, 2 Feb 2026 13:29:36 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 2/2] cgroup/cpuset: Introduce a new top level
 cpuset_top_mutex
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <0c26006b-fe0f-4743-88d0-29b21fa82ee7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13605-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 979E1D02F0
X-Rspamd-Action: no action

On 2/1/26 8:11 PM, Chen Ridong wrote:
>
> On 2026/2/1 7:13, Waiman Long wrote:
>> On 1/30/26 9:53 PM, Chen Ridong wrote:
>>> On 2026/1/30 23:42, Waiman Long wrote:
>>>> The current cpuset partition code is able to dynamically update
>>>> the sched domains of a running system and the corresponding
>>>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>>>> "isolcpus=domain,..." boot command line feature at run time.
>>>>
>>>> The housekeeping cpumask update requires flushing a number of different
>>>> workqueues which may not be safe with cpus_read_lock() held as the
>>>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>>>> which have locking dependency with cpus_read_lock() down the chain. Below
>>>> is an example of such circular locking problem.
>>>>
>>>>     ======================================================
>>>>     WARNING: possible circular locking dependency detected
>>>>     6.18.0-test+ #2 Tainted: G S
>>>>     ------------------------------------------------------
>>>>     test_cpuset_prs/10971 is trying to acquire lock:
>>>>     ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at:
>>>> touch_wq_lockdep_map+0x7a/0x180
>>>>
>>>>     but task is already holding lock:
>>>>     ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>> cpuset_partition_write+0x85/0x130
>>>>
>>>>     which lock already depends on the new lock.
>>>>
>>>>     the existing dependency chain (in reverse order) is:
>>>>     -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>>>     -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>>>     -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>>>     -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>>>     -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>>>
>>>>     Chain exists of:
>>>>       (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>>>>
>>>>     5 locks held by test_cpuset_prs/10971:
>>>>      #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
>>>>      #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at:
>>>> kernfs_fop_write_iter+0x260/0x5f0
>>>>      #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at:
>>>> kernfs_fop_write_iter+0x2b6/0x5f0
>>>>      #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at:
>>>> cpuset_partition_write+0x77/0x130
>>>>      #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>> cpuset_partition_write+0x85/0x130
>>>>
>>>>     Call Trace:
>>>>      <TASK>
>>>>        :
>>>>      touch_wq_lockdep_map+0x93/0x180
>>>>      __flush_workqueue+0x111/0x10b0
>>>>      housekeeping_update+0x12d/0x2d0
>>>>      update_parent_effective_cpumask+0x595/0x2440
>>>>      update_prstate+0x89d/0xce0
>>>>      cpuset_partition_write+0xc5/0x130
>>>>      cgroup_file_write+0x1a5/0x680
>>>>      kernfs_fop_write_iter+0x3df/0x5f0
>>>>      vfs_write+0x525/0xfd0
>>>>      ksys_write+0xf9/0x1d0
>>>>      do_syscall_64+0x95/0x520
>>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> To avoid such a circular locking dependency problem, we have to
>>>> call housekeeping_update() without holding the cpus_read_lock() and
>>>> cpuset_mutex. The current set of wq's flushed by housekeeping_update()
>>>> may not have work functions that call cpus_read_lock() directly,
>>>> but we are likely to extend the list of wq's that are flushed in the
>>>> future. Moreover, the current set of work functions may hold locks that
>>>> may have cpu_hotplug_lock down the dependency chain.
>>>>
>>>> One way to do that is to introduce a new top level cpuset_top_mutex
>>>> which will be acquired first.  This new cpuset_top_mutex will provide
>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>
>>> Introducing a new global lock warrants careful consideration. I wonder if we
>>> could make all updates to isolated_cpus asynchronous. If that is feasible, we
>>> could avoid adding a global lock altogether. If not, we need to clarify which
>>> updates must remain synchronous and which ones can be handled asynchronously.
>> Almost all the cpuset code are run with cpuset_mutex held with either
>> cpus_read_lock or cpus_write_lock. So there is no concurrent access/update to
>> any of the cpuset internal data. The new cpuset_top_mutex is aded to resolve the
>> possible deadlock scenarios with the new housekeeping_update() call without
>> breaking this model. Allow parallel concurrent access/update to cpuset data will
>> greatly complicate the code and we will likely missed some corner cases that we
> I agree with that point. However, we already have paths where isolated_cpus is
> updated asynchronously, meaning parallel concurrent access/update is already
> happening. Therefore, we cannot entirely avoid such scenarios, so why not keep
> the locking simple(make all updates to isolated_cpus asynchronous)?

isolated_cpus should only be updated in isolated_cpus_update() where 
both cpuset_mutex and callback_lock are held. It can be read 
asynchronously if either cpuset_mutex or callback_lock is held. Can you 
show me the  places where this rule isn't followed?

Cheers,
Longman


