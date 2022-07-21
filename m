Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014E57C328
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiGUEFo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiGUEFX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB813DFF
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f3-20020a17090ac28300b001f22d62bfbcso642496pjt.0
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTBK+C00vRPG4JDueYyv7EqFsWvxIqsN3waJE+O/isA=;
        b=QHIvOf/vF7cxWQOSppu23p6vElDHp0+ZqYuQj3IE6sYMS6UGWgb8VpdRJEDv/3fmgK
         EBsyNAQs2eSnCL8T+CYX5Ge6nLSOCZhoT7717mCb3PYoGzDPZvxo0RttCkMybvV+RiqR
         7lSJrgu7/rcXtElobuMaOqMSQk4MZHbvh0tkYM8/N8UBVTGiNPK+sk0l0Q1No0nSuCne
         +ICLWxXj78VcKThofLCbfIwAuz7LBngg0/wfa0zSvrleB7AUxs7BkQP92oCOqUvaFR9q
         96tnMKzLbOOur2qTlrlpvcq9bAVMyNMH61VFRD89X5LBADuZX1NXdhUgyrLX/EYl/Du0
         N72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTBK+C00vRPG4JDueYyv7EqFsWvxIqsN3waJE+O/isA=;
        b=1Pkezb9wFTT485kEZ2oVf5l/SKFGUct9/rbBJd5C7DYIfPI1nyJ5I9nNyJCKUbpWQ0
         1ha8gjfXFqZHqMSLGMBlqetKSV+vW9JAobYZiV0VhvXhDijzZ915OgiHO50atW6wt6an
         XSpTSFZNJFtddFewY8PY8vmUiVeBRhElc29an1ilDslfsgGac3XXKcjXPsdEVbC3Kuo2
         NwqIXm2ofx60JMJt8y1QxMXma/V35nG0LdpyXoh1lTTc+E+xJWRFe0hKLfDlNIE76JIK
         3KQgrX+wI/wwyNbfH4KyD0AEtBEjaEfUnEEoklmWHFsMiZvOHUVECwUAAxEKgX5ykpsp
         4MTQ==
X-Gm-Message-State: AJIora8cYnyO/SB4hk45AEQMXOgVqGVWQtOnM/IVsKGA+WDpXrwycBBm
        bflk581KmgmcXcMuPevSvVX9qQ==
X-Google-Smtp-Source: AGRyM1tD8ydLFbzp0WwR7EaNXDsuFnSu/q0Me8fNNp8ZZt3K7hT+RDgBX5aStMP8YvI5v0abrO21vQ==
X-Received: by 2002:a17:903:44b:b0:16c:b112:7f74 with SMTP id iw11-20020a170903044b00b0016cb1127f74mr35436361plb.149.1658376319603;
        Wed, 20 Jul 2022 21:05:19 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:19 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 5/9] sched/psi: don't create cgroup PSI files when psi_disabled
Date:   Thu, 21 Jul 2022 12:04:35 +0800
Message-Id: <20220721040439.2651-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI can be configured to skip per-cgroup stall accounting. And
doesn't expose PSI files in cgroup hierarchy.

This patch do the same thing when psi_disabled.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..1424da7ed2c4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3700,6 +3700,9 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 
 bool cgroup_psi_enabled(void)
 {
+	if (static_branch_likely(&psi_disabled))
+		return false;
+
 	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
 }
 
-- 
2.36.1

