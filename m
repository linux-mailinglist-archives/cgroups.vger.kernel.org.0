Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635E6F25C6
	for <lists+cgroups@lfdr.de>; Sat, 29 Apr 2023 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjD2SUe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Apr 2023 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjD2SU3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Apr 2023 14:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF872D69;
        Sat, 29 Apr 2023 11:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06071615C1;
        Sat, 29 Apr 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E673C4339B;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792420;
        bh=GGTuoLDlPj0SlyCoRIWGuSfFegPdZ+ImcoWAgVx1Pig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZaqKnY8XD2CGEqGmlREhpk7A+tqA2D+27uvyHgkAhWucZ6oFwTX6KAPYt2ruQs85p
         9e5Oxm915WQaOOSa3Dwjc5buLex9oz0Td/W4MM+UXAm//haBlIMpEy/uDtbaTteEHB
         qbpLwyppCNRdmRrx3OyBPbg29v4TerO47py9VfqfdcqqGdZF6syIyzNVjK0bjrCqua
         yKgQY8vPwazuMbPn56HMMr7f7KhM/m3EpINiLZWPRBBDfJyQhgfTsynceydVF81H3q
         GKCU5dE9kif4YhOKx5lbZ7Ce0h4hCFouB7O53bUDaoVVjaMF7WQsgG316xSrejRqqH
         lXZ/iq2lBFxVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D308C43158;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErg3xZyhlVx_Mw0@slm.duckdns.org>
References: <ZErg3xZyhlVx_Mw0@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErg3xZyhlVx_Mw0@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4
X-PR-Tracked-Commit-Id: 9403d9cb564b6a3af86cb18fe722097ed7620f6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86e98ed15b3e34460d1b3095bd119b6fac11841c
Message-Id: <168279242037.22076.2648918669590825807.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:20:20 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 10:53:51 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86e98ed15b3e34460d1b3095bd119b6fac11841c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
