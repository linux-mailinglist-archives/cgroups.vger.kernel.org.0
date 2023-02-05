Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDE68AE93
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBEG6X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 01:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEG6W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 01:58:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D923108;
        Sat,  4 Feb 2023 22:58:20 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 203so6391464pfx.6;
        Sat, 04 Feb 2023 22:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkWRdzEKke7GR8UIzoPrXe0fCR7Zi4RGiPc8wkbTB4w=;
        b=XSC+bQejMiGP5TbJYVDlLreC8JI6izirwf2lFqkk+LIE4in+7ZH/gEPPm+2/e6s3sj
         4VfBFEKjaVS6SVUHOiDcEf7TGvyMIphk/+tiH/qgiOeuZIC134Qmja6JNox0NpC+uro0
         hq/ZslHjhPEmSkhFXVsx1E3GRLJVqS2ou2fUs/S8qLkFZCFqLLlXdfSht5fx2xt0aPTJ
         wM7CiLm5JJpJYF40pc/jTJpxsXUv5/TfQiDb2/bNX9TsaJVq9fGsjqE8kBNFc6vae5Hm
         FoQHwrX4C/UuNQiWXiNDSB8joi4VfJQGFFL70FV9ToCJ7K64eB+p2C2OG72S8Paoxqvp
         hMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkWRdzEKke7GR8UIzoPrXe0fCR7Zi4RGiPc8wkbTB4w=;
        b=sqCJakAPz7ESVHGUH1oxjBxagYa/7JxV60M5JAAbfDbnDOdJ32QSgJQyDPoIsv5tvi
         f6QfgVzGp8fquQLVkNzRhwTduTbpKSwsKY1mOzoBa/OiuLc5rXUV+YrOXwsJFKm6DxAH
         lKL7Y1Pt0TAjEgoYeRAlVn4jwpNMIDJFb44Jd8B9E5j3D2WASk9aM7mSxPdhVrESeD6c
         jafaLY7OkxqMg0Eh3Cts6xdg4t8MAPyHpkVN43kaF8W7LSjxV3AlMleZFoHIxAKdwZ92
         gd/idA+DcPWDc4HOxNpp+FYiSvSA/ONkNlwNSgxQ4v1lc5EA3oXz9+Q0fcVR4hPQNwHB
         7Usg==
X-Gm-Message-State: AO0yUKWPz7TFLU/cqaFC6UCLYOMpIQQxIw/0tGjkViAf1S0F3IqVlv+q
        GbJh50HqAh7d/2y0KMwN3lAwYeViz3JVoG0j
X-Google-Smtp-Source: AK7set8ZmU5/Kpg6u1AWbZ+6T3Ym9SJiBF6LaA1AfSe3W4zcwl5v6pvvRr1kYum7Kv86G/1Ihb2+vg==
X-Received: by 2002:a05:6a00:230c:b0:56c:232e:395e with SMTP id h12-20020a056a00230c00b0056c232e395emr18950984pfh.15.1675580299680;
        Sat, 04 Feb 2023 22:58:19 -0800 (PST)
Received: from vultr.guest ([2401:c080:1c02:6a5:5400:4ff:fe4b:6fe6])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm4596114pfv.184.2023.02.04.22.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 22:58:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/5] bpf, mm: introduce cgroup.memory=nobpf 
Date:   Sun,  5 Feb 2023 06:58:00 +0000
Message-Id: <20230205065805.19598-1-laoar.shao@gmail.com>
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

So let's give the user an option to disable bpf memory accouting.

The idea of "cgroup.memory=nobpf" is originally by Tejun[1].

[1]. https://lwn.net/ml/linux-mm/YxjOawzlgE458ezL@slm.duckdns.org/

Yafang Shao (5):
  mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
  bpf: use bpf_map_kvcalloc in bpf_local_storage
  bpf: introduce bpf_memcg_flags()
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

