Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B39586FD6
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiHARzG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiHARzA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 13:55:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287C3C161
        for <cgroups@vger.kernel.org>; Mon,  1 Aug 2022 10:54:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-322f9280fe0so91408957b3.23
        for <cgroups@vger.kernel.org>; Mon, 01 Aug 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TT0h45HvgWsHdbEBDmT0Xh/QzjlzP1cphHtwakCGIcs=;
        b=MPoa2ahkqftJtCCQwamXONh3imuj1fc11gLvHmErlPHEQVftxYVmYXKbIQVEPEzMrN
         d/96nYD7171+3GsL2PBIaeo2uPqqTjv3DAYS2+YmniPaPGFLc6m3jew3jDiwE4KYbqt3
         v9ntQucK1EtArTYje84l9fk2F5KX300+2c/5+QF+7IvL0a8HZQi32ZwjAPNdnD6c0GH5
         xtGZ0Cv2jVnb2n1dRXjBW7zoi/13/M/jawWbKX7vC5qDybY4Ni2KQ5VpSdTbXZO1jcaA
         RBb3PBGrhlpvVIQeSBzU/4yP8E1DMv7dgyMV699T5nYTpvfYNoyZXakulYwRlQdAyX6f
         uG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TT0h45HvgWsHdbEBDmT0Xh/QzjlzP1cphHtwakCGIcs=;
        b=imZ0vb0aJnQ0CCFDlJJLeYkl/c+N8ddTCHfJrJsX/W2qZWazU16W2PBN+lVI6a/0yo
         YB+8lAHdcsVcjwyiRThGq0XrET5rO8dpTguqu7cznsZJWUPCrhsnfMPsrDUBxnmWXKbu
         DcMjsqH7YD/MvOrgQPtgOtaDOickQ5TJm1xzMERKZGqI5QhzxdBaqo1Ym+RSc+74jWCR
         eR21HdggIyR3v1Z4OTwE1GGOGhhDFWLKJC1NVjyxGl/VQ3dkpdOUxvCLYPnrpuXYuwUq
         l3J52fbjFHjFcU50dkJAzvb6f7oOhfuKZerN1LxWhlDZt8SlLmatf7+xvils+8rwoHdS
         qEbw==
X-Gm-Message-State: ACgBeo2OKbOD4dqFIRiojMnVnGZAp2bpeINop/LuHRRUkdxj9S6yEmtP
        itWPaol+wZH4sFkcVSFVKuF5sapVahU=
X-Google-Smtp-Source: AA6agR7/Ia2Te0RU2F8G9qmVle6rQ/lQr5q4ydpTOUxduyezVB7kODRc+/A3KwJuO4yCSSQHbQ4KaNfzjkA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a25:2103:0:b0:66f:2c4f:7de8 with SMTP id
 h3-20020a252103000000b0066f2c4f7de8mr11858019ybh.306.1659376489186; Mon, 01
 Aug 2022 10:54:49 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:54:05 -0700
In-Reply-To: <20220801175407.2647869-1-haoluo@google.com>
Message-Id: <20220801175407.2647869-7-haoluo@google.com>
Mime-Version: 1.0
References: <20220801175407.2647869-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v6 6/8] cgroup: bpf: enable bpf programs to integrate
 with rstat
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yosry Ahmed <yosryahmed@google.com>

From: Yosry Ahmed <yosryahmed@google.com>

Enable bpf programs to make use of rstat to collect cgroup hierarchical
stats efficiently:
- Add cgroup_rstat_updated() kfunc, for bpf progs that collect stats.
- Add cgroup_rstat_flush() sleepable kfunc, for bpf progs that read stats.
- Add an empty bpf_rstat_flush() hook that is called during rstat
  flushing, for bpf progs that flush stats to attach to. Attaching a bpf
  prog to this hook effectively registers it as a flush callback.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/cgroup/rstat.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..3289f6e0d306 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -3,6 +3,10 @@
 
 #include <linux/sched/cputime.h>
 
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -141,6 +145,31 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/*
+ * A hook for bpf stat collectors to attach to and flush their stats.
+ * Together with providing bpf kfuncs for cgroup_rstat_updated() and
+ * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
+ * collect cgroup stats can integrate with rstat for efficient flushing.
+ *
+ * A static noinline declaration here could cause the compiler to optimize away
+ * the function. A global noinline declaration will keep the definition, but may
+ * optimize away the callsite. Therefore, __weak is needed to ensure that the
+ * call is still emitted, by telling the compiler that we don't know what the
+ * function might eventually be.
+ *
+ * __diag_* below are needed to dismiss the missing prototype warning.
+ */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
+				     struct cgroup *parent, int cpu)
+{
+}
+
+__diag_pop();
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -168,6 +197,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
+			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
 			rcu_read_lock();
 			list_for_each_entry_rcu(css, &pos->rstat_css_list,
@@ -469,3 +499,21 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 }
+
+/* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
+BTF_SET8_START(bpf_rstat_kfunc_ids)
+BTF_ID_FLAGS(func, cgroup_rstat_updated)
+BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
+BTF_SET8_END(bpf_rstat_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_rstat_kfunc_ids,
+};
+
+static int __init bpf_rstat_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					 &bpf_rstat_kfunc_set);
+}
+late_initcall(bpf_rstat_kfunc_init);
-- 
2.37.1.455.g008518b4e5-goog

