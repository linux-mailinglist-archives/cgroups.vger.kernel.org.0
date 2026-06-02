Return-Path: <cgroups+bounces-16586-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H7vbCuhdH2qmlAAAu9opvQ
	(envelope-from <cgroups+bounces-16586-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 00:49:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87850632940
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 00:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OZfNs04Y;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16586-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16586-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFD330A3D86
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 22:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396323750AC;
	Tue,  2 Jun 2026 22:47:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9832ABCA;
	Tue,  2 Jun 2026 22:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440476; cv=none; b=awRTZq/92ihjSHqxgN9ZOBAeWw6Tpfe8VYkgSbBLhaoHl5h/Q4Wu8jGnRySfkkYogKF8ngUbVB5WdbTjMt7X8QtHW/kzXTaRbMoyTRpRv7YdvmQMarin4lP527H1Il3FZXFiyxE8dPefHp7s8D03A/anGOjycOveAnw4Uq28suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440476; c=relaxed/simple;
	bh=PcvI8PNYRBdloHmQvihJ8z7uK5w8bQLfxxhPhX4E17o=;
	h=Date:Message-ID:From:To:Cc:Subject; b=aj9LCzRtJZe92jWdq8YHJRYW2AOBQF6cblfTASV5ZAAOKwhg4rkCmiLkoilRDs3/UtsKKjYem4SYpJbyFN3ReF/9VrAY8LKrt8LbPzl986tDWpTGSqYwHzI32Io5eWqhWqI1y/iL66fMM2kY/Utg3UOXsdLm/JMWT74WIANgkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZfNs04Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940811F00893;
	Tue,  2 Jun 2026 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780440474;
	bh=t4oiPA9/H8txlkBooPTLKGpXQOzIcFhNXGSKgCQ0Mqk=;
	h=Date:From:To:Cc:Subject;
	b=OZfNs04YlKIetxP6OJn8815HYX3Hj2f+zkpfS+aP51yeVYs2qGNtWRVmfP5mr08+8
	 lqazWPQ2g1pkkSEq50StntYpOVcHaucwLqveO2b8yIzZm0aTCvrQwdBaoNIU3uodIA
	 Jp+TXhlDd5qUKPjXky/96pIfWIIVtDbDh/qCYSmhFvPf35q3tvEt4TJb65kIadVzev
	 POx9XJnDixNGzY2oRLVGJNoYHoZ/uGkMjq2I3TcC27osYEJSjInubdv3GtQd0E5kp4
	 75xYKwv02ZJUSo4IT5f3P5FAGNuDg8hCkZjmi1y2w9F+UTDgVpMfKgoQMGfA0zhIni
	 9fjd5juuDD4Qg==
Date: Tue, 02 Jun 2026 12:47:53 -1000
Message-ID: <547622bc7e85cf6c2c3a2f95bf146f5e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v7.1-rc6
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16586-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:longman@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87850632940

Hello,

A low-risk cpuset fix plus a MAINTAINERS email update.

The following changes since commit 22572dbcd3486e6c4dced877125bbf50e4e24edf:

  cgroup: rstat: relax NMI guard after switch to try_cmpxchg (2026-05-20 09:44:35 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc6-fixes

for you to fetch changes up to 57aff991119693e09b414aff3267c0eae5e81da0:

  cgroup/cpuset: Change Ridong's email (2026-06-02 11:28:54 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.1-rc6

One cpuset fix and a maintenance update, both low-risk:

- Fix cpuset partition CPU accounting under sibling CPU exclusion that could
  produce wrong CPU assignments and trigger scheduling-domain warnings.
  Includes selftests.

- Update an email address in MAINTAINERS.

----------------------------------------------------------------
Ridong Chen (1):
      cgroup/cpuset: Change Ridong's email

Sun Shaojie (2):
      cgroup/cpuset: Use effective_xcpus in partcmd_update add/del mask calculation
      cgroup/cpuset: Add test cases for sibling CPU exclusion on partition update

 MAINTAINERS                                       |  2 +-
 kernel/cgroup/cpuset.c                            | 13 +++++++------
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 ++++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

--
tejun

