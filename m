Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35697683AED
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 01:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBAAGU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 19:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAAGT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 19:06:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC47299;
        Tue, 31 Jan 2023 16:06:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F5BDB81FBC;
        Wed,  1 Feb 2023 00:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55445C433D2;
        Wed,  1 Feb 2023 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675209976;
        bh=FTwoca2NX3VXIIS27ritNTfRi3/YYVuX1RuxhHafJ48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ePoX56bShu8uJzLKM3+KlxxfQpGWhdZrDsrtj1l3ZuNEkbQ5pF9Zn4ednYiPkwgeH
         jU7bVFb8NaJC0pqp4AVQk2ErU/IiTPDSoqifA0FBQeBY7sZWlixGLRIjJUpNjy3fmy
         AhYgJLO4slrq8UHUXemYqclRp1V3RB/e09szd2lEQ3lJhUet3fSynSk1JTZjDV56d7
         88hjeqkKisSqfH8DVaZjLrBlmCKJOUtvrCiE7PLVsU92JnMOKGluQn+sBs/dhMvJzB
         yuGICsWUXBUAmnzgUWD4dxnf9NmYPEmglGhwDM4jKdrP5SX712oFzK4XJItyyWHEeO
         c2EkZK+7mG6ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36EF6C072E7;
        Wed,  1 Feb 2023 00:06:16 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9mUVtmR0AGJKWty@slm.duckdns.org>
References: <Y9mUVtmR0AGJKWty@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9mUVtmR0AGJKWty@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-fixes
X-PR-Tracked-Commit-Id: e5ae8803847b80fe9d744a3174abe2b7bfed222a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0b67534c95c537f7a506a06b98e5e85d72e2b7d
Message-Id: <167520997621.4702.12116728808966510071.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Feb 2023 00:06:16 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 31 Jan 2023 12:21:10 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0b67534c95c537f7a506a06b98e5e85d72e2b7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
