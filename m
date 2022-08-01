Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53476586F42
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiHARGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiHARGE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 13:06:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C50DA8;
        Mon,  1 Aug 2022 10:06:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q16so10217213pgq.6;
        Mon, 01 Aug 2022 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=/GdX+TR/Dtbf4gZ83aEvjO8naUsD3U4cGz+frlvpnOI=;
        b=o49/EjuQpvSTcPsbZwuHWglxkwKdt473C3AZnhHy9r95Q0aLNcUJsXd7JMPC1RZLDB
         UThRymlZAgKSpv7WLErK8CBS11UOIaaKAUnZ32jfIfULDBS9ODMUNx7BZdTY2zF0Kmzm
         tE399kMtdOorrioGu8LSAJLHUPlcKNrtz1VDKC0nPSLULkKrGHCLoM5vO35C1eeED3Rw
         PeS8Ex5Xzfz1Quw2pmDzulr5CJ6vs8LucMdBAfQvwUwe9XE00Wohi+Dxm0W7VM60P3J5
         lsvT7HDn7Ow3XiGODf4hEGrNtCMGA6wqThEn+fli4G0eMV5qHv4obY0Gd1PVZBj2rjfo
         GQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=/GdX+TR/Dtbf4gZ83aEvjO8naUsD3U4cGz+frlvpnOI=;
        b=DexX7S8dWXTsbPJGlvprnm4s6NM7NTiJASfmkZ3DjmtrPj+NnqUGY2xv1vX8OOXSOj
         oO2oVZWw1NdelwJYyT+bojZjHlLhfOeKZtyd71F939xyOXiE5qLDVglwF27RoSwqzsmS
         XM9C7Jx/xeu79vlrj03QhprtG1uSFB3tYlU/L8P97PqYg4hbCnbnV5eKLfx3TTF6bFGW
         JlHtVLia/GZb6n+Uh4ZabuIrZpMyYxwHS+0OkK5APXYeNOVPy2UfqC4zyGhJWzX5GChf
         5WHUVIr32sVMLE/Vb9y78KDN1h3MoUvGfFm/7w9+747HhMQ/05qFd3udIVKINLYHzfSC
         GqJg==
X-Gm-Message-State: ACgBeo0UrM8qSU2/Ktc6urcOSdLK5/5QNMiWIK51GUqucXNFWoXfK1aw
        1RuAUdLMosJvIojjEKnQT0JXBXwlCS0=
X-Google-Smtp-Source: AA6agR5s5Zfk3FtUy7YsJFbbCSJCmURCfncv4qh4gGsK3lo8q1nAgdMpbls2WZiXh5ba7LysV86iqg==
X-Received: by 2002:a63:5b21:0:b0:41c:2292:b2e7 with SMTP id p33-20020a635b21000000b0041c2292b2e7mr4200768pgb.46.1659373561722;
        Mon, 01 Aug 2022 10:06:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090ade1700b001f02a72f29csm5487495pjv.8.2022.08.01.10.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:06:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 1 Aug 2022 07:05:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup changes for v5.20-rc1
Message-ID: <YugH95n04DM6yRta@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit e71e60cd74df9386c3f684c54888f2367050b831:

  Merge tag 'dma-mapping-5.19-2022-06-06' of git://git.infradead.org/users/hch/dma-mapping (2022-06-06 17:56:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.20

for you to fetch changes up to 265792d0dede9259f0ca56bb3efcc23eceee7d01:

  cgroup: Skip subtree root in cgroup_update_dfl_csses() (2022-07-28 07:26:30 -1000)

----------------------------------------------------------------
Several core optimizations:

* threadgroup_rwsem write locking is skipped when configuring controllers in
  empty subtrees. Combined with CLONE_INTO_CGROUP, this allows the common
  static usage pattern to not grab threadgroup_rwsem at all (glibc still
  doesn't seem ready for CLONE_INTO_CGROUP unfortunately).

* threadgroup_rwsem used to be put into non-percpu mode by default due to
  latency concerns in specific use cases. There's no reason for everyone
  else to pay for it. Make the behavior optional.

* psi no longer allocates memory when disabled.

along with some code cleanups.

----------------------------------------------------------------
Chen Wandun (1):
      psi: dont alloc memory for psi by default

Lin Feng (2):
      cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated codes
      cgroup.c: remove redundant check for mixable cgroup in cgroup_migrate_vet_dst

Tejun Heo (4):
      cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree
      cgroup: Add "no" prefixed mount options
      cgroup: Make !percpu threadgroup_rwsem operations optional
      cgroup: remove "no" prefixed mount options

Waiman Long (1):
      cgroup: Skip subtree root in cgroup_update_dfl_csses()

 Documentation/admin-guide/cgroup-v2.rst |   8 ++
 include/linux/cgroup-defs.h             |  21 ++++-
 include/linux/cgroup.h                  |   2 +-
 init/Kconfig                            |  10 +++
 kernel/cgroup/cgroup-internal.h         |   1 +
 kernel/cgroup/cgroup-v1.c               |  17 +++-
 kernel/cgroup/cgroup.c                  | 136 ++++++++++++++++++++------------
 kernel/sched/psi.c                      |  19 +++--
 8 files changed, 151 insertions(+), 63 deletions(-)
