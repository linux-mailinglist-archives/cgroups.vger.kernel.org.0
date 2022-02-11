Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F44B1EC4
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiBKGt0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 01:49:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbiBKGt0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 01:49:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B32188
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j17-20020a25ec11000000b0061dabf74012so17009119ybh.15
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7cEUUMm8No+47SEC0UonhOqIuTdbXjwICtqwH1vHhoQ=;
        b=fb3bmiUsrp8W4YmAG3agpua6xnfwRewOZ8YA8GXSqnYAPC8zDIVx6AoedzrfSysYph
         zzvjaiNO751h5z4oCLk4zWH107SG09igxaI4HWBb1br4poFMySSL6hi1EE3b+DYhoSkr
         E8isZ/nwurJsTuixeh5zQ22wHMxuwcRqJYWTA+SlpVkjSTo1VKwRMe+ZUHsup7SwY5XP
         j0dXPMF/835VLYM3EhP1F/flECnKhOMqisNWuPeE9/Uo+X/0hqoGEnt+lp+mcMd8/d04
         p1R9iZ10rYSwdyqK3vsqBTfPZ8kYkC+5e/3cs9ufj47kI+7yPQufY7yIHZMwKB5NfcpC
         ioxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7cEUUMm8No+47SEC0UonhOqIuTdbXjwICtqwH1vHhoQ=;
        b=BZumQsnO+iHnRsSsWeSV7PLa8YXOjsTN0J1F1liXuK3t7cvbhHW0ML8FUGWTYfZyG+
         GlkI02n/+uVA3NWYCd6PZVt1hL4qZsJirmZ3bVFgRuQOIfmqLHBLEJAb6vDZoAl/HEnt
         MDCC580dxHdSq5NxWwI8cARrbIcv3qMFlQcmJUHtHV8/gNWwu8ysMbJxnaF0D1mvYY9Z
         TRnOTn1vHWSTIxJjP0Qw9ZRxz9h8a0vNh4Bc5VGgo/OjVhTv6TT3X4CEO+SY8TMAor5E
         l9RsSM0UIRetkdbD54SNLRMQB9lgk4Cvuaq/3cuI+kgBlG0dKqbzWft/yQa5UMonMVRp
         GoNw==
X-Gm-Message-State: AOAM531XHkDgay67i9i21G42xAh2KLYQMXqNrfKFxaDdVzcIJpQOzghK
        s9A/ds5qnVJtbJSesrEDcsePkAhjLprcGQ==
X-Google-Smtp-Source: ABdhPJwjcJt1qNgxSN9vWV7QgR7LvR6l6f8Pvejc675UNvm/3bhAMhZsP+fwGZb5+wH9V5YwUfVByIzNtijgDg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:9a07:ef1a:2fee:57f1])
 (user=shakeelb job=sendgmr) by 2002:a81:1ec2:: with SMTP id
 e185mr336741ywe.324.1644562165435; Thu, 10 Feb 2022 22:49:25 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:49:13 -0800
Message-Id: <20220211064917.2028469-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 0/4] memcg: robust enforcement of memory.high
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Due to the semantics of memory.high enforcement i.e. throttle the
workload without oom-kill, we are trying to use it for right sizing the
workloads in our production environment. However we observed the
mechanism fails for some specific applications which does big chunck of
allocations in a single syscall. The reason behind this failure is due
to the limitation of the memory.high enforcement's current
implementation. This patch series solves this issue by enforcing the
memory.high synchronously if the current process has accumulated a large
amount of high overcharge.

Changes since v1:
- Based on Roman's comment simply the sync enforcement and only target
  the extreme cases.

Shakeel Butt (4):
  memcg: refactor mem_cgroup_oom
  memcg: unify force charging conditions
  selftests: memcg: test high limit for single entry allocation
  memcg: synchronously enforce memory.high for large overcharges

 mm/memcontrol.c                               | 66 +++++++---------
 tools/testing/selftests/cgroup/cgroup_util.c  | 15 +++-
 tools/testing/selftests/cgroup/cgroup_util.h  |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 78 +++++++++++++++++++
 4 files changed, 120 insertions(+), 40 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

