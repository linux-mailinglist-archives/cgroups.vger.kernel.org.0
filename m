Return-Path: <cgroups+bounces-7438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12703A81614
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 21:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052447AE3CC
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032024BBFA;
	Tue,  8 Apr 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwlmSXRf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130024A041;
	Tue,  8 Apr 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142058; cv=none; b=GtNLOC4xoAUxjhc9M35+P10FAHclharnYTAYHYX6qn3ByLH/lvVnNTcxulgqnTAosbs/yFFQy0rd0ujFUYhwM0/TVCRX2WiWItEqsYBYvgDGqEOKK90IOyW/sBEknSndhGAm+fH5UgKsv5IBcWhv5/kMsAO+zIA8Ws3/6ddAMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142058; c=relaxed/simple;
	bh=1mJ98AU+NjsMD9mknSCZto0kcvitYEXFlgjDRnplfEA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UcTK6ua1ZCTI0nxF9vmca6M94wtLuVYxUjLlryQHdwtBBDPtZ0xSDJdOoZvXb71VeRFosyth7AgvvZ0BkQJkq6/WOXL8BatPyip3VAum2Mlt3Sbso7/EcJfLFmJWndwR9Izk+bONBezBNn1/FjT0/rF/gWCRq5Gf1YCxdJjhecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwlmSXRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468D4C4CEE9;
	Tue,  8 Apr 2025 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142058;
	bh=1mJ98AU+NjsMD9mknSCZto0kcvitYEXFlgjDRnplfEA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EwlmSXRfxMmu8Z+dA8XKOicyhOxI8mcst3r5aBMO9xm0RC6B7nus/Bq1J56GLAq6j
	 HW6AYgWkv8+qDdI3n3HICTNbwnjYE4h9drcnMuWJDkKKn3tKeEaBZzBaOqpZfhRepz
	 1+TxbQVdfZe9Pkql2lh4Cqrdfwl6p5k7QZBz57c1ZzlOgSTJjwUfmkbgOJ4GzMkDQ4
	 Gb2cmQmU3Wj+Z8brMx+1xFIOskpyBdTX+fUzXniaLQATysTVxUr9RW3LlOMmUkkrGu
	 x590JpSx2ii/dIwdSt6XHCtH2BfDI83Qu5SfqY+rlac96BQRbCx3Yd538EttcHePtT
	 LECIqzN9R0WFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6238111D4;
	Tue,  8 Apr 2025 19:54:56 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z_QMp_w1wVoU5A2w@slm.duckdns.org>
References: <Z_QMp_w1wVoU5A2w@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z_QMp_w1wVoU5A2w@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc1-fixes
X-PR-Tracked-Commit-Id: a22b3d54de94f82ca057cc2ebf9496fa91ebf698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e37f72b3b417ed793cf23a523a4d96d42c9824e5
Message-Id: <174414209538.2111430.1875095133250150202.pr-tracker-bot@kernel.org>
Date: Tue, 08 Apr 2025 19:54:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 7 Apr 2025 07:34:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e37f72b3b417ed793cf23a523a4d96d42c9824e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

