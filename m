Return-Path: <cgroups+bounces-10474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC71BA50DF
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 22:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FC0383D61
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4112285060;
	Fri, 26 Sep 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YldOrLMh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D6270EAB;
	Fri, 26 Sep 2025 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918172; cv=none; b=B1mQyLEmKb2fmYPQuhC6v70tDZ8PFkftpyZfUyl6v8udZFdMwZ6b/Jy4/PEmGI3H0fXICeBotezdhiV5Vzh7/L/F/9HTTVuEnk/sCAh+GYP3by7wxKkLBAUWuRZObr4x775hfCs077OfvpAgyvMOie1OR8EEMbz6nV5rBbP9jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918172; c=relaxed/simple;
	bh=zeRZTgjI1eA9qSzzRchD1N5m8fTC0ZL6vbZ3BOloNrY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=jzrcl1qW5e+gZ6dJR3KWinTWBB7zytor/F6RhlqeWv/zoX7LeN8zPhs9jr8244JvhxnYTtrscrWlikJHUg4fwYu9Qo7KwE59WwHkDQUUyhTZmn3OMi+ZFQ3KGCZH9P2ufP9EXgZ/oe34Fb0Qiaavfhao4fTJGWml2o3fAY3r5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YldOrLMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187E3C4CEF4;
	Fri, 26 Sep 2025 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918171;
	bh=zeRZTgjI1eA9qSzzRchD1N5m8fTC0ZL6vbZ3BOloNrY=;
	h=Date:From:To:Cc:Subject:From;
	b=YldOrLMh8Gc/Qa/goM0tlQp0wplzympB3dPqvKF2MATkZZdwvWthfMKAI+oO53W4X
	 6e/QPAuRkuTf7sVHObYFEctJ22vuEUep547afNYMUK8qTJ5cyHseNfrLhpqmTBAvek
	 Zaa952NSgSb0nyzQ5rZ4Kvn94WlRXgDFCE63fFu6k/gLxYWYDt/jZF5EsoYoqdOa1f
	 rNTgPeKE8HvFimsj8fYJhV/i/vYLjbO0KPAwuXaMngimGvIexzEdt0OnKOMWS+KzZh
	 Ukfm167c+CtM5ALq+WPVrwR7qlUA8RRnrvNkStgJnWG/YMiFc2vJdoe5cKHsJueNTI
	 MHzOOdkQGA0cw==
