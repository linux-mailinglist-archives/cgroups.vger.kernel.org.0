Return-Path: <cgroups+bounces-13313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA10D3AAE6
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 14:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F18D3000DF1
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E3364E93;
	Mon, 19 Jan 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDaOs737"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B892D978A;
	Mon, 19 Jan 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831046; cv=none; b=kdKdVtJzE8UcYaNajerQSZfKcCvjo2+2K6jux/uCEtB/Di1Vh2q5aStCWlvM3dsJ+rbIzyoMBI1xRAT+7gmS6GZnofaHyrPxAHh2eMsBFFCypn9XXS/Nk7E+XI7LsrIrqAHLP7ZrlBiTbmmoVpBYLrQSFLj8DmUbM8BD6hCQwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831046; c=relaxed/simple;
	bh=rG/f+m0mp19ij/KhG4lMTMDN53cY+MgDy67TdR8vDY8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ded9qnkLIR9zIoD0v40mb4YpLjwt/Bmro4n/BcXSlwlHDuOryLqBCkrKn64BOg+ZPT+kJi4nmuKByt+7yAeQlPXzblKSW24XkeaH6xdVfL6VtmsPe8/B6D8ItN1UuDBcgkUR5T714Ykli+hiNC918JQ63n35CB5c6hwa3Ffx40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDaOs737; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5605C116C6;
	Mon, 19 Jan 2026 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831045;
	bh=rG/f+m0mp19ij/KhG4lMTMDN53cY+MgDy67TdR8vDY8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FDaOs737UdhvoIMpO/r+TwIOlSFCDAzA09aVsHkggzc01/QxjvGkIcc7ws9JhSosP
	 W+kfGCsHSS4qM8D6pyEfQr1iBJled3KZjSgOfXFZY46dhe4YGz60b14j1XZVVu3biR
	 LaCxoSlsx2/bACfcFDLWEwMnEiRxs+x7xkUV4Q4e786U7cjgSg78G608bKYoX6qS29
	 tR7UsTKG7Tv6oHVFHTPc/2v07F/7kjNUWngSviZTyegZ/TrBVMQVTEiiALNwoWh2Md
	 fW0ZvDIXqH6Wu4svFB0yCxewGyLKr07+xGwicHT+l2pV7ZmUIYCSTnAI8gT6FAirt+
	 fh2x0nwpGS1Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A5E3A54A38;
	Mon, 19 Jan 2026 13:53:56 +0000 (UTC)
Subject: Re: [GIT PULL] Another cgroup fix for v6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <2d1e28eab84b46584aa3a127ae1e974d@kernel.org>
References: <2d1e28eab84b46584aa3a127ae1e974d@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d1e28eab84b46584aa3a127ae1e974d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes-2
X-PR-Tracked-Commit-Id: 84697bf5532923f70ac99ea9784fab325c560df0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f32aa91612ae7e6a59f7ed228ce6274231a9332
Message-Id: <176883083535.1423140.14460361175798491563.pr-tracker-bot@kernel.org>
Date: Mon, 19 Jan 2026 13:53:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Jan 2026 07:12:14 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f32aa91612ae7e6a59f7ed228ce6274231a9332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

