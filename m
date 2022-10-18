Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFD6020B7
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 04:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJRCBQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 22:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJRCBP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 22:01:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EBE17AA9;
        Mon, 17 Oct 2022 19:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F79AB81BDD;
        Tue, 18 Oct 2022 02:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF29CC433D7;
        Tue, 18 Oct 2022 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666058471;
        bh=F+S51e6wTdPG2aXbo8dh/010c09681MqZA1F3Fzj39c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=om1h2Erm2L3PTREyOpBE7EB3a2xw0DBVx2poVEhOX9E1ZjdD8ftpp8L90y8R9Mxs5
         tE1ZOR52IRCXge04EcunpFtDu0A/jpl+2H6BVuCD3sN8cABse2Pla48WtFHcb7+BgE
         yn5bLhrTPeHlYzutjVUm9Jd6DymsQq/p5vZoT3SgsN2Pcqp75XzX5YFwVHuwYpYG4U
         X8LhgYQB9n6ELsKgcrRctyGxpN1Rfgs7vRNjF9zjXVqRWBCTWBCnqnUIPgH3g5OoRe
         Vd2w/l3W4HZPxFbBe3F5cdB3vsIG05rQmVDHC/7yGp8BG24lK7B1/PGZiIbF/aNcVN
         49Vip/4dPrN6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1E5FE270EC;
        Tue, 18 Oct 2022 02:01:11 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y03NC6GVxT6iPDsr@slm.duckdns.org>
References: <Y03NC6GVxT6iPDsr@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y03NC6GVxT6iPDsr@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1-rc1-fixes
X-PR-Tracked-Commit-Id: 79a818b5087393d5a4cb356d4545d02f55bf1a2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb1a1146467ad812bb65440696df0782e2bc63c8
Message-Id: <166605847178.4906.14956649686203829290.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Oct 2022 02:01:11 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 17 Oct 2022 11:45:47 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb1a1146467ad812bb65440696df0782e2bc63c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
