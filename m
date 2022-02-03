Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680834A8C9B
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbiBCTkZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 14:40:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35808 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353814AbiBCTkW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 14:40:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A878F61949;
        Thu,  3 Feb 2022 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F934C340E8;
        Thu,  3 Feb 2022 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643917222;
        bh=/0QUOiReOFNNywPWXIehNo6nlkCCJhv9EHrfvrPyW4Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LgxRNuDKjlycBVITOho0n2QnclXE5obeBA2XlH69isSaoJGZg/zS9xdQiafhnKRxx
         cKbKF791mIUctJSEeMHbpL1icHRFI68mRUF5yUK7ovB5xcv58d2L+DOoOEotXBwn5E
         aq9fW5fF6321S33PcmLG0gfczW/hPhRNU2xMhwlVKFVuA99Gg08jSoxWxYpnhs/H1v
         9KwwQ0R37KeIbUin1OlLvIc5amw3TcwfWVrMmZ1At9cod4kmPbx3hJN2E0EH3kJP44
         LCc/455uuFSB3HNNAzMW0A2YE+pL1kSnz9zb7cYohYz2Nk3MOxk4iMlaa6tpiXADSt
         8tXOY/gxknzWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CE3FE5D08C;
        Thu,  3 Feb 2022 19:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yfv/LMxqHSa3s5YS@slm.duckdns.org>
References: <Yfv/LMxqHSa3s5YS@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yfv/LMxqHSa3s5YS@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes
X-PR-Tracked-Commit-Id: 2bdfd2825c9662463371e6691b1a794e97fa36b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 305e6c42e8de565864431510230a8ad75c85f4d4
Message-Id: <164391722203.21505.14786787349066651579.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Feb 2022 19:40:22 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 3 Feb 2022 06:13:32 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/305e6c42e8de565864431510230a8ad75c85f4d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
