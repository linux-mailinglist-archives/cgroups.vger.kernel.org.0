Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9A6E1879
	for <lists+cgroups@lfdr.de>; Fri, 14 Apr 2023 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDMXpR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Apr 2023 19:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDMXpP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Apr 2023 19:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E63A84;
        Thu, 13 Apr 2023 16:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA4C64293;
        Thu, 13 Apr 2023 23:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E26C0C4339B;
        Thu, 13 Apr 2023 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429513;
        bh=2UbDLK18wBx03HYCt5hAWTESta7MQFVyDxq6aWeEDjc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=acyZMvvK4eidxgFEukud1gjynXBz4y727Fv5oRD38++IKi+Yc/qyl0ln2T1uXgF6W
         r5BCxlqFEZHhY4xQ8RC+Nzj/nfeYI5ddosuRp9lTHInlG0O13/9y1wbir2cMa5qPu6
         elRZpvV2SS6as13pxgY43GsoH0hVclOMRECQifzkoicvw0J7xLHfjosNGwAVD8MRXw
         nlh36swdLxfHWGnEIj0NqiNbLXLnQYswZZ3l7+6UnPLUXOQvaUwQfTteWV8OoRvYbF
         fpLz4BT1Ft5mOFSQKkYQ+VzGj8JQIJ62K9OqzqLgvm0VIQIfFx36yG58xhF/xjM6gG
         uXbeRYfhUjW5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C63CFC395C5;
        Thu, 13 Apr 2023 23:45:13 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDiKQ7Bia-ki3Vmh@slm.duckdns.org>
References: <ZDiKQ7Bia-ki3Vmh@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDiKQ7Bia-ki3Vmh@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3-rc6-fixes
X-PR-Tracked-Commit-Id: 7e27cb6ad4d85fc8bac2a2a896da62ef66b8598e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44149752e9987a9eac5ad78e6d3a20934b5e018d
Message-Id: <168142951380.2357.469077170664556111.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 23:45:13 +0000
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

The pull request you sent on Thu, 13 Apr 2023 13:03:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44149752e9987a9eac5ad78e6d3a20934b5e018d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
