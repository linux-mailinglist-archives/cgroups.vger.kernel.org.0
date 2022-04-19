Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE8507BEF
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356483AbiDSVfc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbiDSVfc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 17:35:32 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D318B1E;
        Tue, 19 Apr 2022 14:32:48 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id o18so13259054qtk.7;
        Tue, 19 Apr 2022 14:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8nllmOR/z4RsmpSer/nM9ycbgtkYEb8BRUHXDiWoG4=;
        b=i5cgZIpp01q/bUqkS7fZHShGa7tmpBKYplIKc2Ss8Fr2Ma6YHxbCVAEu2gsIWRhves
         JE1Dq1AkDI0V5QW0Rbkp+3eLLW+/JVDiuFbtKAQVaqX0aC4Zw3IKj7ROb1jFrKT4nMWW
         79tSkKKadaAXGz5YMhhFWbScQRFy6EedaE2vmRrGIsON6fsac0BKQK/B1/BIOJNHpmxZ
         QcgYJSU4Qx022NFVuU45zFyy2XRCn4eOKjMw3bUJ02QXBXbrXRbJyipnPu0eSO+PLDnY
         Y2ykk9cPe7zAWo4Oo3cPtOL5X0TKBhJ5NQjd+xmJ8TahKPEzXsfgU1HkVbWgOxT0O1Fq
         RBbQ==
X-Gm-Message-State: AOAM530chz2rWs9Y2cLEWHvYXJFsMBN8r+0UGOIubPCrYhK6GTUeOrOC
        gv/pgiTZcOaMtNm4f/zfGh0=
X-Google-Smtp-Source: ABdhPJwXdjiRvjmj8zQul1ZjG8apEjePAeHKN+zOG66LC8UD7HZCTvPHtfZcEEN9JfPtc7raC0XgDg==
X-Received: by 2002:ac8:5c4e:0:b0:2f3:3ab8:d788 with SMTP id j14-20020ac85c4e000000b002f33ab8d788mr2745333qtj.390.1650403967455;
        Tue, 19 Apr 2022 14:32:47 -0700 (PDT)
Received: from localhost (fwdproxy-ash-019.fbsv.net. [2a03:2880:20ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a0f9600b0069e8ab5034dsm557769qkn.1.2022.04.19.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:32:46 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Date:   Tue, 19 Apr 2022 14:32:40 -0700
Message-Id: <20220419213244.2104972-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset introduces a new test_cpu.c test suite as part of
tools/testing/selftests/cgroup. test_cpu.c will contain testcases that
validate the cgroup v2 cpu controller.

This patchset only contains testcases that validate cpu.stat and
cpu.weight, but I'm expecting to send further patchsets after this that
also include testcases that validate other knobs such as cpu.max.

Note that checkpatch complains about a missing MAINTAINERS file entry for
[PATCH 1/4], but Roman Gushchin added that entry in a separate patchset:
https://lore.kernel.org/all/20220415000133.3955987-4-roman.gushchin@linux.dev/.

David Vernet (4):
  cgroup: Add new test_cpu.c test suite in cgroup selftests
  cgroup: Add test_cgcpu_stats() testcase to cgroup cpu selftests
  cgroup: Add test_cgcpu_weight_overprovisioned() testcase
  cgroup: Add new test_cgcpu_weight_underprovisioned() testcase

 tools/testing/selftests/cgroup/.gitignore    |   1 +
 tools/testing/selftests/cgroup/Makefile      |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c |  12 +
 tools/testing/selftests/cgroup/cgroup_util.h |   4 +
 tools/testing/selftests/cgroup/test_cpu.c    | 416 +++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_cpu.c

-- 
2.30.2

