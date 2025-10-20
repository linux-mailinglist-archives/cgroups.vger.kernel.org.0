Return-Path: <cgroups+bounces-10903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9CBF34F8
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 22:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B1E5401D7
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B286332913;
	Mon, 20 Oct 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2AKGonu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31A32ED58;
	Mon, 20 Oct 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990349; cv=none; b=JDX8Axt32m8EG7jKHc1CXob68fE/YYN+7T+T5wC98oR3l6/eu3Kpwm2yCLuwvFoifP1PbPkO+4VYG1GV14PTHDg0qHr/Wd59M43LN2RjzmOC1W19NhknQ1/82aqVft+4+sXVRom4kamzhKr+vpNNgAEzwCmwRXgx5aqGZAfzlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990349; c=relaxed/simple;
	bh=TMptTs8P8menOA8W9P589h7yU5mbbCM1dsB497Lxw/c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l0+z6GSLJmfN4EmhfQ1te7ei/BhnxRHYF7R/HVtTzEbYN0eUuhMErqGmir5snCfYi7VR/QJ2nUGhj9IhMANo1oSGvjYvigsJewjHpoiwEXBxhzWcEOdbc+I1V8INHj1QfL7YuteaAMCLu3tBKveYypcJdvpbbDwjvLZZsdlvRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2AKGonu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD51FC113D0;
	Mon, 20 Oct 2025 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990348;
	bh=TMptTs8P8menOA8W9P589h7yU5mbbCM1dsB497Lxw/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S2AKGonuzr03OdDfaUnfv+8peR+lRseXLJqC9a/kgDX2FfDVEqoLQL+ZcBBKOf9Q0
	 w0gsc8usFxyHJ/GFNTJzCAv5/te6N65Xe0NngwruIcvbKDVfIDdMJWjrm8QbvoWpKl
	 Np7tWvFiEnY1ZsdLjJXT1OyNmim58NlcCeXRp0ZmusYn5+Uoft9Hr5rgfNXLReBPk0
	 OwsDnxXYmoN6AwnTv5GEDyXvvEj/QRexf+CSWNJ94BzOvJJjG5wJgjjODIZqPSxY6O
	 uyyoNuofjFTXFwiuTUMYGrdNB9pO1jdit0YPzyDEnvrerHd1D9Xl6uB/vZKDqOhNQW
	 fGlUlNvgPtrpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB12E3A4101D;
	Mon, 20 Oct 2025 19:58:51 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ca8c62e00bea051b0bd3bf682155428f@kernel.org>
References: <ca8c62e00bea051b0bd3bf682155428f@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ca8c62e00bea051b0bd3bf682155428f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18-rc2-fixes
X-PR-Tracked-Commit-Id: 0fbbcab7f9082cdc233da5e5e353f69830f11956
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6548d364a3e850326831799d7e3ea2d7bb97ba08
Message-Id: <176099033050.389793.15857252629002654389.pr-tracker-bot@kernel.org>
Date: Mon, 20 Oct 2025 19:58:50 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Oct 2025 08:15:54 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.18-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6548d364a3e850326831799d7e3ea2d7bb97ba08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

