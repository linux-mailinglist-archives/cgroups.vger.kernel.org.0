Return-Path: <cgroups+bounces-8597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4080ADF8C6
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE24179868
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15027E04D;
	Wed, 18 Jun 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L63G+LRY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0627E042;
	Wed, 18 Jun 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282306; cv=none; b=bbBalL+c41eXGfOwUmQUBWYNXHLjyNGE8avj0GSnYh0DbgUn/s0JOFTKWwKfvhWTgNKbZ/KxAK5iRqsj2TQvHMY+ebFwU0DZmqfm62MQUOXQJkPVimK9NBq5TeT0FweFa+LdBN23AI5DDvlQU7N2+rwjVjC5s99TQCYZaQ6Nub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282306; c=relaxed/simple;
	bh=YIq6nn8IpX1gTotZYiCJ5sCA83tSSc51ZXk1kxhEVk0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=siT3yT13KkqLoeQJidBSdQxAbGbi692zioyOzMmwMpZ/SCa7GA67kUrL5KNnSdBR2Qk5zvI4hauEduW+N1rX99rYwAnNcQGANLJO53G223v3iLvSVmibL2pq8AD/pcAbXTwzBCTsO6Sa73v4okdcnohIWrTMx1RHKHdpQj6Pl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L63G+LRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B1EC4CEE7;
	Wed, 18 Jun 2025 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282306;
	bh=YIq6nn8IpX1gTotZYiCJ5sCA83tSSc51ZXk1kxhEVk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L63G+LRYwzeEmu5l/g6ASSW93BzJi1+yz5plSMdqSV451V76+ZQV40j6/bUstg1e8
	 /rt9lPN0yWPbFc9XfuDDClkXw6AFRZrVBtWOIOPio1E0EC3+se+34R2RikfD6s2vlb
	 RPlgn3szH8fmpimo9is1gtf8Ysg5wqXTMEcO1AE3kX/ObrpjyRgA/gas7Xc3GZMAtp
	 +5viQOR7fqVWyHzTE8jlrUUP8CXoenaevqi+sv5FU8oix2Pkmmpo8C3PYe739G3je5
	 81utNzH87I3Szg1Q12wU1xi/8fiXBmmWWFP8QOIcogWmuQrpdxfttAzENu1GtapRDZ
	 qbRmm+w1lyoTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAB3806649;
	Wed, 18 Jun 2025 21:32:15 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: A fix for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aFMgOa1knyr5LM83@slm.duckdns.org>
References: <aFMgOa1knyr5LM83@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aFMgOa1knyr5LM83@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc2-fixes
X-PR-Tracked-Commit-Id: 37fb58a7273726e59f9429c89ade5116083a213d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19
Message-Id: <175028233447.264355.7072059031767126439.pr-tracker-bot@kernel.org>
Date: Wed, 18 Jun 2025 21:32:14 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Jun 2025 10:23:21 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

