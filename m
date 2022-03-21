Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D564E3193
	for <lists+cgroups@lfdr.de>; Mon, 21 Mar 2022 21:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiCUURp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Mar 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiCUURp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Mar 2022 16:17:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA245AFF;
        Mon, 21 Mar 2022 13:16:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i11so13020660plr.1;
        Mon, 21 Mar 2022 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H5h/m458Q7wYqGc+3uQIHPjw143NJQEVleeRF9aQtyI=;
        b=DOmbSvaV5SAVC3ugCRngQsMixY5lvDsFiyMunecammQfl0Gf5b+ThHvaVvxxyOWHru
         jHqfr0edtm4anbxQDhXIKIEi5p/OGGHf6JKH2asyxA4EBM7jm97RJdoFg8jAc2+12OwN
         XWPawlMTUJ6srDY4NhOv8VAg+h6Q9hzsT79TUt6vRHJbwrMoQlHTUItS31izjo+aTBEx
         BUOykWK5iERg9CnVQeSpYxR0N2rB3X63J8KvIzXztZ4N+F4A6DH77lKbU20Oau6jxdYV
         +JziBrbJ/M9bE+2KEV4/WDz8AWlAEpw9N5cJoRfOyhP5PlGoLgih1KGlIz7uYbd1AZL0
         mdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=H5h/m458Q7wYqGc+3uQIHPjw143NJQEVleeRF9aQtyI=;
        b=th3/T7lHJRRHJyjDnzLxg0p8ZhGV1oD5PsR3fMnR7VKiMW+EIt4jLAXKuSCHEyaxMt
         pfaB2I1p6L4ZcjOnV/dzjH3bPTUAQrjWx0ixDLfuFZMd7JxGzL/pwdkFTCK4zzhYp/FI
         gSBQ2SFTVIbW+qcFoVTJdYERAAkpUftSc65WDs6VD2uaT8iURIsB6oCL+wwOetJbkyoE
         UL3K9NpnVjgiLZjNUQQG8flFaSddMkDXPe3McoNbeqkJAdX0tM8nVf56HNfErIGxbBpy
         Sl41OEjWZMaM3KxS4vwCjq53wf1vCjfLslpKKX4SV/i47jBgVZlvBf3wQhVMURLhqmjy
         5Kmg==
X-Gm-Message-State: AOAM533MpFsNZDWzpt4nJqB4S+Fhlx79h+tsSGfTH5srIN2nd/cwHmNM
        tH28tRm9Rs9BLyUyquay7NA=
X-Google-Smtp-Source: ABdhPJwuyh8n6M9IDtQpzxHy0DC8t0UvSFdPgrPDBMJIh3dN3t1ReiQev38rRI+AbQ9zx5SXg6oBBg==
X-Received: by 2002:a17:902:e806:b0:154:38d6:71d4 with SMTP id u6-20020a170902e80600b0015438d671d4mr11300220plg.31.1647893778939;
        Mon, 21 Mar 2022 13:16:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090a481100b001c6a662dd58sm287254pjh.7.2022.03.21.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:16:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 10:16:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.18-rc1
Message-ID: <YjjdEUPIoYyPjsvh@slm.duckdns.org>
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

Hello,

All trivial cleanups without meaningful behavior changes.

Thanks.

The following changes since commit daadb3bd0e8d3e317e36bc2c1542e86c528665e5:

  Merge tag 'locking_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2022-01-11 17:24:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18

for you to fetch changes up to f9da322e864e5cd3dc217480e73f78f47cf40c5b:

  cgroup: cleanup comments (2022-03-13 19:19:27 -1000)

----------------------------------------------------------------
Tom Rix (1):
      cgroup: cleanup comments

Wei Yang (2):
      cgroup: rstat: use same convention to assign cgroup_base_stat
      cgroup: rstat: retrieve current bstat to delta directly

Yang Li (1):
      cgroup: Fix cgroup_can_fork() and cgroup_post_fork() kernel-doc comment

 kernel/cgroup/cgroup.c  |  2 ++
 kernel/cgroup/cpuset.c  | 10 +++++-----
 kernel/cgroup/freezer.c |  2 +-
 kernel/cgroup/rstat.c   |  5 ++---
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
tejun
