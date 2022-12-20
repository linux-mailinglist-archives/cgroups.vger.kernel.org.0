Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491B652387
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 16:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiLTPPI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 10:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLTPPH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 10:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83F1AF25
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671549265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bMwcEP88aaxPcKpXm4Jr7ZoA7j+pIF0TnJwOHWp6n0E=;
        b=eQNZVP7xmLmiQ/e6P+T5VsSm/WW8/GXyV3vHld0WvAuiOWx+IlWaMJkwWDET8wvpYYleAT
        90m8R67uHo8uhHUXGD7RvRZxXX2cdMln98TtES2fc/3291tNQqSbwiluaMne99ObUDi0kV
        JSU4ETvtQNLsjylbqFsFpRVjh8F+tDk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-uA6-OmjONnKk2VNk8fsJgQ-1; Tue, 20 Dec 2022 10:14:21 -0500
X-MC-Unique: uA6-OmjONnKk2VNk8fsJgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C8AE2802E3A;
        Tue, 20 Dec 2022 15:14:21 +0000 (UTC)
Received: from metal.redhat.com (ovpn-194-53.brq.redhat.com [10.40.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC2D2026D4B;
        Tue, 20 Dec 2022 15:14:19 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Daniel Vacek <neelx@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: no need to explicitly init a global static variable
Date:   Tue, 20 Dec 2022 16:14:15 +0100
Message-Id: <20221220151415.856093-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cpuset_rwsem is a static variable. It's initialized at build time and so
there's no need for explicit runtime init leaking one percpu int.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706bb..87fe410361b3d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3281,8 +3281,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 
 int __init cpuset_init(void)
 {
-	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
-
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
-- 
2.38.1

