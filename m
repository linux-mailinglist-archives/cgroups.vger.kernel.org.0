Return-Path: <cgroups+bounces-11203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E83C11F47
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5BBD4F784C
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB942E6CD0;
	Mon, 27 Oct 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIhnmhO2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B81DED64
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607061; cv=none; b=Z7+7nVacB3KDOP6/z3NCtmD7apgxNTcqGC5yxSdIyts89nMwRWi7Xvab8ld3XpeCw8FE6kilXLJ+b2F86Ml2pYXhDBT+wIWthqqujSZ1tpEuFvJgphY4acFjPbV2C0AEoWJ2pv0A5nBMvAy58GD2V7s76HgsfTCDeb5zsZPXxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607061; c=relaxed/simple;
	bh=LnsqDe6Bg6pbtjnwrqJnBeXZ4Oh4cHUb0yXw2ki4v1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JP/FVnSkjUrholTW86uD/HohUyOVo6WytREAnLP5aXVnGewnzPdw7eOArn6ExpdeXQQ5KIim4C2fdLyc0aEQc/pww5Qh4/vhMmFZ8dWjXIeuEDUUkU2m8aawwDJBm0hFQyG5mUWn9HrZIV6MQUBCLPdTWy8K/aDf2tfirI0IBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIhnmhO2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UrpFHTek/IdMLaX2+KNrvyFTR28a4/VoAqsukcSfat8=;
	b=iIhnmhO2pzKRw6wKu5Uj121xjDW5HpvtAAx6RhZE12IbdXF77ieqGXiZHfKIhZARxJWQbq
	+DkR81s+r+T2J+exzW94iPQr2d+RhCM5Lmn5F3j05fVk9cczyf5zec0mUTg+TecpH+jShW
	p4i91KtX0rcsA2s+m68hAXt7qR9/IIs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 00/23] mm: BPF OOM
Date: Mon, 27 Oct 2025 16:17:03 -0700
Message-ID: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset adds an ability to customize the out of memory
handling using bpf.

It focuses on two parts:
1) OOM handling policy,
2) PSI-based OOM invocation.

The idea to use bpf for customizing the OOM handling is not new, but
unlike the previous proposal [1], which augmented the existing task
ranking policy, this one tries to be as generic as possible and
leverage the full power of the modern bpf.

It provides a generic interface which is called before the existing OOM
killer code and allows implementing any policy, e.g. picking a victim
task or memory cgroup or potentially even releasing memory in other
ways, e.g. deleting tmpfs files (the last one might require some
additional but relatively simple changes).

The past attempt to implement memory-cgroup aware policy [2] showed
that there are multiple opinions on what the best policy is.  As it's
highly workload-dependent and specific to a concrete way of organizing
workloads, the structure of the cgroup tree etc, a customizable
bpf-based implementation is preferable over an in-kernel implementation
with a dozen of sysctls.

The second part is related to the fundamental question on when to
declare the OOM event. It's a trade-off between the risk of
unnecessary OOM kills and associated work losses and the risk of
infinite trashing and effective soft lockups.  In the last few years
several PSI-based userspace solutions were developed (e.g. OOMd [3] or
systemd-OOMd [4]). The common idea was to use userspace daemons to
implement custom OOM logic as well as rely on PSI monitoring to avoid
stalls. In this scenario the userspace daemon was supposed to handle
the majority of OOMs, while the in-kernel OOM killer worked as the
last resort measure to guarantee that the system would never deadlock
on the memory. But this approach creates additional infrastructure
churn: userspace OOM daemon is a separate entity which needs to be
deployed, updated, monitored. A completely different pipeline needs to
be built to monitor both types of OOM events and collect associated
logs. A userspace daemon is more restricted in terms on what data is
available to it. Implementing a daemon which can work reliably under a
heavy memory pressure in the system is also tricky.

This patchset includes the code, tests and many ideas from the patchset
of JP Kobryn, which implemented bpf kfuncs to provide a faster method
to access memcg data [5].

[1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
[2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
[3]: https://github.com/facebookincubator/oomd
[4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
[5]: https://lkml.org/lkml/2025/10/15/1554

---
JP Kobryn (3):
      mm: introduce BPF kfunc to access memory events
      bpf: selftests: selftests for memcg stat kfuncs
      bpf: selftests: add config for psi

Roman Gushchin (20):
      bpf: move bpf_struct_ops_link into bpf.h
      bpf: initial support for attaching struct ops to cgroups
      bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
      mm: define mem_cgroup_get_from_ino() outside of CONFIG_SHRINKER_DEBUG
      mm: declare memcg_page_state_output() in memcontrol.h
      mm: introduce BPF struct ops for OOM handling
      mm: introduce bpf_oom_kill_process() bpf kfunc
      mm: introduce BPF kfuncs to deal with memcg pointers
      mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
      mm: introduce BPF kfuncs to access memcg statistics and events
      mm: introduce bpf_out_of_memory() BPF kfunc
      mm: allow specifying custom oom constraint for BPF triggers
      mm: introduce bpf_task_is_oom_victim() kfunc
      libbpf: introduce bpf_map__attach_struct_ops_opts()
      bpf: selftests: introduce read_cgroup_file() helper
      bpf: selftests: BPF OOM handler test
      sched: psi: refactor psi_trigger_create()
      sched: psi: implement bpf_psi struct ops
      sched: psi: implement bpf_psi_create_trigger() kfunc
      bpf: selftests: PSI struct ops test


v2:
  1) A single bpf_oom can be attached system-wide and a single bpf_oom per memcg.
     (by Alexei Starovoitov)
  2) Initial support for attaching struct ops to cgroups (Martin KaFai Lau,
     Andrii Nakryiko and others)
  3) bpf memcontrol kfuncs enhancements and tests (co-developed by JP Kobryn)
  4) Many mall-ish fixes and cleanups (suggested by Andrew Morton, Suren Baghdasaryan,
     Andrii Nakryiko and Kumar Kartikeya Dwivedi)
  5) bpf_out_of_memory() is taking u64 flags instead of bool wait_on_oom_lock
     (suggested by Kumar Kartikeya Dwivedi)
  6) bpf_get_mem_cgroup() got KF_RCU flag (suggested by Kumar Kartikeya Dwivedi)
  7) cgroup online and offline callbacks for bpf_psi, cgroup offline for bpf_oom

