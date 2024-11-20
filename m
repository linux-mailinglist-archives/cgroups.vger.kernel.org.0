Return-Path: <cgroups+bounces-5658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90579D420E
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45254B25232
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2CC1C3052;
	Wed, 20 Nov 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzfU4OSO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD21C3036;
	Wed, 20 Nov 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127518; cv=none; b=ic3ifX/Y0vCCbJrVdeKbjl81+TNoUHOqD5LRLSXTokFJ1wHlaK+BzWqRK5XhayYnyKKqlP/k55j5F28feBV8bzXhXGa5iLSWi2622sf9Ncy5EMhut5jgX4/aHRzHBt6fWGNdJaumavon/mo7nkzitBueignJU7Qns+nE1niPlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127518; c=relaxed/simple;
	bh=wiQHWUVRnWWWNnYvUe3pNE9QqWhHWDv/nYqlujf7RTI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MGycC4aLauT0nWoekQT21Ppkdl1PdkcQNwK1kU3qfUFRW2IH9ZXZe/LxQm+tx+xKW0GfY84iSECHS4NBgYPeIqJWJbhROOJzf+JIBylDdoh7pQuePjRHOM8bI1tJbUolpl2/Za/BtLP2tEO4MGaKEvYRxt3ZXL8tPEMoihnP6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzfU4OSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A3FC4CECD;
	Wed, 20 Nov 2024 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127518;
	bh=wiQHWUVRnWWWNnYvUe3pNE9QqWhHWDv/nYqlujf7RTI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KzfU4OSOtOTv37ZsolzUVM5aGC8SEpPW74kj1c9LqdSb1FwUwwG8hFA/8JeewCIU+
	 M8r22Y+/8jrt6RBzuraH8JBkAa91X6vQLhacgsUl7mtOJD25hihM5e45Nvh6cc+34G
	 stLGJEq+S2O0OhrJm11koX8bAUkNYORKfRP70Na5V5dhv8bt6XslgXOsSw3Sk1TPQo
	 qvP1ufv5tm7pg0cMTLjX+p5DbbwYjrYoPSyq9fQdepnhCXp+CVjDehqjA6zbhyE+FX
	 eb+M5D2v2zFoe2vwq3q/cs8hq+ouTEuneOWEqFZoaGhQy1l7aguYB84PdkYbSmyHBF
	 xfx1b0GUSq9hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD103809A80;
	Wed, 20 Nov 2024 18:32:11 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZztmA9FyfqLtPy47@slm.duckdns.org>
References: <ZztmA9FyfqLtPy47@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZztmA9FyfqLtPy47@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13
X-PR-Tracked-Commit-Id: fbfbf86685b3270dc27d1c5d6108532334aaf329
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7586d5276515a54656bc46530b32e10913c44b1f
Message-Id: <173212753034.1310468.13429092980593562929.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:32:10 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 06:06:27 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7586d5276515a54656bc46530b32e10913c44b1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

