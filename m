Return-Path: <cgroups+bounces-14274-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNS7EAyEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14274-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE9191CA9
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BABFF30CA0D1
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E392E7179;
	Wed, 25 Feb 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPA+RgRS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BD2DECC2;
	Wed, 25 Feb 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995713; cv=none; b=oFNpXbhHGlok3v9xkW/RaurNxkvZoiY02XLI987RTYjO7KnBDWtIiKuplU3gvPEHkHKKrx6cidwx1LMqvxbN8GAGQz62wGg/pQlhKe2xx1SzPqyrt9s3JM9FE3bfj/LyeRaZC/sf6py+BPTV08wIHpB/jkBNKzavxrgrba20fjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995713; c=relaxed/simple;
	bh=It4b+yTeOY43S/HQWf3+BPLLI8XfMhUujDaAMmA/79A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgjE5X9fHfISCq/ccfW1TRQ3RwHIq/IJarZvuc/00mocAG9s84Z9bpeFDD54hmiu/nHE+bYzPwQU6UKH2uI384YjoDOXSxlFISq6M0TkYoaz+20Y3ezwaFa4WAh9z7QMcxFX6Z5Yq8YggYFh2sdtz30Fct4r+ESJlbEpKkBtCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPA+RgRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ECFC116D0;
	Wed, 25 Feb 2026 05:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995712;
	bh=It4b+yTeOY43S/HQWf3+BPLLI8XfMhUujDaAMmA/79A=;
	h=From:To:Cc:Subject:Date:From;
	b=JPA+RgRSW3P8F+ywFTz1LOvSHY01UDfF9cNlwTwgAmqBboShpydrBep3+vum/kScM
	 Z1/7ngRN38TfWuhjKB68PVNmZe3KMGMwMmVJ+vyZQOHOjl9g0TNl5AMEPgw5BaB47G
	 U/viNcjDXPNQhxh3KH4uqXE/faoYSN3N/XqnCmUXeTtwQBbpNtfR2qAP/OojrhQB2B
	 vPp2KD2MiYdrYiOGiwV/UTCAkK9Xa/ve2Qx9UlK9R85Huh0CzB3/kjV/gcmR/m/LZ2
	 cY5aagPcCKz60zzvgtSzfrJbqHDkxCamvMyoJJN4O/StTOLvd9+5yEdrkXCLA7SK9K
	 0XWR0C/SNaTnw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.1] sched_ext: Implement cgroup sub-scheduler support
Date: Tue, 24 Feb 2026 19:01:18 -1000
Message-ID: <20260225050152.1070601-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14274-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDCE9191CA9
X-Rspamd-Action: no action

This patchset implements cgroup sub-scheduler support for sched_ext, enabling
multiple scheduler instances to be attached to the cgroup hierarchy. This is a
partial implementation focusing on the dispatch path - select_cpu and enqueue
paths will be updated in subsequent patchsets. While incomplete, the dispatch
path changes are sufficient to demonstrate and exercise the core sub-scheduler
structures.

Motivation
==========

Applications often have domain-specific knowledge that generic schedulers cannot
possess. Database systems understand query priorities and lock holder
criticality. Virtual machine monitors can coordinate with guest schedulers and
handle vCPU placement intelligently. Game engines know rendering deadlines and
which threads are latency-critical.

On multi-tenant systems where multiple such workloads coexist, implementing
application-customized scheduling is difficult. Hard partitioning with cpuset
lacks the dynamism needed - users often don't care about specific CPU
assignments and want optimizations enabled by sharing a larger machine:
opportunistic over-commit, improving latency-critical workload characteristics
while maintaining bandwidth fairness, and packing similar workloads on the same
L3 caches for efficiency.

Sub-scheduler support addresses this by allowing schedulers to be attached to
the cgroup hierarchy. Each application domain runs its own BPF scheduler
tailored to its needs, while a parent scheduler dynamically controls CPU
allocation to children without static partitioning.

Structure
=========

Schedulers attach to cgroup nodes forming a hierarchy up to SCX_SUB_MAX_DEPTH
(4) levels deep. Each scheduler instance maintains its own state including
default time slice, watchdog, and bypass mode. Tasks belong to exactly one
scheduler - the one attached to their cgroup or the nearest ancestor with a
scheduler attached.

