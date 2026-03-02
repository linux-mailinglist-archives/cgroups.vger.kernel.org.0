Return-Path: <cgroups+bounces-14513-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPO9BmqwpWkiEgAAu9opvQ
	(envelope-from <cgroups+bounces-14513-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 16:44:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13241DC144
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA4930B3BD8
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EA410D38;
	Mon,  2 Mar 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="catNdLn9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C492411605
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466066; cv=none; b=S6XZRBuHgeZZluIJEcvnub4dCGN3Is7BxVSFImnF7QO+kVFsJYn455FPZwB/CN960pv63FzL06rvFf5En7UJAd5gH4nGisjnDfM57+RecamKkEVG7puLKD5l4jCzCrRFR2Zi/g2xOW0GZiQ1zZvTIrzFZ/LW+fqmtdZpOcXtEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466066; c=relaxed/simple;
	bh=Sn79Tp4j4e37SQOpZGw6KBv32AznSaZqQjez4uDw8UU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QXr07i3h5NtRt2qUThlfTwW4XYytckQzPd1MDFyYLzlWRo8ocDSRcN9Qg10n1P3zMLnedWM3cONVl3enXHExa9F4UaqtvWy6pLK54/0aLBv1XN9I5KZIJehaPMq7IS8URLTKtSWtLA6k21hxyvsMs0bF7a6SWv7ZLfXwpIdt+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=catNdLn9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGDe4JIc5UBthN6hNfTBDgbGPk6BWkYMi6VpaUo3v2k=;
	b=catNdLn9Y+kbRfgIbO62+jeuQnVBLhVO5TlWQI0/TlywqAH0iziEt0stPyiL3iZ9MH6Eg5
	FtqKnPgGYg/GjiYNNzlx6FDYVVKIczphEjP7lJ0nsuqyO1e1RPotbRRlCbnVC+Mlb9eR2S
	T/5QJw82bdOFOL/wqKXk8cRU1CNp2hM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-s5WJt1DOOcidKUj6rskWYQ-1; Mon,
 02 Mar 2026 10:40:57 -0500
X-MC-Unique: s5WJt1DOOcidKUj6rskWYQ-1
X-Mimecast-MFC-AGG-ID: s5WJt1DOOcidKUj6rskWYQ_1772466052
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97F6618003FC;
	Mon,  2 Mar 2026 15:40:51 +0000 (UTC)
Received: from [10.22.65.79] (unknown [10.22.65.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39DCB30001B9;
	Mon,  2 Mar 2026 15:40:45 +0000 (UTC)
Message-ID: <3936bd39-2e1c-44b7-8098-e8e950a6df11@redhat.com>
Date: Mon, 2 Mar 2026 10:40:45 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] cgroup/cpuset: Call housekeeping_update() without
 holding cpus_read_lock
From: Waiman Long <longman@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-9-longman@redhat.com> <aaV/Jme7NAooNxZQ@lothringen>
 <69ec4b3c-818b-4784-9b90-1ac5e977ae58@redhat.com>
Content-Language: en-US
In-Reply-To: <69ec4b3c-818b-4784-9b90-1ac5e977ae58@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: A13241DC144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14513-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 9:15 AM, Waiman Long wrote:
> On 3/2/26 7:14 AM, Frederic Weisbecker wrote:
>> On Sat, Feb 21, 2026 at 01:54:18PM -0500, Waiman Long wrote:
>>> The current cpuset partition code is able to dynamically update
>>> the sched domains of a running system and the corresponding
>>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>>> "isolcpus=domain,..." boot command line feature at run time.
>>>
>>> The housekeeping cpumask update requires flushing a number of different
>>> workqueues which may not be safe with cpus_read_lock() held as the
>>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>>> which have locking dependency with cpus_read_lock() down the chain. 
>>> Below
>>> is an example of such circular locking problem.
>>>
>>>    ======================================================
>>>    WARNING: possible circular locking dependency detected
>>>    6.18.0-test+ #2 Tainted: G S
>>>    ------------------------------------------------------
>>>    test_cpuset_prs/10971 is trying to acquire lock:
>>>    ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: 
>>> touch_wq_lockdep_map+0x7a/0x180
>>>
>>>    but task is already holding lock:
>>>    ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: 
>>> cpuset_partition_write+0x85/0x130
>>>
>>>    which lock already depends on the new lock.
>>>
>>>    the existing dependency chain (in reverse order) is:
>>>    -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>>    -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>>    -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>>    -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>>    -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>>
>>>    Chain exists of:
>>>      (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>> Which workqueue is involved here that holds rtnl_mutex?
>> Is this an existing problem or added test code?
>
> Circular locking dependency here may not necessarily mean that 
> rtnl_mutex is directly used in a work function.  However it can be 
> used in a locking chain involving multiple parties that can result in 
> a deadlock situation if they happen in the right order. So it is 
> better safe that sorry even if the chance of this occurrence is minimal. 

Below is the full lockdep splat, I didn't include the individual stack 
traces to make the commit log less verbose.

The rtnl_mutex is indeed involved in local_pci_probe().

Cheers,
Longman

[  909.360022] ======================================================
[  909.366208] WARNING: possible circular locking dependency detected
[  909.372387] 7.0.0-rc1-test+ #3 Tainted: G S
[  909.378044] ------------------------------------------------------
[  909.384225] test_cpuset_prs/8673 is trying to acquire lock:
[  909.389798] ffff8890b0fd6558 ((wq_completion)sync_wq){+.+.}-{0:0}, 
at: touch_wq_lockdep_map+0x7a/0x180
[  909.399114]
                but task is already holding lock:
[  909.404946] ffffffffb9741c10 (cpuset_mutex){+.+.}-{4:4}, at: 
cpuset_partition_write+0x85/0x130
[  909.413562]
                which lock already depends on the new lock.

[  909.421733]
                the existing dependency chain (in reverse order) is:
[  909.429213]
                -> #4 (cpuset_mutex){+.+.}-{4:4}:
[  909.435056]        __lock_acquire+0x58c/0xbd0
[  909.439421]        lock_acquire.part.0+0xbd/0x260
[  909.444129]        __mutex_lock+0x1a7/0x1ba0
[  909.448411]        cpuset_css_online+0x59/0x410
[  909.452948]        online_css+0x9b/0x2d0
[  909.456877]        css_create+0x3c6/0x610
[  909.460895]        cgroup_apply_control_enable+0x2ff/0x460
[  909.466384]        cgroup_subtree_control_write+0x79a/0xc70
[  909.471963]        cgroup_file_write+0x1a5/0x680
[  909.476582]        kernfs_fop_write_iter+0x3df/0x5f0
[  909.481550]        vfs_write+0x525/0xfd0
[  909.485482]        ksys_write+0xf9/0x1d0
[  909.489410]        do_syscall_64+0x13a/0x1520
[  909.493778]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  909.499361]
                -> #3 (cpu_hotplug_lock){++++}-{0:0}:
[  909.505547]        __lock_acquire+0x58c/0xbd0
[  909.509914]        lock_acquire.part.0+0xbd/0x260
[  909.514630]        cpus_read_lock+0x40/0xe0
[  909.518824]        flush_all_backlogs+0x83/0x4b0
[  909.523451] unregister_netdevice_many_notify+0x7e8/0x1fa0
[  909.529465]        default_device_exit_batch+0x356/0x490
[  909.534788]        ops_undo_list+0x2f4/0x930
[  909.539067]        cleanup_net+0x40a/0x8f0
[  909.543168]        process_one_work+0xd8b/0x1320
[  909.547795]        worker_thread+0x5f3/0xfe0
[  909.552068]        kthread+0x36c/0x470
[  909.555830]        ret_from_fork+0x5dc/0x8e0
[  909.560109]        ret_from_fork_asm+0x1a/0x30
[  909.564557]
                -> #2 (rtnl_mutex){+.+.}-{4:4}:
[  909.570224]        __lock_acquire+0x58c/0xbd0
[  909.574592]        lock_acquire.part.0+0xbd/0x260
[  909.579304]        __mutex_lock+0x1a7/0x1ba0
[  909.583580]        rtnl_net_lock_killable+0x1e/0x70
[  909.588465]        register_netdev+0x40/0x70
[  909.592738]        i40e_vsi_setup+0x892/0x14b0 [i40e]
[  909.597854]        i40e_setup_pf_switch+0xaa1/0xe80 [i40e]
[  909.603392]        i40e_probe.cold+0xdb0/0x1d1b [i40e]
[  909.608582]        local_pci_probe+0xdb/0x180
[  909.612951]        local_pci_probe_callback+0x35/0x80
[  909.618008]        process_one_work+0xd8b/0x1320
[  909.622631]        worker_thread+0x5f3/0xfe0
[  909.626912]        kthread+0x36c/0x470
[  909.630673]        ret_from_fork+0x5dc/0x8e0
[  909.634951]        ret_from_fork_asm+0x1a/0x30
[  909.639399]
                -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
[  909.646627]        __lock_acquire+0x58c/0xbd0
[  909.650994]        lock_acquire.part.0+0xbd/0x260
[  909.655699]        process_one_work+0xd58/0x1320
[  909.660321]        worker_thread+0x5f3/0xfe0
[  909.664602]        kthread+0x36c/0x470
[  909.668363]        ret_from_fork+0x5dc/0x8e0
[  909.672641]        ret_from_fork_asm+0x1a/0x30
[  909.677089]
                -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
[  909.683795]        check_prev_add+0xf1/0xc80
[  909.688068]        validate_chain+0x481/0x560
[  909.692431]        __lock_acquire+0x58c/0xbd0
[  909.696797]        lock_acquire.part.0+0xbd/0x260
[  909.701511]        touch_wq_lockdep_map+0x93/0x180
[  909.706314]        __flush_workqueue+0x111/0x10b0
[  909.711026]        housekeeping_update+0x12d/0x2d0
[  909.715819]        update_parent_effective_cpumask+0x595/0x2440
[  909.721747]        update_prstate+0x89d/0xce0
[  909.726105]        cpuset_partition_write+0xc5/0x130
[  909.731073]        cgroup_file_write+0x1a5/0x680
[  909.735701]        kernfs_fop_write_iter+0x3df/0x5f0
[  909.740664]        vfs_write+0x525/0xfd0
[  909.744592]        ksys_write+0xf9/0x1d0
[  909.748520]        do_syscall_64+0x13a/0x1520
[  909.752887]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  909.758465]
                other info that might help us debug this:

[  909.766466] Chain exists of:
                  (wq_completion)sync_wq --> cpu_hotplug_lock --> 
cpuset_mutex

[  909.777679]  Possible unsafe locking scenario:

[  909.783599]        CPU0                    CPU1
[  909.788130]        ----                    ----
[  909.792666]   lock(cpuset_mutex);
[  909.795991] lock(cpu_hotplug_lock);
[  909.802171]                                lock(cpuset_mutex);
[  909.808013]   lock((wq_completion)sync_wq);
[  909.812207]
                 *** DEADLOCK ***

[  909.818127] 5 locks held by test_cpuset_prs/8673:
[  909.822830]  #0: ffff888140592440 (sb_writers#7){.+.+}-{0:0}, at: 
ksys_write+0xf9/0x1d0
[  909.830839]  #1: ffff889100a49890 (&of->mutex#2){+.+.}-{4:4}, at: 
kernfs_fop_write_iter+0x260/0x5f0
[  909.839890]  #2: ffff8890fbfa5368 (kn->active#353){.+.+}-{0:0}, at: 
kernfs_fop_write_iter+0x2b6/0x5f0
[  909.849118]  #3: ffffffffb9134d00 (cpu_hotplug_lock){++++}-{0:0}, at: 
cpuset_partition_write+0x77/0x130
[  909.858522]  #4: ffffffffb9741c10 (cpuset_mutex){+.+.}-{4:4}, at: 
cpuset_partition_write+0x85/0x130
[  909.867576]
                stack backtrace:
[  909.871940] CPU: 95 UID: 0 PID: 8673 Comm: test_cpuset_prs Kdump: 
loaded Tainted: G S                  7.0.0-rc1-test+ #3 PREEMPT(full)
[  909.871946] Tainted: [S]=CPU_OUT_OF_SPEC
[  909.871948] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS 
SE5C620.86B.0X.02.0001.043020191705 04/30/2019
[  909.871950] Call Trace:
[  909.871952]  <TASK>
[  909.871955]  dump_stack_lvl+0x6f/0xb0
[  909.871961]  print_circular_bug.cold+0x38/0x45
[  909.871968]  check_noncircular+0x146/0x160
[  909.871975]  check_prev_add+0xf1/0xc80
[  909.871978]  ? alloc_chain_hlocks+0x13e/0x1d0
[  909.871982]  ? add_chain_cache+0x11c/0x300
[  909.871986]  validate_chain+0x481/0x560
[  909.871991]  __lock_acquire+0x58c/0xbd0
[  909.871995]  ? lockdep_init_map_type+0x66/0x250
[  909.872000]  lock_acquire.part.0+0xbd/0x260
[  909.872004]  ? touch_wq_lockdep_map+0x7a/0x180
[  909.872009]  ? rcu_is_watching+0x15/0xb0
[  909.872013]  ? trace_rcu_sr_normal+0x1d5/0x2e0
[  909.872018]  ? touch_wq_lockdep_map+0x7a/0x180
[  909.872021]  ? lock_acquire+0x159/0x180
[  909.872026]  ? touch_wq_lockdep_map+0x7a/0x180
[  909.872030]  touch_wq_lockdep_map+0x93/0x180
[  909.872034]  ? touch_wq_lockdep_map+0x7a/0x180
[  909.872038]  __flush_workqueue+0x111/0x10b0
[  909.872042]  ? local_clock_noinstr+0xd/0xe0
[  909.872049]  ? __pfx___flush_workqueue+0x10/0x10
[  909.872059]  housekeeping_update+0x12d/0x2d0
[  909.872063]  update_parent_effective_cpumask+0x595/0x2440
[  909.872070]  update_prstate+0x89d/0xce0
[  909.872076]  ? __pfx_update_prstate+0x10/0x10
[  909.872085]  cpuset_partition_write+0xc5/0x130
[  909.872089]  cgroup_file_write+0x1a5/0x680
[  909.872093]  ? __pfx_cgroup_file_write+0x10/0x10
[  909.872097]  ? kernfs_fop_write_iter+0x2b6/0x5f0
[  909.872102]  ? __pfx_cgroup_file_write+0x10/0x10
[  909.872105]  kernfs_fop_write_iter+0x3df/0x5f0
[  909.872109]  vfs_write+0x525/0xfd0
[  909.872113]  ? __pfx_vfs_write+0x10/0x10
[  909.872118]  ? __lock_acquire+0x58c/0xbd0
[  909.872124]  ? find_held_lock+0x32/0x90
[  909.872130]  ksys_write+0xf9/0x1d0
[  909.872133]  ? __pfx_ksys_write+0x10/0x10
[  909.872136]  ? lockdep_hardirqs_on+0x78/0x100
[  909.872141]  ? do_syscall_64+0xde/0x1520
[  909.872146]  do_syscall_64+0x13a/0x1520
[  909.872151]  ? rcu_is_watching+0x15/0xb0
[  909.872154]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  909.872157]  ? lockdep_hardirqs_on+0x78/0x100
[  909.872161]  ? do_syscall_64+0x212/0x1520
[  909.872166]  ? find_held_lock+0x32/0x90
[  909.872170]  ? local_clock_noinstr+0xd/0xe0
[  909.872174]  ? __lock_release.isra.0+0x1a2/0x2c0
[  909.872178]  ? exc_page_fault+0x78/0xf0
[  909.872183]  ? rcu_is_watching+0x15/0xb0
[  909.872186]  ? trace_irq_enable.constprop.0+0x194/0x200
[  909.872191]  ? lockdep_hardirqs_on_prepare.part.0+0x8e/0x170
[  909.872196]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  909.872199] RIP: 0033:0x7f877d3e9544
[  909.872203] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 
00 0f 1f 40 00 f3 0f 1e fa 80 3d a5 cb 0d 00 00 74 13 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[  909.872206] RSP: 002b:00007ffd6ff21b28 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[  909.872210] RAX: ffffffffffffffda RBX: 00007f877d4bf5c0 RCX: 
00007f877d3e9544
[  909.872213] RDX: 0000000000000009 RSI: 0000557ff7ec2320 RDI: 
0000000000000001
[  909.872215] RBP: 0000000000000009 R08: 0000000000000073 R09: 
00000000ffffffff
[  909.872217] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000009
[  909.872219] R13: 0000557ff7ec2320 R14: 0000000000000009 R15: 
00007f877d4bcf00
[  909.872226]  </TASK>


