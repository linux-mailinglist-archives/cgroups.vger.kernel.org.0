Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06236D0FEE
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC3UWx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC3UWv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 16:22:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20F40D3;
        Thu, 30 Mar 2023 13:22:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d10so12111876pgt.12;
        Thu, 30 Mar 2023 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680207770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBkq6KxCtXfKvlem/Zb/2GDPHcnhhSsCCkCs5rwvqhw=;
        b=Ze1fJTTrAjpXdOhtpMZb/pWrc+OxYU0E2dF3+BqmPVjzlrkpBGMbVVwlILNlZ/qbnv
         mjaMFzag7RBRmgw0vQCsufH1JIGiRw7v2iYCClFpCDlDLUrU4Gswed1vjjTf2551B2t1
         y1KP+9T+SgP7GxAskck2N2B38gAgeP1h8RqHlYUanT4Tw9NI9VV37kqbYbk8tYCZyIDs
         wsJyTGiTuvI7HhK6m3Frln7sAMRGFQy5OYDvRxyd+y6Pt5PZs+MaAH06PlqCym4ehpQF
         eb2c6pzclizqej8lG5CHoN5ppB5BHUhjjXI3SqPMD1NHXZxMgzz3d4SwNuVISbEIS9K6
         2xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680207770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBkq6KxCtXfKvlem/Zb/2GDPHcnhhSsCCkCs5rwvqhw=;
        b=Pn7B98FvjaUacfgv9qdPm/ma1M/g0bOr32sd4CbsX39OSPdsFBv62v9Sibpmt/KQZW
         p/qdaXuruyeNpPgG5oenNh01ONzuaEXUnM7ibRSv7K7QK93QL2o2mYbqYuXi8I0GOkVe
         Y9jTwT4JPwKtziaLQ+wkCmTcaFeTDcQKmCmCPmRjKKVPP2Py58qf5rvjwlJIsHRh1rTx
         aMrION5ahabTyya72hMypvnvpAlQt6zCpaet+U9mrHgUnGuP08JVPeIHFSv9UQtNfsQB
         KjQ9seDdHH0YO8WQ49p0+BkW9buXzJgDv724FQojZdB0l/xNLNNWgvYj2TBf4fnfqt3C
         gMXw==
X-Gm-Message-State: AAQBX9eDv0yUES9iJIMu2nHUGenRzQhJsOeF9R5hk/92k0VXFNUP89p6
        Ob1Kgb5fcI6yFkUnvj0szmz/M38wjyBEB0R0
X-Google-Smtp-Source: AKy350a/3LDVNunLU+X2jx+/r8XTGQn4nCYK32oghDWPolROcLXTb+Xmjs+x/CZAAmduRrhpeGJD8w==
X-Received: by 2002:a62:5246:0:b0:628:87f:6b5d with SMTP id g67-20020a625246000000b00628087f6b5dmr21039787pfb.11.1680207770173;
        Thu, 30 Mar 2023 13:22:50 -0700 (PDT)
Received: from lunar.aeonazure.com ([158.140.180.109])
        by smtp.gmail.com with ESMTPSA id x22-20020aa784d6000000b0062505afff9fsm266987pfn.126.2023.03.30.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:22:49 -0700 (PDT)
From:   Shaun Tancheff <shaun.tancheff@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Shaun Tancheff <shaun@tancheff.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "stable @ vger . kernel . org . Shaun Tancheff" 
        <shaun.tancheff@hpe.com>
Subject: [PATCH] memcg: Set memory min, low, high values along with max
Date:   Fri, 31 Mar 2023 03:22:32 +0700
Message-Id: <20230330202232.355471-1-shaun.tancheff@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Shaun Tancheff <shaun@tancheff.com>

memcg-v1 does not expose memory min, low, and high.

These values should to be set to reasonable non-zero values
when max is set.

This patch sets them to 10%, 20% and 80% respective to max.

This fixes an issue with memory pressure with file systems
do an unbounded high rate of I/O hitting oom.

Signed-off-by: Shaun Tancheff <shaun.tancheff@hpe.com>
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2eee092f8f11..0f5918d9dd2a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3491,6 +3491,15 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		if (max > counter->max)
 			enlarge = true;
 		ret = page_counter_set_max(counter, max);
+		if (!ret && !memsw) {
+			unsigned long min = (max / 10) + 1;
+			unsigned long low = min * 2;
+			unsigned long high = max - low;
+
+			page_counter_set_min(counter, min);
+			page_counter_set_low(counter, low);
+			page_counter_set_high(counter, high);
+		}
 		mutex_unlock(&memcg_max_mutex);
 
 		if (!ret)
-- 
2.34.1

