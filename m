Return-Path: <cgroups+bounces-14579-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPDKNE1Xp2lsgwAAu9opvQ
	(envelope-from <cgroups+bounces-14579-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 22:49:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6F1F7C16
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 22:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43DE4300C271
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 21:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B038228B;
	Tue,  3 Mar 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn26ajll"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258432694E;
	Tue,  3 Mar 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574538; cv=none; b=OhPh2Ep2jPySvx2gWPWzNFzmTaqNUGj3uY7MouUzRdRkqt7EQ6337ex37HwqmswGI7Yv176aEWBXpbrO79obAK5BoAVR/9pDhV9kvM7ksCDzeTcxNpgC1tY0YqdFOVpfD9d71a3p7dSKXrXCZieDN8Xlc5M/m1/ZtaI+hfUbX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574538; c=relaxed/simple;
	bh=8omlh4NObVF6slvvfUOPZq5TrbA7XAx7668EqE2O1rw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=MYYbcjj06FmnCdfb8DmRiQQ7M/cC3KbLcIZuMSSRjjZlS2mVab4g2nae99ergGBS2poJukxlfUc11oycuf6/SWN4je5/hmeqKMgC2NQ0RwxrmL01UBoQJLO9Y402Ec9bClhYLyN+ALp0PcExBMNJB3IjdAQjjnUjYgN7LXpyI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn26ajll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BB4C2BC87;
	Tue,  3 Mar 2026 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574538;
	bh=8omlh4NObVF6slvvfUOPZq5TrbA7XAx7668EqE2O1rw=;
	h=Date:From:To:Cc:Subject:From;
	b=gn26ajllrjDjaExmfTpKej9DJwd4Miq8Y8J45GfdwAMGy/xtfyhZ6KUJ2NugzKlxi
	 VFizePvDvZIrpy1XxTy8tGCWXsCZqaiPRaiN1z0KlA1lBPSNlTmnQWvK7azSE/iApK
	 4uyIbxoz4Rmvy78qtd57Zit7n3Xp3hXnFCJQO5ATw0mk1Lex6chHv6Ftx6RNY5J9YF
	 uQ4S5FuU+b4yTEOhPRbm+5MsH0w+L/lPW4IUIaL9aplilDOSzOxHik5B2C6cELkMIH
	 HeyiKPyeHTSiSi51kFrZeoBogshuZn5+C/JVqkiC9Cd3bEtU/VUMmSkBjbqKSzkBNY
	 hAwbZRWo3KH9g==
Date: Tue, 03 Mar 2026 11:48:57 -1000
Message-ID: <c04ce0bbeb7a461f3bb0d571ff5a2911@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cgroups@vger.kernel.org,
 Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.0-rc2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 51B6F1F7C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14579-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

The following changes since commit 37a93dd5c49b5fda807fd204edf2547c3493319c:

  Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-02-11 19:31:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.0-rc2-fixes

for you to fetch changes up to 085f067389d12bd9800c0a9672a174c1de7a8069:

  cgroup/cpuset: fix null-ptr-deref in rebuild_sched_domains_cpuslocked (2026-02-25 07:39:04 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.0-rc2

- Fix circular locking dependency in cpuset partition code by deferring
  housekeeping_update() calls to a workqueue instead of calling them
  directly under cpus_read_lock.

- Fix null-ptr-deref in rebuild_sched_domains_cpuslocked() when
  generate_sched_domains() returns NULL due to kmalloc failure.

- Fix incorrect cpuset behavior for effective_xcpus in
  partition_xcpus_del() and cpuset_update_tasks_cpumask() in
  update_cpumasks_hier().

- Fix race between task migration and cgroup iteration.

----------------------------------------------------------------
Chen Ridong (1):
      cgroup/cpuset: fix null-ptr-deref in rebuild_sched_domains_cpuslocked

Qingye Zhao (1):
      cgroup: fix race between task migration and iteration

Waiman Long (8):
      cgroup/cpuset: Fix incorrect change to effective_xcpus in partition_xcpus_del()
      cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()
      cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
      cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
      kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
      cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains() together
      cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue
      cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock

 kernel/cgroup/cgroup.c                            |   1 +
 kernel/cgroup/cpuset.c                            | 222 ++++++++++++++-------
 kernel/sched/isolation.c                          |   4 +-
 kernel/time/timer_migration.c                     |   4 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 224 +++++++++++-----------
 5 files changed, 266 insertions(+), 189 deletions(-)

Thanks.

--
tejun

