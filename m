Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1917619DA96
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2020 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDCPwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Apr 2020 11:52:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35004 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCPwq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Apr 2020 11:52:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so8485254qki.2;
        Fri, 03 Apr 2020 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Za/htZk64WGRnsEWR8r2929pAGBMjmkKLkKsEbUZhBs=;
        b=D/f3vfZFF1SiLQnrJ7rrb/lAykV3v6OqChYhbcgVee38gxZWZfqb0GD7NQUHUUEVnP
         CotxEZoNUSzeFNJzkp3sTAhsrGhzfdahKtgmqAYQTlFKsUg2QTt6klbDdtCNxX3UKD+A
         HL1AE7mC8xc5PbraXwCj0VYCmbNcFq91kAurjBJOjxbt2m3UDImWk0FWUOlqFeP//Pmp
         OckC5PpYrSEXC7t7QwWuEbz2HOMGVVjhbqZqOPa6opx3L0ghYVH/Ure9CjImZ+4T5LLZ
         ReOeb1smxypWR2ST/UZJICBAKdLT4UkpAUQrx5wlUL+Wl7R7JPmLHY/Vfo7d4V9vMCre
         Ml+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=Za/htZk64WGRnsEWR8r2929pAGBMjmkKLkKsEbUZhBs=;
        b=gi0hXyrCI28JOrHQ/fc8haIeBM05bpeSFgka+Dq0AIgEmzKB1tSZwt3YcCY+2FWKu5
         mgGdNYyASpdsnA6+KpZ3/Tq0HtyD542VpQy9t/uxalUZ73t49Gr3YHlIH1TlYTT7lYbl
         FRDCLxbrdcE0kJhpxdjxrQvq57Pz9XOKnTDHFCCSxz83/FersvpCfOKPhU+GQnDeT+WZ
         e8z2TTV2Esua9awlqtIdugQY/+fgZUS8EbL41cjiiyJKWL4SpciYUgDyDjfsteX1BiMY
         L6S5iQa+//QNMQjxnRPyMVnVg+93YLOaffWy/lgm4yA6lHv+7Y6nKzJbRYkECarpUg79
         6/dA==
X-Gm-Message-State: AGi0Pubg/joyBBIsvSxsPqujuPLixicBKAFUfm05fVxezus5QnbVH3kg
        75x939DglYIRr9xAUWt9tDeTOB74s8A=
X-Google-Smtp-Source: APiQypLzguTcFK111DFmQiS//JU4ZPE6fQa4NUxfxmvPxl+oS3xFFLVGNYZI9KZnc7oa3liVXZf9oQ==
X-Received: by 2002:a37:2e44:: with SMTP id u65mr2850086qkh.42.1585929165516;
        Fri, 03 Apr 2020 08:52:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id 4sm6669594qkl.51.2020.04.03.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:52:44 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:52:43 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: [GIT PULL] cgroup changes for v5.7-rc1
Message-ID: <20200403155243.GF162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* Christian extended clone3 so that processes can be spawned into cgroups
  directly. This is not only neat in terms of semantics but also avoids grabbing
  the global cgroup_threadgroup_rwsem for migration.

* Daniel added !root xattr support to cgroupfs. Userland already uses xattrs on
  cgroupfs for bookkeeping. This will allow delegated cgroups to support such
  usages.

* Prateek tried to make cpuset hotplug handling synchronous but that led to
  possible deadlock scenarios. Reverted.

* Other minor changes including release_agent_path handling cleanup.

Thanks.

The following changes since commit 2e5383d7904e60529136727e49629a82058a5607:

  cgroup1: don't call release_agent when it is "" (2020-03-04 11:53:33 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7

for you to fetch changes up to 0c05b9bdbfe52ad9b391a28dd26f047715627e0c:

  docs: cgroup-v1: Document the cpuset_v2_mode mount option (2020-04-03 11:42:56 -0400)

----------------------------------------------------------------
Christian Brauner (6):
      cgroup: unify attach permission checking
      cgroup: add cgroup_get_from_file() helper
      cgroup: refactor fork helpers
      cgroup: add cgroup_may_write() helper
      clone3: allow spawning processes into cgroups
      selftests/cgroup: add tests for cloning into cgroups

Daniel Xu (4):
      kernfs: kvmalloc xattr value instead of kmalloc
      kernfs: Add removed_size out param for simple_xattr_set
      kernfs: Add option to enable user xattrs
      cgroupfs: Support user xattrs

Madhuparna Bhowmik (1):
      cgroup.c: Use built-in RCU list checking

Michal Koutný (1):
      cgroup: Clean up css_set task traversal

Prateek Sood (1):
      cpuset: Make cpuset hotplug synchronous

Suren Baghdasaryan (1):
      kselftest/cgroup: add cgroup destruction test

Tejun Heo (3):
      Merge branch 'for-5.6-fixes' into for-5.7
      cgroup: Restructure release_agent_path handling
      Revert "cpuset: Make cpuset hotplug synchronous"

Waiman Long (1):
      docs: cgroup-v1: Document the cpuset_v2_mode mount option

 Documentation/admin-guide/cgroup-v1/cpusets.rst   |  11 +
 fs/kernfs/inode.c                                 |  91 +++++-
 fs/kernfs/kernfs-internal.h                       |   2 +
 fs/xattr.c                                        |  17 +-
 include/linux/cgroup-defs.h                       |   5 +-
 include/linux/cgroup.h                            |  23 +-
 include/linux/kernfs.h                            |  11 +-
 include/linux/sched/task.h                        |   4 +
 include/linux/xattr.h                             |   3 +-
 include/uapi/linux/sched.h                        |   5 +
 kernel/cgroup/cgroup-v1.c                         |  34 +-
 kernel/cgroup/cgroup.c                            | 361 ++++++++++++++++------
 kernel/cgroup/cpuset.c                            |   8 +-
 kernel/cgroup/pids.c                              |  15 +-
 kernel/fork.c                                     |  19 +-
 mm/shmem.c                                        |   2 +-
 tools/testing/selftests/cgroup/Makefile           |   6 +-
 tools/testing/selftests/cgroup/cgroup_util.c      | 126 ++++++++
 tools/testing/selftests/cgroup/cgroup_util.h      |   4 +
 tools/testing/selftests/cgroup/test_core.c        | 177 +++++++++++
 tools/testing/selftests/clone3/clone3_selftests.h |  19 +-
 21 files changed, 795 insertions(+), 148 deletions(-)

-- 
tejun
