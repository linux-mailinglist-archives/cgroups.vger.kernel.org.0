Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D16B0EA9
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCHQ0w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCHQ0f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 11:26:35 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88676CB65C;
        Wed,  8 Mar 2023 08:26:29 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s12so18598820qtq.11;
        Wed, 08 Mar 2023 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292788;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+4uYXTHdSZJGlTQ4yJuaUKIcEogMIg606wt+PsHQ10=;
        b=kswqtEU7Xj6n7CisW2qiImBeQaeJAQosHCyMQLF85hJ3RIz6SE9Rt2WZbQXfYtQarS
         w1QOwuboYFZVWg3MH8bUqqwclcgHc3MmuZZUsydleg5jg4zMt4wgbQMRkOBzw3Zucdt8
         bDfH1puKOJ2+Jws7pHS692luihVb02mlaXjFcfe/mkc0SVVtNkvvaMGjhmgRWz60Hrhj
         hsoZyvjuIAA64kBJePxrgKD3g/6sRoG8j42SBuX/XEEqcwDNrw4HvoAAvVN3G64Ld9aT
         Efv9BEBWmzR2cSAbKApAMZDiqB5AIM5zyFGrDWK2hfiWrdLkaCvW3wS224bS2oq9JkyC
         BQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292788;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+4uYXTHdSZJGlTQ4yJuaUKIcEogMIg606wt+PsHQ10=;
        b=nAar0eay/qUiVhrG6/siwQ138i+Btlf7NSquoM8pTduoDhdDLt81WOuYpU5Tnquuiy
         WLQGEu4JUAhwf8338yGQ4tHRHpdHtOBUT74OvMdgUjRNVyNg3SW2z82/nlpGNmpf+luh
         j2GGxn5OxMBCuzSmpHrbZtZt+kmOnF9RAC2Eb6A147uKkUmty+pjqLaYeUtbRITCf2Ns
         rKtVgSadH0OB2jXdHPMCdWjWJnH0mxmX2MtGNCaShO9Sq/Ty6ei4BMPNJ3KTtpAXGv7B
         cjgpTOpx3pOC2p1Q7td2B2vrvGcQuPhf5ch80KTV6mMkHk5hwDgyQ7+HHdjB2LDnGOwa
         R9Hw==
X-Gm-Message-State: AO0yUKVHtcWzUSVgvIflb4j8y2nCVapEmaSSMEXtUIsBpgKV41DZSIgE
        zYWGkkco291ieAQgEVou4jM=
X-Google-Smtp-Source: AK7set+0qHmJ/1GfUszz/r9Eo2DlcBq2rsqeob7MHbP84HYNS4R6ufmoVsorbLyoGDsjhwgPzL4ESw==
X-Received: by 2002:a05:622a:4c6:b0:3bf:cd7a:dd14 with SMTP id q6-20020a05622a04c600b003bfcd7add14mr30017906qtx.12.1678292788636;
        Wed, 08 Mar 2023 08:26:28 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b0073b8459d221sm11619813qkm.31.2023.03.08.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:26:28 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v3, 4/4] mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing
Date:   Thu,  9 Mar 2023 00:25:55 +0800
Message-Id: <20230308162555.14195-5-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308162555.14195-1-findns94@gmail.com>
References: <20230308162555.14195-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v1 memory controller: memory.soft_limit_in_bytes
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely.
But it is better to use [READ|WRITE]_ONCE to prevent compiler from
doing anything funky.

The access of memcg->soft_limit is lockless,
so it can be concurrently set at the same time as we are
trying to read it. All occurrences of memcg->soft_limit
are updated with [READ|WRITE]_ONCE.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b7062d0f5e0..13ec89c45389 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3728,7 +3728,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	case RES_FAILCNT:
 		return counter->failcnt;
 	case RES_SOFT_LIMIT:
-		return (u64)memcg->soft_limit * PAGE_SIZE;
+		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
 	default:
 		BUG();
 	}
@@ -3870,7 +3870,7 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			ret = -EOPNOTSUPP;
 		} else {
-			memcg->soft_limit = nr_pages;
+			WRITE_ONCE(memcg->soft_limit, nr_pages);
 			ret = 0;
 		}
 		break;
@@ -5347,7 +5347,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_CAST(memcg);
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	memcg->soft_limit = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 #endif
@@ -5502,7 +5502,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	memcg->soft_limit = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
-- 
2.17.1

