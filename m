Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003D25E5A0C
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIVEOl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 00:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIVEOj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 00:14:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C7DFD2;
        Wed, 21 Sep 2022 21:14:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so918949pjk.4;
        Wed, 21 Sep 2022 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=z8K8JabQHxvWke1wLuSNQQKC0Zp7p6L1teN9v6xkDP8=;
        b=GZpjOi0ytaP2Q0bSJ8LGmg2pmd5KvjScrRWewswVinGIz3c/zhvb+1l/h2psEwXYaB
         rkShb2F5lWekTtP+LgZDTxg/pbOKMJWns05QG0lgHnwch5fCx0x5MstVObxATaeeFrw7
         lMg1vYE2HDHCqKbxqTeG+KIZlrwSfd+gSnxqUL/VxJAz1TLnACv0ommsz0DE04xROqJw
         EV+zodAOmFwbyqfZpBTpL5Fo8GqljGs583mTwmEvMiwZdeapXtJCQHHniv5KC1ONVs71
         /k1jbqX2Lf9MLz7KlT8Hyddd6h8YFEhEkSx0EGXYcNusCziPsYfnBb8M21UnUzOcxbtD
         1Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=z8K8JabQHxvWke1wLuSNQQKC0Zp7p6L1teN9v6xkDP8=;
        b=WIxMUyNS0xKvZZtBeXTgXatQnHl6n/L4+Z450m5KIarX3FxDrvnt3Izn9AHdI8T1dF
         O1XZvnvc7Eyu8L3b6QH3nwQh2dD8C3QmL94/zNKxtYBR+dxAKUrWzBwNElEs1sMZmWxD
         78YW4izboxMyxvgwALgJlNP1kJytxWa021TvNk1JaJbgXZYiKbAnYFxqNP0NxMYjSls5
         V2fPL+/epVJR/K+q0t3ey3nVGFvKhBwFG296TfL5k/xuGEPKLai/XL4bZMjPe6YrJaP3
         tW/IDgZlErs5ZDtHvNKFciCz8nrV0LcAtvuqgNfOKkHvY5kEsGF0AfsSyYxJLHGQwIFl
         xGKw==
X-Gm-Message-State: ACrzQf0oMp8sTez+l7/GQ6K1DpUYAzOHNWYN50Qc8zx2WPli7wK6fWPW
        ZraCZotqBn/uQ46G75r3DdE=
X-Google-Smtp-Source: AMsMyM6H9DykUZ5nykAuy1NSDpqTlkI7yB2pKbDL1MY31zpOGgU2hatPthfJuE6yM2AFSIdUilvhAg==
X-Received: by 2002:a17:902:f644:b0:172:b074:d1f5 with SMTP id m4-20020a170902f64400b00172b074d1f5mr1407085plg.29.1663820078037;
        Wed, 21 Sep 2022 21:14:38 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:796c:caf8:4dcf:320d])
        by smtp.gmail.com with ESMTPSA id lp5-20020a17090b4a8500b002006f15ad4fsm2749152pjb.10.2022.09.21.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 21:14:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH] perf stat: Support old kernels for bperf cgroup counting
Date:   Wed, 21 Sep 2022 21:14:35 -0700
Message-Id: <20220922041435.709119-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The recent change in the cgroup will break the backward compatiblity in
the BPF program.  It should support both old and new kernels using BPF
CO-RE technique.

Like the task_struct->__state handling in the offcpu analysis, we can
check the field name in the cgroup struct.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Arnaldo, I think this should go through the cgroup tree since it depends
on the earlier change there.  I don't think it'd conflict with other
perf changes but please let me know if you see any trouble, thanks!

 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 488bd398f01d..4fe61043de04 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -43,12 +43,39 @@ struct {
 	__uint(value_size, sizeof(struct bpf_perf_event_value));
 } cgrp_readings SEC(".maps");
 
+/* new kernel cgroup definition */
+struct cgroup___new {
+	int level;
+	struct cgroup *ancestors[];
+} __attribute__((preserve_access_index));
+
+/* old kernel cgroup definition */
+struct cgroup___old {
+	int level;
+	u64 ancestor_ids[];
+} __attribute__((preserve_access_index));
+
 const volatile __u32 num_events = 1;
 const volatile __u32 num_cpus = 1;
 
 int enabled = 0;
 int use_cgroup_v2 = 0;
 
+static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
+{
+	/* recast pointer to capture new type for compiler */
+	struct cgroup___new *cgrp_new = (void *)cgrp;
+
+	if (bpf_core_field_exists(cgrp_new->ancestors)) {
+		return BPF_CORE_READ(cgrp_new, ancestors[level], kn, id);
+	} else {
+		/* recast pointer to capture old type for compiler */
+		struct cgroup___old *cgrp_old = (void *)cgrp;
+
+		return BPF_CORE_READ(cgrp_old, ancestor_ids[level]);
+	}
+}
+
 static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 {
 	struct task_struct *p = (void *)bpf_get_current_task();
@@ -70,7 +97,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 			break;
 
 		// convert cgroup-id to a map index
-		cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
+		cgrp_id = get_cgroup_v1_ancestor_id(cgrp, i);
 		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
 		if (!elem)
 			continue;
-- 
2.37.3.968.ga6b4b080e4-goog

