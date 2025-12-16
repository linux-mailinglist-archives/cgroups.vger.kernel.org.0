Return-Path: <cgroups+bounces-12374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D86CC173E
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B17300C8D4
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E334A797;
	Tue, 16 Dec 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWBK29KB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430C34A78F;
	Tue, 16 Dec 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872415; cv=none; b=a6XiWTQyJNjAdn7u5BPU2SuNnMNB+hsSEeYwg/mR543RnSde36nBAkVeWDNFZa2bIU/qEEU9NqIJUrgX2OhxoYen+pUMUw9jEBF4bs1TJsEXKePagpD0HyjWNgoZkWpa+vFKDfRiOMj0+vy3hRUSpHhDO1YLaZH0vgFYSi/jyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872415; c=relaxed/simple;
	bh=FUHERo0rtRZMsUjioyBlL3hgrWKw0i/xY8dcIULzFHk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZTSIBsqTJLJg5OKUUBOnKC/xjyHGZFaX5K6rF6aX0eBN1FRmiR+eW+IjaB0uGZUNUk9ggjusr3m/Mogj04+xRc2sbBGnG4Lkw8+qAZWppYxwwDpg3/+gPOP+wjKso0LWVzSCzUwW25z2751l2IQzskk/tiYBc0W3aZMQdh5gUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWBK29KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56967C4CEF1;
	Tue, 16 Dec 2025 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872413;
	bh=FUHERo0rtRZMsUjioyBlL3hgrWKw0i/xY8dcIULzFHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aWBK29KBD/Dg3sPLr3zdo10ZdXRD8sXn9qFUDILqS03WoAoAVUaSYQ+d75l+tnFY4
	 gDu40h4tcdzLSWAZLn1p5ogu58rJ2hFm640To1De6fNnFsofOOH3KBQCOCAfdUKU3j
	 BYiM+qwTaKonbs1qOFNgJ0+vwX9oGS111UYtJr044ZUL+fWlu8bcDv4y/0E2vL4W7w
	 ZTmPVtn3O7ET0h3F2YG/HaGIpi+pXAbpaMoNJ69dlWadwoagq1nx3pxADOAH7IHaRE
	 RGkhwwaOlxHGDMzSE0gRI/GxgeNMWfGJXPwmGWQsTp4G4nIAvz5Z8nOgvIRARfu3iK
	 YORGbMG2wo2Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78C91380CECA;
	Tue, 16 Dec 2025 08:03:45 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab515375a4aa072868aeba23668fe162@kernel.org>
References: <ab515375a4aa072868aeba23668fe162@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab515375a4aa072868aeba23668fe162@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc1-fixes
X-PR-Tracked-Commit-Id: 3309b63a2281efb72df7621d60cc1246b6286ad3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b63f90fa2afaa901e7edc9403014e46f0da1c69
Message-Id: <176587222409.917451.3276893149036425339.pr-tracker-bot@kernel.org>
Date: Tue, 16 Dec 2025 08:03:44 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Dec 2025 06:54:23 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b63f90fa2afaa901e7edc9403014e46f0da1c69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

