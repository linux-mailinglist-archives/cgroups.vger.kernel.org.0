Return-Path: <cgroups+bounces-16982-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNKnIyl2MGoyTQUAu9opvQ
	(envelope-from <cgroups+bounces-16982-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 00:01:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DF68A419
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 00:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BLklMAeu;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16982-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16982-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBAA3085E92
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D438F935;
	Mon, 15 Jun 2026 22:01:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726F2D97AA;
	Mon, 15 Jun 2026 22:01:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560870; cv=none; b=gH8bQsTXa5/WoFPAbs4mtjK9ZmRVScRHhamwEYn6ze2Md7/F+kfZ7YfWe5CVRZ5UCmzQSndegos2RAKIxIkmjKg2R63QNYluqMHiE4UbOR3nCncqcCq6aqzqOHuiMrsIOpZmSBGW+Sxa2jLw2GI35L2MINHCdaARx3MJHdvPNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560870; c=relaxed/simple;
	bh=djVUkKbZMiS04rH8RrhggjJ+5OwSQKOgEhG2Zy35xg4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=VkdlAGw8Y+4HAQJSLn0WcdebKagfgpr3ASHqIKGs5Vkj/4zJcpJvCBlzkLiRsFD+yhb+A7M5t2Eam8swa3yqkBML+F6NQZ9yoBwdY3p0ahkNxHnAfOM/O57b6peBUnkJRKyFxx5BicsnYpY1cO3kEORaqArAozoPsrellLXMx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLklMAeu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECA1F000E9;
	Mon, 15 Jun 2026 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560869;
	bh=QntsH/QynFdDiwzreEla2J7OG/pBp6ot0JvM9glzFhY=;
	h=Date:From:To:Cc:Subject;
	b=BLklMAeub55Zts3e61sy+RVH/nnrK4j8phK47toiVnciIaFyTd/eqTH1tBTrIW+vE
	 O8WvjcXetBWgRKgbYReD1pjf0nehv/A9YcNbHvPaNNtTYeVL235Q8Kr6kglsIy9q7L
	 aA0MEw5xN7dUFo8gquaWj99+KX+fd67iGLpHxXIu03ACwzr9lQVlJvOwc7Ft3fTC10
	 qf+mFf7zHzxqo4oxGZxEXkzh1//As8mSI/HsF4FX3cMRKtswA0M7qFvpVa3wkunGz3
	 BrPV8jC5J1HUZS30CBQR7sKETi0hXtJHShY741J2l+TmJiLU3E9YJcyFxVEiibND0i
	 vREBIZHFioFKA==
Date: Mon, 15 Jun 2026 12:01:08 -1000
Message-ID: <b935100af77c4a118f8180ca31627e35@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup changes for v7.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16982-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:longman@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rdma.events:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C84DF68A419

Hello,

The following changes since commit 4a39eda5fdd867fc39f3c039714dd432cee00268:

  cgroup/cpuset: Reset DL migration state on can_attach() failure (2026-05-10 22:14:49 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.2

for you to fetch changes up to a99ce697ea5e27b867c9ba4ee55fa5ba3b8d1188:

  cgroup: Migrate tasks to the root css when a controller is rebound (2026-06-02 08:25:29 -1000)

----------------------------------------------------------------
cgroup: Changes for v7.2

- Last cycle deferred css teardown on cgroup removal until the cgroup
  depopulated, so a css is not taken offline while tasks can still
  reference it. Disabling a controller through cgroup.subtree_control
  still had the same problem. This reworks the deferral from per-cgroup
  to per-css so that path is covered too.

- New RDMA controller monitoring files: rdma.peak for per-device peak
  usage and rdma.events / rdma.events.local for resource-limit
  exhaustion. The max-limit parser was rewritten, fixing two input
  parsing bugs.

- cpuset: fix a sched-domain leak on the domain-rebuild failure path and
  skip a redundant hardwall ancestor scan on v2.

- Misc: pair the remaining lockless cgroup.max.* reads with WRITE_ONCE,
  assorted selftest robustness fixes, and doc path corrections.

----------------------------------------------------------------
Chen Wandun (1):
      cgroup/cpuset: Skip hardwall ancestor scan in cpuset v2 in cpuset_current_node_allowed()

Costa Shulyupin (1):
      docs: cgroup: Fix stale source file paths

Guopeng Zhang (2):
      selftests/cgroup: enable memory controller in hugetlb memcg test
      cgroup/cpuset: Free sched domains on rebuild guard failure

Hongfu Li (3):
      selftests/cgroup: Fix incorrect variable check in online_cpus()
      selftests/cgroup: Add NULL check after malloc in cgroup_util.c
      selftests/cgroup: check malloc return value in alloc_anon functions

Ren Tamura (1):
      cgroup: pair max limit READ_ONCE() with WRITE_ONCE()

Tao Cui (8):
      cgroup/rdma: refactor resource parsing with match_table_t/match_token()
      selftests/cgroup: fix child process escaping to parent cleanup in test_cpucg_nice
      selftests/cgroup: fix misleading debug message in test_cgfreezer_time_child
      cgroup/rdma: add rdma.peak for per-device peak usage tracking
      cgroup/rdma: add rdma.events to track resource limit exhaustion
      cgroup/rdma: add rdma.events.local for per-cgroup allocation failure attribution
      cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local
      cgroup/rdma: Drop unnecessary READ_ONCE() on event counters

Tejun Heo (7):
      Merge branch 'for-7.1-fixes' into for-7.2
      cgroup: Inline cgroup_has_tasks() in cgroup.h
      cgroup: Annotate unlocked nr_populated_* accesses with READ_ONCE/WRITE_ONCE
      cgroup: Move populated counters to cgroup_subsys_state
      cgroup: Add per-subsys-css kill_css_finish deferral
      cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()
      cgroup: Migrate tasks to the root css when a controller is rebound

 Documentation/admin-guide/cgroup-v1/cgroups.rst    |   2 +-
 Documentation/admin-guide/cgroup-v1/memcg_test.rst |   2 +-
 Documentation/admin-guide/cgroup-v2.rst            |  53 ++++
 include/linux/cgroup-defs.h                        |  30 +-
 include/linux/cgroup.h                             |  27 +-
 include/linux/cgroup_rdma.h                        |   4 +
 kernel/cgroup/cgroup.c                             | 222 +++++++++------
 kernel/cgroup/cpuset-v1.c                          |   2 +-
 kernel/cgroup/cpuset.c                             |  10 +-
 kernel/cgroup/rdma.c                               | 315 ++++++++++++++++-----
 tools/testing/selftests/cgroup/lib/cgroup_util.c   |   9 +-
 tools/testing/selftests/cgroup/test_cpu.c          |   2 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh  |   2 +-
 tools/testing/selftests/cgroup/test_freezer.c      |   2 +-
 .../testing/selftests/cgroup/test_hugetlb_memcg.c  |   8 +
 tools/testing/selftests/cgroup/test_memcontrol.c   |  53 ++--
 16 files changed, 532 insertions(+), 211 deletions(-)

--
tejun

