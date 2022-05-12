Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A505652540F
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357249AbiELRtp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357272AbiELRtp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 13:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFA41FC2DD;
        Thu, 12 May 2022 10:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF66060C69;
        Thu, 12 May 2022 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FC3EC385B8;
        Thu, 12 May 2022 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652377783;
        bh=iACxMt1xiFoGjTQxV0SOqR7DmwQ6H5CFvzHBwVxGmO4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ko+B8SI2SkMSxu6L5pFBBFqGKzamZBBLcH2nUltA8OdiDII666dS7KNwAo7qOWJm6
         w2VJ8rXrIcrSRg9pMJeITXtUxoPifNSxIayi6pONLOHBEIJZZNv55STPraXh0/S+cp
         CTValHPWB/vrJc+xEotMceUMhtfTKZZqPiuwF4OsgUGPBMnIxRNqn4KM///Ji0wrP7
         yW6rccgGqOJ1qMN8m6mfIIc7CtB4VdHzbLLCi8GoRjZI1UgyS8C2luQLNgLu50GmIm
         Be/+0SPB8UeVrqd5kXMPgjuQ2Wm/vrmKRg9Ff+f+U7SccNQ6EGtOOPBHqt68QmtgnM
         E+5HlSlAV501A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22105F0392C;
        Thu, 12 May 2022 17:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yn1EFgZdbSSjTatf@slm.duckdns.org>
References: <Yn1EFgZdbSSjTatf@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yn1EFgZdbSSjTatf@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18-fixes
X-PR-Tracked-Commit-Id: 2685027fca387b602ae565bff17895188b803988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ac824f379fba2c2b17b75fd5ada69cd68c66348
Message-Id: <165237778312.3166.15209946095490727314.pr-tracker-bot@kernel.org>
Date:   Thu, 12 May 2022 17:49:43 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 12 May 2022 07:29:58 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ac824f379fba2c2b17b75fd5ada69cd68c66348

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
