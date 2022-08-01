Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89518586FCD
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiHARyk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiHARyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 13:54:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ACEBC03
        for <cgroups@vger.kernel.org>; Mon,  1 Aug 2022 10:54:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a11-20020a5b090b000000b00672acbe13c1so9120258ybq.2
        for <cgroups@vger.kernel.org>; Mon, 01 Aug 2022 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=94uBmcLYR44gO9IwX8w38Cl0b3ucjrw05lLRZoANBEo=;
        b=rsW6JPNEjOByHKoZqtGJI0llTPq60KTitf7bJXV8OIcA7HWQ2jwDpIlYh4NiTbi44U
         /7SW+a184h2h92ey8CKe9MxNIJ5Ng8ysWl3CfH1bLJrDxBMVr9MFcETQxxfOBYswE6zA
         pNYteBbHgrN0aaOFqkSLuGdW2mApz5mLUYEEhkWEvi6K5ZHULL3x9tJvZ/1cYdhf7ncy
         5vWXyHUIpdbK26RpZDPmzHXVDoq7xbNfAa/vJFw0n8Z0b+Tnwne4PxoLWi2BcO2bNH4A
         BNxxuzwmXaJjbELOSQTSuxSkFeCfifQL026l2dMv4rwxiS88sswqMQEU6E7IeermXS5K
         bQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=94uBmcLYR44gO9IwX8w38Cl0b3ucjrw05lLRZoANBEo=;
        b=JTeBB7EUCaeSvLZau6UIRzGsswHhSZ5TuFsmzAvYeHJcfYD5c0uyuvI5gNaBMMdell
         fiuEuVvP/l2k1zeHBFQWUWO0/fyG4agIwE9v3y0otzYN9ChLSWJNrgkBOBCsq22mXJmj
         bf/S5qFt33uyCuIS2h/NimIG/ho5mfgO2I6iHGxH5KdFUVwR+pynFdJoC1JOl4MQaWLM
         43suWiJE3HPMxJdXyNlgVG+eEgTxd1j2vIwK/XE2yhNTOy++2eNca7D8dTlkRzJ52vg/
         hDaTbm2K7YTq2n9ezhCbR7wBi8ywp9QYvfZuA4Id8xyGblsiVnWKr3NqiR10w+YGiPTL
         DOCQ==
X-Gm-Message-State: ACgBeo0AUlO+mrr4IzpsQ9ynud3uPhJM9M3OLnbNW1TTBeu0yf6LfFIo
        exuMRZwzm+QAQELArSnbqvqw7lZbpnI=
X-Google-Smtp-Source: AA6agR4qKYgij7ozdxesZZjTYakKZ8S9yFfDp/tVifPcHrXtZha2s3/p6pa83PCSOZoOwZf8F5aWclmhyE0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a0d:f846:0:b0:324:cb8a:e0ff with SMTP id
 i67-20020a0df846000000b00324cb8ae0ffmr6685761ywf.478.1659376477250; Mon, 01
 Aug 2022 10:54:37 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:54:00 -0700
In-Reply-To: <20220801175407.2647869-1-haoluo@google.com>
Message-Id: <20220801175407.2647869-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220801175407.2647869-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v6 1/8] btf: Add a new kfunc flag which allows to
 mark a function to be sleepable
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

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This allows to declare a kfunc as sleepable and prevents its use in
a non sleepable program.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 Documentation/bpf/kfuncs.rst | 6 ++++++
 include/linux/btf.h          | 1 +
 kernel/bpf/btf.c             | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c0b7dae6dbf5..c8b21de1c772 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -146,6 +146,12 @@ that operate (change some property, perform some operation) on an object that
 was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer to
 ensure the integrity of the operation being performed on the expected object.
 
+2.4.6 KF_SLEEPABLE flag
+-----------------------
+
+The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
+be called by sleepable BPF programs (BPF_F_SLEEPABLE).
+
 2.5 Registering the kfuncs
 --------------------------
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index cdb376d53238..976cbdd2981f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -49,6 +49,7 @@
  * for this case.
  */
 #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
+#define KF_SLEEPABLE   (1 << 5) /* kfunc may sleep */
 
 struct btf;
 struct btf_member;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e64447659f3..d3e4c86b8fcd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6175,6 +6175,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	bool rel = false, kptr_get = false, trusted_arg = false;
+	bool sleepable = false;
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
@@ -6212,6 +6213,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		rel = kfunc_flags & KF_RELEASE;
 		kptr_get = kfunc_flags & KF_KPTR_GET;
 		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
+		sleepable = kfunc_flags & KF_SLEEPABLE;
 	}
 
 	/* check that BTF function arguments match actual types that the
@@ -6419,6 +6421,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			func_name);
 		return -EINVAL;
 	}
+
+	if (sleepable && !env->prog->aux->sleepable) {
+		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
 }
-- 
2.37.1.455.g008518b4e5-goog

