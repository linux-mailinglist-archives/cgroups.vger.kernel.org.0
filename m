Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430D4B07E5
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiBJIOw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 03:14:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiBJIOw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 03:14:52 -0500
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DF1097
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:14:54 -0800 (PST)
Received: by mail-oo1-xc49.google.com with SMTP id r12-20020a4aea8c000000b002fd5bc5d365so3146455ooh.18
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T9FcBDMwvgeHBlJy4y16uXfaabYSCGyJ3a5EN/2FH/k=;
        b=MxdsYuSId5HtvKIg92vKZD2AqHFrlV0PE/vRdDgoIOtAxeRQ9ojCRGSaEaK45fB/bh
         We8jMJdFWXIW3lmpW/ZDfeZqIzKdt/QwufKjFYFwGOjP5J1vxnhO4F61EVjj6I5nQCH9
         fDEgALX0BPefVUNsfL9sWq0H2oZnkV64CrnT5tb6XTyHRbhSH20LE7MeL9YrcLKE+Upn
         ca0C2CBxPkElew+dpCqGOsBsQheR9rbsOFacWIyuWmkdp6LjxepL0z7kc5y4slTtujd4
         Lyx2Ub3/D9/fZ76P15/g2wgvb8rYb5WxFCWJrzgsjaJGP5phBtg3xbKKR3MOb87xNC86
         TOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T9FcBDMwvgeHBlJy4y16uXfaabYSCGyJ3a5EN/2FH/k=;
        b=YHcXCTkTilwXV1SKp9RI7DB4b4U4NFzBlmD99omdDMVK8VKvWRJS24z+GnjiEdIa4r
         GE59IltcOAIoQz8gno7JHiQcBzzBp+ony0gFRLNgYHw75qUJFm6FBpFgcbjM1gI4pYtL
         tKCZKL5r1BZADDqVP6QYcRDvSc/hiVxHag9Itf5TD5goE9pvdN7GbyHP3qXNTi6X916k
         UKbCJdJ5FwMZOMB7rsYDxRA/uYP61lZKzRuLZnBca+yCMGNIG28koQcak8Go3x1xSfcU
         fAKZYaWwxPgaZnllQCP07zlEsSssuW2rE3wIzyUiF12rOfRG2VCqqj8moZZrBPuZ5/F0
         EKMg==
X-Gm-Message-State: AOAM532fs2ITx4yRQVZe7mbww8Nal0ulMSj6cCuDJwVdmAXeMlYJL2cH
        vQ5A0z3sAPE2T7jbb1RrXb453Ktp/OOVFw==
X-Google-Smtp-Source: ABdhPJwpmJs5KvIzTk+4UqumkYVhgfmnjA3Xqt4XkjaPcdUfPtlskWzbyZqOPhpvf84nMJpU67NzE5RGU1VfFw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6801:6774:cb90:c600])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:1688:: with SMTP id
 bb8mr599419oib.163.1644480893417; Thu, 10 Feb 2022 00:14:53 -0800 (PST)
Date:   Thu, 10 Feb 2022 00:14:33 -0800
Message-Id: <20220210081437.1884008-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/4] memcg: robust enforcement of memory.high
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
mechanism fails for some specific applications which does bug chunck of
allocations in a single syscall. The reason behind this failure is due
to the limitation of the memory.high enforcement's current
implementation. This patch series solves this issue by enforcing the
memory.high synchronously and making it more robust.

Shakeel Butt (4):
  memcg: refactor mem_cgroup_oom
  memcg: unify force charging conditions
  selftests: memcg: test high limit for single entry allocation
  memcg: synchronously enforce memory.high

 include/linux/page_counter.h                  |  10 +
 mm/memcontrol.c                               | 175 ++++++++++--------
 mm/page_counter.c                             |  59 ++++--
 tools/testing/selftests/cgroup/cgroup_util.c  |  15 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
 .../selftests/cgroup/test_memcontrol.c        |  78 ++++++++
 6 files changed, 240 insertions(+), 98 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

