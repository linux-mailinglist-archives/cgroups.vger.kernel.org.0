Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCD6EF598
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbjDZNjZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjDZNjY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 09:39:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6963A8C
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 06:39:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2474877cc18so4201101a91.3
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682516362; x=1685108362;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB4DXeiyaGWRGpg1RZJs4YrYQeUFxP8q5oC/iiUzgWk=;
        b=emGe3v+hKdvQrvjl4a2uL61Vidypm6iAFv9LSm15rGZal80ihx30dhzmaX4DR2L5FI
         tzvhVTsOh4fiIVKvw8+UJCzuQDaHqPwEDZnDfNM9fcc/5zhQ7ZE02esGSLVrOacFGa2w
         PbUcgEDLQnqqBYxN8oTZvoL/7EkcSB7Fmoc93quhvb+ktB1bnrmZe3xDyxBjM3c6j1rK
         SAP7DHJ7DGgrwr66cJZRVAOm37uuP+EvleqsdnJUlRGJOdNwzmWm5u2YBeR8mCuVrKsp
         +4dbdz//BxR2iJejLqq+0lkxEiAE1VA6eocg/jtU4SCC2xkrltYe/xm1xPFS9I+qR8OR
         Tllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516362; x=1685108362;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB4DXeiyaGWRGpg1RZJs4YrYQeUFxP8q5oC/iiUzgWk=;
        b=Dh/1Hp97f5UIjZToGVDkmdgUhEGIW112SRP14ANa7vWx5IRANx7mOPJm/4v6cviNMm
         wFGiCMfKYVAoDKtPY2bXLOojeL4therY/aCHRr52+ECW/mVpd61/sUg0wPRyEepLwa66
         0wra5uRs2/PgwOZ1K4x9n071EaR+MnvKVG++l9WTbUTCHCnO347r6DipyYfl3uwKMbc8
         Ae2z4rd55HFzO4XR/67u4Ey2F9KAgJfpuYlj/Fdje5NUzmhQaGsPwgO9Y8VWdyM01jB5
         CG41Te8QgQ26oO2RK33nKe8/vpvY1I7aUdP0v1S3fjLM6xQNQ897G9u0Z13lwgl/cqT6
         Wemw==
X-Gm-Message-State: AAQBX9cXqMWHhj1u+xWTSbBe3SWeYlrZVSC76Y2wHI/kCWl4xg7yN1Ph
        7oFHfP8ZhO5om3tEHnuNnnGI1Pd5E+nDM9XG
X-Google-Smtp-Source: AKy350ZjfZ+BIfyJNqEXcvm2T/R2eUKq4ijsukzf0jNghkcUNvTJFaoDf4KZq6ppxB2RiGelh8+DxoA0H1jlZhsC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:748e:b0:247:101f:954e with SMTP
 id p14-20020a17090a748e00b00247101f954emr4760228pjk.9.1682516362678; Wed, 26
 Apr 2023 06:39:22 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:39:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426133919.1342942-1-yosryahmed@google.com>
Subject: [PATCH 0/2] memcg: OOM log improvements
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This short patch series brings back some cgroup v1 stats in OOM logs,
and it makes memcg OOM logging less reliant on printk() internals.

The series uses seq_buf_do_printk() which was only recently introduced
[1]. It did not land in Linus's tree yet, but ideally it will land this
merge window. I thought I would share the patches meanwhile for
feedback.

[1]https://lore.kernel.org/lkml/20230415100110.1419872-1-senozhatsky@chromium.org/

Yosry Ahmed (2):
  memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
  memcg: dump memory.stat during cgroup OOM for v1

 mm/memcontrol.c | 85 ++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