v1:
  1) Both OOM and PSI parts are now implemented using bpf struct ops,
     providing a path the future extensions (suggested by Kumar Kartikeya Dwivedi,
     Song Liu and Matt Bobrowski)
  2) It's possible to create PSI triggers from BPF, no need for an additional
     userspace agent. (suggested by Suren Baghdasaryan)
     Also there is now a callback for the cgroup release event.
  3) Added an ability to block on oom_lock instead of bailing out (suggested by Michal Hocko)
  4) Added bpf_task_is_oom_victim (suggested by Michal Hocko)
  5) PSI callbacks are scheduled using a separate workqueue (suggested by Suren Baghdasaryan)

RFC:
  https://lwn.net/ml/all/20250428033617.3797686-1-roman.gushchin@linux.dev/


JP Kobryn (3):
  mm: introduce BPF kfunc to access memory events
  bpf: selftests: selftests for memcg stat kfuncs
  bpf: selftests: add config for psi

Roman Gushchin (20):
  bpf: move bpf_struct_ops_link into bpf.h
  bpf: initial support for attaching struct ops to cgroups
  bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
  mm: define mem_cgroup_get_from_ino() outside of CONFIG_SHRINKER_DEBUG
  mm: declare memcg_page_state_output() in memcontrol.h
  mm: introduce BPF struct ops for OOM handling
  mm: introduce bpf_oom_kill_process() bpf kfunc
  mm: introduce BPF kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
  mm: introduce BPF kfuncs to access memcg statistics and events
  mm: introduce bpf_out_of_memory() BPF kfunc
  mm: allow specifying custom oom constraint for BPF triggers
  mm: introduce bpf_task_is_oom_victim() kfunc
  libbpf: introduce bpf_map__attach_struct_ops_opts()
  bpf: selftests: introduce read_cgroup_file() helper
  bpf: selftests: BPF OOM handler test
  sched: psi: refactor psi_trigger_create()
  sched: psi: implement bpf_psi struct ops
  sched: psi: implement bpf_psi_create_trigger() kfunc
  bpf: selftests: PSI struct ops test

 include/linux/bpf.h                           |   7 +
 include/linux/bpf_oom.h                       |  74 ++++
 include/linux/bpf_psi.h                       |  87 ++++
 include/linux/cgroup.h                        |   4 +
 include/linux/memcontrol.h                    |  12 +-
 include/linux/oom.h                           |  17 +
 include/linux/psi.h                           |  21 +-
 include/linux/psi_types.h                     |  72 +++-
 kernel/bpf/bpf_struct_ops.c                   |  19 +-
 kernel/bpf/cgroup.c                           |   3 +
 kernel/bpf/verifier.c                         |   5 +
 kernel/cgroup/cgroup.c                        |  14 +-
 kernel/sched/bpf_psi.c                        | 396 ++++++++++++++++++
 kernel/sched/build_utility.c                  |   4 +
 kernel/sched/psi.c                            | 130 ++++--
 mm/Makefile                                   |   4 +
 mm/bpf_memcontrol.c                           | 176 ++++++++
 mm/bpf_oom.c                                  | 272 ++++++++++++
 mm/memcontrol-v1.h                            |   1 -
 mm/memcontrol.c                               |   4 +-
 mm/oom_kill.c                                 | 203 ++++++++-
 tools/lib/bpf/bpf.c                           |   8 +
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/libbpf.h                        |  14 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |  39 ++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 223 ++++++++++
 .../selftests/bpf/prog_tests/test_oom.c       | 249 +++++++++++
 .../selftests/bpf/prog_tests/test_psi.c       | 238 +++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  42 ++
 tools/testing/selftests/bpf/progs/test_oom.c  | 118 ++++++
 tools/testing/selftests/bpf/progs/test_psi.c  |  82 ++++
 35 files changed, 2512 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 include/linux/bpf_psi.h
 create mode 100644 kernel/sched/bpf_psi.c
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 mm/bpf_oom.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

-- 
2.51.0


