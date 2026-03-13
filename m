Return-Path: <cgroups+bounces-14821-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG+mDKBztGmUoQAAu9opvQ
	(envelope-from <cgroups+bounces-14821-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 21:29:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78F289B7A
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 21:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F413304944C
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE793CF671;
	Fri, 13 Mar 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOgytqqA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5138737E;
	Fri, 13 Mar 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433723; cv=none; b=b8AiubMifgN7RFsG3i1ZtWCFV3cmEDuh8NCDNil0FKa2sMesbSMUHoJcI/IISC19B9oLSnXEtM4UMnhV8nP5sNicGb3z3r4oKW8w3FEec+KRCpnyxLzThdUoyJdqXS6JgmRmDvILfuI1YVG5RNRcyAJkEre5meNMikhaUA0JQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433723; c=relaxed/simple;
	bh=4CxQS1xFdi5X8fdTBOGLQwCS3T4yj6Ky5udoOs3A7Vc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=GkGZjv2fYjcGc9cQuSdJ02HGDbpFvRKRmaXcV6WsSe07U0oIwJ6fQjFfUPAu7hBryIezcwzHeTcIHSLNwG1Y9meueNVW+XwD15P/Lrqfp4/taqAp4hfQhNBhjdncKbj0Z6HNaxkiZJ+99fuk6tLKs4+M3/Xz81ieFC2uGo0BfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOgytqqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A58BC19421;
	Fri, 13 Mar 2026 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773433723;
	bh=4CxQS1xFdi5X8fdTBOGLQwCS3T4yj6Ky5udoOs3A7Vc=;
	h=Date:From:To:Cc:Subject:From;
	b=tOgytqqANy4gdRfOeGJAnxONSmFGD71i6XBHOSd0zpVHp3DkKRjZHedDXhau6o5qo
	 T/ebBXGIgwoss5ONxiKqK3mDx7RaAtLTO7Jo1inkymZeI28YjzQFALS6gIJ6iFIcN1
	 Wk2d/+to43ZbSFNWlGYuGEFeT/iBVcb/BALUuivxKT2DjIt0XTXgYfC20RreQJuGgs
	 1EhssOFtwzEibyFaKVK3dGb01PD4xUk61O1Lzd2XR6s30qae2BdytlM3q3wHCKPCs/
	 Di0aKTx0et+8gNVZp+mt8ozzKhAun2ve65S/seqlEpKoM4hlh6mGDL2jyI6hi8hnki
	 q/qmGy6pDUXsQ==
Date: Fri, 13 Mar 2026 10:28:42 -1000
Message-ID: <bec9d24e3542e85a4bdb229dee142b19@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.0-rc3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14821-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: AB78F289B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

The following changes since commit 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2026-03-05 11:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.0-rc3-fixes

for you to fetch changes up to a72f73c4dd9b209c53cf8b03b6e97fcefad4262c:

  cgroup: Don't expose dead tasks in cgroup (2026-03-06 12:43:25 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.0-rc3

- Hide PF_EXITING tasks from cgroup.procs to avoid exposing dead tasks
  that haven't been removed yet, fixing a systemd timeout issue on
  PREEMPT_RT.

- Call rebuild_sched_domains() directly in CPU hotplug instead of
  deferring to a workqueue, fixing a race where online/offline CPUs
  could briefly appear in stale sched domains.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      cgroup: Don't expose dead tasks in cgroup

Waiman Long (1):
      cgroup/cpuset: Call rebuild_sched_domains() directly in hotplug

 kernel/cgroup/cgroup.c |  6 +++++
 kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++------------------------
 2 files changed, 37 insertions(+), 28 deletions(-)

Thanks.

--
tejun

