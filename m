Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3753104F8
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 07:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBEG3p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 01:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEG3m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 01:29:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181D9C061786
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 22:29:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so3658187pfj.12
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 22:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0he1VW/PCEQZ3zvHTH+OFfohkfMVY0GDe6DZx57Hw=;
        b=mj7FWoJGFrcDOyAz41eFXfoppM9M6PPJ32NbJyxstX+ZDQjXJigyQZplmJkH1qTaAI
         tm89hJvYutfGv0GWNXUUQeCzoJ4C1a7kocoby20QK3xTwDOYU/yJA0TF1WaRDHIUUUdC
         0EWmCqXSeA0fyGWqsNXnOD836itIMNkR8oUG61F/cNHeTPby+jkXrI5RCBcFZzO81HU8
         BN1Tb9aUvc0GqHGTD/r/CFvwf9C+OvZYdrFV4VIhdqahmaktNx4YjXoYrf4mTytMSB+O
         rtJ4q/JfOEKmZiEiZ6H65IwVAg6QM2ai3mfUyEUMJMhZ7LKuc7hL/E3I8Uwbj2NN4jIy
         JCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0he1VW/PCEQZ3zvHTH+OFfohkfMVY0GDe6DZx57Hw=;
        b=lP51OCfTpvyfsEtj6vvVz+VfzNlNdTxHQqaQdm0ow7gAqm/SftTIJnRRYq8TVx9B2Q
         ePbllaLdxgAzbVXCRbE8WxTN7MOh96gaWa3xqLQkPlH6+jPViDPraUp9e6zTYinzFGf0
         /+SxWKhXvlJRkenxOwrLf/SK8kp5ukVLWEIL0A1fip2vjVYbwu7bfp8od5oEK1Lywhql
         AliUY5xTvG8/cB+1/SGrcUVkphXbMo7aimc6tSkH0brkcPR2EPC9yqbghYO541fqG1Gm
         ySBf1YYkeoxohEUFvtQHLWEhs0jPlpezSgxVe9s6r+NxaX28iyIZRP5RyPZLeoG7yY04
         mvAQ==
X-Gm-Message-State: AOAM531RQRzsfxlP6wOFKGRI0tZhOrIDevUATw7RgvflpWLvs5EHerTP
        YzUGoQJrnDsMnFhTdKCHzSKU4g==
X-Google-Smtp-Source: ABdhPJz3xSak1Dn+1ZNBcoidjGDQlEMM7oxnX3oxqr4zZSU6RqBaCShF9omCB+EjG8E8nejz7cbpsQ==
X-Received: by 2002:a63:db05:: with SMTP id e5mr3016291pgg.104.1612506541740;
        Thu, 04 Feb 2021 22:29:01 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::f])
        by smtp.gmail.com with ESMTPSA id z2sm8644919pgl.49.2021.02.04.22.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 22:29:01 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
Date:   Fri,  5 Feb 2021 14:27:19 +0800
Message-Id: <20210205062719.74431-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The get_mem_cgroup_from_page() is called under page lock, so the page
memcg cannot be changed under us. Also, css_get is enough because page
has a reference to the memcg.

If we really want to make the get_mem_cgroup_from_page() suitable for
arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
and call it after rcu_read_lock().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87f01bc05d1f..6c7f1ea3955e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1063,16 +1063,15 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
  */
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	rcu_read_lock();
 	/* Page should not get uncharged and freed memcg under us. */
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
+	memcg = page_memcg(page) ? : root_mem_cgroup;
+	css_get(&memcg->css);
+
 	return memcg;
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_page);
-- 
2.11.0

