Return-Path: <cgroups+bounces-10218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39B3B81C68
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BEC585D31
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7D27B51C;
	Wed, 17 Sep 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2d3n8pt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F334BA33;
	Wed, 17 Sep 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141170; cv=none; b=AOJ5xR6iQTjLkn0HaYX9TXHd3b2K+4019M6yHDsoBSOYUNOThz0Q+8xo/VBjRImVZNZQhGp760/XdpMufT3PGMP75ozmzrG4BjWjLVB3Z+7EDOcMlqKCGfpPkAebxybaJ3hAbxpSyKfs92vT1p/qIp9HXiGbSomiWlcE7bRli3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141170; c=relaxed/simple;
	bh=jogoAxLjuiVu1cDUGn4S6mnABNdIp542FkoD9yzvkz4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f962xAXMpRTLsl+On+6F7avOGdWv6H/oKc3xMty4AH1VjPXhuMEpfgJ7eZDcXxi4nyUadBVB/AzKGaZLXJ/ZywGH5/efOQjNsDLnLOUBMeJTIaRimGwBKukb+ixwrQ3YZHInsMkG8odejEa6ZU4XwlG8xbTicwPsvtNdHj11rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2d3n8pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D7CC4CEE7;
	Wed, 17 Sep 2025 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758141170;
	bh=jogoAxLjuiVu1cDUGn4S6mnABNdIp542FkoD9yzvkz4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K2d3n8ptPH2kxJugKhnquQcDtG0VyF/q5nYIJ5fTeLc4OZQ4fwsmoEKaxKBoVKzCw
	 VvLG26wHdAlXEpFTw2qir8DTO1JOm+837iKo9ZVid2ycFGK21QkTzHeGIbpGwgNx+D
	 KGBHijPlXKmifwCyN6FVxXbrxRX+K8ASNywha6Gbkn7hd1KUavgfA8sC/FlZmXw8T2
	 WjA/ATVCNwiMh0lvbWR/6pdHQpR3UADcs/YSdfoEZQFPj0+wLH3hiqXjZtgMjycXtl
	 SATJaqkJ8B0cZnFAKeHjPT/ia6eS9iGlKh33znCw8TtTwOTz6TrLKXofPAONqnN5C+
	 jMpZEPcddi0XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05039D0C20;
	Wed, 17 Sep 2025 20:32:51 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMsJ1J994GFBkKt7@slm.duckdns.org>
References: <aMsJ1J994GFBkKt7@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMsJ1J994GFBkKt7@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc6-fixes
X-PR-Tracked-Commit-Id: 94a4acfec14615e971eb2c9e1fa6c992c85ff6c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05950213a9717dc8d83ba90538a87b7a9e140ff8
Message-Id: <175814117046.2137494.3569320578620932712.pr-tracker-bot@kernel.org>
Date: Wed, 17 Sep 2025 20:32:50 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Sep 2025 09:19:48 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05950213a9717dc8d83ba90538a87b7a9e140ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

