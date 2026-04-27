Return-Path: <cgroups+bounces-15516-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFKFGi+y72n5DwEAu9opvQ
	(envelope-from <cgroups+bounces-15516-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:59:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD72478E88
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C944303E2D2
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212B3EDAB7;
	Mon, 27 Apr 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNeCCyaH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA61255E43;
	Mon, 27 Apr 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316375; cv=none; b=RG2ZhbZ22TqyooEbWbKjgpU5QhPhZS9u+/kGx3P6LcYMlguCKWDDBOfpQ8mq2+Iqa7NHvcNCJMxGEg6z2RlNRaHyFKIhqNfS8k9O4A4KoU/ql2aLgLtNpXxYXJ2+baazN4kApyHtkhALAgCYGwr/p8SBss9c8OHQGJafPK+B/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316375; c=relaxed/simple;
	bh=qMZupF+hUnWvUj9Tu16uGR5xkR1Vy7JLqqRYOyYBogY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=DUUh/JDKe3doV+K5RDSUlRYnjNlBVVdbPjA8yCoNsaDDpldF6f1iTsXd++OeN22GhDnQYeajeDyGZSd/m1b0l0g2mOUKH127f9zmA60x3avbtybmwurNFBWU5QcA3c5IiyMepDM3tL1gvUcN7JVPxU4ma38ZOGXXIBkhDDSzMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNeCCyaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE145C2BCB7;
	Mon, 27 Apr 2026 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316375;
	bh=qMZupF+hUnWvUj9Tu16uGR5xkR1Vy7JLqqRYOyYBogY=;
	h=Date:From:To:Cc:Subject:From;
	b=nNeCCyaH4CN2ikI1YLvr2WsI9LLLGW7SvO5cB9PGM+iLyqu/YmRoCpp67Pv7X2CrB
	 znBill6ymqw1uoUvvAeSguHVDitSDzoLVNuV7pGw4svXL0nri1iCwm7CntAQRtas/j
	 eqlAKwOwy/bJZYWyRH43elxq4+srBK0SEbYh/mvgzRg6qXPH2NXxDN96krula2yzZg
	 wNR17zpoBhXhhVnicQwa3F4Ox6QFrbYdVkmEhel1tpGndfC2PW8JTq9OJjduNHd5Og
	 2gfNnPVed8HMX5VTd8QEbtkUBW/+GZjopePiznB14lTJf6fmxpyb7m09xE7IB0zPTr
	 txp8DczK0rchg==
Date: Mon, 27 Apr 2026 08:59:34 -1000
Message-ID: <4403616be923254d7f4c878973e44321@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.1-rc1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BFD72478E88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15516-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

The following changes since commit d730905bc3c0075275b2d109cd971735274b98c0:

  Merge tag 'mips_7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2026-04-17 08:53:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc1-fixes

for you to fetch changes up to 981cd338614c96070cf9854679014fd027c1fb1d:

  docs: cgroup: fix typo 'protetion' -> 'protection' (2026-04-27 07:55:40 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.1-rc1

- Fix UAF race in psi pressure_write() against cgroup file release by
  extending cgroup_mutex coverage and ordering of->priv access after
  cgroup_kn_lock_live().

- Fix integer overflow in rdmacg_try_charge() when usage equals INT_MAX
  by performing the increment in s64.

- Fix asymmetric DL bandwidth accounting on cpuset attach rollback by
  recording the CPU used by dl_bw_alloc() so cancel_attach() returns
  the reservation to the same root domain.

- Fix nr_dying_subsys_* race that briefly showed 0 in cgroup.stat after
  rmdir by incrementing from kill_css() instead of offline_css().

- Typo fix in cgroup-v2 documentation.

----------------------------------------------------------------
Edward Adam Davis (1):
      sched/psi: fix race between file release and pressure write

Guopeng Zhang (1):
      cgroup/cpuset: record DL BW alloc CPU for attach rollback

Petr Malat (1):
      cgroup: Increment nr_dying_subsys_* from rmdir context

Petr Vaněk (1):
      docs: cgroup: fix typo 'protetion' -> 'protection'

cuitao (1):
      cgroup/rdma: fix integer overflow in rdmacg_try_charge()

 Documentation/admin-guide/cgroup-v2.rst |  2 +-
 kernel/cgroup/cgroup.c                  | 46 ++++++++++++++++++++-------------
 kernel/cgroup/cpuset-internal.h         |  5 ++++
 kernel/cgroup/cpuset.c                  | 13 +++++++---
 kernel/cgroup/rdma.c                    |  2 +-
 5 files changed, 44 insertions(+), 24 deletions(-)

--
tejun

