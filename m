Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C474E5963
	for <lists+cgroups@lfdr.de>; Wed, 23 Mar 2022 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiCWTw3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Mar 2022 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbiCWTwY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Mar 2022 15:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F38BE14;
        Wed, 23 Mar 2022 12:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3652961617;
        Wed, 23 Mar 2022 19:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97D42C340F2;
        Wed, 23 Mar 2022 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648065053;
        bh=RqABn6AgjRAQfjZ3PntbfZ6wbrEcAVqycah7eoToP1I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b6pNd1iB90Imym8RFfd0/FwusZvxSq2/7GHWhIyTBZqspdln/7m5yOHFI6Q2o2ea9
         LYqrPP4mcsYGpeEPWUYvXarVwgV8E7pkXaJVnlASMbQ7ZGrrMdwl+FG43Ab/b2o6rB
         PQAHdAcjXLu//RZG5DcdLqKEOIDGEwxnDNTm34IJP1jEFEO/Vfz8zM1WN0LR3LgS8v
         comgmmeyt0ULXzN/SfVZsfm4xUnw38JUMmjBcF4MooW5Um5H1RJHAnOBFWby0FrFVS
         xaokr8oasRRAUVkcCcistKru4q8q8hXtsCc9lWHWUeGJVUkZVj+YwrnvCeJya0H0ja
         MVgeiuz/pFPGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81712E7BB0B;
        Wed, 23 Mar 2022 19:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjjdEUPIoYyPjsvh@slm.duckdns.org>
References: <YjjdEUPIoYyPjsvh@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjjdEUPIoYyPjsvh@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18
X-PR-Tracked-Commit-Id: f9da322e864e5cd3dc217480e73f78f47cf40c5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fce7ea0e0964e598cf9da8985d2d811f8c6a4a7
Message-Id: <164806505352.21505.18075985246981642274.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:50:53 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:16:17 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fce7ea0e0964e598cf9da8985d2d811f8c6a4a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
