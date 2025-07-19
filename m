Return-Path: <cgroups+bounces-8786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180FB0B153
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E6AA7017
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E242877E6;
	Sat, 19 Jul 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+AR5dBN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23623D2A9;
	Sat, 19 Jul 2025 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949736; cv=none; b=lI1bSikt2b/mGRmjBBfyyISgbCbF85KQLmZGI6ut1HxlcC3PbUagJNQp1LXJAkay2PxI0Xkb3XixSrYOKlEnSxB+RthB5TCJyBP1X8QBqqsK0b2To+4xbmfhs9vo+PJ2Xzb4FswmpS+se8X6THjOn7YHtS0wVxnLD5S3GfcN5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949736; c=relaxed/simple;
	bh=NJWuiS90uBmLpL+bjO4Mxxde2+xTqEZoCmUyZDsSsXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DLjIycdX7km2uaF4+hos4U2Bgo7bcINJ8hD6EeUqU5uajQVdc1NbKiemMgRoqWGi+CtsNhWU/WCSz9jFlNeSor4qQ8NDmgP6jZk2E/mmfy4RVA/1F0PzXLr50s+3JqlHSkSfPsFEt1WfttbLCNS85eRg0aJZZmm27W9TEq0npfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+AR5dBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF76C4CEE3;
	Sat, 19 Jul 2025 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949735;
	bh=NJWuiS90uBmLpL+bjO4Mxxde2+xTqEZoCmUyZDsSsXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c+AR5dBNHiPk4jDM9LMetGzHLl70ZRLYsyckRQHx6qfTZhMPiYP9EeDbuZC2mTifK
	 V9Wt0Dg5s+ombII5pUDyl/eaYXNWyjByAvkl3YzIArxl6iMTVYFAwYhAoKk6xoFk00
	 VO5NJzGfV1ismZdC9nQdmJq89AvvyqYHxEMeSLLTMiM7/HFQHYZ4cpBHla05qcMtVH
	 8AlyjDbVM2cKEVFTTyTYQ9yH+FIexV1SNDn8nwZbG5Jq+oELPOcFK+fvFLFdSkQg0o
	 gddbZQtyBUW/ku08WkTwswV0zjVGGMPXjWzPIW95TgkZXZfSyaVDOnV0rhkvYNDKk0
	 dPSI5BCKUWQsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA4383BAC1;
	Sat, 19 Jul 2025 18:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHvNRxda7ZvBTEOD@slm.duckdns.org>
References: <aHvNRxda7ZvBTEOD@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHvNRxda7ZvBTEOD@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc6-fixes
X-PR-Tracked-Commit-Id: 14a67b42cb6f3ab66f41603c062c5056d32ea7dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c64004df8914cf5cf4455d9e78d8f371d0f7322f
Message-Id: <175294975471.3026904.6471674596068355524.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 18:29:14 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Jul 2025 06:52:23 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c64004df8914cf5cf4455d9e78d8f371d0f7322f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

