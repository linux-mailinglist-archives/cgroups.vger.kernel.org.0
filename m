Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9F7AB09C
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjIVL3K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjIVL3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D118F;
        Fri, 22 Sep 2023 04:29:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab2a0391c0so1246836b6e.1;
        Fri, 22 Sep 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382142; x=1695986942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBmYJOqhxd1SazsqJY85EKAZwokTy4dGQOyg7MypJ/k=;
        b=matmz69ZegDxdG4AsiHkPrzY4o4hx9uJZ72pFkr3JzSSPTQA/pfMwPR+YRAqrmNW1h
         6ZM5wYGeLlNgqo8sKnIgAI4yUPmFjAxrHoswAIjRaoAll+HZCQYT+nAj6MkdscLvZpz5
         GJCcHmem1m/RUJEBWdGMbOSfy8HvUupABRKZPzlStGWrFmBg5rbTEhYuruqQH/jUwmM4
         Jt++HW1f3Xl1TslnbFZgbFyW/e31QmWq5PN+j/FlRj1gXSBewNhdeUjCTuvQPppOzkQn
         ta2PlXa031TQPujFpmCpdOEDrnTPxC+qTkmtj7HNiIhdwPAX7ACXrLR6+65N3yCIDTvJ
         yM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382142; x=1695986942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBmYJOqhxd1SazsqJY85EKAZwokTy4dGQOyg7MypJ/k=;
        b=E1eIBu21xTJtRAOjTohyMTzBUHJCn/LoFBVW50Kn4vHEbMcj7ibpltMWlVH4Hh0U9u
         f0OZJZMC5Ye/Wb4J67jUSbV0Lge0iRPEeiukLEO3D5f8inVUg8HOx+d8El20VZCg+Coy
         pl6q4FiYLB6e/RLFMWBlCtdbIr0zQ77zcJ0AyjSeYjfJhfAK7TjK8KazxOHIUh4bMydQ
         IhBpeDgTCIhgE1HQa6UaORebqNyyHOjy30GTkbFTWLoC1qsFTDGpMKOwf7KLe0LeCvSl
         t6aOITaM3U3q/V4mh93x8biOjq/iT61VZHh/aQyCPgBHI94Q0JCzyqvUSGjrJ8s3v0eQ
         /vmg==
X-Gm-Message-State: AOJu0YzRPcGqm8UntQkW0Yz8ZGomcMRftmGKXB2aihjmmZ3FhSpVY/I0
        Kf78IaHyzVjDtC4aiey7EJk=
X-Google-Smtp-Source: AGHT+IEfgTKiqmFI0rcKEFvZPpzJey9/Ct0kV2H1czDyk8TcNiakyJvUaP90myJ2b79ArjIOCz1YkQ==
X-Received: by 2002:a05:6808:1388:b0:3a4:2204:e9e6 with SMTP id c8-20020a056808138800b003a42204e9e6mr10207623oiw.21.1695382142195;
        Fri, 22 Sep 2023 04:29:02 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:28:59 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup controller 
Date:   Fri, 22 Sep 2023 11:28:38 +0000
Message-Id: <20230922112846.4265-1-laoar.shao@gmail.com>
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

Given the widespread use of cgroup1 in container environments, this change
would be beneficial to many users.

Based on our investigation, the optimal way to enable BPF on cgroup1 is to
utilize the cgroup controller. The cgroup becomes active only when it has
one or more of its controllers enabled. In production environments, a task
is consistently managed by at least one cgroup controller. Consequently, we
can always establish a direct link between a task and a cgroup controller,
enabling us to perform actions based on this connection. As a consequence,
this patchset introduces the following new kfuncs: 

- bpf_cgroup_id_from_task_within_controller
  Retrieves the cgroup ID from a task within a specific cgroup controller.
- bpf_cgroup_acquire_from_id_within_controller
  Acquires the cgroup from a cgroup ID within a specific cgroup controller.
- bpf_cgroup_ancestor_id_from_task_within_controller
  Retrieves the ancestor cgroup ID from a task within a specific cgroup
  controller.

The advantage of these new BPF kfuncs is their ability to abstract away the
complexities of cgroup hierarchies, irrespective of whether they involve
cgroup1 or cgroup2.

In the future, we may expand controller-based support to other BPF
functionalities, such as bpf_cgrp_storage, the attachment and detachment
of cgroups, skb_under_cgroup, and more.

Changes:
- bpf, cgroup: Enable cgroup_array map on cgroup1
  https://lore.kernel.org/bpf/20230903142800.3870-1-laoar.shao@gmail.com/

Yafang Shao (8):
  bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
  cgroup: Enable task_under_cgroup_hierarchy() on cgroup1
  cgroup: Add cgroup_get_from_id_within_subsys()
  bpf: Add new kfuncs support for cgroup controller
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add parallel support for classid
  selftests/bpf: Add new cgroup helper get_classid_cgroup_id()
  selftests/bpf: Add selftests for cgroup controller

 include/linux/cgroup-defs.h                   |  20 +++
 include/linux/cgroup.h                        |  31 +++-
 kernel/bpf/helpers.c                          |  77 ++++++++-
 kernel/cgroup/cgroup-internal.h               |  20 ---
 kernel/cgroup/cgroup.c                        |  32 +++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  65 ++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h  |   3 +-
 .../bpf/prog_tests/cgroup_controller.c        | 149 ++++++++++++++++++
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   2 +-
 .../bpf/progs/test_cgroup_controller.c        |  80 ++++++++++
 10 files changed, 430 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_controller.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup_controller.c

-- 
2.30.1 (Apple Git-130)

