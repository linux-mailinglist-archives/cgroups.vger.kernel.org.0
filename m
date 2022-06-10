Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE8545A37
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiFJCpS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jun 2022 22:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiFJCpR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jun 2022 22:45:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F561E0AD6;
        Thu,  9 Jun 2022 19:45:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c196so22698698pfb.1;
        Thu, 09 Jun 2022 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wD58Q0nVdN+lpK7XOvbDvW4lZ7h1rqEWk+skYGgOvJ0=;
        b=Y6A0K30lWxEicLPPmjfvigg4Z03uPa39KfSU4jwd5vx9b6x5HxdPlyyVwybkBiEqAQ
         Q15JzwoiSLcUKwmQqfQZLOkbHx/bvsG8q4SQ8dnhpsKngiFuu+nYfYjMZ833CCyEKYQ3
         ztpR4i6TcGQUIE04Cq3wSu0pyDOglJGCx/URJroH+yN+0OWdOj7YUB99S07kecNm+T+g
         4bllY4ycfzaVRA7UJyChYPED0DNusFEaXz4h1vP61YO/M9cxKQvuTojmGDS6I4WOlYll
         qgjVIfP0PHaKlStMD0rk8R34u2rMEgjY54g2rkFPYv5zx6TbRkXI1gbkW6+ipw/bPz4t
         NhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wD58Q0nVdN+lpK7XOvbDvW4lZ7h1rqEWk+skYGgOvJ0=;
        b=yH3w87WQsDUYDf3L+HyYxPp5dZaAc/NsmBcs3mFn8NaSFtSKtNi9Jl5NfkgJz9rS/2
         GrHmU2MK4Shbw8Cxr5qcCWAogxGckLXouN5/4ss5G9/Bz6nSyWK0njWOhJ7lJVWBBWcf
         JsgmAUd1M486apdSxgxKuPS5KBhUBG7PZqmnW+4Jh2Yz1D9DHatw6ul8coHrwFV7gexD
         iFr+8erJqNEezxwdXOEmXw/ZLvRRCrsB27fYx0R8B8kVoTmKHmF91HxtEf226wvNoYEa
         UAOaMT8j9yruFyNkgpuIAhWqO9wtrVi3rFPDEt8iigNrv+WN0O4+ztDIheVCRN9Hn55w
         hjrA==
X-Gm-Message-State: AOAM532PvU49A6TCZaQqYCNN+7jdT0kSf07P9YnGGFvNLZIOOjGU+g1I
        Z471de+e2Tb5h1F0FrZi+Y4=
X-Google-Smtp-Source: ABdhPJzXoeE6YpY5U1nxIZxvEZy9G6CyhdPsDVTXr9N4njk0dTSSPoL3DwikxvApkTiURMuoC0DoBQ==
X-Received: by 2002:aa7:9e9c:0:b0:51b:e1b8:271c with SMTP id p28-20020aa79e9c000000b0051be1b8271cmr36159630pfq.73.1654829114947;
        Thu, 09 Jun 2022 19:45:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id jg15-20020a17090326cf00b001640594376dsm17562244plb.183.2022.06.09.19.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:45:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     hannes@cmpxchg.org, shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] mm: memcontrol: reference to tools/cgroup/memcg_slabinfo.py
Date:   Fri, 10 Jun 2022 02:44:52 +0000
Message-Id: <20220610024451.744135-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

There is no slabinfo.py in tools/cgroup, but has memcg_slabinfo.py instead.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dfbc84313745..ca714699a8e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4820,7 +4820,7 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 {
 	/*
 	 * Deprecated.
-	 * Please, take a look at tools/cgroup/slabinfo.py .
+	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
 	 */
 	return 0;
 }
-- 
2.25.1

