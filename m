Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5EB487FCC
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 01:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiAHACL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 19:02:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55670 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAHACK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 19:02:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45CACB827B7;
        Sat,  8 Jan 2022 00:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFADBC36AE9;
        Sat,  8 Jan 2022 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641600127;
        bh=I20x4Wyk5/OEgv0aB7SmYSXRN4pt2WIGX2rzKyoO5Bs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=muE/+lZacqB1IZIM/MuWz6CE7BmcNJzXW7d25CrPgf+Gvh3ZV75PKgVbRgipb0rd2
         /I1emWrwm1CjCI0/YZNG7jCa4gXIWmqo9J30Odeg89QtmDaGEI20FAO/jQ6/9BFv+n
         0sltFri1SwsiYfrnrdLwj9CJSzHRkP9kC+/crP94DlHUSyBHjRHX10xxsI1UqYuYgw
         Mwp6S2mdO4bDgcCUHoFkcn5KLy+9XhYL9kGrd4ItprEUUsW5Rve0+SGR1bf4WrC5dM
         uQhZjDg1DgdjgXoSiy4wfH+xtiga2Ccfv2vF9rfBw5NG2Dx+CKUnanjlKf5wMUQyr/
         eMNhiv5mF2n5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC4C3F79407;
        Sat,  8 Jan 2022 00:02:07 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.16-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdjAAK4AtsUDv5vw@slm.duckdns.org>
References: <YdjAAK4AtsUDv5vw@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdjAAK4AtsUDv5vw@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16-fixes
X-PR-Tracked-Commit-Id: bf35a7879f1dfb0d050fe779168bcf25c7de66f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1587f7bfe9a0f97a75d42ac1489aeda551106bc
Message-Id: <164160012782.14023.3781753125840093469.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jan 2022 00:02:07 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 12:34:40 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1587f7bfe9a0f97a75d42ac1489aeda551106bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
