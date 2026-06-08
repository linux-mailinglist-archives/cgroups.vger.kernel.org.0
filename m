Return-Path: <cgroups+bounces-16702-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ik4Ne+yJmp2bQIAu9opvQ
	(envelope-from <cgroups+bounces-16702-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0C6560E7
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cRbe4lwH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16702-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16702-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B71B3022F9B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9214D37881D;
	Mon,  8 Jun 2026 12:15:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93197372B26
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920951; cv=none; b=u6WNvYqV1wmpWn4ntWnBjhzsAiPqPSM04kL2PZmq3LaF+1Mr7WeSOpAHn2/eAEadzr79mjXEOo7lJukEJRtIhD9BPEod344FdpjT2zNWtewseFVKLuKshIyoMd660PsDDhjvktM9Prpdaq2c5AZEgFYkhM5IsJkaC9AmTJfWtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920951; c=relaxed/simple;
	bh=SLJOxRsae4Bm5pOCwEhJH4LYfX7nAkh//89T/+9mhwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuVhQrwa4419HCDOx5e8vsYrau1dA/9nje3AT+HYVHaVZ4JJUtkVpPNOwwuJpMZqaWcy8SaGIt/oZuE3OULfs5axk9H6uLcJAHSetrrFV6j2oAuwOK+0gj66V8jAOEbzvy9vx4v1fX71uvzxkEsdptEJLN686jF79ZByscaeRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRbe4lwH; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so45806625e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920948; x=1781525748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmc3n/uBJ0w/FMEaL5e/UAs73OVuyieKrKpdaBMG3DQ=;
        b=cRbe4lwHU31wu1H4zYmxrNOMcYgBcSAfGwa6BjFpMEpfPN2lSs8lJgxEvcEcqZUJxH
         xvRg0YxBNNj7srubA1AgRY6vW9fUKFg5eU7QVd38HGNfZ7vevHm+rJN+AM5ZAwf86Jhv
         Xnmf3eAMpEPM6I16ZH6PSl4HyIwVrGIdV8xXxFK4gOlk9CWnK1AWB43u4atX4UIEY1j2
         /Nlbao7AUqD4HInxOeDF8pyCVcubbXODIkzkERadYQQgVK+zlcme45SpixZ5CLh68SvP
         ly7TpO9TrqkRildS/RXw2R3h7fJpBk3WUMOUS7JytdgZsUYfDLe1ZMRRqU+CR0ISRy24
         evSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920948; x=1781525748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmc3n/uBJ0w/FMEaL5e/UAs73OVuyieKrKpdaBMG3DQ=;
        b=QUXR/3FRkUWTMAljXCCwcnEJaajrUrkh/On3akDR/nLAbG2RoSHe6y5qYxu+NNdfE9
         Ln831n5B7EUpgdKe/nq+/voeAO7WA0uQfhh3dXQEyiTqDayFKArhhGdkWgkKMUq2mE9y
         XUNuYAXMc4wsNPnWQKvpjVNTA9fkdS8fu/8ggabEQvohOExgR5Ejv0ZzuBb8RqeMtTVP
         DkeE8VIYPTqVgHaBGQAoO2lCjHn8Xv7faw1QbwdqPrvtCuK7eGZrmbZ+lQqoYpqf8hW2
         8Wc7WuOjo6ev43qwrBOUeieNY2kz5bipMajOy9FI0UpTSn5XMeMP0rGe2aBUeEGETuF/
         wl1A==
X-Gm-Message-State: AOJu0YxJwFUgRJlHtWNtco8dQFodvZSubwO4ak3Xg92hdsvKNuzCjZ6L
	82Hxilr2WgmZkzML/dIUxKXJWqoeYIjVyILoB+A14m9zT5SKMMYk+QE6
X-Gm-Gg: Acq92OG26dWEF4OsNPe6B8DSDu1WeYUpvKM8vQbcIFqEVc0AMyQnQ9PFusqkDMkBl7Z
	h6jA0Xm0+A3WAGhadLRw3eL4YBckK8hBbvMI5IzXeyLwc5a6zszOnB0k27Gxf9loqP+mjw5zsCT
	A44g7YzsnXfuOi+3uYnStVtEBAtd80NmyFjw8k5+dGXcNHQnIDN5eySMoqKHmSTSKNgi9ZmTNfG
	m2fJ7BjtYHmwfvAXMScC/kEtzPj74+yGWOQroZfPu1Te1dJALuxZyPqEGH/X9NnHqN5VNVixY0s
	93lsd1xr47fAq+QwCdgvvGST2C0e2SESi69vXR5710TqHpe+7XLL6pwFs4A4rlQ9Ljw0aBjHAmB
	GzZs+k8EY6OKxmZanRwyC8Jyi62bT19v5+bwtRck9zRZee+2Cl0GYPOBroqaw+vnE7Sp2vLkoc+
	dqWqFKZGzsM8F7KeOqxyNwNo/IhFUkWrc=
X-Received: by 2002:a05:600c:34cb:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490c25afa03mr245626495e9.7.1780920947747;
        Mon, 08 Jun 2026 05:15:47 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:47 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Date: Mon,  8 Jun 2026 14:15:19 +0200
Message-ID: <20260608121546.69910-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16702-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37A0C6560E7

Hello,

This is the v6 for Hierarchical Constant Bandwidth Server, aiming at replacing
the current RT_GROUP_SCHED mechanism with something more robust and
theoretically sound. The patchset has been presented at OSPM25 and OSPM26
(https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
be found at https://lwn.net/Articles/1021332/ . You can find the previous
versions of this patchset at the bottom of the page, in particular version 1
which talks in more detail what this patchset is all about and how it is
implemented.

This v6 version works on the comments by the reviewers and introduces the
following meaningful changes:
- Update to kernel version 7.1.
- Refactorings and general cleanups.
- Removal of substantial duplicated code.
- Express more locking constraints in code.
- New cpu.rt.max interface.
- Refactoring of migration code to reduce code duplication.
  The new migration code now reuses the existing push/pull and similar functions
  and specializes where needed, substantially reducing the footprint of group
  migration code from previous versions.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
New cgroup-v2 interface:
After extensive discussions with the kernel's maintainers, we have built a new
interface to support HCBS scheduling. Since this will be a cgroup-v2 only
feature (the fate of cgroup-v1 old RT_GROUP_SCHED has yet to be decided), it was
possible to drop the original v1 interface entirely and create a completely new
one that is similar to those that are already existing.

Every cgroup has now two new files:
- cpu.rt.max (similar to the cpu.max file)
- cpu.rt.internal (read-only, not available in the root cgroup, it may be
                   removed if deemed unnecessary, see later for details)

In this new interface, HCBS cgroups may either be set to use deadline servers,
and thus reserving a specified amount of bandwidth, very similarly to the
previous system, or can delegate their FIFO/RR tasks' scheduling to the nearest
ancestor that it is configured (default on group creation). If the nearest
configured ancestor is the root cgroup, tasks will be effectively run on the
root runqueue even if their cgroup is not the root task group.

This means that subtrees are allowed to retain the original non-RT_GROUP_SCHED
behaviour, scheduling on root, while the feature is nonetheless active. In the
meantime other subtrees may use HCBS, and the whole hierarchy can coexist
without issues.

This behaviour is specified in the cpu.rt.max file, which accepts the string
"<runtime | 'max'> <period>". A zero runtime disables FIFO/RR scheduling for
tasks in that group, a non-zero runtime creates a reservation and uses HCBS, a
runtime of 'max' instead tells the scheduler to use the nearest configured
ancestor for the FIFO/RR task scheduling.

The admission test now does not only check the immediate children of a cgroup
for schedulability (recall that a group's bandwidth must be always greater than
or equal to its children total bandwidth), but it has to check its whole
subtree: if a child delegates its tasks to its parents (runtime = 'max'), then
this child's own children (the grandchildrens) are effectively viewed as
immediate children that compete for the same bandwidth of their grandparent, and
so on down the hierarchy.

To support both threaded and domain cgroups, the original test that allowed only
to run tasks in leaf cgroups has been removed: this is already enforced for
domain cgroups by existing code, while this must not be the case for threaded
cgroups.

Since groups in the middle of the hierarchy can now also run tasks, their
dl_servers must be configured properly: a parent cgroup dl_servers can only use
their assigned bandwidth minus the total of their children. The cpu.rt.internal
file reads exactly what is this "remainder" bandwidth. Since dl_servers must
have a runtime and period values assigned, the period is taken from the user
configured cpu.rt.max file and the runtime is computed from the remainder bw.
This runtime and the period are the values shown by cpu.rt.internal.

Supporting both threaded and domain cgroups also dropped all the extra code
related to active and 'live' cgroups as mentioned in previous RFCs.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Summary of the patches:
   1-2) Commits already included in sched/tip (not yet in mainline).
   3-8) Preparation patches, so that the RT classes' code can be used both
        for normal and cgroup scheduling.
  9-19) Implementation of HCBS, no migration.
        The old RT_GROUP_SCHED code is removed.
        16) Remove support for cgroup-v1.
        17) Implement cgroup-v2 cpu.rt.max interface.
 20-24) Add support for tasks migration.
    25) Documentation for HCBS.

