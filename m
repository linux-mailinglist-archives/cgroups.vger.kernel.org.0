Return-Path: <cgroups+bounces-12790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55620CE6036
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB7630062E8
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 06:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38329ACD8;
	Mon, 29 Dec 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Seitz9Vd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25F1A267;
	Mon, 29 Dec 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766989100; cv=none; b=R2Ru+H90xi0LAh2YoxYC0hqC0Gyaf26CgsjBiQPKmwMD3c68aZesNQypTxvhBHogxX2ad4/yTmxZmHgwVgShuHJce01RZmY19wZbJp1lk9n6YM5NPe/eHkkjGHgkrNpPM+H11e8xMzzJRa9qR2yjOoSDR3z81XeG72kxAcfupZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766989100; c=relaxed/simple;
	bh=Qc6Ku8q5OBAXrQfMZyFSHU+dDw7RgB77d3SHtORIwcs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u7LPoVJtzhWzYTLeddSGGHo8ys94mowc0Go9B3/gi5HM1ONLVwYiWpfsXycUcBg6UNqrd0zJeEXnra4qpVnx1vHRpbZErmdR/3U65aXLFXPpGXBUjjfYgcmFJtghMbPuIr0QZliHQVZ/oNsNcLIoIzJjFFHUX3AJfpWumJ0Z1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Seitz9Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B2BC4CEF7;
	Mon, 29 Dec 2025 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766989099;
	bh=Qc6Ku8q5OBAXrQfMZyFSHU+dDw7RgB77d3SHtORIwcs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Seitz9VdjoJNRT0kzcMs1uRMf9Pqfc1b2XPjhe6ceJHwiJG5U9s14h3d1ioe5q8zD
	 CcnjeiYeopp7dsAqyAOHnDqza5ZrkmAb44gBN7KIb5hoIOurRTrcsFC3izbALfcJdo
	 Fu1ZIDRKjiOwhEbtGhU5wfLU87nmUJWtpsiB8JupXyDsaEZ3KnOeEKBJzrhzqekmuT
	 i2lPdRE8iA+5OiRuK8pY+13N4w75TQZS5vXZcrZOATKAg7ssFo7xswoEgRP6eMTWRL
	 zDb5TmgKPbZDCzlur1zD1hVVVxs2SX6wUWuExWPrdt0DhkwyxdJxNeh733Mx39Zhra
	 JCHYxDYtvp7Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B053808200;
	Mon, 29 Dec 2025 06:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ad89f5a3271616fd4effa3fe5f465e26@kernel.org>
References: <ad89f5a3271616fd4effa3fe5f465e26@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad89f5a3271616fd4effa3fe5f465e26@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc3-fixes
X-PR-Tracked-Commit-Id: aa7d3a56a20f07978d9f401e13637a6479b13bd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bba0b6a1c4006f8cf8736c1eafc62640b31c498b
Message-Id: <176698890214.2860963.9331312300173414790.pr-tracker-bot@kernel.org>
Date: Mon, 29 Dec 2025 06:15:02 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Dec 2025 14:39:59 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bba0b6a1c4006f8cf8736c1eafc62640b31c498b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

