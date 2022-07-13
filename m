Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB8B572BF5
	for <lists+cgroups@lfdr.de>; Wed, 13 Jul 2022 05:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiGMDdo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jul 2022 23:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGMDdl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jul 2022 23:33:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8E2672;
        Tue, 12 Jul 2022 20:33:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso1457428pjj.5;
        Tue, 12 Jul 2022 20:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iRBwqOO6cKGAh5e+2I9BxcznEBEGg6GBtbTmrmZAD5s=;
        b=m/9mOSPBXNMkaE1X0mHG4cbeDfBiVmCdjCqVPr0gxgae4rsPPH5ZsGmelWEsO9pvyk
         JYMbWC60s74OqbY/ftiH11cWhoVlhqEG9CsMxuBw091hGfMZQ2NoJM+1OKwG9+GlBvkF
         /jrLizyswJWILyj+5WQqn3lPl0cmJaaTlnNlTJCBoz9bwDAgr3MAwMkHcKnqrkLjPVr+
         lM6HXuQSe5saGzMFNmenltA53yQ689Yh+3DdZrEfuEMB2Pfy2cS2bc7h6Wi7+bAcEl1l
         W+sMUcccr4pvX/J+8cCNUcrwVLVHGroO1e0JSkxoWCVwIXaOe2neW62B6q7/e6Lkhmir
         D9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=iRBwqOO6cKGAh5e+2I9BxcznEBEGg6GBtbTmrmZAD5s=;
        b=bdx2bT7QQl3J2brDMyaXBOjX/HQSXqhs5wlkqJQ8Tchmxb6MgsvwBkGTqdL60W0GFX
         Hs1vemirlg4D7fAPsT+vvVhg2M4HWMFPUr81Tw/xwvJfNWwZoHZCbxP0oPKqC/+72gL/
         /i8MTWN7fFclKdZCQjpqtBkkPT6GiuQflcvXNVDLivE3zZxEU54xAlwbKNlNysvm/dtr
         jZRK82ddoQUvHXp9EHtYAF9cZGCLePsHtT51jW16zCw0Dvwx9diUaEVZgYhiX+KB2jnP
         HHmDLRj5wLE6NHSTnD0fsxosbav7NT4Q9ldTQDfz3Pg6kQn3R4t5WfMCSFAFRxqk4Fh2
         4mtA==
X-Gm-Message-State: AJIora+ZFHTyfJUv5OzZ/UEznC+TocJeoqg84l8J3XhrZDjLuRjcn8SB
        a0juTHDaUbd5hVuvGs13Hjk=
X-Google-Smtp-Source: AGRyM1t/+ymA6+67OQC06ND+tMlzHGyAwOtEuhA4dqJg6WYDjadEgMx7jMvxfW/9+kAbccBiHG9jRA==
X-Received: by 2002:a17:902:e952:b0:16a:74b7:57eb with SMTP id b18-20020a170902e95200b0016a74b757ebmr1146350pll.13.1657683214592;
        Tue, 12 Jul 2022 20:33:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9b46])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b0016c1efb9195sm7662055plg.298.2022.07.12.20.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:33:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 17:33:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.19-rc6
Message-ID: <Ys49Cxqd1YOHpipB@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 48a23ec6ff2b2a5effe8d3ae5f17fc6b7f35df65:

  Merge tag 'net-5.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-06-16 11:51:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.19-rc6-fixes

for you to fetch changes up to 07fd5b6cdf3cc30bfde8fe0f644771688be04447:

  cgroup: Use separate src/dst nodes when preloading css_sets for migration (2022-06-16 09:37:02 -1000)

----------------------------------------------------------------
cgroup fixes for v5.19-rc6

This pull request contains the fix for an old and subtle bug in the
migration path. css_sets are used to track tasks and migrations are tasks
moving from a group of css_sets to another group of css_sets. The migration
path pins all source and destination css_sets in the prep stage.
Unfortunately, it was overloading the same list_head entry to track sources
and destinations, which got confused for migrations which are partially
identity leading to use-after-frees. Fixed by using dedicated list_heads for
tracking sources and destinations.

----------------------------------------------------------------
Tejun Heo (1):
      cgroup: Use separate src/dst nodes when preloading css_sets for migration

 include/linux/cgroup-defs.h |  3 ++-
 kernel/cgroup/cgroup.c      | 37 +++++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 15 deletions(-)

-- 
tejun
