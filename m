Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4385E8E13
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiIXPlx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Sep 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiIXPlw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 24 Sep 2022 11:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880576AA01;
        Sat, 24 Sep 2022 08:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43310B80E52;
        Sat, 24 Sep 2022 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6635C433D7;
        Sat, 24 Sep 2022 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034109;
        bh=veuerdAVOK4AGVI2s09VktzG6lI4Wh5dRvCojYk+5PY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lbEfE+X/gJ2dTmCoEmQfZ8rKVcCui+Eu21msiyZnmhh+CaXvGAj6hjqtWzyNNp8Ns
         uJzvAbs0sbOF65mGeYjI6i02lm1KY4oDa7t0S2alHK1hbdQtzP7BIJAkkhv6nhgy0L
         1zYdt2JBnARcxWdv4WWhVq8kc8y3HXUcc5n4sSqTdObtBM4KbAJiQBUQzzaI2fCzxW
         3budMkFM4z/b+6mOjdYn/RfHwp622TnEIQS5BwXn0hWMgwNAE4/J9i+TVWMiQHWDYc
         C6j2vBrG2UshwvHunXSb7ma2Jy+4u7QOKe1pMPTR0TBAQTl3LVFIjM5dQSC9JmCmDf
         cQs9Z+KT1rrVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBC8CE4D03A;
        Sat, 24 Sep 2022 15:41:48 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy5/MV8BvP+M5Fmi@slm.duckdns.org>
References: <Yy5/MV8BvP+M5Fmi@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy5/MV8BvP+M5Fmi@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc6-fixes
X-PR-Tracked-Commit-Id: df02452f3df069a59bc9e69c84435bf115cb6e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1772094f12a7b180aa9ab849586f891b14d06d1f
Message-Id: <166403410883.30824.4959463978058826483.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Sep 2022 15:41:48 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 17:53:21 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1772094f12a7b180aa9ab849586f891b14d06d1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
