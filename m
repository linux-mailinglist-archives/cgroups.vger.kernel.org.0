Return-Path: <cgroups+bounces-8367-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAFAC60A7
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 06:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A86D16CBAA
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4A1EB1AF;
	Wed, 28 May 2025 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/CkAzM7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB51EA7CC;
	Wed, 28 May 2025 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405914; cv=none; b=PVINvpdsK/XtkIWMh+KfLjOXc68uAvZvr6oYIvcuk6+IIkmlW3CPKFw7iI1EeUjYZiUA2RxPnYStgSfLge5MShA65F0ZxAiRA96y/+7hnjAiWXa8RjSu9U/BBcZ0Or+KIPZ3luZPJs4eQdsn8CI4RNiwA3XlOi3GuXpA8sIfP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405914; c=relaxed/simple;
	bh=oW0RYhWnxaOCSNpS2aKraFApUd2lBlH2hn2IXxAZHf0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EMCT1LKb1TIr0/oYFffb3fZoB9ZLZkHVVfsTw8WKdZvctCQt0eMROkKOtQZd31Xlw3AIf8LP4kbI4WG65kuY8YVhYr8ocIjr4d3BujfYPtgIQL2PkdEWdrGszqVicIa+dWxl8xPNRoGR7cQ2ih+LyLAWCwL/QQDz3H/B/Uub12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/CkAzM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E44C4CEF0;
	Wed, 28 May 2025 04:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748405913;
	bh=oW0RYhWnxaOCSNpS2aKraFApUd2lBlH2hn2IXxAZHf0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R/CkAzM7n7oUp7HqxblT+F7eIjg3YMLuo6evPJUPH55Jx6gfAJ5VZbf3ANqWFIV8+
	 5+7mwhgq3AXmVpOgdVHU/zPP9oHL5hnSkhKFYQ2o9Yf25zSlW+BeoasqCoRRRVoSFk
	 7X2goYA0inAreNH9VgXVEagvSrUTde9RJxgoZehFeMsu2jJ4M5Vv3yn6vGjeLA1LKe
	 gv9qvKixy96NX2LOGapd51RysIrVAtI5KEL3h4GNUqk+i3GM33RCFs1iWZm0txW2nb
	 LUJt1SZa9T9byV28Hei767WTpnH1eAQ/h1onSWEtL69lWCn8TxjSJb0REmUkiPL0w1
	 7vm0F7Z047jwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3EEEE3822D1A;
	Wed, 28 May 2025 04:19:09 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDYVvLimkaLAtdiV@slm.duckdns.org>
References: <aDYVvLimkaLAtdiV@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDYVvLimkaLAtdiV@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.16
X-PR-Tracked-Commit-Id: 82648b8b2ae0a0ff371e2a98133844658cfaae9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b66e6b3c098646f75c54e269dd963e2281c555c
Message-Id: <174840594813.1893196.14058895567465804911.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 04:19:08 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 09:42:52 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b66e6b3c098646f75c54e269dd963e2281c555c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

