Return-Path: <cgroups+bounces-16218-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IhsHFqJEGriYwYAu9opvQ
	(envelope-from <cgroups+bounces-16218-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:50:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4845B7C33
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 183CD3011A4D
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4B46AF2B;
	Fri, 22 May 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoMQGnqw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A5201113;
	Fri, 22 May 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468473; cv=none; b=lx5+tye9YIlaWGsYXnjXnPr2sFq6CaNl21se+IK6+iRK+6RccayoFFmm+/bKchEVcJ/qf2xuHkMagLpCbfQpgZM1S1UMXAG1iMVeMZE0Nb21VYTDPtiAmHb3dB5cYLQkQsujV5X51UrS3QnDRya2106tse5YmIQRXZCkw143zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468473; c=relaxed/simple;
	bh=L9svKRLV62mYFxkAE3Bc4NDb+eQx27QmwJybPbaDekg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=cXwzZqc29Q00Ib6zIuW6pzr3cgx9B6Td3GtiswCwRFq/YxEKde4oYDTlwug8JP9XEz1MqYrSGkGFnmEFBWavGTRK/ib+PGkR164rWmXkzpv4Qw+sTWiOmJuvtAKA/XXSnyVdW/kYvQH8xa1b5PKDZq6Js7kDbRSMOZuzJlQZeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoMQGnqw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546AF1F000E9;
	Fri, 22 May 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468472;
	bh=nDYNEM/+NfCoxQseNPlx6z0X1r+GNdL1J+SzAQ+U788=;
	h=Date:From:To:Cc:Subject;
	b=BoMQGnqwTOtyDHb0BlXdTsppHGWo76fCfdYF9VrlrSY5P1/RRaUNAn/h4jzEL1RVJ
	 dHPJCpmXCdqxRdGbDtsBh/Oryk8AfhVR1eIencnjw3olVaf0uPxN1YdLx2ThxaB8Kr
	 cq2VQjAcwTptcI5bRvZmhHy6OELG0TYxIdt36bgtSmRUOWkkhXdtBHoNEwBRMxf8I+
	 vyl2N1tN4BMwxWmTAqnzDsGTznKY/erprlFoohMafbv/5JG3qJZyDlEBB7SLMnkJS6
	 8+vSJuAfOrL+6E59JwsU3rk3YR8mlb+Re/5OZSg2Zu2NtyfOyOwPVqfGtv04XLIyUr
	 QbWgtMk8r9pag==
Date: Fri, 22 May 2026 06:47:51 -1000
Message-ID: <cff491d26895c2d56392d153592009ea@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.1-rc4
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16218-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF4845B7C33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Linus.

The following changes since commit 345f40166694e60db6d5cf02233814bb27ac5dec:

  cgroup/cpuset: Return only actually allocated CPUs during partition invalidation (2026-05-13 08:54:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc4-fixes

for you to fetch changes up to 22572dbcd3486e6c4dced877125bbf50e4e24edf:

  cgroup: rstat: relax NMI guard after switch to try_cmpxchg (2026-05-20 09:44:35 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.1-rc4

Two rstat fixes:

- Out-of-bounds access in the css_rstat_updated() BPF kfunc when called
  with an unchecked user-supplied cpu.

- Over-strict NMI guard after the recent switch to try_cmpxchg left
  sparc and ppc64 unable to queue rstat updates from NMI.

----------------------------------------------------------------
Cunlong Li (1):
      cgroup: rstat: relax NMI guard after switch to try_cmpxchg

Qing Ming (1):
      cgroup/rstat: validate cpu before css_rstat_cpu() access

 block/blk-cgroup.c     |  2 +-
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 37 +++++++++++++++++++++++--------------
 mm/memcontrol.c        |  6 +++---
 4 files changed, 28 insertions(+), 18 deletions(-)

Thanks.

--
tejun

