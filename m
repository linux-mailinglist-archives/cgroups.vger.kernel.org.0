Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332D6E17D4
	for <lists+cgroups@lfdr.de>; Fri, 14 Apr 2023 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMXDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Apr 2023 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMXDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Apr 2023 19:03:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E96A2;
        Thu, 13 Apr 2023 16:03:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id lh8so3660577plb.1;
        Thu, 13 Apr 2023 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681427013; x=1684019013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D/XQvUMbd184V0d688Zwv75YAW0duMFHkNATV/mO7aw=;
        b=h4UtgBPumQArhAxQCuQPYMTKctURq6HR3viTzmbHWGpGY814xtwyXhtOruu4Gr2MKW
         WJIRqalJgwnq5W8HTNGZPk6plfg8WoJoXTFDG2p24lycnFLqgZQPK/nRw4gjOHPgCNNn
         q+KRpfwDpnuykgOiYgnoRJzV+rShDe6RYDRC4Kl69kBJs1RlBdfJ3ElsG6qBdgem/H+y
         WPpnlvsMgGvpCqydYphqJUWP6Td1CpcKD+QTkYfz8xBsUSjvTWBl6xdpa7TIUTtPtumI
         F9Q/28MgGIOqbvW8i1xVfp7UngobLIX5PiloGu0gtvc1cQmb2xi221N1nJleujA4TcSg
         SUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427013; x=1684019013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/XQvUMbd184V0d688Zwv75YAW0duMFHkNATV/mO7aw=;
        b=G0/bHSFYgBHQEVoEt/8sWC276eah2+spgNPlTJF5OdCng5+rPpArx7PLUqnbAxUvcz
         lg8oNJ326GUEnLeJaMkJKJPzaoyeAAI+ebzp4cHlnpfwMkCSRi88IxSVGjXwgbyd5CJT
         A2DLd3WVWo8roomw/DWKzEGDpHmmO0fdoyXLDLxT+VtGNvvpql7oBLw9LscKcNCTSEd9
         htexoqcJuhVGas+WgndufDEVl06JJunz6/sV0gFQGSl3Kuf5jjggL3027czDlTiXxDD9
         cwNuf1NbyPCaYaEwtzw0enjAUnhL5UDG3awrclPSWyPS9zFjVNM+KnlMsZSOsup61Wkr
         p+WQ==
X-Gm-Message-State: AAQBX9fayOnew0I4j2dYZ1Xl39YYZhkX8BNd274xk0j7FN2vX5XATqRe
        ebMaFaLOskuQ5s2r4HKIS+umy4JVBYM=
X-Google-Smtp-Source: AKy350YCRWZETtmNpl+6tfX+EwKUUhjI/gO+2pM1Jjg4upo6vfj+DkbnJ+jk6O10mNDai/mphTjuBA==
X-Received: by 2002:a17:902:e745:b0:1a2:a8d0:838e with SMTP id p5-20020a170902e74500b001a2a8d0838emr565131plf.61.1681427013126;
        Thu, 13 Apr 2023 16:03:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a8ce])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b001a217a7a11csm1952130pll.131.2023.04.13.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:03:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Apr 2023 13:03:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v6.3-rc6
Message-ID: <ZDiKQ7Bia-ki3Vmh@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21:

  Merge tag 'block-6.3-2023-03-16' of git://git.kernel.dk/linux (2023-03-17 11:20:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.3-rc6-fixes

for you to fetch changes up to 7e27cb6ad4d85fc8bac2a2a896da62ef66b8598e:

  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset (2023-04-12 08:23:58 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.3-rc6

* Fix several cpuset bugs including one where it wasn't applying the target
  cgroup when tasks are created with CLONE_INTO_CGROUP.

* Fix inversed locking order in cgroup1 freezer implementation.

* Fix garbage cpu.stat::core_sched.forceidle_usec reporting in the root
  cgroup.

This is a relatively big pull request this late in the cycle but the major
contributor is the above mentioned cpuset bug which is rather significant.

----------------------------------------------------------------
Josh Don (1):
      cgroup: fix display of forceidle time at root

Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex

Waiman Long (5):
      cgroup/cpuset: Fix partition root's cpuset.cpus update bug
      cgroup/cpuset: Wake up cpuset_attach_wq tasks in cpuset_cancel_attach()
      cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
      cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
      cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset

 kernel/cgroup/cpuset.c         | 178 +++++++++++++++++++++++++++++++++--------
 kernel/cgroup/legacy_freezer.c |   7 +-
 kernel/cgroup/rstat.c          |   4 +-
 3 files changed, 150 insertions(+), 39 deletions(-)
