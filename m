Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3950A7903F9
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbjIAXUT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Sep 2023 19:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351189AbjIAXUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Sep 2023 19:20:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A54107;
        Fri,  1 Sep 2023 16:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C4F5B826A4;
        Fri,  1 Sep 2023 23:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDC13C433C7;
        Fri,  1 Sep 2023 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693610408;
        bh=8nHzbUyKQSksECZ1k5GkiCyOUMANlqvI+hpl06uuLig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ngIktYq7Msgwbzm1Kej2buIGBKoPvvZ5+8vLaWg9fVqnSYfq9Ck7aonSQw58g15xh
         VUkctZLZkMiiBx0ZFDWACPs6ArPaBolG+Y4SQhHSsNJB925RzvL51yw3MUviL9Cmnb
         ycIflS4fgS82uNEHaQO+kWlGR30FTQld3LF+Lr2vKT9SKK2dBELA03eKPQQIP4nRG/
         qR2kZPLcv/Ovw/jTWb9atlbVV24S/42/hswmUE6JwqPdVQmKl39dDkOQ/clhg6OBRW
         rCo2tK3xwASPaRIPiCxdjWxp2t5yjFvWaN3CV/iC3NoWn9F7p4i9ga5s6NPlLN4CiV
         fdOc6WYqGYoSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F7DC64457;
        Fri,  1 Sep 2023 23:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPEN6j8Zm6ZfpqxJ@slm.duckdns.org>
References: <ZPEN6j8Zm6ZfpqxJ@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPEN6j8Zm6ZfpqxJ@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6
X-PR-Tracked-Commit-Id: 78d44b824ed04dd1553c55c5b839c9a55cbcaf4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7716f383a58314378604eecdd66949ea2cd80ef3
Message-Id: <169361040781.4205.11967740783618051175.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 23:20:07 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 12:02:18 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7716f383a58314378604eecdd66949ea2cd80ef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
