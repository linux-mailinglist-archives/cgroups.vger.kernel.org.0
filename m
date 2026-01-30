Return-Path: <cgroups+bounces-13534-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFpTK+gKfGkEKQIAu9opvQ
	(envelope-from <cgroups+bounces-13534-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:35:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765FB62FF
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 654D73011788
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649032FA18;
	Fri, 30 Jan 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1kNNovF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OODMM4SU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897662E093C
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736933; cv=none; b=M3Ky0nTSyvUjIBhfVVUYpsBdU5sb2nM59RsmwBb7yNfFYfFpzRG1zDzArqCP3D1/3IZrubQ6p9q2mivS/w/see+Ud6qsBrLZ/rt2ARAMBkWHfmpLqtIElCYIAGbaC6np/5AOrdiRDOpND9SOg1PSwZTtV9fuhuBWivc3jVpomOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736933; c=relaxed/simple;
	bh=yNqlr+g/dAVXBHRwuF9me3BcgwA3Yv8lNZBTDFDN7tI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ufhk4aVJ01KBxL21hpdIs5Ch6Fkl26+vmlaUOhYO/6Qn95oPjNjnyfp8TWCS956lJBmgmwNr2bV8etP8QV3b4M8IZoCUxblOypqRQhjYMvDx74u633v5KDoUtHMLuaZpnE7XnWghFnomy20f4E/6V38JihxU4+R1Bz575n6mHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1kNNovF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OODMM4SU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769736930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfw5mJCevCS/+1BMTGHFbRfoHE7pIKNdXZrhR2HqMDk=;
	b=C1kNNovFQeGpugsYsVHF12Yo4hsAfNel4mHGih+iy8TQbU09M/Crs48AQlulFKZpT9YfDX
	OXl1ykRdrS/t3kewkD1X/evfk/cr/XOEzZYNO1oadEOkblHRJwWVV7vutgky2HwVgGcHdB
	as/XbWPBgTyDFUg7FVSC5OZgwR2WYcQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-8eEw5f1OMqGP1NVOanNrsQ-1; Thu, 29 Jan 2026 20:35:29 -0500
X-MC-Unique: 8eEw5f1OMqGP1NVOanNrsQ-1
X-Mimecast-MFC-AGG-ID: 8eEw5f1OMqGP1NVOanNrsQ_1769736928
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89473f5a755so52041296d6.0
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 17:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769736928; x=1770341728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tfw5mJCevCS/+1BMTGHFbRfoHE7pIKNdXZrhR2HqMDk=;
        b=OODMM4SUW6hVpCd+LTBynzVCR9erhy1FSGzPRnsua+iCP8HlUGBmRpmW56iCHMGNRl
         KDkRhtxPBuy4irLa0dyflCqRrZMmFWLX/wKmA+s+c+oPDpH4/RjbmAPjbgrwIvXQTpQz
         h9au0mNfnQx9PaNCkIA6rUX7mPy4CwWW4qgv5uq5PvDtGeD0RXLTIAN6dg1dGoc7cOvH
         rmNKawuUb0nSs3aa5WH/FJHYc4GH2unJ6B9BuJId6XadIMqrxxbOTN9auFDLZbNB3K/7
         9r2PhEbmDACNNlNzhDMwUhBxJsg5A1XWOu56KL1W++Wbt6Mw8jeMfWXOCQsREKslIl3W
         Ftmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769736928; x=1770341728;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfw5mJCevCS/+1BMTGHFbRfoHE7pIKNdXZrhR2HqMDk=;
        b=ExEaDcGLuClWfq3aSEipmfKm7Eto8Nv29ODHkuCUKUXVHrwEMSj/e/GSTBTPURzLVQ
         1JSMxoVPkE3S99WaG/vGjtERqUqLoG8cvc1BcUQfn0jkNjHhdpX/JDhmvT2w0YZIFD9w
         Wt1CYA6c2+y2T5jpcljP4hNgzUadjlKu/AkVA+kbp+0m4fgGqnwrZAR95VortgWY9/AA
         SealuL01haQ4SOblUyeV0FdEZCKmwxi9MRm6RQLKe6VNgg+Y0QAL8e773Dv+rhgRpjau
         eb1MZ8nPWA6zDRXDvbHeTDJjawgv6ceToWSp7Obb52BQ5iNgFaLVGT7UBF/ROLLQ/7c+
         HlCA==
X-Gm-Message-State: AOJu0YzJvNWBssVQLAJIS14GUG+/18vaNdjWaQAWdmaAVidaAgLs+h3f
	eE2z/ZGTwnv0xdZEKWFh62lqIKWuJsg1bGFcEf0QfNdjFyHJcgqgKfjr13wFXsJlsiZSV+j7aXC
	SZ9ILaOHrXF2s8Pl/uDCZiROal5x0HhVRvGavfhLcVtYvkNKvCJ8/h1J3jNo=
X-Gm-Gg: AZuq6aJiR0hMz/zLyXxQVy/sDFssshZAFLaEk93dqVnyLNNRd3+vMksEa9yCVFVq1Sx
	B1rgcOhfa+J9iXAdWQ2ITmnIcydXOZnPF4/TL94w3nkIAim8q9oFGusffzl45FMzpDZzzY50MZc
	9AyYtUdi9SukGz0kK3jO1L5RIOAdhMjQh6znQpQg4xwf+TKU/5/7atp+mU4Io7vkTRa9pRpvQMr
	SbidKMFHhe1Rpm0WVtmtWnblsvw8f9prWA21uK5w/fPjfk/YJBoxlh+JF7qD4w3b2cn9Fx1VnGS
	dyNteFIhudxgg+YnnjxorbbV1Ac+XF2I7BNyn8t9k5zj3eTxl3OhUhoKMkSBqTbZAqjENFq4GTX
	guzBSUUpn9VT5ZTP3M+RYLhniP8+du3qfvMPOsyKp0KbKpFgQ9ugBiPoO
X-Received: by 2002:a05:6214:2aa3:b0:894:71b0:6b11 with SMTP id 6a1803df08f44-894e9f27757mr23304196d6.14.1769736928451;
        Thu, 29 Jan 2026 17:35:28 -0800 (PST)
X-Received: by 2002:a05:6214:2aa3:b0:894:71b0:6b11 with SMTP id 6a1803df08f44-894e9f27757mr23303976d6.14.1769736928041;
        Thu, 29 Jan 2026 17:35:28 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36ad309sm49846046d6.6.2026.01.29.17.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 17:35:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <80842353-e054-4c70-a560-f67401c5b4a2@redhat.com>
Date: Thu, 29 Jan 2026 20:35:26 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 2/2] cgroup/cpuset: Introduce a new top level
 isolcpus_update_mutex
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
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-3-longman@redhat.com>
 <08c3fad6-b881-4089-b081-bde6efbafbd2@huaweicloud.com>
 <a6f6a5f6-ca71-424d-a56f-96a896a151ae@redhat.com>
 <11d8ff97-74e5-440e-b56a-af590da5a3f6@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <11d8ff97-74e5-440e-b56a-af590da5a3f6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13534-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1765FB62FF
