Return-Path: <cgroups+bounces-6092-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82917A0A00E
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D4B7A4EDB
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607C4D5AB;
	Sat, 11 Jan 2025 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFWOM55h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BA433A0;
	Sat, 11 Jan 2025 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558748; cv=none; b=Q5FM/K8psAqYA413yiwd/ZAHYQ2V8O/M6Fc50ThbeRyqprVtuxYuRKp++TmYMNvrLDk0QHDcWfVKnNlzPp96UphCFteXltwxYRNBmR2/5TpwTnYQZmzPoastMjJLxRWL2uovsR7Xp9rxEaMCQAs02SVOekTmJffJYr+1ONwAlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558748; c=relaxed/simple;
	bh=sjmbjfWjsh488UdCTLTEpyaTwnivZahKIxOXHoEuf3g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sa9MMwm6OsgQOIhUyqTUYJIOlfr0UVuaPk7GjswPYwqRYfZ3V3gXdwA7Un/V7N9hP2/RmLfWJnpSB6ex/1tYTamfSWqg6GHt2ZVCVsodVVZlAcN3zZMJbwq51nGWtGmUoVZW+tpEnPDG3ri6LYSXCsKHt4ypWgwktDEt6jYtems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFWOM55h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0DAC4CED6;
	Sat, 11 Jan 2025 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736558748;
	bh=sjmbjfWjsh488UdCTLTEpyaTwnivZahKIxOXHoEuf3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fFWOM55hzVSM0zl5ulCv5wi4jyOaaZbBiI7zmdfGalZCecGfvp8Fe3ip8FBqaj/Gs
	 EKcnOIYZWCNdZPfJdEsj45u24zPXUS+EYXGRkZxITpJ+1ksYoP5aiIJzfmZp/0cEm5
	 tai4UOwwFgXqhzUFDd1tU/r4QiPhQvyhqOG4iIV/Ax5BJ1UmH5sC2/MltKtE1jzTxL
	 8PdXJ38RYZenpCfF+4KEsjNB8ybdmpIoQwVCIgoBlODAGe+Kf3TPo0ozFUMwWX3nmQ
	 44Ma+v1eDeA3iaDvlxzHlL3zmop9ahpjDTcfkPru29SBjTx8++GAbXL89HIzz2PB8g
	 Ovdklk9t/Fiyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE4380AA57;
	Sat, 11 Jan 2025 01:26:11 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.13-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z4GlPPv2Ku5xRs6N@slm.duckdns.org>
References: <Z4GlPPv2Ku5xRs6N@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z4GlPPv2Ku5xRs6N@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13-rc6-fixes
X-PR-Tracked-Commit-Id: 3cb97a927fffe443e1e7e8eddbfebfdb062e86ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58624e4bc876198a5dc41be1d7dd39e7c944b9c6
Message-Id: <173655876972.2259020.8674365237576361536.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jan 2025 01:26:09 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jan 2025 12:54:52 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.13-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58624e4bc876198a5dc41be1d7dd39e7c944b9c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

