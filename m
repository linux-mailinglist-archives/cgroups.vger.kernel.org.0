Return-Path: <cgroups+bounces-8431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A49ACD02D
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817DE3A742C
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024D22A4F0;
	Tue,  3 Jun 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh5U+yo3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46017A30A;
	Tue,  3 Jun 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992774; cv=none; b=qu/SRzv8TMKYjDtOTxulA/Wv2QABgdSynvDEqsL9PWGJZFmcrQHaSHxijBkOTX4sFn/8DV1mFp+ITV6Vh4T1t0UQXgm/HJbB9ONX6Yn6LPEia093w/MRZz/CbRCj4Lrb3UwV7Me6KGbZ0PvSHBo1FVPoZTn0iRBDBqBhB2wNmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992774; c=relaxed/simple;
	bh=RG1+4q8Me5BzyOLg9KVTM7b/Ji24D6d1EwJ9zRTJ/9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eYcq+LnaccLlIjbT/4eCpCAB6TApFbYI2wyg5690ZrZ5+EL6UVXoQ91E+kPpL8DGt/hVL3s7xK7e6Fq/NwHbU/G7hCL1eaLKxdOM/fxZBXFGU36HSf8a2GSehX3CM/TOGPTMx2ZNweVgTG6OaeMj5shQbN/fXop3dMUKotXgXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh5U+yo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2908CC4CEED;
	Tue,  3 Jun 2025 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748992774;
	bh=RG1+4q8Me5BzyOLg9KVTM7b/Ji24D6d1EwJ9zRTJ/9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jh5U+yo3y5YdIhzF7Y2l6PYnG08rLHJ2+5sFkMe86GEUAeqDw0kQ7QmUMrI45i0nB
	 EatfOA1JXYRM+tZCYyhCAtLKxN2bV5s3Rf92pt1lGehRxEVwWaZIXz2DnuKoKevTXy
	 zDmB1x0TvgNnzTUP7h0CAr0PA9gHYg1GREICgB5wfz0vke73jVoJfCtS8MfpSq6dHP
	 JHpp0/dMronk2DH98MidwsoLYT2ZjLYraFlEvUSAwjff+DBUK+XNVGcTKuiCadpD1u
	 ltYqvYxNurni59v8gAz6VxTKRdODLdgNCHUFIKxBtpD6liEbj+dj6ur7SqvwK+rEJ7
	 lGj/jsTo5/Jrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0A39380DBEC;
	Tue,  3 Jun 2025 23:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: A fix for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aD9CL3oO5LFgKNXY@slm.duckdns.org>
References: <aD9CL3oO5LFgKNXY@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aD9CL3oO5LFgKNXY@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc1-fixes
X-PR-Tracked-Commit-Id: c853d18706de8c9525126b362f747d2e480e93df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: def5b099a6452856801da71ad07c601ae2dbf6ef
Message-Id: <174899280643.1701538.1613065180797034574.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 23:20:06 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, JP Kobryn <inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Jun 2025 08:42:55 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/def5b099a6452856801da71ad07c601ae2dbf6ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

