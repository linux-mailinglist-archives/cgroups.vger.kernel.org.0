Return-Path: <cgroups+bounces-136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C77DC6D3
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 08:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5E51C20B9F
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8330D2F3;
	Tue, 31 Oct 2023 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApTE+HvI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A141078F
	for <cgroups@vger.kernel.org>; Tue, 31 Oct 2023 07:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09DDCC433C7;
	Tue, 31 Oct 2023 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698735752;
	bh=Qv70C+G0MHGS+TkKdYelm8+m198Y5NdfL9cgr4mEo70=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ApTE+HvI+MMApOBn23xVLeLFF7pC8xoQPKwb7AL+1+Cb2N48UvMtS84s8dbK2K9j8
	 dej70Bo3Upt8HKS2Dvxh42YkHvf0DJ60rXM04ZC0Ga3+cL3yi6xC5qH7Wm54tPHGrq
	 /eB0RS7wJ6DDJ8g8nJNvwnoiX2rqUSj2dMVYbj004JhuRgwEUeO2lNOKMMLa8EU57M
	 IfIdlYodm8Cu1dMfneOWZmZqPAslzDyLUOKTYkGA21BkwIJfEZpbohLNbaEK6TbU1A
	 CHZlJTTnBhHevE/1sR1qVP/j3gPj166PzlQXfmMBq4Om/O6AMxoz/9+RLchqOnNNz7
	 zOwCz+UINxf+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2C5AC4316B;
	Tue, 31 Oct 2023 07:02:31 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUBVRmaimsnGY09k@slm.duckdns.org>
References: <ZUBVRmaimsnGY09k@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUBVRmaimsnGY09k@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7
X-PR-Tracked-Commit-Id: a41796b5537dd90eed0e8a6341dec97f4507f5ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a6a09e97199d6600d31383055f9d43fbbcbe86f
Message-Id: <169873575192.30696.8945234866104018704.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 07:02:31 +0000
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Oct 2023 15:15:50 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a6a09e97199d6600d31383055f9d43fbbcbe86f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

