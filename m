Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DA58C726
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiHHLFJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiHHLE6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:04:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A35140F9
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:04:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q16so8257802pgq.6
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHJHLaCoDzV5QUtZAIutwfB8iOBAVflqU47uK3W3CxI=;
        b=frlElavzwzibQasm6LTTz+dwYLm/7rqeeNLg0mE9N8JxS4JAEYhTzxo0uKrELF+WKw
         7BEevAELdtUIHm0Xky0Bw2JYBA+kR11snSOYCiz4VncyE9W7aGBlRw2P8z8s1sBeNKde
         SERqentIU6/0Zn0YuMv5jlTA2bvPz9zxhgB94RoAwxf0qr3Ndpnr0fzN8t1VPXX7wrq0
         SCJPtJNDDahbjM+oOF4wd1meW2kU/S192uFI594ytliYDDWzCTsxma71FB+4OSu2g87C
         qJeAIanKsgf1HweklW8pGokQtQ8q878zeCuJwj3ttpS3Z+CgYOC8CCfQyrRLDjIOR0ZN
         c+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHJHLaCoDzV5QUtZAIutwfB8iOBAVflqU47uK3W3CxI=;
        b=DDt3xolM3jqqT1/U1H8IGA66n/bvE9NqnPoH13u41J0gtfuP3n5OCHNqfGNbCuj2U5
         BwNbbsddALY703D+nFqLSnjA/z7/ApwtVpOfMuCVSVXKo6DVIREjAY0XHn6iTsrToLQA
         xux13n6BJh0FlTLJk7XJdL/Ciiuo6dhOuo2FkoiARXM7InrPIk6hQamB3/rFg9rMrkvS
         U7UQfDJZAMK/M2gLwyFPrgU8S014YNlDflQdun8X/kdiNnoN8Xc0LfrvCJOrRwshOeuT
         Il9PSxNvE4D/MLTgQ2Zkocapr1e3QeqiMz0N0bYrBi7DBtuLKwu+4jS8SQCFujZiKXDB
         8u6A==
X-Gm-Message-State: ACgBeo03KBbw0tnLBb/nmqTZceEo2dUCHzEGtd4GEM8/8S8GH0BGfXjD
        1kcaIFchhI+Pea1JY70ShzMipg==
X-Google-Smtp-Source: AA6agR6hWWne6ZVloa2WFigujscawmh6Y7gt/eGM5EqEV9V9cEv5bTVEdBbwyLR2UDI42TdcC+aFzA==
X-Received: by 2002:aa7:8147:0:b0:52f:3fd9:aced with SMTP id d7-20020aa78147000000b0052f3fd9acedmr4723823pfn.78.1659956696502;
        Mon, 08 Aug 2022 04:04:56 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:04:56 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 05/10] sched/psi: don't create cgroup PSI files when psi_disabled
Date:   Mon,  8 Aug 2022 19:03:36 +0800
Message-Id: <20220808110341.15799-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 13c8e91d7862..5f88117fc81e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3709,6 +3709,9 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 
 bool cgroup_psi_enabled(void)
 {
+	if (static_branch_likely(&psi_disabled))
+		return false;
+
 	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
 }
 
-- 
2.36.1

