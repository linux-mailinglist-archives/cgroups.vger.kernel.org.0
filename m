Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB73B97D1
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhGAU6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 16:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhGAU6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 16:58:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF2C061762;
        Thu,  1 Jul 2021 13:55:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i13so4344433plb.10;
        Thu, 01 Jul 2021 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TQW637DJWCb83mxa1TulL3O+huq6X3gVUkozf2I06Ng=;
        b=gfZSgzXRqgwx54Zblgxw7Xi9NZcW0FpG16mhu1b5ogzLFdIrYmuD6V8X8ax2hz6YdP
         3s1+mx46q6P3hMQGw1rNAw9t3775zD+SZXrYP9krYeVzI2FIDHeCmWlQFaBKzvYE3EUD
         4MxbJRqvVZLYPx2r9+02tsEj09Ys1OQS97u04r9IRwLHm4+FEtBZ/MRiM3EY5lXTlpLe
         /lAIW6fPLkg33RvZdWC5jQyIN5T2zglMEHGdZ5467wV21ekrLDm5ZT+Q6l/7HDJD59WU
         x+UrMAZildRvNBQx3VeD0z3K+FNKXKekGMd3JOk4XsgVkJBmvCRXt8yBruhzdKDhlJT4
         KZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=TQW637DJWCb83mxa1TulL3O+huq6X3gVUkozf2I06Ng=;
        b=b7eYVuUseyCKbf6wXZ2p4DtwOjrMNpoH7eyhSclNhLcyaWm0MGUrbggjCRuYEHU1wI
         zBHGfCYBnZr6yFJ/DBl3moCpXp0TAQ71ZLPN+MMfDQki0rnWbp8vZS2jhYy4J08snJYp
         xAGOuyb+z2hmirQM19ewAIufws/2l2mNvxRwavM/dA6NLiN94mbHd8N9ezeOOAojogPP
         xJyuEriTk4u/ZrSxx4UHUDzyr1ZGx8ndqA41670smDKOOXoAl72sgYuPWLoindQQVjTq
         79sV+fmtaNV3MVGy0FGsc7MPnIIuZh+I9Crav4PXlAWWQ+SUvvqR4YXUPuIIzIOOmOc2
         vyrQ==
X-Gm-Message-State: AOAM531aGO8wTso3QxJRMoB59bYKlRzlzw2LRe9IO06mbWCYV3NtOkN/
        hABQEVHFMwwnpbGbTdpidwXZhDb/MCuxkw==
X-Google-Smtp-Source: ABdhPJxjLG8SAhUEhMHCo+vg0dklXUdaMnIKBJCTSuLYDhLQo5H2cxShu3ZD2aAXP0ZBZnxukroLaA==
X-Received: by 2002:a17:90a:3ccf:: with SMTP id k15mr1464917pjd.226.1625172944439;
        Thu, 01 Jul 2021 13:55:44 -0700 (PDT)
Received: from localhost ([2600:380:7547:7ebc:47d6:2ed3:f5f0:d329])
        by smtp.gmail.com with ESMTPSA id o34sm862453pgm.6.2021.07.01.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:55:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Jul 2021 10:55:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.14-rc1
Message-ID: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* cgroup.kill is added which implements atomic killing of the whole subtree.
  Down the line, this should be able to replace the multiple userland
  implementations of "keep killing till empty".

* PSI can now be turned off at boot time to avoid overhead for
  configurations which don't care about PSI.

Thank you.

The following changes since commit 08b2b6fdf6b26032f025084ce2893924a0cdb4a2:

  cgroup: fix spelling mistakes (2021-05-24 12:45:26 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14

for you to fetch changes up to 3958e2d0c34e18c41b60dc01832bd670a59ef70f:

  cgroup: make per-cgroup pressure stall tracking configurable (2021-06-08 14:59:02 -0400)

----------------------------------------------------------------
Christian Brauner (5):
      cgroup: introduce cgroup.kill
      docs/cgroup: add entry for cgroup.kill
      tests/cgroup: use cgroup.kill in cg_killall()
      tests/cgroup: move cg_wait_for(), cg_prepare_for_wait()
      tests/cgroup: test cgroup.kill

Roman Gushchin (1):
      cgroup: inline cgroup_task_freeze()

Suren Baghdasaryan (1):
      cgroup: make per-cgroup pressure stall tracking configurable

Tejun Heo (1):
      Merge branch 'for-5.13-fixes' into for-5.14

Yang Li (1):
      cgroup: Fix kernel-doc

 Documentation/admin-guide/cgroup-v2.rst         |  15 ++
 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 include/linux/cgroup-defs.h                     |   4 +
 include/linux/cgroup.h                          |  25 +-
 kernel/cgroup/cgroup.c                          | 180 ++++++++++++--
 kernel/cgroup/rstat.c                           |   2 +-
 kernel/sched/psi.c                              |  30 +--
 tools/testing/selftests/cgroup/.gitignore       |   3 +-
 tools/testing/selftests/cgroup/Makefile         |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c    |  51 ++++
 tools/testing/selftests/cgroup/cgroup_util.h    |   2 +
 tools/testing/selftests/cgroup/test_freezer.c   |  57 -----
 tools/testing/selftests/cgroup/test_kill.c      | 297 ++++++++++++++++++++++++
 13 files changed, 569 insertions(+), 108 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_kill.c

-- 
tejun
