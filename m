Return-Path: <cgroups+bounces-4903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662697B901
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AAA2814B8
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3917A586;
	Wed, 18 Sep 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOQ+QhLX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43F176AAA;
	Wed, 18 Sep 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647004; cv=none; b=A/JwHMEmcLqQjMjzTzggTKXQv1JIXLefWlDZDiWhD/IDDqNtkgYlVReztCJJtPIUFxMAQAS5IqBzVbAmIjlce9hZcsjPOYmb0m/9hQ7qmlSL03l9GorooqneXrr7cHUz+dQQ8isph+xgg8W6lWGxDIzYURqputB6fFb8UrSgMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647004; c=relaxed/simple;
	bh=Jqmk4ZvNkBfSW5OguoBnesTatLc/EdomM4uS56IpsoY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TjxhYsh3sRKx/vOINrI5vksGfQwx54vMXVadhmIi4YVypOlj04yegB6wOSDeKZxu0CjOpDATKZphhhITWINEWbf3hgKXrwnMGBp2CWM+0iybgVdyO0wu55xjFqYpOIa/Y328rubmxLPkfHhTHkvdXoJFsNy6HrvOALUHV8Y5/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOQ+QhLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC965C4CEC3;
	Wed, 18 Sep 2024 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647004;
	bh=Jqmk4ZvNkBfSW5OguoBnesTatLc/EdomM4uS56IpsoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DOQ+QhLXB3S+88eVIv4K21uHz8ewvr5NTJ2faXBMISEwiNj2KzMMirNDxatvMegSb
	 bii70Mgzv4qIak7pofL5rE0GoprfGnRQmtULkoEAmPaLWK6qeo6OuT94NrLrW3Luvy
	 Ax5SzOLHiTyAQzIje+c94jYKeJsikUJYj8HExNYmXEZqzt5HusSybrSa0YqY96NSz4
	 hrXr7+7CR+r6z/ifw35IEesrHQxGAi0HmBwNJpQI96aeSbsOw18fCuwIFGK85q9l0O
	 FaTG2FFrCsYYc4ZmxNP2cu4yWQF+YLx7wljr60dmfTEgWP3GNlqPXABL7LnFA7mUie
	 B/2uDhgtb1i1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBDF3806655;
	Wed, 18 Sep 2024 08:10:07 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuNVf1ocpQi03lkf@slm.duckdns.org>
References: <ZuNVf1ocpQi03lkf@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuNVf1ocpQi03lkf@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12
X-PR-Tracked-Commit-Id: af000ce85293b8e608f696f0c6c280bc3a75887f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78567e2bc723b444228644d2e34ae5255d4ab8a0
Message-Id: <172664700657.684502.763317521130186395.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:06 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 10:56:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78567e2bc723b444228644d2e34ae5255d4ab8a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

