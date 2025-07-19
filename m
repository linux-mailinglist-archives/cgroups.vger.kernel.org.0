Return-Path: <cgroups+bounces-8785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31CB0B0F3
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 18:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC1D1AA2136
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BA286433;
	Sat, 19 Jul 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tABBr3sp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFB7FD;
	Sat, 19 Jul 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752943945; cv=none; b=IFFuUb7jf37wfqCQtFTO6SGVI7Hw0V/UGvWsH7Ij2EUSbK9x5ou3NK6uVk5Tm0lmgdzqbueuQ5UgZOPSKZauYeFwjez3V4bmu6M6n22j8X09NJHpTA81wa7ddxqsXGK8j5QceCgiLzyUJoQE3s8Enil3GpqcSVCADk2gIucmxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752943945; c=relaxed/simple;
	bh=EyTnctRVO7RTlj8YOty49mvwBeQLQU0t6JjymSXy0aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FXzUkIbGHqajQOeS4Ptq3wcXSckPWwbUEpXvyWeqR4WopYei9I1wFY4MXoMbnFzWmhHdEBv4/bx8ShiJ58DVBIMjHViovDhKTXXqhJ3RqN+9n9w+WV6gQHDaPblpX91eYBxj5FAZZPGCrM7iRnG07pslUh7HPrBt19hQPimBQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tABBr3sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D582BC4CEE3;
	Sat, 19 Jul 2025 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752943945;
	bh=EyTnctRVO7RTlj8YOty49mvwBeQLQU0t6JjymSXy0aQ=;
	h=Date:From:To:Cc:Subject:From;
	b=tABBr3sp/WCeWNuaT7LEjtNX8WYkOS+JRxR1CKmtyK85XItn36CP8NbzcQEpMshxu
	 iHQopuaqiuQ0x79zot5+HlJIw0XHWdrSgILsvDzdgApY2XwP/IeeNNNz/HxhsEnj4y
	 k7u4dyN8PJOcuC1BlqDAzzBKbOJUWZEbkcWjsZoO6lD06bTTXRTdoTU+0gNisJGxLY
	 nyYTAZ4KEKW9ojxvyCVqjjS2ih2m7SPDG/0sz/wMpsloukBiA3SRqTALEJPwooqj/3
	 xTT8kQAfxeZpVfBikatxM++4E+nW96ksI23Q1I7gs/G+5gTxTji86QNGOiX/9BnLGh
	 OQM/eoAG4fUvg==
Date: Sat, 19 Jul 2025 06:52:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.16-rc6
Message-ID: <aHvNRxda7ZvBTEOD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 37fb58a7273726e59f9429c89ade5116083a213d:

  cgroup,freezer: fix incomplete freezing when attaching tasks (2025-06-18 09:43:30 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc6-fixes

for you to fetch changes up to 14a67b42cb6f3ab66f41603c062c5056d32ea7dd:

  Revert "cgroup_freezer: cgroup_freezing: Check if not frozen" (2025-07-17 07:57:02 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.16-rc6

An earlier commit to suppress a warning introduced a race condition where
tasks can escape cgroup1 freezer. Revert the commit and simply remove the
warning which was spurious to begin with.

----------------------------------------------------------------
Chen Ridong (2):
      sched,freezer: Remove unnecessary warning in __thaw_task
      Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"

 kernel/cgroup/legacy_freezer.c |  8 +-------
 kernel/freezer.c               | 15 +++------------
 2 files changed, 4 insertions(+), 19 deletions(-)

-- 
tejun

