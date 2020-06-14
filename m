Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171DE1F88C1
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2020 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFNM1X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Jun 2020 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgFNM1W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Jun 2020 08:27:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A59C05BD43
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2020 05:27:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so5259913pje.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2020 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3wDQLkjLZhz8HlGMqP3m6FBvc0T90YmqvSvkQbSHmY=;
        b=UZdFv0Xir9MEd893nm2NsmxcmIkqD+9uJfe/NWiB6X4ESmnvYuGlbYeBwqpFlqO9RE
         GEBYJJZFKnYz3RhjfSojLRVr5YVm5AGj/u7OUlKiuBC9pTCpa/UTUp4W0JS62X3RZVlN
         yUkG04sIKOg+sRsa+nZB76FklBpGfLDF2tULWeLOIx3xRMLvhRlyusQ8swY5N6V6FueI
         OgCRl6obnJBQmMr4UfhxeO0voZrS3sJhbQYyQanMRjl6HbdtGdAg8MKQCLIovef0xhA0
         hY8ljJPDg1iToDvZczOb8CPHo34wtShhA11Rm7JQiD3cdRyhygvgKhIxkBp0UuA/gl99
         oQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3wDQLkjLZhz8HlGMqP3m6FBvc0T90YmqvSvkQbSHmY=;
        b=qyq2RppkJL3MLGltfbK2l0oEvPnL0N83eUn41RNVlfpMtg9Qdi3mejqMzUj54d01uS
         XOBjpo8Acxc047jUATw8YNkEkeACbFSQ55AVm5fkNQns4wvgWNDFaOH/XmfLE/zmp4vd
         Ge42clNj1yfSN27EguN+B7ANC37mYIZl2d+OHZEAkvns1cZjONwvp9Q9jiDfovg6Qufh
         197CNTyu0lvM5zm6gGbAwS/qoLk8n6SzpffydBeoSstpqXMIYjQ5E84TslvaZvaWnhab
         6Yfusictl5wcMcqpMkDhBAKwqbCF1wjRFIRVlRAtxtN5w6AOIt8LbPCAcuhF/9oAY4s0
         9W+A==
X-Gm-Message-State: AOAM533vSVFGYCUwjGec0mLOoJfv+ZVAtzMyfoAL6q5GcHVbX5yui2pw
        7dIGLJDIN2HUQhV949oKenNCag==
X-Google-Smtp-Source: ABdhPJyKXq2O5tZt9d5Ihr84MF3ntpaY3fEND9aEIzF7aB1JW4W4ZCcKR2/fuQNjE6b9yQhdOpGLeg==
X-Received: by 2002:a17:90a:de1:: with SMTP id 88mr7630576pjv.124.1592137639325;
        Sun, 14 Jun 2020 05:27:19 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id u12sm9688454pjy.37.2020.06.14.05.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:27:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     guro@fb.com, cai@lca.pw, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: Fix do not put the css reference
Date:   Sun, 14 Jun 2020 20:26:53 +0800
Message-Id: <20200614122653.98829-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We should put the css reference when memory allocation failed.

Fixes: f0a3a24b532d ("mm: memcg/slab: rework non-root kmem_cache lifecycle management")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6ad547d..2323d811ee8e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2772,8 +2772,10 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 		return;
 
 	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
-	if (!cw)
+	if (!cw) {
+		css_put(&memcg->css);
 		return;
+	}
 
 	cw->memcg = memcg;
 	cw->cachep = cachep;
-- 
2.11.0

