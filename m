Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6EF790C6C
	for <lists+cgroups@lfdr.de>; Sun,  3 Sep 2023 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjICO2N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Sep 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjICO2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Sep 2023 10:28:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6E97;
        Sun,  3 Sep 2023 07:28:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a56401c12so303839b3a.2;
        Sun, 03 Sep 2023 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751288; x=1694356088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXDwjjmxqBAOxuWYsnka7JEJGco2H68JBbaxg6PfkIk=;
        b=jSNWjZ5wyBil44ZjC6NBwT9tp9IDYKITmez76HTetNXNAJrdXuSQ73e82iagc3zblY
         lT5N439w2C5Lp38k8a5dQNI3BSkVScx/GMR7XBDsAuBF0fQ7TzLkzXiYP+57XulMi4vS
         Cfj3mL5QoV5IVkF5LWuiqU64aL7FliupZM6JpYFdmXiS6S3+VHDBtqYlmVIDAWuz2i8t
         tvJ4l24W4SxWYox+tKm8dhLVdAvNhG20EQfWvl/cRh7Xq2Nri1le6V3oJI7788Q7Qffu
         6TvqjfZMRiGTC/fGFYdIne9UrdoaQ5PQE00jTEgTaE3NBLuNgZ61BP0dUCwNYojiUdpG
         mOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751288; x=1694356088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXDwjjmxqBAOxuWYsnka7JEJGco2H68JBbaxg6PfkIk=;
        b=WbiJnP5it14neHf5Ih8F5iYe2b9KvZkQ7wpp/j4Cd8Q9vIs+ZT+gum9PZarB9BY5Hz
         4uSqP/R5+Ozil1b8khP6rF7dTJ2Er2N7fRE5zxio1W7BIXBcj3gcJc385BEmDsN6utrA
         Vq4mq/h2nDZ/kGhRWVvmydKIphEvVpfhb7eyMJnnwGQReclhOOvcoxCSs8wNnWOST7Lj
         rlzrxcAjd/EZgOcVSDosIE96AAEFrddzVOvKGhwSholI3AuoocB5vsy6RI/VtMVM5g8p
         fv3D+eZNHjH8D3jH5Qx2RBBBmmUae2VHo07TUUtPVCKbuQH+1fJDO7CzS9vayXgn9+Fc
         2n5Q==
X-Gm-Message-State: AOJu0YyFUHmYDwzQDO7b7sp6YgqZIV8LL877Yr8sT8xcBxRmYo2/EbSn
        yGG+LVn6m/CiYnmAKOJuRNI=
X-Google-Smtp-Source: AGHT+IHN5LVt6UWxQXM7fpLnvTYDUubpKJGTP1gKhXqoPOAIWTMH5ncDoNt1iwVWBa6pMdruvYageQ==
X-Received: by 2002:a05:6a00:2385:b0:68c:6ebc:2210 with SMTP id f5-20020a056a00238500b0068c6ebc2210mr7248043pfc.18.1693751287792;
        Sun, 03 Sep 2023 07:28:07 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:07 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1 
Date:   Sun,  3 Sep 2023 14:27:55 +0000
Message-Id: <20230903142800.3870-1-laoar.shao@gmail.com>
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

Currently, the cgroup_array map serves as a critical component for
bpf_current_under_cgroup() and bpf_skb_under_cgroup() functions, allowing
us to determine whether a task or a socket buffer (skb) resides within a
specific cgroup. However, a limitation exists as we can only store cgroup2
file descriptors in the cgroup_array map. This limitation stems from the
fact that cgroup_get_from_fd() exclusively supports cgroup2 file
descriptors. Fortunately, an alternative solution presents itself by
leveraging cgroup_v1v2_get_from_fd(), which accommodates both cgroup1 and
cgroup2 file descriptors.

It is essential to note that it is safe to utilize a cgroup1 pointer within
both bpf_current_under_cgroup() and bpf_skb_under_cgroup(), with the result
of receiving a "false" return value when verifying a cgroup1 pointer. To
enable the checking of tasks under a cgroup1 hierarchy, we can make a minor
modification to task_under_cgroup_hierarchy() to add support for cgroup1.

In our specific use case, we intend to use bpf_current_under_cgroup() to
audit whether the current task resides within specific containers.
Subsequently, we can use this information to create distinct ACLs within
our LSM BPF programs, enabling us to control specific operations performed
by these tasks.

Considering the widespread use of cgroup1 in container environments,
coupled with the considerable time it will take to transition to cgroup2,
implementing this change will significantly enhance the utility of BPF
in container scenarios. This is especially noteworthy because the necessary
adjustments can be made with minimal alterations to both the cgroup
subsystem and the BPF subsystem.

Yafang Shao (5):
  cgroup: Enable task_under_cgroup_hierarchy() on cgroup1
  bpf: Enable cgroup_array map on cgroup1
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add new cgroup helper open_classid()
  selftests/bpf: Add selftests for current_under_cgroupv1v2

 include/linux/cgroup.h                             | 24 ++++++-
 kernel/bpf/arraymap.c                              |  2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       | 34 ++++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h       |  1 +
 .../bpf/prog_tests/current_under_cgroupv1v2.c      | 76 ++++++++++++++++++++++
 .../bpf/progs/test_current_under_cgroupv1v2.c      | 31 +++++++++
 6 files changed, 160 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/current_under_cgroupv1v2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_current_under_cgroupv1v2.c

-- 
1.8.3.1

