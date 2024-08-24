Return-Path: <cgroups+bounces-4436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41E95DAB9
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 04:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA571C210E1
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 02:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BC2A1CA;
	Sat, 24 Aug 2024 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKw/yB7J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BD28DD1;
	Sat, 24 Aug 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467608; cv=none; b=YV3R6rryFwDFD+YuVI+wsS2yxBccJZ12gJelhqv8a7pppqGwtvEPcHub2hBKZzM2Vdb2JEKf3j0EQVLG92JZ34Fjuy5xDZWLB6OUkRE6msJ8k5sdx2xGzUmQcvW/VLZSIvpMoz/IRSQgLihaQoyXJx+IE6SVbrHQQ8xVqCcAJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467608; c=relaxed/simple;
	bh=2HsgaGYvBjPRBocM9y+CMBsg4KXVx6kMYAvog66ed8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=chbVaKh2s/XXsgsAyDhQwgbpsZcy3PIQGt5RXGycu+dytP2kLTgwth48z4oH/AADta5D61E4r8cfFaQLHh0eFoEeEaAfnb830wU12k6AojZ7M8lZcb9qQP45H4vVjXH79oMg+TVUBgkOiBGT2Y/PtJOFbZBbLsPhTvUy7+gtRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKw/yB7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A746CC4AF0E;
	Sat, 24 Aug 2024 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724467607;
	bh=2HsgaGYvBjPRBocM9y+CMBsg4KXVx6kMYAvog66ed8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BKw/yB7JOiHtyU4CubRn4sF3LHfsE2mKDmhiJiRzrL2BGXHIHipHpQK6kPRBey/+8
	 m5cvPNQ9CROsItyT1yAhxzVgQgUXHI/x/5bml3AO+A3ZIwPQ6oEXo35ll3a79VR2ku
	 TTlxqM8xKdDQBBEq6ncz1dMNKSEXfcsjdNKahf3mlLlDDEQiAOodN9s2mvUBlBB+t7
	 EPWvO3i+2abRluAE+iseXDNMbRMUCCTagkJwFXBIk6Nkxw9wCrHv2Zlw9UEBC82ul6
	 UVF1Db5NZgduBDOQUAN2vYL9hbH+cpHEae0ftDkFWuUDXwtINAhVSs4pdw6DVBEEFL
	 TDeQmTjzl0Flg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00139EF647;
	Sat, 24 Aug 2024 02:46:48 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZskwI2nciPwdwNeA@slm.duckdns.org>
References: <ZskwI2nciPwdwNeA@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZskwI2nciPwdwNeA@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11-rc4-fixes
X-PR-Tracked-Commit-Id: ff0ce721ec213499ec5a532041fb3a1db2dc5ecb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2bafcf224f3911b183113b2fcb536c9e90684a3
Message-Id: <172446760738.3138696.11131416151755088613.pr-tracker-bot@kernel.org>
Date: Sat, 24 Aug 2024 02:46:47 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 14:58:11 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2bafcf224f3911b183113b2fcb536c9e90684a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

