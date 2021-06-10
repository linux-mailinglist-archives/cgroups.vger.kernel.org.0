Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068E23A33D3
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJTU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 15:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhFJTU3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 10 Jun 2021 15:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D7E4613E1;
        Thu, 10 Jun 2021 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623352712;
        bh=V6Mh4utTcaCYp/3IU5a9nkuqJqsDNpxv6UzH9zGKe4A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DkH3fAiZbOESC2kIakx+fQ9aJkULXS4eJJhxtVJYwSrRpdjUgoKGMK1R/TNSVWa7p
         fmA49ad6z7HB7OoVeLWVmOGRMXklsm/AmMvOoSKud9lrVM1WghxOmxb9iK59UlX8br
         7bOIrAwQlJ1iblpiGzQfPPA3xy25SoAQNFjXb0J5lFPgyJkBDIPndQ4lOdQOT3OOJ8
         oki6kL+1M9Oa9mzC0bsfWrL96z5FQAaSI066Y2+KFko0pXwPOC2bCZILbzeQuwQCZe
         mc0skAhcwlj6pShglS1rrS63qqZkXF42tnXIzFbnCkwjrjPiloPVLCuP/FZyo7M7Y8
         AzLdQDVudL57Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4F3F0609E4;
        Thu, 10 Jun 2021 19:18:32 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMIg/rC1TQwEbabA@slm.duckdns.org>
References: <YMIg/rC1TQwEbabA@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMIg/rC1TQwEbabA@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes
X-PR-Tracked-Commit-Id: b7e24eb1caa5f8da20d405d262dba67943aedc42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f09eacca59d27efc15001795c33dbc78ca070732
Message-Id: <162335271231.23981.15027693961958091298.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Jun 2021 19:18:32 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 10 Jun 2021 10:26:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f09eacca59d27efc15001795c33dbc78ca070732

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