X-Rspamd-Action: no action

On 1/29/26 7:56 PM, Chen Ridong wrote:
>
> On 2026/1/30 5:16, Waiman Long wrote:
>> On 1/29/26 3:01 AM, Chen Ridong wrote:
>>> On 2026/1/28 12:42, Waiman Long wrote:
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
>>>> call housekeeping_update() without holding the cpus_read_lock()
>>>> and cpuset_mutex. One way to do that is to introduce a new top level
>>>> isolcpus_update_mutex which will be acquired first if the set of isolated
>>>> CPUs may have to be updated. This new isolcpus_update_mutex will provide
>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>
>>>> As cpus_read_lock() is now no longer held when
>>>> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
>>>> directly.
>>>>
>>>> The lockdep_is_cpuset_held() is also updated to check the new
>>>> isolcpus_update_mutex.
>>>>
>>> I worry about the issue:
>>>
>>> CPU1                CPU2
>>> rmdir
>>> css->ss->css_killed(css);
>>> cpuset_css_killed
>>>                  __update_isolation_cpumasks
>>>                  cpuset_full_unlock
>>> css->flags |= CSS_DYING;
>>> css_clear_dir(css);
>>> ...
>>> // offline and free do not
>>> // get isolcpus_update_mutex
>>> cpuset_css_offline
>>> cpuset_css_free
>>>                  cpuset_full_lock
>>>                  ...
>>>                  // UAF?
>>>
> Hi, Longman,
>
> In this patch, I noticed that cpuset_css_offline and cpuset_css_free do not
> acquire the isolcpus_update_mutex. This could potentially lead to a UAF issue.
>
>> That is the reason why I add a new top-level isolcpus_update_mutex.
>> cpuset_css_killed() and the update_isolation_cpumasks()'s unlock/lock sequence
>> will have to acquire this isolcpus_update_mutex first.
>>
> However, simply adding isolcpus_update_mutex to cpuset_css_killed and
> update_isolation_cpumasks may not be sufficient.
>
> As I mentioned, the path that calls __update_isolation_cpumasks may first
> acquire isolcpus_update_mutex and cpuset_full_lock, but once cpuset_css_killed
> is completed, it will release the “full” lock and then attempt to reacquire it
> later. During this intermediate period, the cpuset may have already been freed,
> because cpuset_css_offline and cpuset_css_free do not currently acquire the
> isolcpus_update_mutex.

You are right that acquisition of the new isolcpus_update_mutex should 
be in all the places where cpuset_full_lock() is acquired. Will update 
the patch to do that. That should eliminate the risk.

Cheers,
Longman


