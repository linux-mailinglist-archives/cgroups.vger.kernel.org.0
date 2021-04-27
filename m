Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1641036C81A
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhD0O5D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhD0O5C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 10:57:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A9C061574;
        Tue, 27 Apr 2021 07:56:17 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h15so19295806qvu.4;
        Tue, 27 Apr 2021 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NnSA+nWh0rBNTmeoPOnQ0TPq2BsER9tVNRP8Acu7TPc=;
        b=Klrrv9sBhGLpydc+azHgNuqL7vDvN9teKG9RkVbuqgJP81giP/YgVK3DmRnWBNIADw
         5GOMNf36NeA2qawEPgt8o45VsQWr6zSvGT/aaYp4OqykAkIigQvg+0ATahCfX16sVQ+e
         Eqr+URa6kXlw95BD8T3qhZ0qk9+eSwH1VkGzDb5tyRWqMUzNQtdTGLmnCf/d/W3EP3y2
         lwrE5hh1kaZ3UqDUSfG2pbXI8OZmRTnDjWpqAE9CYpWBfvIzfSwg2niE8dCgOVv2egVs
         dzhnipYLxB0wIb5m0u16xgwvHXnG0oq6bszm9UOulXC20pu+0mp2u6uZgazMHgQSBZAu
         zurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=NnSA+nWh0rBNTmeoPOnQ0TPq2BsER9tVNRP8Acu7TPc=;
        b=M79s+snhtJNhDsyFQqIRRjgwAU5lSv22QtWoHdacBaVA4xrJuDPz6AYeqAPzD9nTus
         ID932fW9RN0pxIyiSUG+aXyQS/vw4TDnPDPdJ5kVqqCXN29XY6FOojFaIkistzFEAGfM
         GXX+qEXXxWOh/lZPy9CgaBhxzUC4I7aeWoDkdWJVhoHq3FY4b2i3vnakvQsykIcdTv10
         SEdtwkWW8VY4piYAFW3iOSwLm9TsMUBcuVleSHeWshKriu4MDX6BvE4urJTQIXBQYlro
         acWofBW6PQFKJTUbhoaBWXs4QtTjqGvqpJmGTqXCEWfQAmAy4srHWbsIIN/lIPENJdky
         /0aA==
X-Gm-Message-State: AOAM5305LTYEg7fbjpqIX/i8UUpnWJIIJDou5hgLPN4UFksQH+VNRRxE
        0DLBGCYTcSpyObkXfSNLHbc7mP7mBCoB2w==
X-Google-Smtp-Source: ABdhPJw/M8byKTnJ9HCLhU0XXdVTBPHJW8/t6v/ZebyN5zTM6qB6dPBKiRhoWokp5kqcDscBfJPBDA==
X-Received: by 2002:a0c:f78e:: with SMTP id s14mr23686861qvn.46.1619535376852;
        Tue, 27 Apr 2021 07:56:16 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id k11sm56146qth.34.2021.04.27.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:56:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Apr 2021 10:56:15 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup changes for v5.13-rc1
Message-ID: <YIgmD4t2UM7lSXYz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

The only notable change is Vipin's new misc cgroup controller. This
implements generic support for resources which can be controlled by simply
counting and limiting the number of resource instances - ie. there's X
number of these on the system and this cgroup subtree can have upto Y of
those. The first user is the address space IDs used for virtual machine
memory encryption and expected future usages are similar - niche hardware
features with concrete resource limits and simple usage models.

Thanks.

The following changes since commit 2023a53bdf41b7646b1d384b6816af06309f73a5:

  Merge tag 'for-linus' of git://github.com/openrisc/linux (2021-04-03 15:42:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13

for you to fetch changes up to ffeee417d97f9171bce9f43c22c9f477e4c84f54:

  cgroup: use tsk->in_iowait instead of delayacct_is_task_waiting_on_io() (2021-04-16 16:49:37 -0400)

----------------------------------------------------------------
Chunguang Xu (1):
      cgroup: use tsk->in_iowait instead of delayacct_is_task_waiting_on_io()

Lu Jialin (1):
      cgroup/cpuset: fix typos in comments

Tejun Heo (1):
      cgroup: misc: mark dummy misc_cg_res_total_usage() static inline

Vipin Sharma (3):
      cgroup: Add misc cgroup controller
      cgroup: Miscellaneous cgroup documentation.
      svm/sev: Register SEV and SEV-ES ASIDs to the misc controller

 Documentation/admin-guide/cgroup-v1/index.rst |   1 +
 Documentation/admin-guide/cgroup-v1/misc.rst  |   4 +
 Documentation/admin-guide/cgroup-v2.rst       |  73 ++++-
 arch/x86/kvm/svm/sev.c                        |  70 ++++-
 arch/x86/kvm/svm/svm.h                        |   1 +
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/misc_cgroup.h                   | 132 +++++++++
 init/Kconfig                                  |  14 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/cgroup-v1.c                     |   2 +-
 kernel/cgroup/cpuset.c                        |   6 +-
 kernel/cgroup/misc.c                          | 407 ++++++++++++++++++++++++++
 12 files changed, 699 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/admin-guide/cgroup-v1/misc.rst
 create mode 100644 include/linux/misc_cgroup.h
 create mode 100644 kernel/cgroup/misc.c

-- 
tejun
