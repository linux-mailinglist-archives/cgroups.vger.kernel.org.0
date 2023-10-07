Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12D7BC832
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjJGODR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGODQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82511BF;
        Sat,  7 Oct 2023 07:03:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c87e55a6baso22595955ad.3;
        Sat, 07 Oct 2023 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687395; x=1697292195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5wlDoYxzVIeScokp/8KshwCTixlVDCtPhsT0zoCop8=;
        b=bjcoZkKX7vUYWDlPYvBG9ryoRkxhEUq0mnet5CQ4x2Sbv02HLAoXC0MtQItcTvWbBY
         j+FASX7FlH5hCNRCfkI5J98IqZ2aTdibDtsVMzz/2b5z5C6Dr0VuDS/BoAZDmZtUh290
         n0ymgpNZyNFGqzZ7Y7LgulbvShT60lNmO+mzSZnC0xFTEzcYaZw8pk4E7+5IT7399kXm
         LWWQT6pbNyW/tJcvLsLeg1XzC8pLlOp3IgUItwCTVg4cxCUuUPBw3J402FKEYEhy3pUP
         ZsnGSdp9zDEFenrDUPxGiunojBTNtjtOuJERgkW3IWOAulIFhRfqRYdODfhb9s2k4hyE
         hfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687395; x=1697292195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5wlDoYxzVIeScokp/8KshwCTixlVDCtPhsT0zoCop8=;
        b=hFhVqcEsfqs76YiPRhpzgnRUfcvoYhisZmSAyu5+3L74upn9aldDGruucFn60ZE0Jb
         3w6wtxc/QYkAhJTNcqJWgKhFJujWVFu7J3M6Fu0QJWn6P8kQDahVL83ws6K4nCCQhukj
         dWSfZRmP8Un0j7MRKOcqPxnd9TlwwrbthbI1jrlDJhrvsXxf1TzTxouWsBI7kw/Bt02q
         rKWjPva4YSaBfq4nNBf5McEluipKo7oqYpu0iooJfAL+lRy4wAAN1/U08pbnwUctFZbE
         zkxJrdbLmt0RW0dckJDcbfxIyGXoUNI+cvcVEcXwGt3bR4le5TzZtkaBCUgGEYWIZBVH
         cZ3A==
X-Gm-Message-State: AOJu0YzNUTfCEtplyIYzoY7TeaQmOG4ffMEPmuATB8JeWZJ7FjGex4re
        +R3vOny5thP87OosjZmdSVY=
X-Google-Smtp-Source: AGHT+IFiLy9ShGYPhLYdExUofG9fYedfCOv1rJGaYo7AZaKCTT0iqPNAZJ055FsfUjw7VAiZW4pDPw==
X-Received: by 2002:a17:902:8e87:b0:1b2:4852:9a5f with SMTP id bg7-20020a1709028e8700b001b248529a5fmr10067504plb.54.1696687394891;
        Sat, 07 Oct 2023 07:03:14 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add BPF support for cgroup1 hierarchy 
Date:   Sat,  7 Oct 2023 14:02:56 +0000
Message-Id: <20231007140304.4390-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
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

Given the widespread use of cgroup1 in container environments, this change
would be beneficial to many users.

As discussed with Tejun[1], it has been determined that tying the interface
directly to the cgroup1 hierarchies is acceptable. As a result, this
patchset introduces cgroup1-only interfaces that operate with both
hierarchy ID and cgroup ID as parameters.

Within this patchset, two new cgroup1-only interfaces have been introduced:

- [bpf_]task_cgroup1_id_within_hierarchy
  Retrieves the associated cgroup ID of a task whithin a specific
  cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
  hierarchy ID.
- [bpf_]task_ancestor_cgroup1_id_within_hierarchy
  Retrieves the associated ancestor cgroup ID of a task whithin a
  specific cgroup1 hierarchy. he specific ancestor cgroup is determined by
  the ancestor level within the cgroup1 hierarchy.
 
These two new kfuncs enable the tracing of tasks within a designated
container or its ancestor cgroup directory in BPF programs. Additionally,
they are capable of operating on named cgroups, providing valuable utility
for hybrid cgroup mode scenarios.

[1]. https://lwn.net/ml/cgroups/ZRHU6MfwqRxjBFUH@slm.duckdns.org/

Changes:
- bpf, cgroup: Add bpf support for cgroup controller
  https://lwn.net/Articles/945318/
- bpf, cgroup: Enable cgroup_array map on cgroup1
  https://lore.kernel.org/bpf/20230903142800.3870-1-laoar.shao@gmail.com/

Yafang Shao (8):
  cgroup: Don't have to hold cgroup_mutex in task_cgroup_from_root()
  cgroup: Add new helpers for cgroup1 hierarchy
  bpf: Add kfuncs for cgroup1 hierarchy
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add parallel support for classid
  selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
  selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
  selftests/bpf: Add selftests for cgroup1 hierarchy

 include/linux/cgroup.h                        |   9 +-
 kernel/bpf/helpers.c                          |  26 +++
 kernel/cgroup/cgroup-internal.h               |   2 -
 kernel/cgroup/cgroup-v1.c                     |  67 ++++++++
 kernel/cgroup/cgroup.c                        |   5 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  | 114 +++++++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +-
 .../bpf/prog_tests/cgroup1_hierarchy.c        | 159 ++++++++++++++++++
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   2 +-
 .../bpf/progs/test_cgroup1_hierarchy.c        |  62 +++++++
 10 files changed, 426 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

-- 
2.30.1 (Apple Git-130)

