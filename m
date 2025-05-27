Return-Path: <cgroups+bounces-8363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EEAC5AE8
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4BC1BA5D1C
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E028A3EA;
	Tue, 27 May 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amR6FtHf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117A248F72;
	Tue, 27 May 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374974; cv=none; b=T1eRdSkmKQ/nK7XNLu484G+8gXoz7Sdz/NEymNq7ShZn8AeGyMWiFkXceME+cW4M3bP0kArsqprOOTKyFxwtuErODG5nsDtWpflna8wLJkSShNqhcKofYMjWKorf0CDrk0K6GjMhC5jj/fR/YgRRdOXzLuy2XmWy3F/gNWbpy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374974; c=relaxed/simple;
	bh=a2m/Xm0Fx0H//NfL7YFGhI3gk44cer5mXM1DGjNXank=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P0aXJU0LUZFSrMPxt9vzjFJ2G1t5E3Gn1phKv2hnG0kd9PIrLAPA80EUwnymID35Uajxf4Ppf/OH/0Kgde5eDmrlcGNRgHvOt80GASN+TBrJQGQTVbLtaj4MI8ZxBDSd70bhCl1UIEmMLZY8A1zP1bCGY+fdLd7xG/hrTjxHiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amR6FtHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF520C4CEE9;
	Tue, 27 May 2025 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374974;
	bh=a2m/Xm0Fx0H//NfL7YFGhI3gk44cer5mXM1DGjNXank=;
	h=Date:From:To:Cc:Subject:From;
	b=amR6FtHfQ099XCyRkIHq5Z7+novkFXoVDurJQF4fVbEVgyXL5MreH20ieSIhg2aJW
	 VLu51hxN1wn+1EIV71Ej822hhF5v74Td55cmjb1NFA0iqdLccJBDu1y5ZoOHyktI3J
	 9zP7QoBlEnmJ2W0UQea2SYjewSe2YvfQRvBCo1k40Rk5ryb/ZwiRU1egVdYkbpIVA7
	 7C2QKx5+DIlSEIUBcfTGySQZnYjZRenAId3YH4ZTYPeYcxkK4M0lqypr1srBz46UTY
	 5+RB1LtYud7Fs+hEMKk6VA358NT/dagwBK4SwNx+dEtNtZsDTTSr080Kcc6h1wYYaP
	 6IvCEOy7fCzcw==
Date: Tue, 27 May 2025 09:42:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Changes for v6.16
Message-ID: <aDYVvLimkaLAtdiV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a22b3d54de94f82ca057cc2ebf9496fa91ebf698:

  cgroup/cpuset: Fix race between newly created partition and dying one (2025-04-01 21:46:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.16

for you to fetch changes up to 82648b8b2ae0a0ff371e2a98133844658cfaae9a:

  sched_ext: Convert cgroup BPF support to use cgroup_lifetime_notifier (2025-05-22 09:20:19 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.16

- cgroup rstat shared the tracking tree across all controlers with the
  rationale being that a cgroup which is using one resource is likely to be
  using other resources at the same time (ie. if something is allocating
  memory, it's probably consuming CPU cycles). However, this turned out to
  not scale very well especially with memcg using rstat for internal
  operations which made memcg stat read and flush patterns substantially
  different from other controllers. JP Kobryn split the rstat tree per
  controller.

- cgroup BPF support was hooking into cgroup init/exit paths directly.
  Convert them to use a notifier chain instead so that other usages can be
  added easily. The two of the patches which implement this are mislabeled
  as belonging to sched_ext instead of cgroup. Sorry.

- Relatively minor cpuset updates.

- Documentation updates.

----------------------------------------------------------------
JP Kobryn (12):
      cgroup: move rstat base stat objects into their own struct
      cgroup: add helper for checking when css is cgroup::self
      cgroup: change rstat function signatures from cgroup-based to css-based
      cgroup: fix pointer check in css_rstat_init()
      cgroup: fix goto ordering in cgroup_init()
      cgroup: warn on rstat usage by early init subsystems
      cgroup: compare css to cgroup::self in helper for distingushing css
      cgroup: use separate rstat trees for each subsystem
      cgroup: use subsystem-specific rstat locks to avoid contention
      cgroup: helper for checking rstat participation of css
      cgroup: document the rstat per-cpu initialization
      cgroup: avoid per-cpu allocation of size zero rstat cpu locks

Shashank Balaji (3):
      cgroup, docs: be specific about bandwidth control of rt processes
      cgroup, docs: convert space indentation to tab indentation
      cgroup, docs: cpu controller's interaction with various scheduling policies

Tejun Heo (3):
      cgroup: Minor reorganization of cgroup_create()
      sched_ext: Introduce cgroup_lifetime_notifier
      sched_ext: Convert cgroup BPF support to use cgroup_lifetime_notifier

Waiman Long (4):
      cgroup/cpuset: Always use cpu_active_mask
      cgroup/cpuset: Fix obsolete comment in cpuset_css_offline()
      cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs
      cgroup/rstat: Improve cgroup_rstat_push_children() documentation

Yury Norov (1):
      cgroup/cpuset: drop useless cpumask_empty() in compute_effective_exclusive_cpumask()

 Documentation/admin-guide/cgroup-v2.rst            |  79 +++-
 block/blk-cgroup.c                                 |  10 +-
 include/linux/bpf-cgroup.h                         |   9 +-
 include/linux/cgroup-defs.h                        | 100 +++--
 include/linux/cgroup.h                             |  24 +-
 include/trace/events/cgroup.h                      |  12 +-
 kernel/bpf/cgroup.c                                |  38 +-
 kernel/cgroup/cgroup-internal.h                    |   6 +-
 kernel/cgroup/cgroup.c                             | 148 +++----
 kernel/cgroup/cpuset.c                             |  90 ++--
 kernel/cgroup/rstat.c                              | 460 ++++++++++++++-------
 mm/memcontrol.c                                    |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c      |  18 +-
 .../bpf/progs/cgroup_hierarchical_stats.c          |   9 +-
 14 files changed, 665 insertions(+), 342 deletions(-)

-- 
tejun

