Return-Path: <cgroups+bounces-2923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7D8C6FB4
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 02:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C506DB23071
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CFEDE;
	Thu, 16 May 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr++ZeRB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D31C14;
	Thu, 16 May 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821000; cv=none; b=nrwOXG+mdSCYm9GBCkHxk+72g3Gs+ws1DmhoxAr4o0SZijazIqoYdS2GoqB90OtoCalgYbhrxFQwHQXIun9tBQEETMQaBHi7WYwDvpps/COkHsF4KBp/xyz6rQBh/QiGdlmSMJqUeMPFOXeHeU+VlTG4I/XA9vT2Agwwm5UeOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821000; c=relaxed/simple;
	bh=pP7cTyUJ71kXCxqkipKEkmeaoyi4wNqBI3uhN6leh6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tkxtaHxfiYbnUucfaQhf9VksIaX0p/z1ejB3Q/pb05g3AzcTn2GZQTMZvVN/kk2pNLzEMqRizNH73zGqMaOZs+zKrHmpNCTYjjfNHz87vSBKLnR24V3F9ItnCruayazJYn8lhm6cI6T4IzZaFta7ICfQwdSkRLKRFj+I67rnNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr++ZeRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDAA5C4AF08;
	Thu, 16 May 2024 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715820999;
	bh=pP7cTyUJ71kXCxqkipKEkmeaoyi4wNqBI3uhN6leh6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mr++ZeRB1o94EWCyuApJX7BoMTT5cVr0AIZZ0Pq8oNctWUA8tGlAxB9rkA6spc5zz
	 wqradaQK7UlIo+u66DPH2awbbsWFjneHPs72cFniqqlis1g4I0xPE02t7EYd//k/yk
	 adBlTg3avN266/sLAQ28ie80jZ6opm35qRBSJv1+nd6r4UrRCY0kR6HjCXVVGhlJnO
	 hU2/48tprUQrw0+oYZOFeIuIbH+P8NaQMjBFyqPLu319t84BNfEzF/ejGUgvE30viW
	 m+ueAHDAFa8O77Vgbgbr5L9VF5nkp4jG91eTD1VVTHkG1oB/P8dESzg/P8ijc9pq7k
	 lBgN7jvhVm9TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B673DC43332;
	Thu, 16 May 2024 00:56:39 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkUrofC2xdDndwxO@slm.duckdns.org>
References: <ZkUrofC2xdDndwxO@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkUrofC2xdDndwxO@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.10
X-PR-Tracked-Commit-Id: 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de6fef50eaf40789b11841474726fd918a3a84a1
Message-Id: <171582099974.27993.15098603607536877487.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 00:56:39 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 11:39:45 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de6fef50eaf40789b11841474726fd918a3a84a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

