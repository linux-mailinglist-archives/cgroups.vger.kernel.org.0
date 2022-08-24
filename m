Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF059F176
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 04:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiHXCqD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 22:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHXCqB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 22:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2D3D585;
        Tue, 23 Aug 2022 19:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87C3BB822DC;
        Wed, 24 Aug 2022 02:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34A71C43470;
        Wed, 24 Aug 2022 02:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661309157;
        bh=gjnhOAGSUFLCZ+8mbIbzZxTplYWXZUIiS5eNiwoQAEs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1AbfK8C937pTNGDsIPsVzf11UeFqtdarYkTwJs5qB2ZtgbKucXX1kRUbhEsbWugQ
         ok/Nb0mynYe4LpU5bX2NIDLNFAWj0Vm8hCy4icu3/2tObPvnAgFS61FjMiSBantsYl
         RqnsbBVc1sguGzZQ4TW9+yb9hyAc6vc45AYlvaTFWpKdYoZAFNVsYnZwkziTdGaBhR
         Nqj32HGUK8Le2lpR12YnPWbQJyY693S+fp9KDGp1XRqTNtqgqUN9GpEGIkPJ+B2Ldr
         UfGQwgdwyPuuziZKPKexjTZN0iBarQpELHUmwNgNLTT1mp8cYIY14o+7WZni8bdm6S
         MRDS8xXkTsl0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 160FCC0C3EC;
        Wed, 24 Aug 2022 02:45:57 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwVmlMzNMS5ym9JI@slm.duckdns.org>
References: <YwVmlMzNMS5ym9JI@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwVmlMzNMS5ym9JI@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes
X-PR-Tracked-Commit-Id: 763f4fb76e24959c370cdaa889b2492ba6175580
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c40e8341e3b3bb27e3a65b06b5b454626234c4f0
Message-Id: <166130915708.7543.10455408281357977924.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Aug 2022 02:45:57 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 23 Aug 2022 13:45:24 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c40e8341e3b3bb27e3a65b06b5b454626234c4f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
