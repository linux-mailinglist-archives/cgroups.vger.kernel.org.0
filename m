Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F350C9F0
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiDWMfS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiDWMfQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 08:35:16 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535319FA93;
        Sat, 23 Apr 2022 05:32:19 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id o18so7288768qtk.7;
        Sat, 23 Apr 2022 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjvd9HBYUKTG7tiz4UXuo0+xBPTs1X922uSucprikPU=;
        b=Uh933T/JUH5JD1O6b/ORDwu6FDFx9tMdYjVswJEYMacwDN/AVdUS8AMvDwe9TwxBWI
         Z13GXkEqxVbFpUmAFpLr6H/3kYlzjo5X4N+Woovb1LeDq1/0oOK1kGs62vIx2tpGN5vb
         iqNmlecYm0846Xu5uGSrr2rGrp5rpRmgnTiShSOYrJig8YsQ4urItNFtuIbyNRK2DZ6V
         acXZlRR+YmxxEfeGtjC1NKxMtB0ZHJKjMVBlXlBpqj331CxkFC/3RgN4krupoKvhQM7K
         7SVodeIReUjhinnU+VG8CyxJjPyS86J/LqYPjj1n6iqXDtANXA+EoPyzg2Kh5oWkA6vZ
         M4TQ==
X-Gm-Message-State: AOAM533dlAnQV21rD71ajxzJdNtu71T0tf1QM7YVGk3KH5ji4QX6ZVYF
        ycil73XhSwzs03rKQEDVJwI=
X-Google-Smtp-Source: ABdhPJw8PGnHGavsa+EyWdLnGCYp2f6dr0yiWghsmS0eIwJ1W/l+HoNZZYB4dc8W1OdAyvkSTuJ1Vw==
X-Received: by 2002:a05:622a:1d4:b0:2f1:f278:d387 with SMTP id t20-20020a05622a01d400b002f1f278d387mr6514973qtw.645.1650717138590;
        Sat, 23 Apr 2022 05:32:18 -0700 (PDT)
Received: from localhost (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm2146844qkm.111.2022.04.23.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:32:18 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] cgroup: Add config file to cgroup selftest suite
Date:   Sat, 23 Apr 2022 05:30:54 -0700
Message-Id: <20220423123053.2982931-5-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423123053.2982931-1-void@manifault.com>
References: <20220423123053.2982931-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Most of the test suites in tools/testing/selftests contain a config file
that specifies which kernel config options need to be present in order for
the test suite to be able to run and perform meaningful validation. There
is no config file for the tools/testing/selftests/cgroup test suite, so
this patch adds one.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/config | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/config

diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
new file mode 100644
index 000000000000..84fe884fad86
--- /dev/null
+++ b/tools/testing/selftests/cgroup/config
@@ -0,0 +1,8 @@
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_KMEM=y
+CONFIG_MEMCG_SWAP=y
+CONFIG_PAGE_COUNTER=y
-- 
2.30.2

