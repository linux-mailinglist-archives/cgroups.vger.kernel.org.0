Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BE6B0EA1
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCHQ0Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCHQ0N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 11:26:13 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E4C5ACA;
        Wed,  8 Mar 2023 08:26:12 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id m4so11441106qvq.3;
        Wed, 08 Mar 2023 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292771;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWwMHeJpend+hzpuPqFIQzMgVunHLYMAMCx5MYeNU2o=;
        b=CNf5LmESb4+kOCQPbjMP3umJWUrWFr7U3y+v8xZk5znqjCZWCO/16aFonllNQHNRat
         Z2dON/28zs8dIvG93QXsMc8SjqHPhwmN/CEm+ULLN7V3peF9D09lEhm/2OMLfA92Q39I
         hQ7D6o6MgkuomYj5Dmzoio/OCP1Ym6QmxKFpFadpIpSXZtvbyTicuMJX2ucI4Axzwjjh
         9xsz2lXZR+ynHCDTZ830xdWISm4rQF89FOJbbiTjhcgfeBMsfgwTUp6X4eLFzxqMn2lb
         VE72KXOQ4EXPKjmYmVa8Cc4zqMO5BZpM6TyRJGTv6mXp6qoYE9oeg2vmrsP+GZnxY/dS
         OQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292771;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWwMHeJpend+hzpuPqFIQzMgVunHLYMAMCx5MYeNU2o=;
        b=RG6xVDX+Ku2T6Jzqn6osZI41ZiEi925rED01I/I22JrOqsv7xHk37Yzc0IKqF9RcgF
         XxfaNi/L32nwBnrPUwHC1Oyqvviw+ZZtSWg8+CWUL2v5qSudQKPQ5gw33VuRIFqUP7pv
         Z01wh7WsQ1d1cjtrafQJ4DecM8NGTjBCI2C7ycuT7JTBq1Gx5kUX5oNhg6GH1a8eMwER
         IUyG2rFFb8/D4MTmWFmCWHcwHNV13/o/3t6QSQH1wv1uhY/miLPLjItYUzmXiKwQ2sXA
         za0Sp4IOudEXuwoXA0q+IcF7iHWC8m6S4EZj1UZA9khS39D0TdYEawelLwcxba3mLzhu
         AEIQ==
X-Gm-Message-State: AO0yUKXLTtDQAjPq0hx7V8+9ZMxeh5YF9fAZLGf0wuFsuuTIX+jkKZjn
        dnTOo3ERQYKeO9FjPJ3UFQc=
X-Google-Smtp-Source: AK7set/as0jc+PLnDcLadk3eqz5UZsoBO2dp2eM+0xhER+r6ezgdGVFNJO6maPLojNxiR8j6ovPReg==
X-Received: by 2002:a05:6214:20c4:b0:56c:240d:3015 with SMTP id 4-20020a05621420c400b0056c240d3015mr4615645qve.32.1678292771444;
        Wed, 08 Mar 2023 08:26:11 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b0073b8459d221sm11619813qkm.31.2023.03.08.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:26:11 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v3, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store tearing fixes
Date:   Thu,  9 Mar 2023 00:25:51 +0800
Message-Id: <20230308162555.14195-1-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series helps to prevent load/store tearing in
several cgroup knobs.

As kindly pointed out by Michal Hocko, we should add 
[WRITE|READ]_ONCE for all occurrences of memcg->oom_kill_disable,
memcg->swappiness and memcg->soft_limit.

v3:
- Add [WRITE|READ]_ONCE for all occurrences of
memcg->oom_kill_disable, memcg->swappiness and memcg->soft_limit
v2:
- Rephrase changelog
- Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
 memcg->swappiness, vm_swappiness and memcg->soft_limit
v1:
- Add [WRITE|READ]_ONCE for memcg->oom_group

Past patches:
V2: https://lore.kernel.org/linux-mm/20230306154138.3775-1-findns94@gmail.com/
V1: https://lore.kernel.org/linux-mm/20230220151638.1371-1-findns94@gmail.com/

Yue Zhao (4):
  mm, memcg: Prevent memory.oom.group load/store tearing
  mm, memcg: Prevent memory.swappiness load/store tearing
  mm, memcg: Prevent memory.oom_control load/store tearing
  mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing

 include/linux/swap.h |  8 ++++----
 mm/memcontrol.c      | 30 +++++++++++++++---------------
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.17.1

