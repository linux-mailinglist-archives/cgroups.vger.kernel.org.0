Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674596F194D
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbjD1NYM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjD1NYL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 09:24:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4498E46
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115e69e1eso10532946b3a.0
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682688250; x=1685280250;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WHCBk5ekoAeggcfMzSItuZKOWJ2+XlF6kZloOg6sBWI=;
        b=ExU31UHiJbjXrqTR/RqtL1j7rtOUfrWye3kSIY+A9bN+qQOyMIen7nZ14d0Cslj/rw
         0K0Bqef8k5GwIXCOnaTSAtRwXteDZmLIh3M61j5KjQlBPVJeSd7nlkWo+zsS3dmJYcg1
         4kPNtWe5dhSdiycCKhAgpILFExYKaISctW+uSpbiivNtdrGlhP1C28da5SqI+Iiz/NK1
         BUf2RYaYobH43+xZz2BSvVquZXldFj1iCvK92+4k6ySBsJwHjva5lbQtAhc1AiBKG1pL
         LpsLc8MUIU41XiyWbUGY1rpSwpiDqSKC8VLyEJxX3Lg3X0R8kl5GTNZ9vmj9HQs11RGP
         83HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688250; x=1685280250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHCBk5ekoAeggcfMzSItuZKOWJ2+XlF6kZloOg6sBWI=;
        b=kg7l4uopbcFQAv2LMkZugSSmjQBcLJXZ9b/KaBs6aaF5s3prVUfwClf/Dk4lG07g25
         RWTYdL/jsCjM+QM28ml6QFWJL1ghQOzbWkaXZZiO2Wa8rCPKKYUaVvMfxRAFpt4BiseU
         /LXjZddLQzMfgdgjDCecYodkkJthRs7IUTf00FESSUYQDsOOU8yVW0BSLLoPxXXc3gaX
         1bDXG2ZLuSfTXnFLyCPiz1P/3TSG4t2SodGQPbqH2v71jzQarBC/0+S0DTk3SkZ3TaCT
         w8jlyXoIfpvgbLrZ9FglrxF2fnej4sa+iMjEVBucqzjeOWWpnOXexVbIzKauVyh8imI6
         IJ3A==
X-Gm-Message-State: AC+VfDzOeXPRo1TMYsx6l5XNb73EHb4jQ5GiqpDvPs6iK0VWwwws559w
        F41MJZQDmqVMePlI0n+9C84hJmN9ho1ok2HV
X-Google-Smtp-Source: ACHHUZ5yDwP6znzISpEDQqOcWA1LzG9974vmTJ9VwtAXQ0FSs47oGTk6dHRKZ40/nhBwiSptB2LvFwUEOvOcf6L1
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:be05:b0:1a5:112d:f90b with SMTP
 id r5-20020a170902be0500b001a5112df90bmr1728309pls.1.1682688250374; Fri, 28
 Apr 2023 06:24:10 -0700 (PDT)
Date:   Fri, 28 Apr 2023 13:24:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428132406.2540811-1-yosryahmed@google.com>
Subject: [PATCH v2 0/2] memcg: OOM log improvements
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This short patch series brings back some cgroup v1 stats in OOM logs
that were unnecessarily changed before. It also makes memcg OOM logs
less reliant on printk() internals.

The series uses seq_buf_do_printk() which was only recently introduced
[1]. It did not land in Linus's tree yet, but ideally it will land this
merge window. It lives in linux-next as commit 96928d9032a7 ("seq_buf:
Add seq_buf_do_printk() helper").

v1 -> v2:
- Collect Ack's and Reviewed-by's on patch 1 (thanks!).
- Reworded the commit log for patch 2 after discussions with Michal
  Hocko.

[1]https://lore.kernel.org/lkml/20230415100110.1419872-1-senozhatsky@chromium.org/

Yosry Ahmed (2):
  memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
  memcg: dump memory.stat during cgroup OOM for v1

 mm/memcontrol.c | 85 ++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

