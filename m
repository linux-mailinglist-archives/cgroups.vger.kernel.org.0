Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF3573D19
	for <lists+cgroups@lfdr.de>; Wed, 13 Jul 2022 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiGMT1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jul 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGMT1H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jul 2022 15:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017242CC9C;
        Wed, 13 Jul 2022 12:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920B761DB9;
        Wed, 13 Jul 2022 19:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C8EC34114;
        Wed, 13 Jul 2022 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657740426;
        bh=GPfukqpYt/ElnAzDgbYCLI0kTMLGcY/CGVixu0++SJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MXZJDzOCivBxZChv7guAFNqaJD2LTSubLovmnNDQbZ+gYChyfv03DsXSv0CZ1IMtS
         HAvfBDegb3wrOKluXHO1RSEt6jJOe52LuAITD5/B2YkLk9bYUtF1hZBdlNYkutdZ6E
         sr4TjcF3agtkxA+GGIjGP3KWz4Qd/42Zapb3cdpFkUbvprI3ZsRdx48L4Col/9XwwU
         /VQ7Z43DxHMBxMYQvZuDmWMV8/V1+SNN4nB2dhyvittqfLL+32JT/BC+dPXNg23/m8
         BEzj2CAwGS4Zsny0Gd9N89FYoi2iUdvUC/MjNMp+gDOZsNHXSoUCZ4PeXNYdNN953s
         pZdHiVLhUKXRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D61A9E45223;
        Wed, 13 Jul 2022 19:27:05 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ys49Cxqd1YOHpipB@slm.duckdns.org>
References: <Ys49Cxqd1YOHpipB@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ys49Cxqd1YOHpipB@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.19-rc6-fixes
X-PR-Tracked-Commit-Id: 07fd5b6cdf3cc30bfde8fe0f644771688be04447
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0b97f3891fb414bd1fd1cb3d83f0f6b9fd0d357
Message-Id: <165774042586.19997.1756917258201599461.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Jul 2022 19:27:05 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 12 Jul 2022 17:33:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.19-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0b97f3891fb414bd1fd1cb3d83f0f6b9fd0d357

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
