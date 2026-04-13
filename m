Return-Path: <cgroups+bounces-15274-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCXcEHck3WkzaQkAu9opvQ
	(envelope-from <cgroups+bounces-15274-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 19:14:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F63F10B7
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61EA304A215
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F253368B5;
	Mon, 13 Apr 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s17z851E"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFA313537;
	Mon, 13 Apr 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100063; cv=none; b=c2qhEXirmV5sLOa3ZiMGH5XZ7xNaT6GFos/3w46IYmYLwykqcgOFeAvVnHQ/AXcHI4NMyszjZOQutON6hrKvUzuPHDoDEqlrffL5HP8JvlZcZUu/qhpA0vXGXsdsC4I9IaGj0Cc2XwjK2yEinyk26/jnvuX5FAc4lC/QXwgs+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100063; c=relaxed/simple;
	bh=1HUCPv1QfLJN+JhT/kN8fpgFOBpBqiJT+HN3dAiN/ZY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=U8Uz7lfzqeXKFeCidrh4LXU6n9fNFLAmg97n8ErjnbQ+2mLDZwzxqax1KJNObI9Vi0sz7l7fW2zU7r9ntw+1azKrBR2qPkAdmYIGaskHyyyQL05TvLmq0L8XtOQd9wkSGt/FDpJwywV7Ls9NyuwZKLqv2oQxHrbrsiNUmeW90tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s17z851E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F3C2BCAF;
	Mon, 13 Apr 2026 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776100063;
	bh=1HUCPv1QfLJN+JhT/kN8fpgFOBpBqiJT+HN3dAiN/ZY=;
	h=Date:From:To:Cc:Subject:From;
	b=s17z851EiLEcxoV2oFbElJYqpa+Qx8haTXEgLpMNNhCNnqL1qT0Cd+tAMylVTeekO
	 NJY4/DX9piwlDRLi7MrTxl+NyygLihLZcFp9SQBhu6/5Tl7jOQB+pLKKL2L4cHsXxG
	 /j2tDMVpQx7AxmJMrLNig5mv7pW+HPFJ/gBDU3jd/+puLDwE39xWNJDra145ZxdigO
	 s/Hu8yedUbbYPpirA8sja71n78ox1MQuIBIQo2wYGcuWCbLDE6377vaBGqYyvn+/6c
	 jFaf2Kq52eAED5zth3tF0hotPbyLq3y68qs/eXJhwN8dusLI3RRoViTMXpGDgVh56s
	 NaCLKuRniN1jA==
Date: Mon, 13 Apr 2026 07:07:42 -1000
Message-ID: <5c154b2c25e1dae88c419232ae1cc581@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup changes for v7.1
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
	TAGGED_FROM(0.00)[bounces-15274-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: C03F63F10B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

The following changes since commit 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2026-03-05 11:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1

for you to fetch changes up to 3348e1e83a0f8a5ca1095843bc3316aaef7aae34:

  cgroup/rdma: fix swapped arguments in pr_warn() format string (2026-04-09 22:30:08 -1000)

----------------------------------------------------------------
cgroup: Changes for v7.1

- cgroup_file_notify() locking converted from a global lock to
  per-cgroup_file spinlock with a lockless fast-path when no notification
  is needed.

- Misc changes including exposing cgroup helpers for sched_ext and minor
  fixes.

----------------------------------------------------------------
Shakeel Butt (3):
      cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
      cgroup: add lockless fast-path checks to cgroup_file_notify()
      cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock

Tejun Heo (1):
      cgroup: Expose some cgroup helpers

Thadeu Lima de Souza Cascardo (1):
      cgroup/dmem: remove region parameter from dmemcg_parse_limit

cuitao (1):
      cgroup/rdma: fix swapped arguments in pr_warn() format string

 include/linux/cgroup-defs.h     |   1 +
 include/linux/cgroup.h          |  65 +++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h |   6 ---
 kernel/cgroup/cgroup.c          | 108 +++++++++++-----------------------------
 kernel/cgroup/dmem.c            |   5 +-
 kernel/cgroup/rdma.c            |   2 +-
 6 files changed, 95 insertions(+), 92 deletions(-)

--
tejun