Date: Fri, 26 Sep 2025 10:22:50 -1000
Message-ID: <21156f925598248ffe7d2d5f00b212da@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Changes for v6.18
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The following changes since commit 94a4acfec14615e971eb2c9e1fa6c992c85ff6c6:

  cgroup/psi: Set of->priv to NULL upon file release (2025-08-22 07:47:43 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18

for you to fetch changes up to 8f0fdbd4a06bf795c68bc9839d9c349ab592654f:

  cpuset: remove is_prs_invalid helper (2025-09-22 12:57:46 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.18

- Extensive cpuset code cleanup and refactoring work with no functional
  changes: CPU mask computation logic refactoring, introducing new helpers,
  removing redundant code paths, and improving error handling for better
  maintainability.

- A few bug fixes to cpuset including fixes for partition creation failures
  when isolcpus is in use, missing error returns, and null pointer access
  prevention in free_tmpmasks().

- Core cgroup changes include replacing the global percpu_rwsem with
  per-threadgroup rwsem when writing to cgroup.procs for better scalability,
  workqueue conversions to use WQ_PERCPU and system_percpu_wq to prepare for
  workqueue default switching from percpu to unbound, and removal of unused
  code including the post_attach callback.

- New cgroup.stat.local time accounting feature that tracks frozen time
  duration.

- Misc changes including selftests updates (new freezer time tests and
  backward compatibility fixes), documentation sync, string function safety
  improvements, and 64-bit division fixes.

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: cgroup-v2: Sync manual toctree

Chen Ridong (21):
      cpuset: remove redundant CS_ONLINE flag
      cpuset: decouple tmpmasks and cpumasks freeing in cgroup
      cpuset: separate tmpmasks and cpuset allocation logic
      cpuset: add helpers for cpus read and cpuset_mutex locks
      cpuset: move the root cpuset write check earlier
      cpuset: remove unused assignment to trialcs->partition_root_state
      cpuset: change return type of is_partition_[in]valid to bool
      cpuset: Refactor exclusive CPU mask computation logic
      cpuset: refactor CPU mask buffer parsing logic
      cpuset: introduce cpus_excl_conflict and mems_excl_conflict helpers
      cpuset: refactor out validate_partition
      cpuset: refactor cpus_allowed_validate_change
      cpuset: introduce partition_cpus_change
      cpuset: use parse_cpulist for setting cpus.exclusive
      cpuset: use partition_cpus_change for setting exclusive cpus
      cpuset: fix failure to enable isolated partition when containing isolcpus
      cpuset: Use new excpus for nocpu error check when enabling root partition
      cpuset: fix missing error return in update_cpumask
      cpuset: remove redundant special case for null input in node mask update
      cpuset: remove impossible warning in update_parent_effective_cpumask
      cpuset: remove is_prs_invalid helper

Chuyi Zhou (3):
      cpuset: Don't always flush cpuset_migrate_mm_wq in cpuset_write_resmask
      cpuset: Defer flushing of the cpuset_migrate_mm_wq to task_work
      cgroup: Remove unused cgroup_subsys::post_attach

Marco Crivellari (2):
      cgroup: replace use of system_wq with system_percpu_wq
      cgroup: WQ_PERCPU added to alloc_workqueue users

Michal Koutný (1):
      selftests: cgroup: Make test_pids backwards compatible

Tejun Heo (2):
      cgroup: Remove unused local variables from cgroup_procs_write_finish()
      cgroup: Merge branch 'for-6.17-fixes' into for-6.18

Thorsten Blum (1):
      cgroup: Replace deprecated strcpy() with strscpy()

Tiffany Yang (3):
      cgroup: cgroup.stat.local time accounting
      cgroup: selftests: Add tests for freezer time
      cgroup: Fix 64-bit division in cgroup.stat.local

Waiman Long (1):
      cgroup/cpuset: Prevent NULL pointer access in free_tmpmasks()

Yi Tao (3):
      cgroup: refactor the cgroup_attach_lock code to make it clearer
      cgroup: relocate cgroup_attach_lock within cgroup_procs_write_start
      cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs

pengdonglin (2):
      cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
      cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock

 Documentation/admin-guide/cgroup-v2.rst            |  33 +-
 include/linux/cgroup-defs.h                        |  43 +-
 include/linux/cgroup.h                             |   5 +
 include/linux/sched/signal.h                       |   4 +
 init/init_task.c                                   |   3 +
 kernel/cgroup/cgroup-internal.h                    |  11 +-
 kernel/cgroup/cgroup-v1.c                          |  19 +-
 kernel/cgroup/cgroup.c                             | 199 ++++--
 kernel/cgroup/cpuset-internal.h                    |   5 +-
 kernel/cgroup/cpuset-v1.c                          |  12 +-
 kernel/cgroup/cpuset.c                             | 752 +++++++++++----------
 kernel/cgroup/debug.c                              |   4 -
 kernel/cgroup/freezer.c                            |  16 +-
 kernel/fork.c                                      |   4 +
 tools/testing/selftests/cgroup/lib/cgroup_util.c   |  12 +
 .../selftests/cgroup/lib/include/cgroup_util.h     |   1 +
 tools/testing/selftests/cgroup/test_freezer.c      | 663 ++++++++++++++++++
 tools/testing/selftests/cgroup/test_pids.c         |   3 +
 18 files changed, 1355 insertions(+), 434 deletions(-)

