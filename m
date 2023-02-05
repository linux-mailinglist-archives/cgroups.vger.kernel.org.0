Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870468AE99
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBEG6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 01:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBEG6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 01:58:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D52310D;
        Sat,  4 Feb 2023 22:58:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a5so3374450pfv.10;
        Sat, 04 Feb 2023 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvT0LPmkis2rub1BPyeQPcuStniilZcgbmYKVTz7Hvo=;
        b=Oy5xAL4aXjTTwo6yYaI1NHOu5VWyI2xXvQE6gfQ6deE11ldVIy3ideM0a5D+DQHey0
         1Ch7zNbFrAM2Mxq+adjEPGfyeb6rkTy+HItd92lPh8wBG4qwkyfkKPPwsViylhGza+2R
         3m4jVEHwA/hpX7IsxmkeHZ7RjPVTU9InZBjXFDXeOK3Lrfwqm8SvHreAqgU64/YUAy6w
         Kv6b5gjZC6d3vw/2ds1OCOlSAyY5ByndnEwkG1T3n0AZC8BIy9hjKO7Ro6JNzD7+GWxY
         zNIqq6ubKqbPiTxzqG4R42z68sNVUDjUNaL3mxLmQ1F+t+JTCAnjxOizNdm3nk8hlzL6
         0q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvT0LPmkis2rub1BPyeQPcuStniilZcgbmYKVTz7Hvo=;
        b=r1JDDmKZEsU7z+hVPetPOv1BMOJaAsC9go48y9kp/qio/6G7UNMQPX+jDY1E7xNzDh
         U5VfQd0odsVDB4Z7EegJxUsnYQxVqn0A8g1dW8tY9VHRLnXbNBvlkvbJ+VLEfSJm3EAV
         ByjwOFsEW970bUXJumU16hAyt3qbDTfGRrNT28f+Qf61ojasXsAWRPzHz8AtqKYVQAGb
         BgMbBbxnTRAT1qXsDAu0qpbgY9L29i/UCBZnh2WxrlOSfC23bkLwTkEasjU3u+zew38U
         xs/fcbzRMtj3Pf9UPWvEMaKYvT0ohuTwaQGqVtrTqgK9WJCxpyaOAYMGSsX+4MC9tulF
         NMMQ==
X-Gm-Message-State: AO0yUKWZSCqClbQcwqvQw7FZIF93KDnqWbUJdLVeKDPV3cpeHucQ54dl
        pz8H0agkUp/oe79Ue/ZcGMQ=
X-Google-Smtp-Source: AK7set8rzEt0uEX1G54vHxZcUNYhAOhvPT5WYRO8loZlm4Skh+fcwGoowH1x0LGxykpYOtRuAaIVEA==
X-Received: by 2002:a62:7bc4:0:b0:590:7126:4771 with SMTP id w187-20020a627bc4000000b0059071264771mr15626594pfc.1.1675580315371;
        Sat, 04 Feb 2023 22:58:35 -0800 (PST)
Received: from vultr.guest ([2401:c080:1c02:6a5:5400:4ff:fe4b:6fe6])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm4596114pfv.184.2023.02.04.22.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 22:58:34 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 3/5] bpf: introduce bpf_memcg_flags()
Date:   Sun,  5 Feb 2023 06:58:03 +0000
Message-Id: <20230205065805.19598-4-laoar.shao@gmail.com>
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

This new helper will be used in both bpf prog and bpf map.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fe0bf48..4385418 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -28,6 +28,7 @@
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
+#include <linux/memcontrol.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2933,4 +2934,11 @@ static inline bool type_is_alloc(u32 type)
 	return type & MEM_ALLOC;
 }
 
+static inline gfp_t bpf_memcg_flags(gfp_t flags)
+{
+	if (memcg_bpf_enabled())
+		return flags | __GFP_ACCOUNT;
+	return flags;
+}
+
 #endif /* _LINUX_BPF_H */
-- 
1.8.3.1