Updates from v5:
- Rebase to latest master.
- General rebasing/cleanup.
- More locking contraints expressed in code.
- New cpu.rt.max interface.
- Refactoring of migration code.

Updates from v4:
- Rebase to latest tip/master.
- General rebasing/cleanup.
- Update default sysctl_sched_rt_runtime to 1s, same as the period.
- Fix non-deferred deadline server replenishment logic.
- Add missing RCU read sections.
- Account HCBS servers along with their tasks when the servers are active.
- Release bandwidth resources early in unregister_rt_sched_group.
- Drop server_try_pull_task as it is now redundant.
- Remove dl_server_stop call in dequeue_task_rt.
- Update to reuse __checkparam_dl for deadline servers.

Updates from v3:
- Rebase to latest tip/master.
- General rebasing/cleanup.
- Add Documentation.
- Define **live** and **active** groups.
- Introduce server_try_pull_task in place of the removed server_has_task.
- Introduce RELEASE_LOCK helper macro for guard-based locking.
- Update inc/dec_dl_tasks to account for served runqueues regardless of the
  server type.
- Fix computing of new bandwidth values in dl_init_tg.
- Fix check in dl_check_tg to use capacity scaling.
- Fix wakeup_preempt_rt to check if curr is a DEADLINE task.

Updates from v2:
- Rebase to latest tip/master.
- Remove fair-servers' bw reclaiming.
- Fix a check which prevented execution of wakeup_preempt code.
- Fix a priority check in group_pull_rt_task between tasks of different groups.
- Rework allocation/deallocation code for rt-cgroups.
- Update signatures for some group related migration functions.
- Add documentation for wakeup_preempt preemption rules.

