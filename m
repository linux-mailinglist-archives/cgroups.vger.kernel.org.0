Return-Path: <cgroups+bounces-7700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE25EA95C0C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 04:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A590177CAC
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F419ADA6;
	Tue, 22 Apr 2025 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppVKlXtl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60611362;
	Tue, 22 Apr 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288687; cv=none; b=iCaf99RzhT2ZoCQoOJA2p/REbDbVOzrVG8Gw3gdlp5GJStjgm5oFzySch2Ye70lWOxJzf1s31iB47nNBS9Ky15MLhWxez4O8a1NTrqWxud+cT9G/gNadNyDf5AzyEn2ZfpwKfyV1edC9Bi+A0CTPqizM/K+S97QHmqeNveAiaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288687; c=relaxed/simple;
	bh=Ry1XJAK3k4mJafgMvVJWTOurYenX/jtTAnejZmCF7hg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JPVTLt5CrKKc1zAfw/otoMF7y0lZPY3Vn8ADwVHvBYKLlqWxDa9M6YV86z1kpMCy+MAbm5vaspaZLHTQE2ZWE/asUyTHp1IR9ya8nRJ8006Q7zR2O5F/Ahc/Wm405FRoD6PenOidb2MTfwWVoUtKxDEy2/pe24infwY7KwjqiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppVKlXtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3CCC4CEE4;
	Tue, 22 Apr 2025 02:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288686;
	bh=Ry1XJAK3k4mJafgMvVJWTOurYenX/jtTAnejZmCF7hg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ppVKlXtlPjT+i+MY+UayfVGJQQwI66wxqKWhYUoqGR0aGckHxENcgaAAr5uG4Ktdg
	 leshnDQGNY5coONJ6/rPjSbhG1Ul34GNEWLIFr9yGDuoVcoAKvjVMQL1JzLavKjHjA
	 EFUEioDRt8AN4j7p9GdAWQFsENpeCG2awm1lIBknsRUtKdmL8TOJKJJ5jUakqIq5kY
	 c8adwaTtHtLUhxrh+krHIzEaMoy022WKn5TEvSD5e469skmh8cOrjTHS1mbGwZ+SC+
	 TPkiolfbbt5z9TFRJQXt3cldDz7JL2PrWwEjjpPbeUTX9x/nljJ4JIeF97XMhbbZen
	 dLLaxaTj6tASw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB33B39D60B4;
	Tue, 22 Apr 2025 02:25:25 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aAadRYdydJYibDwB@slm.duckdns.org>
References: <aAadRYdydJYibDwB@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aAadRYdydJYibDwB@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc3-fixes
X-PR-Tracked-Commit-Id: 1bf67c8fdbda21fadd564a12dbe2b13c1ea5eda7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a22509a4ee99e23c6bd8980b70dd78aade6baabd
Message-Id: <174528872451.1361490.1714454429094600612.pr-tracker-bot@kernel.org>
Date: Tue, 22 Apr 2025 02:25:24 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 21 Apr 2025 09:32:21 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a22509a4ee99e23c6bd8980b70dd78aade6baabd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

