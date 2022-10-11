Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690B15FB499
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJKObF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKObB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 10:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1C62ABC
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665498658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4/tx5Hg2EBXygF2G8xfjAkH7UAOIXn21J5RskYrkmds=;
        b=DwjXgvSEvRerTGNgLLu7FR7yhLhl+YK0VdOKH2M5ox9vDwAPkMA8az0zpAYppF1vysR7P4
        S76mEq2PxczCY3Ywcr09QQmHH9hqoKfYOUWpQAf02bnlH/cINtY14v5Ne3gAOqqD2mFZwL
        LrzNnM/gjqDuBNdqEElF/AIV4n9Jpcg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-SvpcsVCvNv6sGp-hOHfwnQ-1; Tue, 11 Oct 2022 10:30:55 -0400
X-MC-Unique: SvpcsVCvNv6sGp-hOHfwnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0657B382ECCD;
        Tue, 11 Oct 2022 14:30:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA0040E9920;
        Tue, 11 Oct 2022 14:30:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memcontrol: Don't increase effective low/min if no protection needed
Date:   Tue, 11 Oct 2022 10:30:15 -0400
Message-Id: <20221011143015.1152968-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit bc50bcc6e00b ("mm: memcontrol: clean up and document
effective low/min calculations"), the effective low/min protections can
be non-zero even if the corresponding memory.low/min values are 0. That
can surprise users to see MEMCG_LOW events even when the memory.low
value is not set. One example is the LTP's memcontrol04 test which fails
because it detects some MEMCG_LOW events for a cgroup with a memory.min
value of 0.

Fix this by updating effective_protection() to not returning a non-zero
low/min protection values if the corresponding memory.low/min values
or those of its parent are 0.

Fixes: bc50bcc6e00b ("mm: memcontrol: clean up and document effective low/min calculations")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..893d4d5e518a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6660,6 +6660,9 @@ static unsigned long effective_protection(unsigned long usage,
 	unsigned long protected;
 	unsigned long ep;
 
+	if (!setting || !parent_effective)
+		return 0UL;	/* No protection is needed */
+
 	protected = min(usage, setting);
 	/*
 	 * If all cgroups at this level combined claim and use more
-- 
2.31.1

