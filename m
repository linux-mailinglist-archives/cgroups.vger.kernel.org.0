Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA858361D
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiG1A6o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiG1A6n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 20:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D5645A3E7
        for <cgroups@vger.kernel.org>; Wed, 27 Jul 2022 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658969922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaSdAy4qMc+i3X3/uhcqoqHr76wuTtjP8hQcmc/LmaQ=;
        b=FKN4GWOSqWib36POdqvBs3gH49rj+NhT+EO1w2ECm0ckvNf1h70b2McF2sqzdC+C4wM5C4
        IfiL3wuzWTIUNGs8jgaEipyETAIb8JXdDU+DOwNVR6yQYGxDTRz8oyjGNj5jG9UnohzVLr
        aBxcp7H9XLEj6FSH2iP3tBEkcFhmGps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-5AbWPQWLNMONX91Or2AirQ-1; Wed, 27 Jul 2022 20:58:37 -0400
X-MC-Unique: 5AbWPQWLNMONX91Or2AirQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 269DA8037AA;
        Thu, 28 Jul 2022 00:58:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC66C15D67;
        Thu, 28 Jul 2022 00:58:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup: Skip subtree root in cgroup_update_dfl_csses()
Date:   Wed, 27 Jul 2022 20:58:15 -0400
Message-Id: <20220728005815.1715522-2-longman@redhat.com>
In-Reply-To: <20220728005815.1715522-1-longman@redhat.com>
References: <20220728005815.1715522-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup_update_dfl_csses() function updates css associations when a
cgroup's subtree_control file is modified. Any changes made to a cgroup's
subtree_control file, however, will only affect its descendants but not
the cgroup itself. So there is no point in migrating csses associated
with that cgroup. We can skip them instead.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 13c8e91d7862..1151ff44d578 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2960,6 +2960,15 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
 		struct cgrp_cset_link *link;
 
+		/*
+		 * As cgroup_update_dfl_csses() is only called by
+		 * cgroup_apply_control(). The csses associated with the
+		 * given cgrp will not be affected by changes made to
+		 * its subtree_control file. We can skip them.
+		 */
+		if (dsct == cgrp)
+			continue;
+
 		list_for_each_entry(link, &dsct->cset_links, cset_link)
 			cgroup_migrate_add_src(link->cset, dsct, &mgctx);
 	}
-- 
2.31.1