Updates from v1:
- Rebase to latest tip/master.
- Add migration code.
- Split big patches for more readability.
- Refactor code to use guarded locks where applicable.
- Remove unnecessary patches from v1 which have been addressed differently by
  mainline updates.
- Remove unnecessary checks and general code cleanup.

Notes:

Patches 1-2 have already been merged in sched/tip, but not yet merged in master.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Testing v6:

The patchset has been tested with a suite of tests tailored to stress all the
implemented functionalities.
The tests are available at https://github.com/Yurand2000/HCBS-Test-Suite .
Refer to the README of the repository for more details.

Follow these steps to test HCBS v6:
- Get the HCBS patch up and running. Any kernel/disto should work effortlessly.
- Get, compile and _install_ the tests.
- Run the `go_rt.sh` script to set the frequency of the CPUs to a fixed value
  and disable hyperthreading and power saving features.
- Run the `run_tests.sh full` script, to run the whole test suite.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Future Work:

We think the current patchset is stable enough. Our current test suite
demonstrates, on our limited hardware, that the kernel does not throw warnings
and that it is actually possible to guarantee time reservations and isolation
among tenants.

Comments on the new cpu.rt.max interface are to be expected, but hopefully with
this new ideas we have solved some of the issues mentioned in the past, such as
not being able to use the cpu controller because standard FIFO/RR tasks had to
be migrated to the root cgroup first. For the future it needs to be investigated
how to integrate this interface with the cpuset controller and with the multiCPU
feature which was presented at OSPM26.

