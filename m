Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335F029DBFB
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 01:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgJ2ASp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgJ1WqH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 18:46:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310BC0613CF
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:46:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so1292834ior.2
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP9leRSqd8Nt5uw/ZcHLxalg6StnlmANhYwqDz5BamY=;
        b=GnFZV28/BNLRDucvzLESFv3OK7W6Iffx80nxt4gJX1KhQieE7APUfRH855/sp8RpMp
         cgkPejLvI+G6njV9mAmeo8VpZR4SfRadMjAssX2yRNc0iM3vyKnAhArixSQD58RO3L72
         Z0dOyUvEwxRX46FND2HUmFnhDDWdGNDCh5D+vNMyuk0wOXQ0ey1QMESV6UzxiDxR0yMU
         I/NSyZH3V7OUkd/ZNH6L5ToixcPb8J95qJPY7X1JOPEGvzroGJRZk1n/vBLocJO8sU4I
         fcnSEqdRLC/8x96lYmo1J1CBnTvGU14rV/VVdMwwMHdnccSu1XPj2SlK3p3yIP7wc1RY
         4KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP9leRSqd8Nt5uw/ZcHLxalg6StnlmANhYwqDz5BamY=;
        b=i28LR/eev3+ZJiS4g2we1h4ctx0QcvyE2rtZ/W6hylaGdKntSnJ5o64E71joEN0xqk
         Kv5+6QUFdvUzUKBLailtJCGi1jXg/Z8e4q26aIUYJiJYo3b4vB7gOdAfOGCHBpEAF8Ze
         c5LIgkSaVxQRDVZs9PTQhlbjfm3wFwTZL/PsLGuMp836B4Wwm1vE3MGFbbN8YJujqBSe
         808cxtx5Bal9LeD3LlITA+tsh7ijtS3q/iwuYda29d/yoP87sGlw0lixA4iw3ugZMrj9
         pfMoawL//5OSG99wAoe8woiwKoIdTZJmHikqyLh++JvNtm4b+G/TY24oC9dIaDU+k/hk
         R98Q==
X-Gm-Message-State: AOAM532F+pQx/WEzgBUweyfGN9+L06jpoko66uduEDft0BEAPp+kNru8
        hbGwWDmoi9SxfdxFqeK6Q5t2i4KsKt9tsZWo
X-Google-Smtp-Source: ABdhPJzaRhN3aDdXWQ0D5XcrckptuF92X7FGcRacXma9zoZkUg7BhB9XvJmIZJEeUtmL/cOvXiejSQ==
X-Received: by 2002:a63:4c19:: with SMTP id z25mr4603006pga.58.1603857050037;
        Tue, 27 Oct 2020 20:50:50 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:50:49 -0700 (PDT)
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
Subject: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
Date:   Wed, 28 Oct 2020 11:50:10 +0800
Message-Id: <20201028035013.99711-1-songmuchun@bytedance.com>
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

If we get the objcg of memcg A failed, the get_obj_cgroup_from_current
can return the wrong objcg for the root memcg.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
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

