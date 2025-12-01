Return-Path: <cgroups+bounces-12239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1EC98D25
	for <lists+cgroups@lfdr.de>; Mon, 01 Dec 2025 20:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C99A3A4ECF
	for <lists+cgroups@lfdr.de>; Mon,  1 Dec 2025 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD42080C8;
	Mon,  1 Dec 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCtO8EoP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD41ACEDE;
	Mon,  1 Dec 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616574; cv=none; b=QKOO/4Cu9P2XCRK700TdCQHA58qBPEcQQk8vlS8MgDGckvps4upkuxZ4k6dYMrDo/IxVH7z1LPY9qQZoCGcm+iAy5/gNB9+tE+YCXc3UcrDfgKUZLGpMGd7FEmHuW6WhuL0H9BH1n4dJw0jWY8hhm7nm2HlzGpnVXCxz8lLH6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616574; c=relaxed/simple;
	bh=8LtbS+dXdRiiJ2grwGKcDIrFXJ92YvnQOLfaqNowQCE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Q5xCe3iLh3Dh6HgkTzWCHeEWcKDKH6K6zWl+TCbdomE/ULaCP+X+vpfs6t4NbhXxsGif7C6QWzc4PrGalKBdTQLpX9t26MhE8/B7d8R0GuzMjTMN6ZnWMnMCtedfq/HxnX3fnbUhrQRDMNE54Jwv7TqipT2L0lstwEnj2gt0vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCtO8EoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E4C4CEF1;
	Mon,  1 Dec 2025 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764616574;
	bh=8LtbS+dXdRiiJ2grwGKcDIrFXJ92YvnQOLfaqNowQCE=;
	h=Date:From:To:Cc:Subject:From;
	b=DCtO8EoPlDPLx4fJywiMqKkCJyvXWB7mB8gD+c8k2vw7BlIfDRiqAjV9MY8ANRolv
	 8xfjNEV+ic0LjdljiH/WgUqiXYHYIYq4MwDPr304qVUMYjFtA33nkdUXhaiftBRu/C
	 dg8rldvAhID9e1iOfdpVuPontQoI8TNSUC/makb+PhvtWB14Zqd2QxqlZ483Ne6BVm
	 729gN7wSJHpd6K7o00BYbbqEY04qXob2jhnqUMBfaKYcrzhoeQPgK7C00yIDxEw9Dr
	 oC8mFzGqpRKb5pm6D1/vgcuWBAXp5+hyKPc3kWTr3+cpKLaI1KE+TuJGmPe+61FHLb
	 K6zAF+ffNqPHg==
Date: Mon, 01 Dec 2025 09:16:13 -1000
Message-ID: <58579714c3f54951dddf5af185da0515@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup changes for v6.19
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi Linus,

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19

for you to fetch changes up to b1bcaed1e39a9e0dfbe324a15d2ca4253deda316:

  cpuset: Treat cpusets in attaching as populated (2025-11-20 16:25:26 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.19

- Defer task cgroup unlink until after the dying task's final context switch
  so that controllers see the cgroup properly populated until the task is
  truly gone.

- cpuset cleanups and simplifications. Enforce that domain isolated CPUs
  stay in root or isolated partitions and fail if isolated+nohz_full would
  leave no housekeeping CPU. Fix sched/deadline root domain handling during
  CPU hot-unplug and race for tasks in attaching cpusets.

- Misc fixes including memory reclaim protection documentation and selftest
  KTAP conformance.

----------------------------------------------------------------
Bert Karwatzki (1):
      cgroup: include missing header for struct irq_work

Chen Ridong (4):
      cpuset: simplify node setting on error
      cpuset: remove global remote_children list
      cpuset: remove need_rebuild_sched_domains
      cpuset: Treat cpusets in attaching as populated

Gabriele Monaco (1):
      cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_cpumasks()

Guopeng Zhang (1):
      selftests/cgroup: conform test to KTAP format output

Michal Koutný (3):
      docs: cgroup: Explain reclaim protection target
      docs: cgroup: Note about sibling relative reclaim protection
      docs: cgroup: No special handling of unpopulated memcgs

Pingfan Liu (2):
      cgroup/cpuset: Introduce cpuset_cpus_allowed_locked()
      sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug

Tejun Heo (4):
      cgroup: Rename cgroup lifecycle hooks to cgroup_task_*()
      cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()
      cgroup: Defer task cgroup unlink until after the task is done switching out
      cgroup: Fix sleeping from invalid context warning on PREEMPT_RT

Waiman Long (5):
      cgroup/cpuset: Don't track # of local child partitions
      cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
      cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
      cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition
      cgroup/cpuset: Globally track isolated_cpus update

 Documentation/admin-guide/cgroup-v2.rst          |  31 +-
 include/linux/cgroup.h                           |  14 +-
 include/linux/cpuset.h                           |   9 +-
 include/linux/sched.h                            |   5 +-
 kernel/cgroup/cgroup.c                           |  91 +++++-
 kernel/cgroup/cpuset-internal.h                  |  13 +-
 kernel/cgroup/cpuset.c                           | 356 ++++++++++++++---------
 kernel/exit.c                                    |   4 +-
 kernel/fork.c                                    |   2 +-
 kernel/sched/autogroup.c                         |   4 +-
 kernel/sched/core.c                              |   2 +
 kernel/sched/deadline.c                          |  54 +++-
 tools/testing/selftests/cgroup/test_core.c       |   7 +-
 tools/testing/selftests/cgroup/test_cpu.c        |   7 +-
 tools/testing/selftests/cgroup/test_cpuset.c     |   7 +-
 tools/testing/selftests/cgroup/test_freezer.c    |   7 +-
 tools/testing/selftests/cgroup/test_kill.c       |   7 +-
 tools/testing/selftests/cgroup/test_kmem.c       |   7 +-
 tools/testing/selftests/cgroup/test_memcontrol.c |   7 +-
 tools/testing/selftests/cgroup/test_zswap.c      |   7 +-
 20 files changed, 435 insertions(+), 206 deletions(-)

Thanks.
--
tejun

