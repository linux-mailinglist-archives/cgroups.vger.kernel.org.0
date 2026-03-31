Return-Path: <cgroups+bounces-15140-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcGHZ8kzGnHPgYAu9opvQ
	(envelope-from <cgroups+bounces-15140-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:46:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBECC370CD7
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E30309A2C3
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A13DEAEB;
	Tue, 31 Mar 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUZfhXx5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550B3A255D;
	Tue, 31 Mar 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986208; cv=none; b=O0PlxBXAAYMuvIw3Qm601M+tewsFR4+tNZfwaeYOTWz/DzQwIxbmcTFGP/gMHf8DLK7DN5EhswM6FaSE7TFgZ+wbwtd7lmCV8VjxPT27jZ8tFilS69E43ihN6Q6Ja4BiN0g4P2UUJl58yZwjQ8jObtrROIasVv7aSnt6cLL2Jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986208; c=relaxed/simple;
	bh=ulGL5DonYsjY7R1ocZZWnYptOcG1mqo/NsrqP3fhCMI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=rE0SwGNmqB2bWL1MnbZAXsOdLJoymPt1PrE7aR4hjL5394/NfiIU0yzvD41Hruu+cEogbfT8W0ioz6ZHmkj9Z9jkiWpOajSyLag0FP5wnbqCDVIWIg6emc+VtJMnLKMhq4/77/7em9okffXJCJOE9d9SLaq0SJng+4GZ5+sGwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUZfhXx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E3DC19423;
	Tue, 31 Mar 2026 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774986208;
	bh=ulGL5DonYsjY7R1ocZZWnYptOcG1mqo/NsrqP3fhCMI=;
	h=Date:From:To:Cc:Subject:From;
	b=tUZfhXx5bIwvhxEVI0W1Bu9WawQ4AC1OG906B97g+DETtSJ8QRqV5tPiIdGNyiQ2m
	 +eC6spu5rtL3+9uFlzPC2H0KPmwQbWhSM+5TpajzKdfDKQfNDNlPnEVmK7ioFLARVK
	 PLeZCMEy4zA4KBpbkchM4NhYJwXPiVDfUDatRVz6Rq8PWFsauCmokStgceJCJEQqRS
	 SEfvSpBX4hevHt9MU0S6mtNvS28lh9t148WVi6DL2HvI+VS85XPNFn+1tr/jbDUoZ2
	 HDri/r6ca2EN799amRpHvub8d7jVRbXBV3SMxQL2jzIzurNUshy9Sug7VVe9M3U1xo
	 vqxNcTe02kjtg==
Date: Tue, 31 Mar 2026 09:43:27 -1000
Message-ID: <85ee59a014d0eb2b005c623a0e7c45b2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.0-rc6
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15140-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBECC370CD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

The following changes since commit a72f73c4dd9b209c53cf8b03b6e97fcefad4262c:

  cgroup: Don't expose dead tasks in cgroup (2026-03-06 12:43:25 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.0-rc6-fixes

for you to fetch changes up to 089f3fcd690c71cb3d8ca09f34027764e28920a0:

  cgroup/cpuset: Skip security check for hotplug induced v1 task migration (2026-03-31 09:14:13 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.0-rc6

- Fix cgroup rmdir racing with dying tasks. Deferred task cgroup unlink
  introduced a window where cgroup.procs is empty but the cgroup is still
  populated, causing rmdir to fail with -EBUSY and selftest failures. Make
  rmdir wait for dying tasks to fully leave and fix selftests to not depend
  on synchronous populated updates.

- Fix cpuset v1 task migration failure from empty cpusets under strict
  security policies. When CPU hotplug removes the last CPU from a v1
  cpuset, tasks must be migrated to an ancestor without a
  security_task_setscheduler() check that would block the migration.

----------------------------------------------------------------
Tejun Heo (3):
      cgroup: Wait for dying tasks to leave on rmdir
      selftests/cgroup: Don't require synchronous populated update on task exit
      cgroup: Fix cgroup_drain_dying() testing the wrong condition

Waiman Long (2):
      cgroup/cpuset: Simplify setsched decision check in task iteration loop of cpuset_can_attach()
      cgroup/cpuset: Skip security check for hotplug induced v1 task migration

 include/linux/cgroup-defs.h                        |  3 +
 kernel/cgroup/cgroup.c                             | 88 +++++++++++++++++++++-
 kernel/cgroup/cpuset.c                             | 29 ++++---
 tools/testing/selftests/cgroup/lib/cgroup_util.c   | 15 ++++
 .../selftests/cgroup/lib/include/cgroup_util.h     |  2 +
 tools/testing/selftests/cgroup/test_core.c         |  3 +-
 tools/testing/selftests/cgroup/test_kill.c         |  7 +-
 7 files changed, 131 insertions(+), 16 deletions(-)

--
tejun

