Return-Path: <cgroups+bounces-7228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C2A6E7B7
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710EB1896940
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2048193086;
	Tue, 25 Mar 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtsnTbTh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102A191F95;
	Tue, 25 Mar 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863510; cv=none; b=ciw4FRjJxQrGRmWTaR0XxjI3CbnxC+tLs7REdAAFMquqNFBBOcmF1YolP514xRWq5ffvkC3CZ7r0lxBGnPA9cUHfpE8AT4Ne8HGvH0CTB5NqfWK/ypNRDZ+0ipQYWuoO9ZSDike7pn8leSTFqyeQ5QT1xJ9QlgUqAl9nSb6h3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863510; c=relaxed/simple;
	bh=UlTE/q/4QWPEUOCxpTgiTUqTheHvx8tTCY/lBQYmOZo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V5Yu4GiNkOdh8QS7qFCZGbHAINLbSUv7g6IoOYCoNbfYd1wsWqsreMoN7ovVu3YGZ7x7+eyxKd+WubQVAXiiV5kmb+DsbZ8AQT863jxKwlGEjAiS5C+OoIrfMwZEtVUUPuNTgP+8XWh1qdGerArwFUBENCvPgXxxtjeUIp/FbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtsnTbTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41115C4CEF1;
	Tue, 25 Mar 2025 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863510;
	bh=UlTE/q/4QWPEUOCxpTgiTUqTheHvx8tTCY/lBQYmOZo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PtsnTbThJUN+fAuP62ZZjso5w3r7P0ER7J03bscCgco40qgZX24rJAFmvCnEaOiit
	 IOxYsTHcnFWZ+XtSKqksc3m4ixjYCcSEMFJu4bHLHxZeF5pNu2kffot8JNrcVcK0nW
	 8gvMzg6P1VBBrAVOih2XT/Umjq18kQ8Mb+IAwCIazN1vBQT8ZfAA+kOo0cIpNwN/Y9
	 MxUtGtTRDhjkVWgS9cifUw2zGKTkwUqJdP9xogaLNRrzR6rB1BekeUDoKkFeVYQ8VF
	 57Rj1c4AytOLsZ9Z/Am3vD8fncu3CVv8TYIBiqVswdTL6AzwSVl8Yio+QVwxQ8pAJj
	 7dOvlq7522m+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC66380664F;
	Tue, 25 Mar 2025 00:45:47 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9xPK55yOmH4YUsk@slm.duckdns.org>
References: <Z9xPK55yOmH4YUsk@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9xPK55yOmH4YUsk@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15
X-PR-Tracked-Commit-Id: 093c8812de2d3436744fd10edab9bf816b94f833
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94dc216ad848ebee06ce7692fcfcbb2e9b3e643c
Message-Id: <174286354631.36585.17119973637664943071.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:46 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 07:23:55 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94dc216ad848ebee06ce7692fcfcbb2e9b3e643c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

