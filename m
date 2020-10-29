Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5D29F1FF
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgJ2Qos (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgJ2Qos (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 12:44:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6FC0613D2
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:44:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so1578339plr.4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMTjr2+W+gNVsgeHGd8A7YK4eqPL28HpThgEaSeH9eU=;
        b=hfspaErkNEk3rAQDqD3A0QgoFYIiQkGUXf8U4LtwDIZRnTaq5uY+72sOy4F8Tecu7/
         S10JQrb+7JGVOXgAIaOvAXO67dScyeX13atrBB4zM+n0Vnq+wRAjitHeNE4ZuCqVjq/T
         y1K07iO66M5EAMlOc0n1HSwbJUn8tCD1O10RG0i3r2KoxYlwfxpn3eJjkJamTOQhXQdz
         WRu4N0U20Nh5rSCsry63lSKA1ytldBRzUIhbDSqHt73GjcTEdUL5KABUa1mss8WbXjsR
         IAJ/w6jdyyyMBerGnkWLXBgWJR/Zw+o2nEuA5MEUGTCnJccPYfUJRhZrugg2P3djBpW3
         d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMTjr2+W+gNVsgeHGd8A7YK4eqPL28HpThgEaSeH9eU=;
        b=ixnjTctzGUBT2ReYCGebzumcMJP9vxU9023rBOpVsNWe+ejCUX0QJl/PbUQWra6SM/
         Z9VqoU72dXGjCZRZL0yImb747yZDaQbuwx41UbDnbU8AYRLw9HkXMw11QrkCJ5PPXvxG
         YCGxvcTLgosnAaHYKuHiImF1B51mGlrdyPExWQ1GuzE7mcPz23wdbDp8vBbjDeG4SsFP
         4qWcGiwwRLUrqGSym+i40dKdKunFwMxFrYgJ7VX4k3+VsbYGTnqE8ufG44eThbXQrJB1
         QAQbcFQoeSZk4i0Re+SFgELi+EluhoH9zuW3Zyy4e9fCK9Xi4aBt7PMHk4XhZKQZk3Hs
         JDUg==
X-Gm-Message-State: AOAM530UY+953D5NDqaJvK73RNc0UDX3ZEfVrpEsZJSku4mHsRvw3PwU
        3zpsmrySYulY0T/CGCFpHB6GoA==
X-Google-Smtp-Source: ABdhPJwQrJmv/aoXAfRDFvHvxaf+pIXE+6B7vM/dhQRAubpFI5YbGj/chIP9FmZN25gkwUQQYOHgsQ==
X-Received: by 2002:a17:902:b497:b029:d5:c01a:f06b with SMTP id y23-20020a170902b497b02900d5c01af06bmr5152085plr.13.1603989887265;
        Thu, 29 Oct 2020 09:44:47 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.95])
        by smtp.gmail.com with ESMTPSA id 197sm3429491pfa.170.2020.10.29.09.44.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:44:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm: memcg/slab: Fix return child memcg objcg for root memcg
Date:   Fri, 30 Oct 2020 00:44:29 +0800
Message-Id: <20201029164429.58703-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Consider the following memcg hierarchy.

                    root
                   /    \
                  A      B

If we failed to get the reference on objcg of memcg A, the
get_obj_cgroup_from_current can return the wrong objcg for
the root memcg.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 changelog in v3:
 1. Fix commit grammar, thanks to Shakeel.

 changelog in v2:
 1. Do not use a comparison with the root_mem_cgroup

 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1337775b04f3..8c8b4c3ed5a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 		objcg = rcu_dereference(memcg->objcg);
 		if (objcg && obj_cgroup_tryget(objcg))
 			break;
+		objcg = NULL;
 	}
 	rcu_read_unlock();
 
-- 
2.20.1

