Return-Path: <cgroups+bounces-10503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0BBAE38C
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 19:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278AA7AE673
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6430F939;
	Tue, 30 Sep 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAk0hEeR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE42FBE16;
	Tue, 30 Sep 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253761; cv=none; b=F0WwT2yM4rluyVOVSQHE7hmPq/5+UOh3od3mnfm/IzTeYVmNFJO5PB0p5gWsZDPBMFg3GR11oEwBBcPOCzuhrg1OeVaV6gl4DMp/7CSQ+Xm+77+9E1SWA8q0WMsccNLFjryhnmZGElLZkekRdeiTZ41UqD1SEzybzgDIun2DH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253761; c=relaxed/simple;
	bh=E3Ka0RatBzWCbvQisHXsZhWAnZIoFC9h0frm0AfxW/g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nD76Sjt62EsOWMhEHWSP4djSJOsWepzZ1ihki5XInifsQmLhuf+QHdh9WW6oOqqu+XEqH7ucIEJpUB2z2s1XNw65hQjJ4Ktg3aXZp1wZsVbcMlVaN9lVkPjTxZdH8NnWHLd5xeu6akDHjF5W3z12v0QTrmkLJT6KOJwYE5h4tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAk0hEeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D44DC4CEF0;
	Tue, 30 Sep 2025 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253760;
	bh=E3Ka0RatBzWCbvQisHXsZhWAnZIoFC9h0frm0AfxW/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UAk0hEeRCbnY/nW9Rpvt7q4O6Ynjb8wpNSnC3V0u7rzJAk2K0hGeNpBlXOJpQxMxm
	 i9WIHT15oanUELAnImFST3PEzLNMQoxclgzM/A510BfLUVYTn75aLmjHg1H47wbEIV
	 FXcyZL7S+BDOY3K83thZqtWjdPZ2kZiWDOlmEUy9Z/sxVJDT2ZnTHJd/zDuxjXaHCz
	 yYuURuQR0/Ec9w30Mj3tt502fnXESWsWsAaqoHwv27MRwNc+UQOZ/r0Lk7/wG3eHLT
	 ypZr4ZIgoDQW0uVoZIbjOlH/vUZQIafQV3ybBqFA5KgiXXdXaDoS3fsCU7xMpV57YW
	 wL72+Qaxz1+7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1239D0C1A;
	Tue, 30 Sep 2025 17:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <21156f925598248ffe7d2d5f00b212da@kernel.org>
References: <21156f925598248ffe7d2d5f00b212da@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <21156f925598248ffe7d2d5f00b212da@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18
X-PR-Tracked-Commit-Id: 8f0fdbd4a06bf795c68bc9839d9c349ab592654f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 755fa5b4fb36627796af19932a432d343220ec63
Message-Id: <175925375363.2087146.1679597749043435278.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:53 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 10:22:50 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/755fa5b4fb36627796af19932a432d343220ec63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

