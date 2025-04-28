Return-Path: <cgroups+bounces-7850-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2EA9E697
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002073B60D5
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006F1925AF;
	Mon, 28 Apr 2025 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uj5xmv6S"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242D8F77
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811398; cv=none; b=ltOju93FIPaoSwmIcKUvWRRiP9F4O8Kp2J0rf9WjfdFNOGw3tXYVX3JBFY4enNq9ts0ix3fMHjm5MQbd+D9RNwHoICtUIHCIbbjk7dK70XCBqEIkwxHU4btXXF6ZqrYUJ8UTyy3w77M2NnDfu7geWBDpL73a1BzMim/PgyVNInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811398; c=relaxed/simple;
	bh=wkd6vZFx+IhH6EZxtpOK4H28EIt0MitS2iLwZ7iZJp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEcpWFne3iNOKOgAHVOjaE3cz9NYRYGQuRbhz0agdUlU9QmXri0kJnPYn3VHe6gPsOs6klrH4CRRkD0C2kfll+0xEZ5rfNJTDN8CVtqrBrG9R21o/PvkYtFZrnGbo+BfnzOrJMj0Q49DpY3vWWREwSxlKLQXDXHjwV3pgGmMaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uj5xmv6S; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tFWeksBB0juVbpa0rRrrSWdVJEnufM4rtKFQMpJhEFo=;
	b=Uj5xmv6Snanvh9Ynazp3rYSVNuYCISEFJVrFWlzEle4yNq3AZfGNs8pqoMzgpo04o5kkPT
	hhQPewkRFVz6yHoHGE/6v5wfhoLLYxGl84shOS2I6dtqMd7Vp5hhYiUpTcc4FQpJ411yLD
	NV1aUUtsX0TJO4oeJg0moyDezzYWlIg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 00/12] mm: BPF OOM
Date: Mon, 28 Apr 2025 03:36:05 +0000
Message-ID: <20250428033617.3797686-1-roman.gushchin@linux.dev>
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
ranking-based policy, this one tries to be as generic as possible and
leverage the full power of the modern bpf.

It provides a generic hook which is called before the existing OOM
killer code and allows implementing any policy, e.g.  picking a victim
task or memory cgroup or potentially even releasing memory in other
ways, e.g. deleting tmpfs files (the last one might require some
additional but relatively simple changes).

The past attempt to implement memory-cgroup aware policy [2] showed
that there are multiple opinions on what the best policy is.  As it's
highly workload-dependent and specific to a concrete way of organizing
workloads, the structure of the cgroup tree etc, a customizable
bpf-based implementation is preferable over a in-kernel implementation
with a dozen on sysctls.

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

[1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
[2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
[3]: https://github.com/facebookincubator/oomd
[4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html

----

This is an RFC version, which is not intended to be merged in the current form.
Open questions/TODOs:
1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
   It has to be able to return a value, to be sleepable (to use cgroup iterators)
   and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
   Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
   arguments as trusted"), which is not safe. One option is to fake acquire/release
   semantics for the oom_control pointer. Other option is to introduce a completely
   new attachment or program type, similar to lsm hooks.
2) Currently lockdep complaints about a potential circular dependency because
   sleepable bpf_handle_out_of_memory() hook calls might_fault() under oom_lock.
   One way to fix it is to make it non-sleepable, but then it will require some
   additional work to allow it using cgroup iterators. It's intervened with 1).
3) What kind of hierarchical features are required? Do we want to nest oom policies?
   Do we want to attach oom policies to cgroups? I think it's too complicated,
   but if we want a full hierarchical support, it might be required.
   Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the true root
   memcg, which is potentially outside of the ns of the loading process. Does
   it require some additional capabilities checks? Should it be removed?
4) Documentation is lacking and will be added in the next version.


Roman Gushchin (12):
  mm: introduce a bpf hook for OOM handling
  bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
  bpf: treat fmodret tracing program's arguments as trusted
  mm: introduce bpf_oom_kill_process() bpf kfunc
  mm: introduce bpf kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
  bpf: selftests: introduce read_cgroup_file() helper
  bpf: selftests: bpf OOM handler test
  sched: psi: bpf hook to handle psi events
  mm: introduce bpf_out_of_memory() bpf kfunc
  bpf: selftests: introduce open_cgroup_file() helper
  bpf: selftests: psi handler test

 include/linux/memcontrol.h                   |   2 +
 include/linux/oom.h                          |   5 +
 kernel/bpf/btf.c                             |   9 +-
 kernel/bpf/verifier.c                        |   5 +
 kernel/sched/psi.c                           |  36 ++-
 mm/Makefile                                  |   3 +
 mm/bpf_memcontrol.c                          | 108 +++++++++
 mm/oom_kill.c                                | 140 +++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.c |  67 ++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |   3 +
 tools/testing/selftests/bpf/prog_tests/oom.c | 227 ++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/psi.c | 234 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_oom.c | 103 ++++++++
 tools/testing/selftests/bpf/progs/test_psi.c |  43 ++++
 14 files changed, 983 insertions(+), 2 deletions(-)
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

-- 
2.49.0.901.g37484f566f-goog


