Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D873AE24
	for <lists+cgroups@lfdr.de>; Fri, 23 Jun 2023 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFWBDj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjFWBDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 21:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290A10C2;
        Thu, 22 Jun 2023 18:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFAA61944;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C599C433C8;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482214;
        bh=TKiEHOWtshuxNrZbvQHJAhEobaeZXc/Q3jmeJ3HQOaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WW1arIO63XQL1FDnzLHSl6KbNjOO+sGhpmF/SNqG4CDi0CFx33/2TN08e3wlPLUoW
         v4Kc8kXFs/HsyKl3ZE98t9My5yGC3eh+0rEiAH1R7bhgxjwsu1nBjbQv2JboEscebT
         52+6Wq2LakKAQbn1PRWW2QsjZXMA4nUnCWf049lU7fC6kM3m9vnk3g8mStF/sd6tmN
         LoLkwCTAICk8OCiUvRNxBSPbSnUWpBRBtcMhvZ+bQuuENdtXl8wCuWwF6rpscLVR9s
         9GAdRO+PYeG4oAH57nJbIW+0XG+ebdg+ZtlfyDyDdHkEoEoAP641W4go1c06yan128
         b4z/33cR0uxyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31229C395F1;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJN0Qa--_aBSJ_K3@slm.duckdns.org>
References: <ZJN0Qa--_aBSJ_K3@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJN0Qa--_aBSJ_K3@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.4-rc7-fixes
X-PR-Tracked-Commit-Id: 6f363f5aa845561f7ea496d8b1175e3204470486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5950a0066f415e4409a3b39ed6c5de1a04131894
Message-Id: <168748221419.12146.8189175020883380137.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:34 +0000
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

The pull request you sent on Wed, 21 Jun 2023 12:05:53 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ cgroup-for-6.4-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5950a0066f415e4409a3b39ed6c5de1a04131894

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
