Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4C7CC382
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJQMqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjJQMqI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F5100;
        Tue, 17 Oct 2023 05:46:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so3923363b3a.1;
        Tue, 17 Oct 2023 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546765; x=1698151565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1PEAO9uUD2HLuTz2oxUS0AZ8D9nP4m2XuUuNZk6pCg=;
        b=bqZEXx3WcCNUtj9KWOXSbfGU8zCtnIRC1YfXT0JCnjX7Pm2wpwlYPEcm7XARMSK3Bw
         c8AUVoUP5rVakfkNsgldPSUN4imxp1op/FOt1Ql0PtZeHHeUHwqgHOFYa5O5L96B+Z4J
         XgGbGQyCQrqXLf/UdxpDuhG9gnyYKtdDCT2IJVra7OeHjjL6cxYjo85I0NetoucueGvC
         QBV56rc107pWYUGD9IrOOHutD4hEZwvHZ7gkY/kNtCWAQZbVZVjtfufirsCpDpDJ/02t
         lS7bNT4oDiDPiHJMn0sLEIfS7NAV+yf1wounLTyYw5am5MdwXCD2o+yoKAs2sgTQaTgj
         w2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546765; x=1698151565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1PEAO9uUD2HLuTz2oxUS0AZ8D9nP4m2XuUuNZk6pCg=;
        b=oJ1IwOjvGl5Q0fmwjbXw5IL7bAnQn0DUiR3H0NnL2FOQqxpGOI52zC0qJm07ed2HXm
         /75HpvEZsLrfTO+wqCNGZpROaKWMRt0ZrMly5OSBF77xOTZxhuQTHfrVJ2tewhcB1Wvg
         rajXOjt1vWduErguwViN3EWUBHe9drCyZR9WGnUykUmRElBI56pFtFjFfmiKVRyQF3iC
         +uJKe/xMGn+pzUCI6TdEkA9ncO5ltMslfCJLSf142POcDuN2yRPAAzs7h5AfZ/a5dUrk
         G2ZTIO+pYjZH3Vte9sI7KiaHduYzbw3bdNTC486aqVOd2M2YeHjTv/EtySyGSj9zclIM
         cTOQ==
X-Gm-Message-State: AOJu0Yxn3NeBFX/xuEmNhaqM/vLKZj1VpbSTMGBRyJbK2dRKVTam9dLe
        cZJEOlHa6iJgldcOi8lX2X71B9vcHzYKHTSq
X-Google-Smtp-Source: AGHT+IEvshRN7yOizLfUI87HlJjGU3wxGTUolki6aZMbM1cow/RuRe22bWjGehZk1mvvGdzXmCTtrg==
X-Received: by 2002:a05:6a00:2355:b0:6b2:6835:2a7f with SMTP id j21-20020a056a00235500b006b268352a7fmr2448876pfj.22.1697546764949;
        Tue, 17 Oct 2023 05:46:04 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:04 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 0/9] bpf, cgroup: Add BPF support for cgroup1 hierarchy 
Date:   Tue, 17 Oct 2023 12:45:37 +0000
Message-Id: <20231017124546.24608-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, BPF is primarily confined to cgroup2, with the exception of
cgroup_iter, which supports cgroup1 fds. Unfortunately, this limitation
prevents us from harnessing the full potential of BPF within cgroup1
environments.

In our endeavor to seamlessly integrate BPF within our Kubernetes
environment, which relies on cgroup1, we have been exploring the
possibility of transitioning to cgroup2. While this transition is
forward-looking, it poses challenges due to the necessity for numerous
applications to adapt.

While we acknowledge that cgroup2 represents the future, we also recognize
that such transitions demand time and effort. As a result, we are
considering an alternative approach. Instead of migrating to cgroup2, we
are contemplating modifications to the BPF kernel code to ensure
compatibility with cgroup1. These adjustments appear to be relatively
minor, making this option more feasible.

As discussed with Tejun[1], it has been determined that tying the interface
directly to the cgroup1 hierarchies is acceptable. As a result, this
patchset introduces cgroup1-only interfaces that operate with both
hierarchy ID and cgroup ID as parameters.

Within this patchset, a new cgroup1-only interface have been introduced,
which is also suggested by Tejun.

- [bpf_]task_get_cgroup1_within_hierarchy
  Acquires the associated cgroup of a task within a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This new kfunc enables the tracing of tasks within a designated container
or its ancestor cgroup directory in BPF programs. Additionally, it is
capable of operating on named cgroups, providing valuable utility for
hybrid cgroup mode scenarios.

To enable the use of this new kfunc in non-sleepable contexts, we need to
eliminate the reliance on the cgroup_mutex. Consequently, the cgroup
root_list is made RCU-safe, allowing us to replace the cgroup_mutex with
RCU read lock in specific paths. This enhancement can also bring
benefits to common operations in a production environment, such as
`cat /proc/self/cgroup`.

[1]. https://lwn.net/ml/cgroups/ZRHU6MfwqRxjBFUH@slm.duckdns.org/

Changes:
- RFC v1 -> RFC v2:
  - Introduce a new kunc to get cgroup kptr instead of getting the cgrp ID
    (Tejun)
  - Eliminate the cgroup_mutex by making cgroup root_list RCU-safe, as
    disccussed with Michal 
- RFC v1: bpf, cgroup: Add BPF support for cgroup1 hierarchy
  https://lwn.net/Articles/947130/
- bpf, cgroup: Add bpf support for cgroup controller
  https://lwn.net/Articles/945318/
- bpf, cgroup: Enable cgroup_array map on cgroup1
  https://lore.kernel.org/bpf/20230903142800.3870-1-laoar.shao@gmail.com

Yafang Shao (9):
  cgroup: Make operations on the cgroup root_list RCU safe
  cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
  cgroup: Add a new helper for cgroup1 hierarchy
  bpf: Add a new kfunc for cgroup1 hierarchy
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add parallel support for classid
  selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
  selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
  selftests/bpf: Add selftests for cgroup1 hierarchy

 include/linux/cgroup-defs.h                   |   1 +
 include/linux/cgroup.h                        |   6 +-
 kernel/bpf/helpers.c                          |  20 +++
 kernel/cgroup/cgroup-internal.h               |   4 +-
 kernel/cgroup/cgroup-v1.c                     |  33 ++++
 kernel/cgroup/cgroup.c                        |  25 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c  | 113 +++++++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +-
 .../bpf/prog_tests/cgroup1_hierarchy.c        | 159 ++++++++++++++++++
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   2 +-
 .../bpf/progs/test_cgroup1_hierarchy.c        |  73 ++++++++
 11 files changed, 409 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

-- 
2.30.1 (Apple Git-130)

