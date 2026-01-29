Return-Path: <cgroups+bounces-13523-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ6mOrTJe2kQIgIAu9opvQ
	(envelope-from <cgroups+bounces-13523-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 21:57:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B54B45F9
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 21:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 594E930138B9
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C135B137;
	Thu, 29 Jan 2026 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT5DwTai";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft5UpGEu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D235A955
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720242; cv=none; b=ByRKmWWaPasWq8nCfnxAIeGM+7OgDK01lkq44FMi6J2KsDIP5RvGED2np4rbCzIlv+kY3xujRYElBtrVdziPCRoH+7r5bjE+fGsbH5I9+EY0E4msA6HKB5FIthHoojHmHEeUO/1qji9BlLYvzPxWNe0ok27UFmMd7enR9V55rvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720242; c=relaxed/simple;
	bh=p4FTC5ZyH+C3t13NMpOGBz9eFYM/+qAG9LyXQfJNC38=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uSb2kfW1wPaYBcyX9Rn/7DXXbZQU90u1U8CITDmNwPtU7tRQTHypwfWvekOJGw2jezcOVT8tzC7lRHy9tU5PmHHZSA8QRto1hsFBX1JV/0ZL4PuQUztJLGFEpVbYdQFtYYhksF5RtjUu+DMkDKm9bXKgmdEqM0xR/li58BYADr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT5DwTai; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ft5UpGEu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769720239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QG3wvjCSAd8hZsGbKuvepZVeOKrzgGWIR2Hdb2A8lo=;
	b=ZT5DwTaiqJqrvMcFGAR6vZtpt4VFyPD2LOp79CiLj8AxCAayA5DEDs+2cO7+NoF8qSXzo5
	wwmEFd958CXbqXcw9m4JLkzPI8iK5YkD3g+cdSh+alwPDfleHyW3EkBM0ieZt7NDX4Ipt3
	vr2O29izg0wMKGZaOGwEtqfGOc2zA6U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689--pBaMwRsNSe5IuMvhbEFSg-1; Thu, 29 Jan 2026 15:57:18 -0500
X-MC-Unique: -pBaMwRsNSe5IuMvhbEFSg-1
X-Mimecast-MFC-AGG-ID: -pBaMwRsNSe5IuMvhbEFSg_1769720238
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c5e166fb75so420799085a.0
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769720238; x=1770325038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QG3wvjCSAd8hZsGbKuvepZVeOKrzgGWIR2Hdb2A8lo=;
        b=Ft5UpGEuLbwdGSkVIPjEfpzx4urdH220iJox5JZ2B3V2Ib1ISQSgKU50NDD0hz2ABa
         QD6fY+wi0TWItaZZaNGjTE2Bvhdunqs7upnX4f4iQhvpqFAPHd0XDg1R4RuGHsPdqjyk
         iYQzGnjlfCOK8ISaduWxj2wOxb3aDZpkWGyD5JCQXwZliO7dZ9ZaEE4SBiZCBujpTX5n
         EChL+CHc8KIKwxwJA8L2qon6moWSRGO8SzsPXnx78uhZPVynOXkbC3NR3kQK36Id0h1W
         jhBJ6Zot4HoITChaReT2Djozc1xu3Rh7hSsZz86JyIOzUD/Abt1WOg41HfSmei64TIq1
         k2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720238; x=1770325038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QG3wvjCSAd8hZsGbKuvepZVeOKrzgGWIR2Hdb2A8lo=;
        b=nYy0eVsou9uyNGU//3L/ksxqqREGZiw1wpWs/z2CpRZJaLAgm/U94ixmnJvbAB/MJR
         SWS0aY4XxgaY8KbZd0gU78B9LKKj67KAwAA6BfNe7GUISinjfEYtIBm7au9CFzamGKu+
         8nunmBCnFlPx6Bsi/RCUnGdVLyeALBYN+XJbhOylWYl36i5y/HgV0kAPXLbzApe6tYPp
         QQXSg3l0Hz1vdV92SUmQoIII/xnaWA4TZnftTL3Ps4ap0ccTqLj+aHEA6hxZdIdk54FT
         mo5o7Bxo+cTvaLfVZ0u7hO7bETLWxRX9zcRY4l1ZdPDGpz7gVPJn14mcFq25pY3Gbmfg
         BUKw==
X-Gm-Message-State: AOJu0YyLeXFQ/W8STYjfcJTJiMvk5WKRjYQ7R+WxDg8TLp5U7nKT6CLI
	CY7r6BjzYv7XlXNYWgZLhYEZ9qE1UCeOEF7JycwnC9dnFEn27mYQSyH9PDT7XLw21kKGGwfIQPg
	miFC3akwAItFws0nzKNmpIyb/AAidn4k5BtBPU8g95sNtXkiea34q1c/wkIM=
X-Gm-Gg: AZuq6aLSHBxCCRDigyvIjR2ZU6b1TIWoftnGvrDqUiLXzokVr9I8K9BFO0u9+4DmY80
	JI/ec6hXeaVLiv6ikrPgb03BwbsjAC1w6zsYpphocLHCffU88+McOmu5QhEDwMrjuh5DZ3Qb9+q
	0sB4gwFNCQaB2P2B1+E9c/u1vKoVRFqLtrDkFP1KUw/6M2xFLpn8JJ6qYWk7tLOJUElXQnN7G/v
	AWNEeM3wCH+KVTekFH1gb/I39k8VFMTT5JQofoVah+Aan2zfZqElf45Y5vAYJsbmT3LmO+CQ6Fu
	vOYqGT6xPKm6xq90stA1TsfooMolfo2wqmb0wAVlTtyuxhW5IasVx4RjHH1ll6GLRFagVDAcCUO
	TIOmPMO/iKoHjGb7fkOH/arU+tUptZ1nw3fCKh90gGDX1U1d49pz+faqc
X-Received: by 2002:a05:620a:4154:b0:8b2:e1d7:ca6a with SMTP id af79cd13be357-8c9eb31574bmr130734385a.75.1769720237890;
        Thu, 29 Jan 2026 12:57:17 -0800 (PST)
X-Received: by 2002:a05:620a:4154:b0:8b2:e1d7:ca6a with SMTP id af79cd13be357-8c9eb31574bmr130732385a.75.1769720237466;
        Thu, 29 Jan 2026 12:57:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e4esm536422085a.15.2026.01.29.12.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 12:57:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be3ca35e-ec22-47e7-8507-c637fbb39d51@redhat.com>
Date: Thu, 29 Jan 2026 15:57:15 -0500
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
 <8fb3aab5-ba0a-4523-a404-5643b8a749c9@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <8fb3aab5-ba0a-4523-a404-5643b8a749c9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13523-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 68B54B45F9
X-Rspamd-Action: no action

On 1/29/26 3:20 AM, Chen Ridong wrote:
>
> On 2026/1/29 16:01, Chen Ridong wrote:
>>
>> On 2026/1/28 12:42, Waiman Long wrote:
>>> The current cpuset partition code is able to dynamically update
>>> the sched domains of a running system and the corresponding
>>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>>> "isolcpus=domain,..." boot command line feature at run time.
>>>
>>> The housekeeping cpumask update requires flushing a number of different
>>> workqueues which may not be safe with cpus_read_lock() held as the
>>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>>> which have locking dependency with cpus_read_lock() down the chain. Below
>>> is an example of such circular locking problem.
>>>
>>>    ======================================================
>>>    WARNING: possible circular locking dependency detected
>>>    6.18.0-test+ #2 Tainted: G S
>>>    ------------------------------------------------------
>>>    test_cpuset_prs/10971 is trying to acquire lock:
>>>    ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180
>>>
>>>    but task is already holding lock:
>>>    ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
>>>
>>>    which lock already depends on the new lock.
>>>
>>>    the existing dependency chain (in reverse order) is:
>>>    -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>>    -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>>    -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>>    -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>>    -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>>
>>>    Chain exists of:
>>>      (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>>>
>>>    5 locks held by test_cpuset_prs/10971:
>>>     #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
>>>     #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x260/0x5f0
>>>     #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b6/0x5f0
>>>     #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x77/0x130
>>>     #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
>>>
>>>    Call Trace:
>>>     <TASK>
>>>       :
>>>     touch_wq_lockdep_map+0x93/0x180
>>>     __flush_workqueue+0x111/0x10b0
>>>     housekeeping_update+0x12d/0x2d0
>>>     update_parent_effective_cpumask+0x595/0x2440
>>>     update_prstate+0x89d/0xce0
>>>     cpuset_partition_write+0xc5/0x130
>>>     cgroup_file_write+0x1a5/0x680
>>>     kernfs_fop_write_iter+0x3df/0x5f0
>>>     vfs_write+0x525/0xfd0
>>>     ksys_write+0xf9/0x1d0
>>>     do_syscall_64+0x95/0x520
>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> To avoid such a circular locking dependency problem, we have to
>>> call housekeeping_update() without holding the cpus_read_lock()
>>> and cpuset_mutex. One way to do that is to introduce a new top level
>>> isolcpus_update_mutex which will be acquired first if the set of isolated
>>> CPUs may have to be updated. This new isolcpus_update_mutex will provide
>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>
> When I reviewed Frederic's patches, I concerned about this issue. However, I was
> not certain whether any flush worker would need to acquire cpu_hotplug_lock or
> cpuset_mutex.
>
> Despite this warning, I do not understand how wq_completion would need to
> acquire cpu_hotplug_lock and cpuset_mutex.
>
> The reason I want to understand how wq_completion acquires cpu_hotplug_lock or
> cpuset_mutex is to determine whether isolcpus_update_mutex is truly necessary.
> As I mentioned in my previous email, I am concerned about a potential
> use-after-free (UAF) issue, which might imply that isolcpus_update_mutex is
> required in most places that currently acquire cpuset_mutex, with the possible
> exception of the hotplug path?

A circular lock dependency can invoke more than 2 tasks/parties. In this 
case, the task that hold wq_completion does not need to acquire 
cpu_hotplug_lock. If a worker that flushes a work function required for 
the completion to finish and it happens to acquire cpu_hotplug_lock with 
another task trying to acquire cpus_write_lock in the interim, the 
worker will wait there for the write lock to be released which will not 
happen until the original task that calls flush_workqueue() release its 
read lock. In essence, it is a deadlock.

Cheers,
Longman


