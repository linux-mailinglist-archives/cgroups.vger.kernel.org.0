Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FE29DBD6
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 01:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJ2AON (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgJ2AMc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 20:12:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0BC0613CF
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 17:12:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x1so1433157oic.13
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f42zNGuydbxsMprn7/o4rTiW5Mh/YrWQVTbGkrcpGAU=;
        b=JRG9qhqWVdv+qAPGEyd6hAeN94upYYLiFE/8ziCyK2IfmG0KH0vcgx4BU3gjZFhSCf
         OEaj1GD1WXVm1jmeXl1DAWeAzX9Lob3XEKoPsdIGbnDQ1EZlxhf90ONNi7wNxTQIRxa9
         JYfxxPzpE73/OCT2b00zuaCJtatE4mhFQZTM1zuzRudG7zsEUnH4gtecsO/0Msaf4j7w
         CHNZUDlEGkeM+dWh/h54KR874ZVAd/8idZH6gFDdGIdh0J1HKh15Z6JSbBjt3nBo17Ag
         izJQJtcjN0Ho2qCL3Miw31aUHdSVubCbCTwrcvEvzj7CbUF9eK85qoW+4YUKLq/JBNAg
         8XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f42zNGuydbxsMprn7/o4rTiW5Mh/YrWQVTbGkrcpGAU=;
        b=oV7urxSHvuzI6dUb1wa1Wp07zqGJ9dJZT9nmG4UEDLp6n1l0RSHYpYHIZDhTuiXJXu
         HU9r28dprUbQoxSuNINW8OINwOPc+o3mKPPNVEjv3iJzZEs4CrW+1foPg+j+HSwX6v2D
         eWD+G3dOP/CGteob051nybcIyCzqCWsZ1gVL911zUs5jWip9OFzFP9c3mv8MUZC+WyXS
         3HLwUf0QL1AHpvyQlaxx8uPKWn9IhQ4Q6x4VDnGnXTziun0zBmYoo18N+xYSo5V/IbA0
         HnwGI6qIIeVd12gag8ZpYbr+gyCoin8BxUGDs/EVwGuaZMLHVBZopTlfXC03dDGgTFtn
         XbfA==
X-Gm-Message-State: AOAM5334hRkk7CdJGI3mh9WhHfnpjmx6Kc6oX4vwGYrut0vn6i9fMaUh
        8HMATHKzT4Q1bEI/GqAmGc2MR0qO2KCREMSm
X-Google-Smtp-Source: ABdhPJyMlM5OFcaQWKTSVzpQLorRg0eUkIPGImJyauZgOd1B4JNiA5dI9gI84a4KFGgTpJ2ovwTXOA==
X-Received: by 2002:a17:90b:1392:: with SMTP id hr18mr4756699pjb.182.1603857057592;
        Tue, 27 Oct 2020 20:50:57 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:50:56 -0700 (PDT)
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
Subject: [PATCH v2] mm: memcg/slab: Fix use after free in obj_cgroup_charge
Date:   Wed, 28 Oct 2020 11:50:11 +0800
Message-Id: <20201028035013.99711-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The rcu_read_lock/unlock only can guarantee that the memcg will
not be freed, but it cannot guarantee the success of css_get to
memcg.

If the whole process of a cgroup offlining is completed between
reading a objcg->memcg pointer and bumping the css reference on
another CPU, and there are exactly 0 external references to this
memory cgroup (how we get to the obj_cgroup_charge() then?),
css_get() can change the ref counter from 0 back to 1.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 changelog in v2:
 1. Add unlikely and update the commit log suggested by Roman.

 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c8b4c3ed5a0..d9cdf899c6fc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3221,8 +3221,10 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 	 * independently later.
 	 */
 	rcu_read_lock();
+retry:
 	memcg = obj_cgroup_memcg(objcg);
-	css_get(&memcg->css);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
 	rcu_read_unlock();
 
 	nr_pages = size >> PAGE_SHIFT;
-- 
2.20.1

