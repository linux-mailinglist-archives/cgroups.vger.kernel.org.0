Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D577C723C
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbjJLQQG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbjJLQQG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 12:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BDCF
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697127319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yK0UlD3djzpWABLGKAkWK+EBIxdVaT62RUBs+nKaYeM=;
        b=T1G+hA6bW2V0p8V9/nDu1QDxfc8aMtajGajTGv/Bo4inLtNVVGlBRUXZyOcWva/3YNobFP
        O2L0imzQUAInpE4lRsH1N5o3qipCCUo2HEg2KqLZn5Ay8qowu1kTvwboTcftVIRZxRAcwq
        hWF6sJSUU5/mGndLx97/DNEoehyrE+o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-YrMuxBEwOPq_N8GMot6KQA-1; Thu, 12 Oct 2023 12:15:14 -0400
X-MC-Unique: YrMuxBEwOPq_N8GMot6KQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B071C1C01521;
        Thu, 12 Oct 2023 16:15:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30BCB40C6F79;
        Thu, 12 Oct 2023 16:15:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] mm: memcontrol: Don't css_get() on root_mem_cgroup in get_mem_cgroup_from_mm()
Date:   Thu, 12 Oct 2023 12:15:04 -0400
Message-Id: <20231012161504.3445042-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As reference counting in the root memcg is disabled, there is no need
to get a reference if root memcg is to be returned.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b009b233ab8..2b3864194042 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1060,8 +1060,10 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	rcu_read_lock();
 	do {
 		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-		if (unlikely(!memcg))
+		if (unlikely(!memcg)) {
 			memcg = root_mem_cgroup;
+			break;
+		}
 	} while (!css_tryget(&memcg->css));
 	rcu_read_unlock();
 	return memcg;
-- 
2.39.3

