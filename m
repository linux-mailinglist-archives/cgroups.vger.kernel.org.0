Return-Path: <cgroups+bounces-8155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2171AB4A2F
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 05:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954DD1B42B2C
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5C1E0083;
	Tue, 13 May 2025 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+A4/dZw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE223D529;
	Tue, 13 May 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107168; cv=none; b=S286qm5wHzquaJC7M+LOD2zlmBEte8DFCtzxkz4E3r1uGWPtmne+Ncq/j8N5VZZklOljTk6chkL0RfmpEm0zGdg6+73+QXBD+pRoYO/D3s9GQ0NoPmlaGqfATeaSv3NANuO2Y9h/9m+oNuKqrjY8yuoSNkJeTdSDdL0TP0OS5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107168; c=relaxed/simple;
	bh=4ZpuRm/rWnIt8cBt9aMZCGpXNxBNEUvJFCjUueodcS0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lwMi9gWULsgmLN9CbC6XeDnAJzEnsNkUDguETpOTRccLV/rxE71ZChXt9uBFhyoRm+obdLINMCGfCOCIbWqUIB5P8xZxSQfUaEZwxo65hoYRnjFdxNkPMCL27Eq+3bKWLNb6QNJFoimBzdLefUjNjbSX+Tux/XatDcedL0Rd0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+A4/dZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6CC4CEE7;
	Tue, 13 May 2025 03:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747107167;
	bh=4ZpuRm/rWnIt8cBt9aMZCGpXNxBNEUvJFCjUueodcS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W+A4/dZwtj3v6qjYKfPdK6tZ/uQXTWC4zYh9Hxz484m59dMmB4ATcxIJ2HVhOi420
	 iqa87eFlqAEwbFaT9KFj7CtyIvYe2qFRXnEqrpAI4St0Bul11rDNQxtwCYj3IcF3BC
	 83EXmqAR7dcB09DpklydJ4urW8Rhd/A1U1KONgRilGF12OTb78InTNBPCc17hCq7fy
	 k/E317XkVLYu1SfOH/S/6SnwmeQ46kNd509RzTemwLOyfbqNt/1I+OgByBg7l95KO7
	 W5lMNzT0GV8a+hLr37n0bNhfhw/F8fQXsZO9dyBwSenwNuozTMzptmUiOHPmNWEHkE
	 Srgk3NGlnXKsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBAE39D6541;
	Tue, 13 May 2025 03:33:26 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: A fix for v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aCKV6jvb5Cej5wlF@slm.duckdns.org>
References: <aCKV6jvb5Cej5wlF@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aCKV6jvb5Cej5wlF@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc6-fixes
X-PR-Tracked-Commit-Id: 39b5ef791d109dd54c7c2e6e87933edfcc0ad1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d471045e757e941ca802bca3147aab45bf770754
Message-Id: <174710720517.1163096.1522779546894472787.pr-tracker-bot@kernel.org>
Date: Tue, 13 May 2025 03:33:25 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 May 2025 14:44:26 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d471045e757e941ca802bca3147aab45bf770754

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

