Return-Path: <cgroups+bounces-10216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADCB81916
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347DD7B3890
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5113002DC;
	Wed, 17 Sep 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr03+UE9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49485314D0C;
	Wed, 17 Sep 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136790; cv=none; b=l20cMfhjsSkdKsX+CsNCQbqiV9nSRrmrwX6vgG9J/kyKD7rre7HC9bbCzABXCG+tojkmMfKXLLn2sopC9Bih0IqFcw1dddWPBwSLmkixRJw6ti4banKsKnzhdchItB+anL+wXqA8C9lVdRnTPz9HnQO7HfM6JNCJs+NdPNtBB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136790; c=relaxed/simple;
	bh=8vOSHuxDh5rS2TQSsLVX8UZJhtTlo0eEN9UUzTM1Sms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mtz5sw3VRh97kk1q39KRxYo2/rTxFnkLst8mFH0XfX6N8BPhW9eQtypjF5+Gq2UIZuIpFgNfQ4BQZQE/9yaMplAtL22Afq2r5ktL9YDDtAAvKgfAtgdtuDpVZS5upMWMcqvTGN4yiQ/ULFZr6UYTOuUpZApoy3Yfx7qMSGcw5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr03+UE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5BCC4CEE7;
	Wed, 17 Sep 2025 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758136789;
	bh=8vOSHuxDh5rS2TQSsLVX8UZJhtTlo0eEN9UUzTM1Sms=;
	h=Date:From:To:Cc:Subject:From;
	b=qr03+UE9m4rMoVlZL9vwZ0Bu9KwplUd2GH0IqH1Dqhgp1vR7wEiQmMUF6uKg/26+4
	 iLZfaJWdSPuhtoyQjxzNCLYwl2O0PWpCdwTKs8NC31jvEcQdNFwkjW5rw4cWjtVL56
	 aaj0P3bvVLw2E1jdTw9CbhVBxA72bITKgsS48h86m+Zz549hiqIRci2rwoEXUXqoaM
	 omP0W8cNIUZtubCWf3fhi80I+v/Xs1OBdjWje09TS6KULqLK3DaKpf46ywuAI0W0bf
	 G0tmCCi8uxEwUOZ13px6WrJ5PfyRdwulUuZ4oJckXld12b66mLRKwYiQPs6Y0/920F
	 GzKczMNZE2S2A==
Date: Wed, 17 Sep 2025 09:19:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.17-rc6
Message-ID: <aMsJ1J994GFBkKt7@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6563623e604e3e235b2cee71190a4972be8f986b:

  docs: cgroup: fixed spelling mistakes in documentation (2025-08-12 10:52:28 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc6-fixes

for you to fetch changes up to 94a4acfec14615e971eb2c9e1fa6c992c85ff6c6:

  cgroup/psi: Set of->priv to NULL upon file release (2025-08-22 07:47:43 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.17-rc6

This contains two cgroup changes. Both are pretty low risk.

- Fix deadlock in cgroup destruction when repeatedly mounting/unmounting
  perf_event and net_prio controllers. The issue occurs because
  cgroup_destroy_wq has max_active=1, causing root destruction to wait for
  CSS offline operations that are queued behind it. The fix splits
  cgroup_destroy_wq into three separate workqueues to eliminate the
  blocking.

- Set of->priv to NULL upon file release to make potential bugs to manifest
  as NULL pointer dereferences rather than use-after-free errors.

----------------------------------------------------------------
Chen Ridong (2):
      cgroup: split cgroup_destroy_wq into 3 workqueues
      cgroup/psi: Set of->priv to NULL upon file release

 kernel/cgroup/cgroup.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

-- 
tejun

