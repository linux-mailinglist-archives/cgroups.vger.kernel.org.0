Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA87692293
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBJPrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBJPrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 10:47:47 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CC70736;
        Fri, 10 Feb 2023 07:47:47 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id ea13so3695500pfb.13;
        Fri, 10 Feb 2023 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+YH2jubPt3atRm183/M73ZL/tfmWGLNd7PCoTgNemA=;
        b=QNqX8q2ZIQrMW67nmsy+zUNpS7XR5DpjwMa+QC46vQ4QQmBXgjRWFzUADH3PIVQAvM
         FZQ0+Lwy2K0/Q2dxn7RUNIP2sSCxrkOWkrr7iR7EFCZjNYeXAt2HozKhomVVZ84I1Req
         JaybFnw9Q3fIYLoNgQJdOlHfqCehA7iHa+v+DquWbC8y3Quf4X2ILQxsPHjhh2v7hjzD
         HTVfSVvQSXhPC2803RTP2MCbSbL20xfU1iKSVd1lK5EBjizBudJSJxvBrsNGQuyOaTZ/
         njYYNt/pF7HbveYbeszG4LcRP2LxwcPrizgibQa72LOJwIrixuInxvYzU7aTn6mCyyiY
         Ocjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+YH2jubPt3atRm183/M73ZL/tfmWGLNd7PCoTgNemA=;
        b=htzO73BqDHaZ5ZQ8Lkf5MSip3s2nEK6aZIK5y6YfMX4XUNvQlNZo7uII10HS5EQeA1
         cvKgAyzR+u0hDA9bgc+44kOAHlLgJeDKMB/L6J3jGX4PxhGbtXq2M87cr2gXbPam+ZM+
         7Md7n03cd8Ijge9SEFCEMFAa4+u71vXFA8XqgiBZlV2n4UzQC3LKbuYfBgNfLDzQO0jH
         vSRIYFeWCQV4xX4Rk11/he+moc3NeQAln54QhdqLbSAalyMNOwiU/ts/CfpZTYvrLKuW
         uBAk76EScBmcVQxyfowWX1ESw1hxbVS9bS4UQr29USZXpRIlyn9/g6zphIt7Kt6DqiaD
         xZ7A==
X-Gm-Message-State: AO0yUKX6Riv/sC55Cjfl8LPPUaMJW4++/o4yfZlRTFC49hKH8nOY6ClE
        RnnzGPwH/5TcJJGEv/PvyQg=
X-Google-Smtp-Source: AK7set8mHinKZZpdR2SeOy1pRrvPpKDphy3bpuU2275HlwAF6DtEddZcfOT81C2VzeZlsXGLNBDHMw==
X-Received: by 2002:a62:7b0c:0:b0:5a8:4b23:85e5 with SMTP id w12-20020a627b0c000000b005a84b2385e5mr7626941pfc.20.1676044066725;
        Fri, 10 Feb 2023 07:47:46 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:2f6a:5400:4ff:fe4c:e050])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm3520069pfe.99.2023.02.10.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:47:46 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 0/4] bpf, mm: introduce cgroup.memory=nobpf 
Date:   Fri, 10 Feb 2023 15:47:30 +0000
Message-Id: <20230210154734.4416-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The bpf memory accouting has some known problems in contianer
environment,

- The container memory usage is not consistent if there's pinned bpf
  program
  After the container restart, the leftover bpf programs won't account
  to the new generation, so the memory usage of the container is not
  consistent. This issue can be resolved by introducing selectable
  memcg, but we don't have an agreement on the solution yet. See also
  the discussions at https://lwn.net/Articles/905150/ .

- The leftover non-preallocated bpf map can't be limited
  The leftover bpf map will be reparented, and thus it will be limited by 
  the parent, rather than the container itself. Furthermore, if the
  parent is destroyed, it be will limited by its parent's parent, and so
  on. It can also be resolved by introducing selectable memcg.

- The memory dynamically allocated in bpf prog is charged into root memcg
  only
  Nowdays the bpf prog can dynamically allocate memory, for example via
  bpf_obj_new(), but it only allocate from the global bpf_mem_alloc
  pool, so it will charge into root memcg only. That needs to be
  addressed by a new proposal.

So let's give the container user an option to disable bpf memory accouting.

The idea of "cgroup.memory=nobpf" is originally by Tejun[1].

[1]. https://lwn.net/ml/linux-mm/YxjOawzlgE458ezL@slm.duckdns.org/

Changes,
v1->v2:
- squash patches (Roman)
- commit log improvement in patch #2. (Johannes)

Yafang Shao (4):
  mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
  bpf: use bpf_map_kvcalloc in bpf_local_storage
  bpf: allow to disable bpf map memory accounting
  bpf: allow to disable bpf prog memory accounting

 Documentation/admin-guide/kernel-parameters.txt |  1 +
 include/linux/bpf.h                             | 16 ++++++++++++++++
 include/linux/memcontrol.h                      | 11 +++++++++++
 kernel/bpf/bpf_local_storage.c                  |  4 ++--
 kernel/bpf/core.c                               | 13 +++++++------
 kernel/bpf/memalloc.c                           |  3 ++-
 kernel/bpf/syscall.c                            | 20 ++++++++++++++++++--
 mm/memcontrol.c                                 | 18 ++++++++++++++++++
 8 files changed, 75 insertions(+), 11 deletions(-)

-- 
1.8.3.1

