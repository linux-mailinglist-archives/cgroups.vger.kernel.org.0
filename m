Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF43740706
	for <lists+cgroups@lfdr.de>; Wed, 28 Jun 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjF1AFh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jun 2023 20:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjF1AFg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jun 2023 20:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480B2963;
        Tue, 27 Jun 2023 17:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B26D6125A;
        Wed, 28 Jun 2023 00:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0471C433CC;
        Wed, 28 Jun 2023 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687910729;
        bh=K1q5eY/7V72aUCquOMcMTrY/5u0DEnDqAr6KzjugOlo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QA3AOfV5f/hKILHL6f9zwozgWXG8Mzl2R11UZQ/atnbohGthR1toO+X/mQJxw90hZ
         /jkrzWa0s+e2OEQWpvL7h9pcnhGxbmnm8+Cbr9CUyZy5N8gYjockCtjSTqz6THdNbL
         vyEj16S0ugftJR4m/AG0kmcZt5H1RrE5WZgnORTXyeOnGTZk1pNYoVYnxTOkZtdsAs
         4ToB/bIj5jSpfrP9yYMpqbTc5LytLcHBU1OnTOQkJRlE8/MSA7MTG1wFi7+U267A+y
         eK0ACueMJlIcPoczCzrzeYFn33Zfg2mJNaN03RFNBukyjO1XrgbLNDZTzZcIipQIVu
         3dKt0zh30c9wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB1EBC0C40E;
        Wed, 28 Jun 2023 00:05:29 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJoRezbOXRTLIL3T@slm.duckdns.org>
References: <ZJoRezbOXRTLIL3T@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJoRezbOXRTLIL3T@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.5
X-PR-Tracked-Commit-Id: 81621430c81bb7965c3d5807039bc2b5b3ec87ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e2332e0ab532eb01f1fde39080dbfa9bf65c4cf
Message-Id: <168791072969.16670.1997125289929728161.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 00:05:29 +0000
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

The pull request you sent on Mon, 26 Jun 2023 12:30:19 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e2332e0ab532eb01f1fde39080dbfa9bf65c4cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
