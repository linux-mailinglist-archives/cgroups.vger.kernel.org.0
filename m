Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6469229F
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjBJPsJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 10:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjBJPsH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 10:48:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6878D57;
        Fri, 10 Feb 2023 07:48:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n3so3964308pgr.9;
        Fri, 10 Feb 2023 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BzE4dHWY04pl7eRXElI/6nAwQrbbF33iW2gxKhD+d4=;
        b=j+gxHQfBd7YR9DKjd+QCY3jhunM0qE502k1Q1kOFjTYec6K5h0eypt2BdeB7fPrask
         zyOtXXHaIaHjLTKHKppAk+Iy+jmgbTPFqltPNUJ8CKtzG4mVYDU3DV9d/VNVRXP8ypOf
         lK6HEtis6SdYcjcUu0PABvv/+/8NvYPV7hnLtRbdKElboXcv350wk00qsAXJKMK3Fy+g
         XXIjW6cnwBzFFcNKYrzsNYgo5j/TBfrHuKQOy5NrkBMgMceLhjn1k0+oWJKmb0Qoq8Z4
         qJX68FnAXTZOjPtdUc3wYrlty43ptBoVJ6kLPOUWuI1ZILmy8c8lp1GSGuApFVrT5irw
         ISmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BzE4dHWY04pl7eRXElI/6nAwQrbbF33iW2gxKhD+d4=;
        b=TyQ3Djh1QSSaIKlmwh3gltgA7J2zJKDBe+KBX//2UmeDSi6tEGYsZVCLwXSoibZGqF
         cr1kaIL//Jko/OBFb23WZ5a5/H4jD62WBB9AmJqZTfKSXVQHNblw/SH2FNSvmLQHZT79
         6B23AOWdXBufUYTbuQGVvCLvycxCgTTANuLRQAjXmUsdrTUSTiVO4nlHFRXHsfzvJc5B
         f9a9vi/bW8DJsq8JtbrQXK6TluRBnOdhj3PQ4IdQRzfO390Y2KIO8C6ywKnRLAteOi9F
         M3Dd3MBghUACBQoXuXQ2vaLZ+z6QLEiowOofnENOLoe5Tm8Co4PL8R461wAq1qpPgHeG
         tCvQ==
X-Gm-Message-State: AO0yUKU6sKDoP3dbzNbRKtVU6nvcb3dRELdJ1DZelUyfzpUfC2ErY2aF
        D/n/PoYUrhxQ8FO4KhwitP4=
X-Google-Smtp-Source: AK7set8W5dANe0k+W3DZarFPjaiIci6Hk8I9WJxnZToYOnQzh2s0R3baoCshnGT3Pp6WNhUtjdz6zw==
X-Received: by 2002:a62:6d87:0:b0:5a8:58b5:bfa7 with SMTP id i129-20020a626d87000000b005a858b5bfa7mr4558913pfc.5.1676044084887;
        Fri, 10 Feb 2023 07:48:04 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:2f6a:5400:4ff:fe4c:e050])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm3520069pfe.99.2023.02.10.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:48:04 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 4/4] bpf: allow to disable bpf prog memory accounting
Date:   Fri, 10 Feb 2023 15:47:34 +0000
Message-Id: <20230210154734.4416-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210154734.4416-1-laoar.shao@gmail.com>
References: <20230210154734.4416-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We can simply disable the bpf prog memory accouting by not setting the
GFP_ACCOUNT.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/bpf/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 16da510..3390961 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -35,6 +35,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
 #include <linux/bpf_mem_alloc.h>
+#include <linux/memcontrol.h>
 
 #include <asm/barrier.h>
 #include <asm/unaligned.h>
@@ -87,7 +88,7 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
-	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
 
@@ -96,12 +97,12 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	if (fp == NULL)
 		return NULL;
 
-	aux = kzalloc(sizeof(*aux), GFP_KERNEL_ACCOUNT | gfp_extra_flags);
+	aux = kzalloc(sizeof(*aux), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
 	if (aux == NULL) {
 		vfree(fp);
 		return NULL;
 	}
-	fp->active = alloc_percpu_gfp(int, GFP_KERNEL_ACCOUNT | gfp_extra_flags);
+	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
 	if (!fp->active) {
 		vfree(fp);
 		kfree(aux);
@@ -126,7 +127,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 {
-	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog *prog;
 	int cpu;
 
@@ -159,7 +160,7 @@ int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog)
 
 	prog->aux->jited_linfo = kvcalloc(prog->aux->nr_linfo,
 					  sizeof(*prog->aux->jited_linfo),
-					  GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+					  bpf_memcg_flags(GFP_KERNEL | __GFP_NOWARN));
 	if (!prog->aux->jited_linfo)
 		return -ENOMEM;
 
@@ -234,7 +235,7 @@ void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 				  gfp_t gfp_extra_flags)
 {
-	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog *fp;
 	u32 pages;
 
-- 
1.8.3.1

