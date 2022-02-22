Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EF4C0432
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 22:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiBVV7f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 16:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiBVV7f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 16:59:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A53799ECB;
        Tue, 22 Feb 2022 13:59:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso303412pjj.2;
        Tue, 22 Feb 2022 13:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ZD9aczGWM/RyGSNkYUTlRQgGJLx3CbLeoXY5+amhhW4=;
        b=hwJbYCxcK63zg7KrWjPb+4bg3PQWZ57DqhR7888nkaxNFUdkMo2Jkc8ZxAkFQP2AKX
         HERYhbUli2++fWI6akh0iGzAvztV4FFXuMi/OkQYugOPuqVDmnlbETT0YJYi711/9ihv
         NCZQ+/1g6Y+/VOFBh/GSjoVwvneMELHlH9OSGC9o3sLQC9uKvToXg45fpVyi0u7oFGYq
         wJr+1243JGXb908MFwC1Yade86/BQ94ikg2WcEmg3d9OP+m8yr2Wds1N8tNGBfzGMoDP
         l8zpp5rOBM2ffqFEMiuMJ5inGqiAT0DpA5a9I2AGQD5XPjCnSXt3gd+hYsf5HwYyOVmM
         aFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=ZD9aczGWM/RyGSNkYUTlRQgGJLx3CbLeoXY5+amhhW4=;
        b=TApsJ0EmVDMhnIGWWoea4kdm0AMGqy/P/08gFbq1OGc0Ibgwd92foW/uM1NiXIerj0
         GBHYdn9dXjsguLQ9ArxFBU9Dc0mvAeTivbkPhLSFKs6tsx0MFneo+yUs6lBRktCeVqMU
         mW965EvHBvfjGKaEXH3ZTUAzWBV0V+rBZC806lWxGT2/CjMh+3yYy6gdUzKQg+jLf/l9
         ZDsP/CVIhhuR8ND2OL0dRH1mNFCQeCsbalKS95n+h/donYFJsOml3+LFmuJX9mnWPP29
         o7jjrh0XOwzAbrETTsuQJb3ClnYmDvn1st9786ZzaYqmeKuKvyUjm/Wo0oWEZVn8Filn
         HSOA==
X-Gm-Message-State: AOAM533BswFNZrtoYrq/uNJFjy/N6JarC3zcaVqISzZn2meEfAZdj1yX
        3UkP/3t0aFIvVM6R0VCn5tk=
X-Google-Smtp-Source: ABdhPJzuGUzxWs/2zIbMIp6P45Xd902NY6SfgZGgTSMudH8S7fucSNXJEtq0bTVBT4iAgpNkzYRh+w==
X-Received: by 2002:a17:90a:a887:b0:1bc:388a:329f with SMTP id h7-20020a17090aa88700b001bc388a329fmr6160110pjq.17.1645567148487;
        Tue, 22 Feb 2022 13:59:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s11sm19152570pfk.8.2022.02.22.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:59:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 11:59:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.17-rc5
Message-ID: <YhVcqpUHepfxgL88@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

* Fix for a subtle bug in the recent release_agent permission check update.

* Fix for a long-standing race condition between cpuset and cpu hotplug.

* Comment updates.

Thanks.

The following changes since commit 2bdfd2825c9662463371e6691b1a794e97fa36b4:

  cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning (2022-02-03 05:59:01 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes

for you to fetch changes up to c70cd039f1d779126347a896a58876782dcc5284:

  cpuset: Fix kernel-doc (2022-02-22 09:49:49 -1000)

----------------------------------------------------------------
Christian Brauner (1):
      cgroup: clarify cgroup_css_set_fork()

Jiapeng Chong (1):
      cpuset: Fix kernel-doc

Michal Koutný (1):
      cgroup-v1: Correct privileges check in release_agent writes

Zhang Qiao (1):
      cgroup/cpuset: Fix a race between cpuset_attach() and cpu hotplug

 kernel/cgroup/cgroup-v1.c |  6 ++++--
 kernel/cgroup/cgroup.c    | 14 ++++++++++++++
 kernel/cgroup/cpuset.c    | 12 +++++++-----
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
tejun