Additional future work:
 - unprivileged FIFO/RR in cgroups.
 - capacity aware bandwidth reservation.
 - hotplug/hotunplug management.

Have a nice day,
Yuri

v1: https://lore.kernel.org/all/20250605071412.139240-1-yurand2000@gmail.com/
v2: https://lore.kernel.org/all/20250731105543.40832-1-yurand2000@gmail.com/
v3: https://lore.kernel.org/all/20250929092221.10947-1-yurand2000@gmail.com/
v4: https://lore.kernel.org/all/20251201124205.11169-1-yurand2000@gmail.com/
v5: https://lore.kernel.org/all/20260430213835.62217-1-yurand2000@gmail.com/

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Yuri Andriaccio (14):
  sched/deadline: Fix replenishment logic for non-deferred servers
  sched/rt: Update default bandwidth for real-time tasks to ONE
  sched/rt: Disable RT_GROUP_SCHED
  sched/rt: Remove unnecessary runqueue pointer in struct rt_rq
  sched/rt: Add {alloc/unregister/free}_rt_sched_group
  sched/rt: Implement dl-server operations for rt-cgroups.
  sched/rt: Update task event callbacks for HCBS scheduling
  sched/rt: Remove support for cgroups-v1
  sched/rt: Update task's RT runqueue when switching scheduling class
  sched/rt: Add HCBS migration code to related functions
  sched/rt: Hook HCBS migration functions
  sched/rt: Try pull task on empty server pick.
  sched/core: Execute enqueued balance callbacks after
    migrate_disable_switch
  Documentation: Update documentation for real-time cgroups

luca abeni (11):
  sched/deadline: Do not access dl_se->rq directly
  sched/deadline: Distinguish between dl_rq and my_q
  sched/rt: Pass an rt_rq instead of an rq where needed
  sched/rt: Move functions from rt.c to sched.h
  sched/rt: Introduce HCBS specific structs in task_group
  sched/core: Initialize HCBS specific structures.
  sched/deadline: Add dl_init_tg
  sched/deadline: Account rt-cgroups bandwidth in deadline tasks
    schedulability tests.
  sched/rt: Update rt-cgroup schedulability checks
  sched/rt: Remove old RT_GROUP_SCHED data structures
  sched/core: Execute enqueued balance callbacks when changing allowed
    CPUs

 Documentation/scheduler/sched-rt-group.rst |  470 ++++-
 include/linux/rcupdate.h                   |    1 +
 include/linux/sched.h                      |   12 +-
 kernel/sched/autogroup.c                   |    4 +-
 kernel/sched/core.c                        |  143 +-
 kernel/sched/deadline.c                    |  221 ++-
 kernel/sched/debug.c                       |    6 -
 kernel/sched/ext.c                         |    4 +-
 kernel/sched/fair.c                        |    4 +-
 kernel/sched/rt.c                          | 2046 +++++++++-----------
 kernel/sched/sched.h                       |  214 +-
 kernel/sched/syscalls.c                    |   11 +-
 12 files changed, 1761 insertions(+), 1375 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
--
2.54.0


