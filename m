Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E668AE9D
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 07:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBEG67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 01:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBEG66 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 01:58:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDA23107;
        Sat,  4 Feb 2023 22:58:46 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s13so4610028pgc.10;
        Sat, 04 Feb 2023 22:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUYnykaARkkOFageVVuRXJFo/+sLEm/iUIcvMP09NQo=;
        b=a57J4S2w9eyKDMZ9OBUJ6kf6vR1VHJuYUOYq6cGgNDezvgehxMQxiQLzN51fOnil+5
         DlIcYvlG4h0xQaPY+WdBD9SdZIQsg67KK4axSoellK3vUZSqXtJocopfFVARTJnLQbk4
         xGzbd3RY72M2M5MSGcfKyymLNNeBoSbRbgxq8BZo9nqCyaZDW83JoZ98YMhPHNIIUdQH
         AplmWxymxSsBbTx3vRXRWPAve2uLvQTLdcAEMGTrQeiRQJ+2zB1nbaw+WBuBwBQaXiuW
         T8HRsVyFsv8OzuyK0mXraJ8183a5zu/RW4pS7pQ7r/omuWkXLEv8TbXEHyl5OEJmZyfP
         HLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUYnykaARkkOFageVVuRXJFo/+sLEm/iUIcvMP09NQo=;
        b=QNPcDUC4j1nmsHzEcuzpHFbxC3L/RKg2PuYEqLBJCvo3dRDkaHP4vL9Dn/3xbx0PLw
         BAgjsA0y6llEbeZXUS3GX7SiUvMa2u+z8srZOsVi/86+fJSJ4zsHuTuBH20/aHD3owpe
         /8ebCtnu99+pr0wNHxpR5itVC8t7acm3Vb3i2lfVxffUmYVklDivqOS6naZN+Wvcs6lG
         OqXjktSFXBpH8rKWAY3q2nkw3T1Y4c6fKUvWkUnBJwLZ6khMBe9X6UL4tLKkx+TQjhzO
         Icn/vIkoa30PnzvxkBJ/XXgM6Cn5BMnEEVLm8P15WnbtYdEvAAibM6cBRm7wQErgnE8K
         SIgA==
X-Gm-Message-State: AO0yUKXgWiU1BIi6acQ2SJVYUy2r/rygJ0x/MFAIGwL3L+gh3osdjMxU
        aVzCgvb+C1sorc/4C8D+bCSBQX9VVCb8t/dy
X-Google-Smtp-Source: AK7set/w6dPubyS97p4WKEL9Dv1iFkX3k0KUGaY6uG6A7WSUm6tHBNwMv7hcZLwgEx+QbevpeIc8Rg==
X-Received: by 2002:a05:6a00:1a47:b0:593:b309:aa55 with SMTP id h7-20020a056a001a4700b00593b309aa55mr16799764pfv.28.1675580326085;
        Sat, 04 Feb 2023 22:58:46 -0800 (PST)
Received: from vultr.guest ([2401:c080:1c02:6a5:5400:4ff:fe4b:6fe6])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm4596114pfv.184.2023.02.04.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 22:58:45 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 5/5] bpf: allow to disable bpf prog memory accounting
Date:   Sun,  5 Feb 2023 06:58:05 +0000
Message-Id: <20230205065805.19598-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205065805.19598-1-laoar.shao@gmail.com>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
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

