Return-Path: <cgroups+bounces-12256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEACA1BE8
	for <lists+cgroups@lfdr.de>; Wed, 03 Dec 2025 22:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F009F303BE3E
	for <lists+cgroups@lfdr.de>; Wed,  3 Dec 2025 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A43090E8;
	Wed,  3 Dec 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk88cCXt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E788255F3F;
	Wed,  3 Dec 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798777; cv=none; b=e4HlbePNLyUFeJE6lPDD3KlnBodcHj4CDGGnyPM5ilb84SEujLLQvlWY7yhTGZE/ZVvdkOGbl72FxbdRn2eTi+gE6Sereu7OyF/yG+qGSbElQEK75gv2RH711UtrsXWvUnWYlkZccYTznVTeL5Rcym9adYBMgxN5csJtnwM2Qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798777; c=relaxed/simple;
	bh=7L9z9zp6hP/0rjsCibNnWOjRt0kLWRDEDyAqVSNMJOI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AGxEVqh7h+Tuv8eJGhLS4u0UOtC+WKGxr7hsoO7k62fGx/v8nhgpmpZTl3tHNyxfIRBk8+unUVbB545a6uT+LphsISXboa4ePDsHdKGER8uC+g9D//r4KjG95Tw7crdsnRqHwLtdH0EY3y4JCDMG05QVOBiJ1pFh5LPD2X3elK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk88cCXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B51CC4CEF5;
	Wed,  3 Dec 2025 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764798777;
	bh=7L9z9zp6hP/0rjsCibNnWOjRt0kLWRDEDyAqVSNMJOI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lk88cCXt1XQa6AmmMX5sNmFbwRsCRZvqf00pRceAqyQDPgHCADWqs2afylTM8u3dC
	 WMDa8QpCvutUyLSjQ1MqNigyY4wQMLrrHoGNbipGVHL5SAUp+u0m2cxE3ovrD7s5ZI
	 4krkpR68V36CqJeqvzNFOkdQ68izWnwvlTbN6etfk9hZ/8wSebUmJNZwZb3YFMZHiX
	 6/L9bHKPBFiblWuZD29TtmRQ7ZXbsJFYcm4ASHuD/iWgDK+4+KyIlDLT8LeAfGLia9
	 PW6OVs1Cn+WMxeTCPfieO860nQkvK4xZBXNen6TRzU91lfhdqmBBuud76VhwSq2iUb
	 jzDTNPuWEqxxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C6F3AA9A81;
	Wed,  3 Dec 2025 21:49:56 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <58579714c3f54951dddf5af185da0515@kernel.org>
References: <58579714c3f54951dddf5af185da0515@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <58579714c3f54951dddf5af185da0515@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19
X-PR-Tracked-Commit-Id: b1bcaed1e39a9e0dfbe324a15d2ca4253deda316
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8449d3252c2603a51ffc7c36cb5bd94874378b7d
Message-Id: <176479859566.93177.1463844935026739385.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 21:49:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Dec 2025 09:16:13 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8449d3252c2603a51ffc7c36cb5bd94874378b7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

