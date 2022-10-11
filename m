Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215085FABEA
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 07:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKF2L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKF2K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 01:28:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964765554;
        Mon, 10 Oct 2022 22:28:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14951054pjq.3;
        Mon, 10 Oct 2022 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptih+RO6sVP3W/jBVYc29KEuxtFP8RFJxq2H7Lnlg7M=;
        b=RoB6MUgSotHIwjjtS/88cXgbrKPZSaYZ+eEQMxm65BA2KXats6SO7HK2nHMR58QCnI
         Z1TWj2ZmOiNAfJSMuHCKOur2hADW15ULjnSYzOkm4wA9cbN5OgOkSXL/EqoRdBmSjq39
         YqPAYT+3vttWdkVKHzH+dmBgIIf7y3Ps7KKy9ivND5wtO+CV6o87L4QCGIqJmpuhdJN3
         f8HFjxnpS0LQuV5e/X509t0CHIfRT0prGRrr67t2mXn2ceTOPvWc8QUc4A0a/H402Spb
         kI0nNxpqyAKe/j8u6Rs4fw8AcY7M6UI5ScpyDxvWgLHOBEuw5pFX8TnSfeuaBQuqF17V
         4MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptih+RO6sVP3W/jBVYc29KEuxtFP8RFJxq2H7Lnlg7M=;
        b=f5GJisp7e1UIRE8HSHlLcaGbFYohBfasJM9BzzBvoAADuVTM+st6Xx39cIq3WPirFe
         O9KU/4quCsCAUIMDvFkUmsUfpUUtOQV7i8/w3HjhSGRieapYEreSZ8E6OfSqTpKnMWOv
         5mabXyeYO1Mx0iMyno9mLi7K1/gnE3HcDR6JUPpLuToxsozEWPyopgvWVSoriI2AqCnK
         HmJnS1QmY3QCSmgbRkxK1UNpe7SIP5h8LRXn+WzNvHrWuRUKE4+j+01CKS9xetICd9GS
         sQ6adjeJ4CV5HGoEJI7iw9ipc08Zvw8bpG0lN9h1mdO30gUjborb5EYVXyQCbvbaPmYW
         0gIQ==
X-Gm-Message-State: ACrzQf1uuFvBylUl7Dv4mf5d7/pzrdzVRg4s29DPJcgu0hNDcfQFyRft
        7ZqIdufSRD0Hpt0SrzeQqrE=
X-Google-Smtp-Source: AMsMyM5OD30N96OOT/R0R37lDogobkBgB36o/THLxO+mx68wKUEemrMST6RBH3NkNzUKnH/XBK5WsQ==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr21856446plh.41.1665466088894;
        Mon, 10 Oct 2022 22:28:08 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:bb9c:600a:490c:ecc0])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b0018003571809sm7309141ple.224.2022.10.10.22.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 22:28:08 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2] perf stat: Support old kernels for bperf cgroup counting
Date:   Mon, 10 Oct 2022 22:28:08 -0700
Message-Id: <20221011052808.282394-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
References: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
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

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 435a87556688..6a438e0102c5 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -43,6 +43,18 @@ struct {
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
 
@@ -50,6 +62,21 @@ int enabled = 0;
 int use_cgroup_v2 = 0;
 int perf_subsys_id = -1;
 
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
@@ -77,7 +104,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 			break;
 
 		// convert cgroup-id to a map index
-		cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
+		cgrp_id = get_cgroup_v1_ancestor_id(cgrp, i);
 		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
 		if (!elem)
 			continue;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