A parent scheduler is responsible for allocating CPU time to its children. When
a parent's ops.dispatch() is invoked, it can call scx_bpf_sub_dispatch() to
trigger dispatch on a child scheduler, allowing the parent to control when and
how much CPU time each child receives. Currently only the dispatch path supports
this - ops.select_cpu() and ops.enqueue() always operate on the task's own
scheduler. Full support for these paths will follow in subsequent patchsets.

Kfuncs use the new KF_IMPLICIT_ARGS BPF feature to identify their calling
scheduler - the kernel passes bpf_prog_aux implicitly, from which scx_prog_sched()
finds the associated scx_sched. This enables authority enforcement ensuring
schedulers can only manipulate their own tasks, preventing cross-scheduler
interference.

Bypass mode, used for error recovery and orderly shutdown, propagates
hierarchically - when a scheduler enters bypass, its descendants follow. This
ensures forward progress even when nested schedulers malfunction. The dump
infrastructure supports multiple schedulers, identifying which scheduler each
task and DSQ belongs to for debugging.

Patches
=======

0001-0004: Preparatory changes exposing cgroup helpers, adding cgroup subtree
iteration for sched_ext, passing kernel_clone_args to scx_fork(), and reordering
sched_post_fork() after cgroup_post_fork().

0005-0006: Reorganize enable/disable paths in preparation for multiple scheduler
instances.

0007-0009: Core sub-scheduler infrastructure introducing scx_sched structure,
cgroup attachment, scx_task_sched() for task-to-scheduler mapping, and
scx_prog_sched() for BPF program-to-scheduler association.

0010-0012: Authority enforcement ensuring schedulers can only manipulate their
own tasks in dispatch, DSQ operations, and task state updates.

0013-0014: Refactor task init/exit helpers and update scx_prio_less() to handle
tasks from different schedulers.

0015-0018: Migrate global state to per-scheduler fields: default slice, aborting
flag, bypass DSQ, and bypass state.

0019-0023: Implement hierarchical bypass mode where bypass state propagates from
parent to descendants, with proper separation of bypass dispatch enabling.

0024-0028: Multi-scheduler dispatch and diagnostics - dispatching from all
scheduler instances, per-scheduler dispatch context, watchdog awareness, and
multi-scheduler dump support.

0029: Implement sub-scheduler enabling and disabling with proper task migration
between parent and child schedulers.

0030-0034: Building blocks for nested dispatching including scx_sched back
pointers, reenqueue awareness, scheduler linking helpers, rhashtable lookup, and
scx_bpf_sub_dispatch() kfunc.

v2: Rebased to sched_ext/for-7.1. This patchset depends on the following fix
    which is being sent separately targeting sched_ext/for-7.0-fixes:

      sched_ext: Disable preemption between scx_claim_exit() and kicking
      helper work

v1: http://lkml.kernel.org/r/20260121231140.832332-1-tj@kernel.org

Based on sched_ext/for-7.1 (477174ac35c5) + scx-fix-claim-preempt
(097f6d24de4a).

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-v2

 include/linux/cgroup-defs.h              |    4 +
 include/linux/cgroup.h                   |   65 +-
 include/linux/sched/ext.h                |   11 +
 init/Kconfig                             |    4 +
 kernel/cgroup/cgroup-internal.h          |    6 -
 kernel/cgroup/cgroup.c                   |   55 -
 kernel/fork.c                            |    6 +-
 kernel/sched/core.c                      |    2 +-
 kernel/sched/ext.c                       | 2353 +++++++++++++++++++++++-------
 kernel/sched/ext.h                       |    4 +-
 kernel/sched/ext_idle.c                  |  104 +-
 kernel/sched/ext_internal.h              |  248 +++-
 kernel/sched/sched.h                     |    7 +-
 tools/sched_ext/include/scx/common.bpf.h |    1 +
 tools/sched_ext/include/scx/compat.h     |   10 +
 tools/sched_ext/scx_qmap.bpf.c           |   44 +-
 tools/sched_ext/scx_qmap.c               |   13 +-
 17 files changed, 2294 insertions(+), 643 deletions(-)

--
tejun

