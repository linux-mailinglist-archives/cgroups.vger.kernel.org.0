Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F402D79285D
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349562AbjIEQWD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354682AbjIENdp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 09:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233ED1A8
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693920775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsMuS7PTbmTmLZ/65tzTFutVzo4Sb2uYSpo6j3AWtxQ=;
        b=RhWfLSooRklgB3gtN4+B0XtwPYgpkZ7ONRPBVzNY93WOBGLKHYiPvvG+jq0rgbQ8wU/28E
        euFy7QggSYmEwl9ED/s+GzuET6AkoGrF66HJpjMTpQWbrS4IR/1QbIQ1/vcnpj6m5Yd7Sv
        jZ5ioQIcfhxNyl/S/sfN8ZoTs8OADXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-Uqy4g4SXOb6yp13Uf1nn_g-1; Tue, 05 Sep 2023 09:32:52 -0400
X-MC-Unique: Uqy4g4SXOb6yp13Uf1nn_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F7BF1C29799;
        Tue,  5 Sep 2023 13:32:51 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4BDB202869C;
        Tue,  5 Sep 2023 13:32:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 1/7] cgroup/cpuset: Fix load balance state in update_partition_sd_lb()
Date:   Tue,  5 Sep 2023 09:32:37 -0400
Message-Id: <20230905133243.91107-2-longman@redhat.com>
In-Reply-To: <20230905133243.91107-1-longman@redhat.com>
References: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit a86ce68078b2 ("cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE
& CS_SCHED_LOAD_BALANCE handling") adds a new helper function
update_partition_sd_lb() to update the load balance state of the
cpuset. However the new load balance is determined by just looking at
whether the cpuset is a valid isolated partition root or not.  That is
not enough if the cpuset is not a valid partition root but its parent
is in the isolated state (load balance off). Update the function to
set the new state to be the same as its parent in this case like what
has been done in commit c8c926200c55 ("cgroup/cpuset: Inherit parent's
load balance state in v2").

Fixes: a86ce68078b2 ("cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE handling")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58ec88efa4f8..4749e0c86c62 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1304,13 +1304,23 @@ static int update_partition_exclusive(struct cpuset *cs, int new_prs)
  *
  * Changing load balance flag will automatically call
  * rebuild_sched_domains_locked().
+ * This function is for cgroup v2 only.
  */
 static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 {
 	int new_prs = cs->partition_root_state;
-	bool new_lb = (new_prs != PRS_ISOLATED);
 	bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
+	bool new_lb;
 
+	/*
+	 * If cs is not a valid partition root, the load balance state
+	 * will follow its parent.
+	 */
+	if (new_prs > 0) {
+		new_lb = (new_prs != PRS_ISOLATED);
+	} else {
+		new_lb = is_sched_load_balance(parent_cs(cs));
+	}
 	if (new_lb != !!is_sched_load_balance(cs)) {
 		rebuild_domains = true;
 		if (new_lb)
-- 
2.31.1

