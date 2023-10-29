Return-Path: <cgroups+bounces-103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04957DAB0F
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF3EB20E3B
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5445539F;
	Sun, 29 Oct 2023 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGLQJyU7"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1D33D1;
	Sun, 29 Oct 2023 06:14:49 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B650ED;
	Sat, 28 Oct 2023 23:14:46 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ac376d311aso29517457b3.1;
        Sat, 28 Oct 2023 23:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560085; x=1699164885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlYZHzJqm6FeRtL6MoVyl7ioo2gf284xMVeOQZGByY8=;
        b=AGLQJyU7AXDe+ZqJwFuSyxR6vUroeQ4sgDZgNlXDJdlKgHN1lzc1CGL2oxerGZIs2K
         M7HdRx+BXdA+RmAKeZxSydtkXGaZ0HDzfiwEZnhUJXTw9ieiVPUB9ejuzW7WLJRLHSB7
         uxIjkx5hxV3mrtif1g5FqBC1+lIopoKLlv8TVTYz1J8CdiHhcDlT8qgjr8PJR0Q1Q/Uo
         Qa0IZDBq0sF2QtbO2b8zus+/DEtEEiwY6np3GNnz7D9jfoouh2PvggAjk6kMyIez+Hcb
         Dumoq91loOauYo5nJhLqycsgCpL3MdstOpaGngEHJ4i2Ew4o0iNlt9rp5YIurh2pAmwD
         0vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560085; x=1699164885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlYZHzJqm6FeRtL6MoVyl7ioo2gf284xMVeOQZGByY8=;
        b=X6xvA7kX4+2KeaIHn8iu4Vmzns3G2Yeki3Y9uSqmnKuS164MCUaKm4DwUUV0TyiToi
         J3GCc1AvRTpTpbRWm9UIWHOFWtYnKtBE4pY4mM80s3n0Dx92UML9u4nQGcJhtJWWptGT
         xAZgjq1EaTSvUhON0/85niXFZuWLG262Iq9dBT8k6oNoxZNf7wUu5Fn8DAgFqqV0LbY6
         IYaaIjhomAj4/6CD3+/+j9tPHhZyH7fWskWi830lQExe6kdEY3+ssER5fXB7k9CWZRp6
         w1AJYdw56xdcOEpXEBqInezfhIGPakTtGX2/GJdFSKZDDdOamnv4q02hI+T6i7hKLirY
         k8yA==
X-Gm-Message-State: AOJu0YyH7qnmP8IWdPRW0kAen6bGgaDTjpzo0FRhh7dVb9gSlOw6J3YL
	P4w3ZtAiPU1C0pkciIe2QSo=
X-Google-Smtp-Source: AGHT+IExM2I1bxfKYjzNyxmtPQE1s9zSEoqSi56Pfhs9kSjrGhD9l/tEJpaFXtryHJkvvLsSIKx+ww==
X-Received: by 2002:a81:4411:0:b0:5af:6cb2:5e92 with SMTP id r17-20020a814411000000b005af6cb25e92mr7501447ywa.30.1698560085362;
        Sat, 28 Oct 2023 23:14:45 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for cgroup1 hierarchy 
Date: Sun, 29 Oct 2023 06:14:27 +0000
Message-Id: <20231029061438.4215-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

As discussed with Tejun[0], it has been determined that tying the interface
directly to the cgroup1 hierarchies is acceptable. As a result, this
patchset introduces cgroup1-only interfaces that operate with both
hierarchy ID and cgroup ID as parameters.

Within this patchset, a new cgroup1-only interface have been introduced,
which is also suggested by Tejun.

- [bpf_]task_get_cgroup1
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
`cat /proc/self/cgroup`. As pointed out by Michal, we can further
replace cgroup_mutex with the RCU read lock in other paths like
cgroup_path_ns(), but it necessitates some refactoring, so I prefer to
address it in a separate patchset.

[0]. https://lwn.net/ml/cgroups/ZRHU6MfwqRxjBFUH@slm.duckdns.org/

Changes:
- RFC v2 -> v3:
  - Use [bpf_]task_get_cgroup1 instead (Tejun)
  - Skip the unmounted cgroup in /proc/self/cgroup (Tejun)
  - Fix lockdep_is_held() in list_for_each_entry_rcu()
    (Tejun, oliver.sang@intel.com)
  - Drop the warning in __cset_cgroup_from_root()(Tejun) 
  - Fix mismatched comments (Tejun, lkp@intel.com)
  - Add a explicit warning in current_cgns_cgroup_from_root (Michal)
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

Yafang Shao (11):
  cgroup: Remove unnecessary list_empty()
  cgroup: Make operations on the cgroup root_list RCU safe
  cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
  cgroup: Add annotation for holding namespace_sem in
    current_cgns_cgroup_from_root()
  cgroup: Add a new helper for cgroup1 hierarchy
  bpf: Add a new kfunc for cgroup1 hierarchy
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add parallel support for classid
  selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
  selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
  selftests/bpf: Add selftests for cgroup1 hierarchy

 include/linux/cgroup-defs.h                        |   1 +
 include/linux/cgroup.h                             |   4 +-
 kernel/bpf/helpers.c                               |  20 +++
 kernel/cgroup/cgroup-internal.h                    |   4 +-
 kernel/cgroup/cgroup-v1.c                          |  33 +++++
 kernel/cgroup/cgroup.c                             |  45 ++++--
 tools/testing/selftests/bpf/cgroup_helpers.c       | 113 ++++++++++++---
 tools/testing/selftests/bpf/cgroup_helpers.h       |   4 +-
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   | 159 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |   2 +-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |  72 ++++++++++
 11 files changed, 420 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

-- 
1.8.3.1


