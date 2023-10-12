Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D17C73BA
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjJLRKP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJLRKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 13:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3759B7
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697130565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SPP01noqv2eDjcek8c4pF//YWGN5uzha7P5McAWCFt4=;
        b=QUmP1iIJFN25Nekussdl4C2v6hycWtVJxwTcjfqis3nDuco36P7GaNCmB62tSzgHG+dqhK
        AHaGsGHxkF/vIh6LPLeknrMW+6bcvzNlkH2ycmidvB9qhEk0nBqWem/aWz/Xe62uxV+xnj
        KDHSO3sxqDrBI/a55CjxN4qfFZaiZL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-685-HpmUbWJdMzOBtusgr8f-Kw-1; Thu, 12 Oct 2023 13:09:19 -0400
X-MC-Unique: HpmUbWJdMzOBtusgr8f-Kw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC737185A7B9;
        Thu, 12 Oct 2023 17:09:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A9CE492B01;
        Thu, 12 Oct 2023 17:09:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup: Fix incorrect css_set_rwsem reference in comment
Date:   Thu, 12 Oct 2023 13:09:02 -0400
Message-Id: <20231012170902.3448834-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit f0d9a5f17575 ("cgroup: make css_set_rwsem a spinlock
and rename it to css_set_lock"), css_set_rwsem has been replaced by
css_set_lock. That commit, however, missed the css_set_rwsem reference
in include/linux/cgroup-defs.h. Fix that by changing it to css_set_lock
as well.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f1b3151ac30b..265da00a1a8b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -238,7 +238,7 @@ struct css_set {
 	 * Lists running through all tasks using this cgroup group.
 	 * mg_tasks lists tasks which belong to this cset but are in the
 	 * process of being migrated out or in.  Protected by
-	 * css_set_rwsem, but, during migration, once tasks are moved to
+	 * css_set_lock, but, during migration, once tasks are moved to
 	 * mg_tasks, it can be read safely while holding cgroup_mutex.
 	 */
 	struct list_head tasks;
-- 
2.39.3

