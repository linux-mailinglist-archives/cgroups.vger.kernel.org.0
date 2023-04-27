Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6658C6F0D7F
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjD0Ux6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbjD0Uxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 16:53:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F871BCB;
        Thu, 27 Apr 2023 13:53:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6715ee82fso93041085ad.1;
        Thu, 27 Apr 2023 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682628833; x=1685220833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/5HWPeVY1MQbyixrvVym4tZ22GEw9R6F1zseVGpafmk=;
        b=emB5v8zA8+Re9OPy+eYSmdTZbC5NAZo0kYdTWKXuC1+PTSPgR9LZnp07/I0f0ex2G2
         o4Bedy0IxCUyuZAm/IjGAz95AVan+L+JB283acbS4a9hjICkG4afU3tRr2wSdBj9HiCh
         G2hQSvfdPP4k9dEguUChEcjfn+P/hQTPisKO50Lz4jMJDiOCv+OmadAwWhAYUSxrr0do
         98BUMbuNcRtlJQK4PAl9KfjI0ZVtcysgNM3JdRIof9jG0pdi7mJatyO4Ip8B1wovVtvZ
         bhIofXEThLitec/y5p1rEDbbo7zc9tJ6ODxoaWYMhXlUoKFkWK6yT6FqeKsME4twVQ45
         ahQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628833; x=1685220833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5HWPeVY1MQbyixrvVym4tZ22GEw9R6F1zseVGpafmk=;
        b=OBrVMk2gJGjNX51VoFUfEcCKo6/bB/88Nf+5flZTKC2k34Q50TfPL9Fs0CikZGjr2I
         xybG1w0dSNfbSXBRzgsi0GK21K5siOEBct7R6lejALP5wSN7NAVQHiwnBbg59/u/OkId
         W29IztcznuLs+aiFHGrnS/615M10OZpEUO+MKN4vsmN+wyE3Uh16eJGJ6yao1LOewhi+
         KgMoSJh84RDAEhvdivvNNyLYajlMztVpcgVMmALkRT+UedHV+eOIvCDhI+8hT0DlWIaW
         b/mEWta+2mCej/nuZVTIlAJq38iQFvxDgv/B/SrKv0GwGEyxXC4ib0LvxU59CIEwWnx2
         Rdew==
X-Gm-Message-State: AC+VfDxz3VOnetb7EyInQ2OohIaIALPAOaFFnuP/Uv1oXHQpG1EgSMZS
        d4+Yg3+qWolrubVoExcbej1+NzO0Tbs=
X-Google-Smtp-Source: ACHHUZ6nowdw4FFYg8bfdI8w+PApjBFH6JLx3NdJRskT0XzHWQgFkxXpmk50Jg3MqcKX7Ka8Ai/jzw==
X-Received: by 2002:a17:902:d4c6:b0:1a6:71b1:a0b9 with SMTP id o6-20020a170902d4c600b001a671b1a0b9mr3255637plg.47.1682628832942;
        Thu, 27 Apr 2023 13:53:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001a6ed2d0ef8sm12076718plb.273.2023.04.27.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:53:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 27 Apr 2023 10:53:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [GIT PULL] cgroup changes for v6.4-rc1
Message-ID: <ZErg3xZyhlVx_Mw0@slm.duckdns.org>
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

The following changes since commit 292fd843de26c551856e66faf134512c52dd78b4:

  cgroup/cpuset: Fix partition root's cpuset.cpus update bug (2023-03-29 08:37:07 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.4

for you to fetch changes up to 9403d9cb564b6a3af86cb18fe722097ed7620f6f:

  docs: cgroup-v1/cpusets: update libcgroup project link (2023-04-14 06:55:48 -1000)

----------------------------------------------------------------
cgroup changes for v6.4-rc1

* cpuset changes including the fix for an incorrect interaction with CPU
  hotplug and an optimization.

* Other doc and cosmetic changes.

----------------------------------------------------------------
Haifeng Xu (1):
      cpuset: Clean up cpuset_node_allowed

Kamalesh Babulal (2):
      cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
      docs: cgroup-v1/cpusets: update libcgroup project link

Tejun Heo (1):
      Merge branch 'for-6.3-fixes' into for-6.4

Waiman Long (3):
      cgroup/cpuset: Skip task update if hotplug doesn't affect current cpuset
      cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset are updated
      cgroup/cpuset: Minor updates to test_cpuset_prs.sh

 Documentation/admin-guide/cgroup-v1/cpusets.rst   |  2 +-
 include/linux/cpuset.h                            | 16 +-----
 kernel/bpf/cgroup.c                               | 38 +++++++-------
 kernel/bpf/cgroup_iter.c                          |  4 +-
 kernel/bpf/local_storage.c                        |  4 +-
 kernel/cgroup/cgroup-v1.c                         | 16 +++---
 kernel/cgroup/cgroup.c                            | 60 +++++++++++------------
 kernel/cgroup/cpuset.c                            | 30 +++++++-----
 mm/page_alloc.c                                   |  4 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 25 +++++-----
 10 files changed, 99 insertions(+), 100 deletions(-)
