Return-Path: <cgroups+bounces-2026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C187896E
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B473282194
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81857861;
	Mon, 11 Mar 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwheS22K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781957329;
	Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188770; cv=none; b=d71uaY0poMNBhjWQacTVOGUitXBXBnfJZA53LbXQ8sxmELqKHNLFlY1WftgWHBztaI1nPKoEEvyemOA21OGe6POd37lXXgFeUDuLdQHE4VBPqYRisu6YNM1UfHF1McXSrQ4l+8Tm1CaY/sZHSHjklqbraI0BVwwlYpKk+Zb5St4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188770; c=relaxed/simple;
	bh=PAeoA6SXSAVQ0jAnR2sgwtsZbAEvuYYXicyV5Er6pDc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UA+o/GIoRmB4Q6almNd5eF5P5xVLlx8KhvmJK0QlAs4D+XgPL14dOrh13jzTmRoh8w2h+2wK6NigncAdPrDowzXBKfCR6xTxX4qibYWkTe+cNT4BzhBPJJ5Y1zSzhTGWCerWXeY1hk+aSWYudhcO6ihHLHh/X84wRhZ5VO9a6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwheS22K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AB03C433A6;
	Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710188770;
	bh=PAeoA6SXSAVQ0jAnR2sgwtsZbAEvuYYXicyV5Er6pDc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RwheS22KoEADbxCJsX7PUTfy3xqN6y1BooYxrSdNRacvZUQNag/Wacou8EOOLSLn9
	 ASEVuDT7gpVcNUma+TvdqQlfJkz67ybNDwLO1ZYutC/UHUdpRjsdunZDWVUdS+tTWe
	 1o9HBGo64RLzjAm51yTk5u/eGeFLIF/r6aEluMt3abRO2cvY3PPM6np4pk+6TD5qfv
	 /Shzso7Xs3y3aMUaIlib3+aeZur5yuWE+Fzd3X8XTMAXPb7v+pfPpV4PGsBIcUyt0U
	 8V+5zNDEVrEVl0UW6Hfa/AywM1fFyENiZFYIaZ2lYkisy5hGU1bxVGW8PqUvB1Q5c7
	 A9NoeJa08Bk7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1547FD95057;
	Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze7MzJUQZG41zx1w@slm.duckdns.org>
References: <Ze7MzJUQZG41zx1w@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze7MzJUQZG41zx1w@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.9
X-PR-Tracked-Commit-Id: 3ab67a9ce82ff22447b1dad53b49a91d1abbf1ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 045395d86acd02062b067bd325d4880391f2ce02
Message-Id: <171018877008.21519.14926090079138053875.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 20:26:10 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 23:20:12 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/045395d86acd02062b067bd325d4880391f2ce02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

