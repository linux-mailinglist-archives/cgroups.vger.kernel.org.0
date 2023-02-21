Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAAC69E844
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBUTaA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBUT37 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 14:29:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50B2279C;
        Tue, 21 Feb 2023 11:29:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 613F9B810AC;
        Tue, 21 Feb 2023 19:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D88AC4339E;
        Tue, 21 Feb 2023 19:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007796;
        bh=2TzDzRqJWdA0hpzuflHU1T/44M4OXR1Yh75Ydd8Abww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n4VHdXfuR5wKf1hGSp9EBpBPw9DzzFOtY5FxtWWbKaE7/TL7xLVFJFBq2jKI9yWXK
         kGG+bpFK1F/N4gHOiQR9vZ3J6MqAvtkjnVgY3mV6Om+sGcH9eiSTcuATVY7JpWetsH
         j53aIOeLa45dXvEOlFzvPM0n7yTgtHJC5WIVbCvOXamNz/Gm1bkMxc739VTbyOwTvz
         gUkMffT3uqxNqaCq82XVxgJ3X7W6M1V+IJBkiZWL6ph8BL2zmDlJAMWTHzog2eBJWK
         9gIyo7Mk7iR7nHCGw8ZTyB9D42kb6yrRGxLBaIpZJMBZvNdqKIR7KV2I0njM9BhZ7A
         XiDHeXU/YqJKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 089D1C43151;
        Tue, 21 Feb 2023 19:29:56 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/Kv/v/zdeHfwgcc@slm.duckdns.org>
References: <Y/Kv/v/zdeHfwgcc@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Kv/v/zdeHfwgcc@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3
X-PR-Tracked-Commit-Id: 32a47817d07557ffca9992964c514fd79bda6fba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ca8d89b43caf9a02a18414d6eeff966d2b14512
Message-Id: <167700779603.6594.9596749595346133260.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 19:29:56 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 13:25:50 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ca8d89b43caf9a02a18414d6eeff966d2b14512

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
