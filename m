Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D966218F48
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEIRgq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 13:36:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43057 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRgq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 13:36:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id z6so1120388qkl.10;
        Thu, 09 May 2019 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iom6SqE2pGkNK9Z5BBYeoQQuW8YcGD2ELbPKlGymboM=;
        b=cs0FXI2lpYwghUSDOf097f2v6Rt4diQmigrD+c/Xo1713L8qT08oedAGfjEbWsJUYJ
         Y4uKJTdVdNlH5L2MyZL/0C5q/QLyE+ubVYeRFqZX8QwccR9HwEcpxshclYF2cqqOMnBL
         ArKHoK9IiybB9p/TBSc6izdky9KEgTCNrSG3YfvQ5t+M1AsJdSrAr23HIhrXJJ8a1+OZ
         6DiXvnfAxygTWRdUtaronQth1170tRMp467SFEcmAwqwIOvJSO9k64YUc5qLMAbbjhDT
         KLFHGOIbXHgb3WyyF+MGnwAIvJejG1ZOLF7KZ4/O+H7WoXMreTJzTS7OfgJbDsYUqCGA
         9WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iom6SqE2pGkNK9Z5BBYeoQQuW8YcGD2ELbPKlGymboM=;
        b=GlKDBxSwjK81S4HsifJV7Z4HC0FqGXQvlMOxVuQ94dbc1ZUQSzjuwu3i6GSnGl+/9v
         xObkClwB1/JKWP64Nb82TfddP3CKFtZlBS3gbyweyTGCtrW/l1PKK/FvPmnIFmj6uk5/
         QDTyRlDj88nYyAxyBYpgfhXg9L+SdPSUpCjJCgFYh/ITK/JNPUCCcH0fPYO5CK8Dk+Yx
         EJ+Qifv1Sa6vmObEFtdJT3xCC8uJRMBrtFHaPc8qP4bUPhDgWnNFOPBV6n17hxQYiKly
         vIDSIjOly0++xocrf/SfCBOtpI0gDpvYN9W2EJInExQAnfTBxdxlEHtAPqalrM1PRS02
         P3vg==
X-Gm-Message-State: APjAAAU3tPqi4muh1dui4m0EIsU0ftUUPgBJ+E3k1qtOs+0ocicdgRvh
        fSrdyKn/iNLQKVSbVU15KiE=
X-Google-Smtp-Source: APXvYqxjQ7swkRK1YRWZ4ss04zp7hmROFHao0gs+Me0/F62lHiaZreba66C0xaFRZCf49sR/6+o1Tw==
X-Received: by 2002:a37:5945:: with SMTP id n66mr4312900qkb.295.1557423405211;
        Thu, 09 May 2019 10:36:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id f129sm1316130qkj.47.2019.05.09.10.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:36:44 -0700 (PDT)
Date:   Thu, 9 May 2019 10:36:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] cgroup changes for v5.2-rc1
Message-ID: <20190509173642.GA374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

This pull request includes Roman's cgroup2 freezer implementation.
It's a separate machanism from cgroup1 freezer.  Instead of blocking
user tasks in arbitrary uninterruptible sleeps, the new implementation
extends jobctl stop - frozen tasks are trapped in jobctl stop until
thawed and can be killed and ptraced.  Lots of thanks to Oleg for
sheperding the effort.

Other than that, there are a few trivial changes.

Thanks.

The following changes since commit 145f47c7381d43c789cbad55d4dbfd28fc6c46a4:

  Merge tag '5.1-rc3-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2019-04-03 20:21:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2

for you to fetch changes up to f2b31bb598248c04721cb8485e6091a9feb045ac:

  cgroup: never call do_group_exit() with task->frozen bit set (2019-05-09 07:56:47 -0700)

----------------------------------------------------------------
Fuqian Huang (1):
      kernel: cgroup: fix misuse of %x

Roman Gushchin (12):
      cgroup: rename freezer.c into legacy_freezer.c
      cgroup: implement __cgroup_task_count() helper
      cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
      cgroup: cgroup v2 freezer
      kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
      kselftests: cgroup: add freezer controller self-tests
      cgroup: make TRACE_CGROUP_PATH irq-safe
      cgroup: add tracing points for cgroup v2 freezer
      cgroup: document cgroup v2 freezer interface
      cgroup: prevent spurious transition into non-frozen state
      cgroup: get rid of cgroup_freezer_frozen_exit()
      cgroup: never call do_group_exit() with task->frozen bit set

Shakeel Butt (1):
      cgroup: remove extra cgroup_migrate_finish() call

Shaokun Zhang (1):
      cgroup: Remove unused cgrp variable

 Documentation/admin-guide/cgroup-v2.rst       |  27 +
 include/linux/cgroup-defs.h                   |  33 +
 include/linux/cgroup.h                        |  43 ++
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 include/trace/events/cgroup.h                 |  55 ++
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   8 +-
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 152 ++++-
 kernel/cgroup/debug.c                         |   8 +-
 kernel/cgroup/freezer.c                       | 639 +++++++------------
 kernel/cgroup/legacy_freezer.c                | 481 +++++++++++++++
 kernel/fork.c                                 |   2 +
 kernel/signal.c                               |  66 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  58 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   5 +
 tools/testing/selftests/cgroup/test_freezer.c | 851 ++++++++++++++++++++++++++
 20 files changed, 2012 insertions(+), 443 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
tejun
