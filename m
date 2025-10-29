Return-Path: <cgroups+bounces-11312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275AEC186C5
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1727F1A66B3C
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C0F30170D;
	Wed, 29 Oct 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgBVHq6f"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41E2F9D88;
	Wed, 29 Oct 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718760; cv=none; b=o/DaP1JDymrpGMgsyxwNSqGg1ojvq6jqmbIyQKZpbSpgAiUPKmxZa12RFS+7Dppo83VSusYs4dX4fXHmgadYdMTB9l3FuIZlXV38UE/vVc2JFqCm4nEYs7PbRgASnPWwZ5KD934gWMLtbLEJVoEYXJ5jf+ppbSeLovVT0oUy2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718760; c=relaxed/simple;
	bh=HPV6sOpBQAfE4Ue/L/fxbs1a18Xiw9Af+NS/cSFNbc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbL4Amsr/Z1IQ9rVvnP8V7zNSrgm8uWLmtwXN7vNMFXmjj5DNo2nshqG3YcGh9f6hYUeyZuc30tTdj6GILcSL/Zn6UDX/OSRv0KT+3REuUOv3roQzCnpLMBBrb+DJgrxa4UxlleMP15S7MG2g25PcZLqCzh/TnpXpgJwYE56O0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgBVHq6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78F9C4CEFB;
	Wed, 29 Oct 2025 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718760;
	bh=HPV6sOpBQAfE4Ue/L/fxbs1a18Xiw9Af+NS/cSFNbc0=;
	h=From:To:Cc:Subject:Date:From;
	b=tgBVHq6fA7uZ5cwFLqKC8DAmTVW0AWoz1X4MhyDD1X9etbrMdfJDmbvRynqt+3JHB
	 WD0uIxuwpkVnERYuyG7+gSfmz7FXFzli9kq4JDMxOEDuMxkavNNJJtFlxY4OsGWAwO
	 bUe2cdT0Xqj6c1NkHrcyD/ttgL88V6ZHLIz7mCDkPnsCJlKFtiwHTul6KRMqvoO94J
	 j8rW1sGkIOA4+dO0JtWDJzC/uEtIJPdkI0X/H+llOF/wKLmb7pao/MLwMeQaWp/8An
	 OXs9YmLE6c7D917/Q+9NuDII3bVqhoWJiyYrm5lqHiXEP3TA5CSBPse1lBKpe7e45U
	 mevkc25WvyeoQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET cgroup/for-6.19] cgroup: Fix task exit ordering
Date: Tue, 28 Oct 2025 20:19:14 -1000
Message-ID: <20251029061918.4179554-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series fixes a cgroup task exit ordering issue that is generally
suboptimal for all cgroup controllers and has caused real breakage for
sched_ext schedulers.

Currently, when a task exits, cgroup_task_exit() in do_exit() immediately
unlinks the task from its cgroup via css_set_move_task(). From the cgroup's
perspective, the task is now gone. If this makes the cgroup empty, it can be
destroyed, triggering ->css_offline() callbacks that notify controllers the
cgroup is going offline resource-wise.

However, the exiting task continues to run, perform memory operations, and
schedule until the final context switch in finish_task_switch(). This creates
a problematic window where controllers are told a cgroup is offline while
resource activities are still occurring in it. While this hasn't broken
existing controllers, it's clearly suboptimal and has caused real breakage
for sched_ext schedulers.

The sched_ext breakage manifests in two ways:

1. When a sched_ext scheduler is loaded, it walks all tasks and calls
   ops.init_task() on each. For tasks in a cgroup, it first ensures the
   cgroup has been initialized via ops.cgroup_init(). However, if the task
   is in the dying state (still running but already unlinked from its
   cgroup), the cgroup may already be offline. This results in
   ops.init_task() being called on a cgroup that never received
   ops.cgroup_init(), breaking the initialization invariant.

   This broke the scx_mitosis scheduler with errors like "cgrp_ctx lookup
   failed for cgid 3869" where the BPF program couldn't find cgroup context
   that was never created. See: https://github.com/sched-ext/scx/issues/2846

2. Because sched_ext_free() was called from __put_task_struct() (which can
   happen long after the task stops running), ops.cgroup_exit() could be
   called before ops.exit_task() was called on all member tasks, violating
   the expected ordering where all tasks exit before their cgroup does.

The fix defers the cgroup unlinking from do_exit() to finish_task_switch(),
ensuring the task remains linked to its cgroup until it's truly done running.
For sched_ext specifically, we also move the cleanup earlier to
finish_task_switch() to ensure proper ordering with cgroup operations.

This adds two new calls to finish_task_switch() that operate on the dead task
after the final switch: cgroup_task_dead() and sched_ext_dead(). It may make
sense to factor these into a helper function located in kernel/exit.c if this
pattern continues to grow.

Patch 0004 changes sched_ext and can be applied to sched_ext/for-6.19 after
pulling cgroup/for-6.19. Alternatively, would it be easier for some or all of
this series to go through the tip tree?

Based on cgroup/for-6.19 (d5cf4d34a333).

 0001 cgroup: Rename cgroup lifecycle hooks to cgroup_task_*()
 0002 cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()
 0003 cgroup: Defer task cgroup unlink until after the task is done switching out
 0004 sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git cgroup-fix-exit-ordering

 include/linux/cgroup.h    | 14 ++++++++------
 include/linux/sched/ext.h |  4 ++--
 kernel/cgroup/cgroup.c    | 39 +++++++++++++++++++++++----------------
 kernel/exit.c             |  4 ++--
 kernel/fork.c             |  3 +--
 kernel/sched/autogroup.c  |  4 ++--
 kernel/sched/core.c       |  8 ++++++++
 kernel/sched/ext.c        |  2 +-
 8 files changed, 47 insertions(+), 31 deletions(-)

--
tejun

