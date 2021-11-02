Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7743944391B
	for <lists+cgroups@lfdr.de>; Tue,  2 Nov 2021 23:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhKBXAr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Nov 2021 19:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhKBXAP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 2 Nov 2021 19:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BD59361073;
        Tue,  2 Nov 2021 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635893859;
        bh=Oaiylfv9vi5PDeBxdLnG+SiKoH+yFN3hSkpX5tBjHyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BJt7L0VTKlKzPDm8AOEzVe0oDyU3Osfc9B3yDDUQvhaKP7KPgcfzT8Yta+w0ifnPP
         p8+l28TKgNakoDgH42ihFWN2OeRJQ6bMcABbb62yMg+WzNYSX+1cT1N5aP0vqCmhQt
         EmTvzZy4vivo71SNyW0P0GTECGujTmjJ/RWYLLp0K9CS9wPVSpOmIQED68Rj49vIGV
         kxEjpa8G+0ZSUvKtalm4sTWEk7z1xmHhVCUAAgmKMiRzn1daodiS/bNoDIqZy/ZRl+
         SsD1ZXhX99CBOBQ7cpHeLwrEEI6kcOyrOK+XoW4vfsQS/lpJrwJ/qNvgmPNSHfYu5v
         8NEW0C1Z2dxNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B425E60AA2;
        Tue,  2 Nov 2021 22:57:39 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYFryTJQxFok0jo/@slm.duckdns.org>
References: <YYFryTJQxFok0jo/@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYFryTJQxFok0jo/@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16
X-PR-Tracked-Commit-Id: 588e5d8766486e52ee332a4bb097b016a355b465
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a85373fe446adb37cab7b2702f054af1b275dc13
Message-Id: <163589385973.10018.9665498852958639394.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 22:57:39 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 06:48:09 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a85373fe446adb37cab7b2702f054af1b275dc13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
