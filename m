Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307DE728DC6
	for <lists+cgroups@lfdr.de>; Fri,  9 Jun 2023 04:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFICZA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 22:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjFICY6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 22:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982862722;
        Thu,  8 Jun 2023 19:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1A665309;
        Fri,  9 Jun 2023 02:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC55C433EF;
        Fri,  9 Jun 2023 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686277496;
        bh=551V/FnDZd4UX/nJ2A2jmOSakVM7Of2h/Uno2PxXFmQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GIn+6c05b9e7cj7WvpTGuxtyePG3vy0veTmXE08yVvyxEwOxCYcQkezK2C32AQMmn
         Hcr8d+mdn/qnKosaXGdVjYU9FnOLnI5Ja1yyZQ4IUu88vBkr//SI6mXmHehDk416+e
         8F/DqpP5Uww3kcYqUTtONdI6iexKcRmNdqDA55DzDPh7jNTPcCoy4bRv6bm3/0+3Ho
         80wDnoG9fiQ7URdYrbQDhxqYQf+PaGabHZRLn26FUtXMc+7QzN3Z567s7cdXiSzJEu
         2FApLwIi3RvZdNvppHtVPKOEjQXXJFw7/zmSjUMmttRvk/qRiyOEtLbPmjSG0WVTk+
         QiFjj5iKOD5ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70197E87232;
        Fri,  9 Jun 2023 02:24:56 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZIJ53jQAPxEXF-iu@slm.duckdns.org>
References: <ZIJ53jQAPxEXF-iu@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZIJ53jQAPxEXF-iu@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4-rc5-fixes
X-PR-Tracked-Commit-Id: 5647e53f7856bb39dae781fe26aa65a699e2fc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cd6357f100b3eb0f5027b1ff1a5eebb9f785145
Message-Id: <168627749645.4066.9517750733952460014.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 02:24:56 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 8 Jun 2023 15:01:18 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cd6357f100b3eb0f5027b1ff1a5eebb9f785145

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
