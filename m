Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9536D069
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhD1CG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 22:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhD1CG2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 22:06:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 857D161151;
        Wed, 28 Apr 2021 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619575544;
        bh=WA+8HRXIjno8aNkTFxntF+zwDHxIKww14+HYuvd6MIs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=owyYVOeHQ01UZzQBqaUlykhhnTW8z3KGAYjh1gM0IN3CIMWe2y5EZZoor4Zt6r+bu
         iTgZrAjlCp6pgfkGqx+XuK6zXQqapTMtICrzbOulSXZJM18fTYt4n4Dyq4dDhG8GK1
         2qDVovQdAEqDCpWCwzUr7p1EjmfzUJyHFf5CJHuJY4qOyl7+n0M7RnEvuoum5slGtk
         bQ10EjaXtnVfIP91ssx0L32MmEngCc9VzimJHZF/i00LRcCls7GbwMEEi+6fpiF9kU
         MRJHL5IQHvIDfWbzIlPTtfLHNsfpil2t1q4qnOeZRPV2iFIjwVX3BOpErDqImnbZrf
         fhNrqXLPkbAvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A56960A24;
        Wed, 28 Apr 2021 02:05:44 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIgmD4t2UM7lSXYz@slm.duckdns.org>
References: <YIgmD4t2UM7lSXYz@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIgmD4t2UM7lSXYz@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13
X-PR-Tracked-Commit-Id: ffeee417d97f9171bce9f43c22c9f477e4c84f54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55e6be657b8d774d9a2e67363e5bcbbaf80fdc28
Message-Id: <161957554443.21925.17556300526205901198.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 02:05:44 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 10:56:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55e6be657b8d774d9a2e67363e5bcbbaf80fdc28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
