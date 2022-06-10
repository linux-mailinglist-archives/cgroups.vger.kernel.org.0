Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3483E546D80
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350479AbiFJTpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350429AbiFJTpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 15:45:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03914927E
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:44:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso10748pgc.23
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XL2ObbHh5bI7PkeXJYGc2UizZ2yMx0505kd5+6ZTGek=;
        b=V3FC87ToUbSYHf9bcAaSuAZkXLsAVlExIxHjjiSdh7QMh02pWjjd6E4B6KhNiA1WpZ
         wQs+tK4vP63QqacshGi7SJTaZU1yq6orG3ioQrH/ECMcW5DnQHBLM/tgT3J3gC1Y3tUE
         NIVL9e156rrxhaF7d/TohQFAqUrJ8xhXkl+Nx51wagFPyZSTYL1LiNofjdmqEiS9AwcH
         Wp/hJmcWK/LD0/hoTFDDIDdKENwKOsBPT5tZKRr14jzUN++hNlPv5gxli9eX7ki33559
         PI8x7eKkaXF/raklqyIIGN2PTc5dXzYJm6hj5I6kJAJjavpnoqjMrgMM50C+/2x8XIk+
         fEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XL2ObbHh5bI7PkeXJYGc2UizZ2yMx0505kd5+6ZTGek=;
        b=hMZQSnv1WIaTGWQMuyTTMY18Jd4OR9Uf9g95a+CZuq8ymyG0lT9gqy5ychN86D0Vhh
         F14bnFWGP6vMmXQFlSwLh3c/tLbVaaLqHxYHbxDlxOOQ5TueTxgwY6bA2kPsE7DvTBKW
         aq9b8LHfEuHGGAkioXCrv2NS48AW8jW07UuLsvOanEIOg5A8bsC4KS4wAnYwz10Pdz69
         tDrnqRQZkIGkG7UMhRBHAmTI1TjdGJw8F2MWPTjBl3adx/4iP+IcDVpPrt+EkpQ0hJcR
         RELgsZ8pyV12ctyTQaF75BPDWXEryVBJqp2isLlKokeKLNeWwfshHotG2SunCowDEHoP
         AbXA==
X-Gm-Message-State: AOAM530Gykz+iky00qCTHB34Bd3k0BTIBMYLu9IdjLRaZ29vWBxn3ttx
        AI4mSunNLBpEEmRWmeTkqnCawSdlBXKd+jKr
X-Google-Smtp-Source: ABdhPJwvl+cJQi3YElE3/Lz5iGQDjGxVLKiETlBjbZAEsXfjtLViJu8qfKaeaaP+quYiPY8x/7J13hO6f3EHI64W
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:181:0:b0:3fe:149a:35df with SMTP id
 123-20020a630181000000b003fe149a35dfmr16815341pgb.158.1654890292074; Fri, 10
 Jun 2022 12:44:52 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:33 +0000
In-Reply-To: <20220610194435.2268290-1-yosryahmed@google.com>
Message-Id: <20220610194435.2268290-7-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 6/8] cgroup: bpf: enable bpf programs to integrate
 with rstat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

Enable bpf programs to make use of rstat to collect cgroup hierarchical
stats efficiently:
- Add cgroup_rstat_updated() kfunc, for bpf progs that collect stats.
- Add cgroup_rstat_flush() kfunc, for bpf progs that read stats.
- Add an empty bpf_rstat_flush() hook that is called during rstat
  flushing, for bpf progs that flush stats to attach to. Attaching a bpf
  prog to this hook effectively registers it as a flush callback.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/rstat.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab55983..94140bd0d02a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -3,6 +3,11 @@
 
 #include <linux/sched/cputime.h>
 
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
+
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -141,6 +146,23 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
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
+ */
+__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
+				     struct cgroup *parent, int cpu)
+{
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -168,6 +190,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
+			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
 			rcu_read_lock();
 			list_for_each_entry_rcu(css, &pos->rstat_css_list,
@@ -469,3 +492,26 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 }
+
+/* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
+BTF_SET_START(bpf_rstat_check_kfunc_ids)
+BTF_ID(func, cgroup_rstat_updated)
+BTF_ID(func, cgroup_rstat_flush)
+BTF_SET_END(bpf_rstat_check_kfunc_ids)
+
+BTF_SET_START(bpf_rstat_sleepable_kfunc_ids)
+BTF_ID(func, cgroup_rstat_flush)
+BTF_SET_END(bpf_rstat_sleepable_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.check_set	= &bpf_rstat_check_kfunc_ids,
+	.sleepable_set	= &bpf_rstat_sleepable_kfunc_ids,
+};
+
+static int __init bpf_rstat_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					 &bpf_rstat_kfunc_set);
+}
+late_initcall(bpf_rstat_kfunc_init);
-- 
2.36.1.476.g0c4daa206d-goog

