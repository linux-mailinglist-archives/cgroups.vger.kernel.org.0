Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427D6DDC41
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDKNhH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDKNhG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 09:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D153581
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681220182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8knbqgpwDwW2izpddcqO89y+h297sf846uyalSPG3Do=;
        b=Yo0cXe5MdkQ9mzjs7XKfhor7dq3vQNRI0jnhqQcAcOKi98DM9KvXEqUYeq4sDUweeeWp/E
        q6S0g5lbg/CGvfTldGuWk7hjPPnnFmXSDaql8peVwkDfbPumA7xg9cwLpOsu9UldR9JbSY
        5nGTtMyvtxLyrTvntNyGLJ8SU88Dnj4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Gfi479X1MjWH0AwHmlI-Qg-1; Tue, 11 Apr 2023 09:36:19 -0400
X-MC-Unique: Gfi479X1MjWH0AwHmlI-Qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770F71C08786;
        Tue, 11 Apr 2023 13:36:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B22C47CD0;
        Tue, 11 Apr 2023 13:36:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/5] cgroup/cpuset: Wake up cpuset_attach_wq tasks in cpuset_cancel_attach()
Date:   Tue, 11 Apr 2023 09:35:57 -0400
Message-Id: <20230411133601.2969636-2-longman@redhat.com>
In-Reply-To: <20230411133601.2969636-1-longman@redhat.com>
References: <20230411133601.2969636-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After a successful cpuset_can_attach() call which increments the
attach_in_progress flag, either cpuset_cancel_attach() or cpuset_attach()
will be called later. In cpuset_attach(), tasks in cpuset_attach_wq,
if present, will be woken up at the end. That is not the case in
cpuset_cancel_attach(). So missed wakeup is possible if the attach
operation is somehow cancelled. Fix that by doing the wakeup in
cpuset_cancel_attach() as well.

Fixes: e44193d39e8d ("cpuset: let hotplug propagation work wait for task attaching")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bc4dcfd7bee5..066689a7dcc3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2507,11 +2507,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
 
 	cgroup_taskset_first(tset, &css);
+	cs = css_cs(css);
 
 	percpu_down_write(&cpuset_rwsem);
-	css_cs(css)->attach_in_progress--;
+	cs->attach_in_progress--;
+	if (!cs->attach_in_progress)
+		wake_up(&cpuset_attach_wq);
 	percpu_up_write(&cpuset_rwsem);
 }
 
-- 
2.31.1

