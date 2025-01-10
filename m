Return-Path: <cgroups+bounces-6091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195EA09E6C
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFA5188ADFC
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319421A43A;
	Fri, 10 Jan 2025 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elP+eq3h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E92080F6;
	Fri, 10 Jan 2025 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549693; cv=none; b=jw+RCLwAl9a/JgUZ9zkxB/TZd5rmK1t6UxNfd88bqRtTodo0xPKHX/bZpqXo/BLN9ZSuYrAirhC1SpPlXaOvanOyQHAb4gaF4Qtqgg7wRyCo8dRUA/4fK3jhrxutw9YF2rzQ83ExwaBmekhgPDnoScQu8Sg8YeQ0zKL6fVLUgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549693; c=relaxed/simple;
	bh=f9JiWFrGEwi8hLt237XzDglvO03EV7vVu7PMXaPKWeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rHRml8/L8CL0N/EbcCpJUyXp9qSHf+eTUMix7ZMtyZyyerqOutF6cFuidz9kdcU9BErJPdxWjBAmfdnbYHFtYYuLfqa7darBoNMl2Q13IHTYBomjj4y9DykvNgJqQPeHyLFzwB/x76Nb1aRaabLNAsOUoeZ6JkNin/WPzDG2WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elP+eq3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B91C4CED6;
	Fri, 10 Jan 2025 22:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736549693;
	bh=f9JiWFrGEwi8hLt237XzDglvO03EV7vVu7PMXaPKWeQ=;
	h=Date:From:To:Cc:Subject:From;
	b=elP+eq3hnXpkTm3qG+rGY8sMyPrcfftfVQSTiw3LN6tt9eU7rCSxoXcUFy9ea00M4
	 dHe2QUG8vBk1PvqdgDuT51DtihpZHzO+GQ9YykzTG2FUaj1xHyFnOV518Y6KV80zDI
	 K+G4gfGrmrjXXrHsd4E3wOPhmKyX/Mbqx5i7wlckpHaS5bSHwHciJ6btOK4UzP46uP
	 CS8qV7vCFhihjwRrOR9LLKoJCLVEcMyF8Ni5kKTrkTxxRue8EdxvkHOuOCi1fjdzm1
	 5gnegUJSDBuDd7txPYbJwlv3ggGsdeSV9CKeknZD/4r9NfndtBtqMTIuGFMOpG2O4M
	 xXRCGpk/iPCkg==
Date: Fri, 10 Jan 2025 12:54:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.13-rc6
Message-ID: <Z4GlPPv2Ku5xRs6N@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f92f4749861b06fed908d336b4dee1326003291b:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2024-12-10 18:21:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13-rc6-fixes

for you to fetch changes up to 3cb97a927fffe443e1e7e8eddbfebfdb062e86ed:

  cgroup/cpuset: remove kernfs active break (2025-01-08 15:54:39 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.13-rc6

All are cpuset changes:

- Fix isolated CPUs leaking into sched domains.

- Remove now unnecessary kernfs active break which can trigger a warning.

- Comment updates.

----------------------------------------------------------------
Chen Ridong (1):
      cgroup/cpuset: remove kernfs active break

Costa Shulyupin (1):
      cgroup/cpuset: Remove stale text

Waiman Long (1):
      cgroup/cpuset: Prevent leakage of isolated CPUs into sched domains

 kernel/cgroup/cpuset.c                            | 44 ++++++-----------------
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 33 +++++++++--------
 2 files changed, 30 insertions(+), 47 deletions(-)

-- 
tejun

