Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE276AC5BE
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjCFPnM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCFPnC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 10:43:02 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9A7DB3;
        Mon,  6 Mar 2023 07:42:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d7so10918678qtr.12;
        Mon, 06 Mar 2023 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117341;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kK+Z862YESi30yZiQZC0bVwPclz8DCYbgAA/NRofcVQ=;
        b=MQT4Hnfv44YHIOGxCsajlC63JnDzxTzHLtNuHQ/4uiD559rPdzNVrnv4Px3cAWbxDT
         mINlBKvoJaziRxF2qQ48A+vB+8zsxIWkAgcnn431o0fdeuq+YmC8FrPglq91Yb0DDBkJ
         WCLdr+wil1dX/B6cEeylUBOsYJhZePeAW3jZ1aJkQWk2cbXPdeqFFkZtLAxMl1FEsIxI
         ZOYN/pszFbWfajWHX+xyZoGuf9/U9Vv9ybClKwIRhxirENLM5KmkGZl7e3gna1SBvxIm
         JgGvX3aNy1f0bzrfeRrAG0+mzAEsXE05Es60AK0gbwyXOMMURS2NJzZ+Y2ZsdTWsYAeT
         IXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117341;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kK+Z862YESi30yZiQZC0bVwPclz8DCYbgAA/NRofcVQ=;
        b=nSD3VAJ9vUEZI5uvgdVezT/lIJ/19CbVTJiMwH3eEF5O5//x2noDWoosRlMMP/Bghh
         m7U/IDoY5zOk6bJu8qEKSTfZs0zct3gJxQ5l7nXe6fR+KAB97Bx8oNgtBfJwQsbiEows
         sg3NfQTrfL6DotTD+jOI024VluFfvX+XGKfCkQtGr/Pki9vv9LZAy9ILT5xOIVrPMpnW
         y2kRviZbhersIZD8KmUsmDp3oQbLZhqreTWxAGywkws288sLiL84f3FwC1KqQkfffm//
         51gTRLCu8Tq780p7xB9whl8k1moxSE6JYOJbB3Mgxd/jwzDdPf1XRtex48Gznl+IG2Dg
         YAfw==
X-Gm-Message-State: AO0yUKXhIM+pV8g3MVjD88pABSU+FVWh33dgO3+lIS2W6nPV6h1JWcEC
        HbIAjzXJ6SsqpVxwdm39g+I=
X-Google-Smtp-Source: AK7set9H0BTWMzOhU3KF9k6OdGcn73zqo6lyLsqmCFPYgOIf9YsSnu6km3TTtQCJGL4RAvTZa3gmwA==
X-Received: by 2002:ac8:7d95:0:b0:3bd:48:70a3 with SMTP id c21-20020ac87d95000000b003bd004870a3mr19059103qtd.1.1678117341520;
        Mon, 06 Mar 2023 07:42:21 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm7618400qkj.18.2023.03.06.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:42:21 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v2, 4/4] mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing
Date:   Mon,  6 Mar 2023 23:41:38 +0800
Message-Id: <20230306154138.3775-5-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
References: <20230306154138.3775-1-findns94@gmail.com>
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
But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
doing anything funky.

The access of memcg->soft_limit is lockless,
so it can be concurrently set at the same time as we are
trying to read it.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 26605b2f51b1..20566f59bbcb 100644
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
-- 
2.17.1

