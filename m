Return-Path: <cgroups+bounces-6558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9383A3662B
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3761730D9
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AB1C8619;
	Fri, 14 Feb 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzp4rsaR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB31C860C;
	Fri, 14 Feb 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561338; cv=none; b=IWvBKXv1gh52PAFxEwjsWrYAzM933on+qLjHgGU9//7V1N2+YD0CwpUmomhNxxJunluE12qdiq0SjQ4PLIHUIISn4aKhYlQ6+E2XnGoLM7F42TpLF32blzMBrQw0cUTqm0t3oH2muY8i6Pg33h8k9Uza3FbpjFw+QX1TiXQXvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561338; c=relaxed/simple;
	bh=QW9AocoXHCUksZ3zIb9uJIQz+7oSlCOG6am+3MmYug4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Drtz9hiCdAo2aQ26GGUXigKLllS/A4j4qmV0kTpcgCZ4zMjgSFixjgX1OHwYKWJcws+F8KNcpJf/hDt5NOsGjvdn1BAlWKkSy3uwJODMQ+0O1/d+k/dn29Hb0PnxwIGkkT+Pz6qjWMoCPGA+W64um8L+pBhbUPVyNJgqD5C19Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzp4rsaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F038BC4CED1;
	Fri, 14 Feb 2025 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739561338;
	bh=QW9AocoXHCUksZ3zIb9uJIQz+7oSlCOG6am+3MmYug4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qzp4rsaRgx+HD3biS879OGXhSy4K27E5nfMuvSTTWmIFMJ63pY88OR1ARaII6WWlA
	 RYJOVhyZRkOxHYRbQPW5rAaexvj9cHksYysiSa0m+yjR7NzGYzTTFSNsYmfIcSOi8u
	 FDk0WWbo/sSre37zgFpR+CIYnXDgi337KSIg7rke2N0Z8LdJ38NfMP8kEQAmSpRl4C
	 ZsnUNPjOnQptjqBtGxaQWSSRNQNwV691BXJKfoQoWokiPg9k9FCV7mybHy+6cuZLPO
	 Y8OSrmi7fpUPGUYW7hja421kEq8DJr/fGPz9lu5TBdHkbfmaLSRNvchJ+WKlNW0I1l
	 JLCZX6eq1/HmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD91380CEE8;
	Fri, 14 Feb 2025 19:29:28 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z693aRJLusQVW9iZ@slm.duckdns.org>
References: <Z693aRJLusQVW9iZ@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z693aRJLusQVW9iZ@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.14-rc2-fixes
X-PR-Tracked-Commit-Id: db5fd3cf8bf41b84b577b8ad5234ea95f327c9be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80868f5d3dca7230a87ee7947d0c7f821ce85b3e
Message-Id: <173956136717.2081923.13452161459955668161.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 19:29:27 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 07:03:37 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.14-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80868f5d3dca7230a87ee7947d0c7f821ce85b3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

