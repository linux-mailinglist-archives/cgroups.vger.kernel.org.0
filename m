Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252745E7A00
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIWLvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIWLve (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 07:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDAF858B
        for <cgroups@vger.kernel.org>; Fri, 23 Sep 2022 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663933892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LSqlKmINboHpHtUNR10HWYgYVkgSi8ssnna63UQWneM=;
        b=UgQeyVN5SmEqxFp4n0VDwvpLYVIQACHaflA2gCt/vnbqcoo7uCzOlnlZt+y97+yIhVEqqj
        4MpT9iIFJq/mwtYUFxjIEgKiHwO8v7RbR9YviygaBZ1xmg+LdPON70jfiO+ox4vIupjm93
        Kt8SZbM1ESLCnZieA6k8yQd/cdiq/xQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-NhEncvQePGKBOhXkHh4LGQ-1; Fri, 23 Sep 2022 07:51:27 -0400
X-MC-Unique: NhEncvQePGKBOhXkHh4LGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE124101245C;
        Fri, 23 Sep 2022 11:51:26 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B130B40C6EC2;
        Fri, 23 Sep 2022 11:51:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH] cgroup: fix cgroup_get_from_id
Date:   Fri, 23 Sep 2022 19:51:19 +0800
Message-Id: <20220923115119.2035603-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup has to be one kernfs dir, otherwise kernel panic is caused,
especially cgroup id is provide from userspace.

Reported-by: Marco Patalano <mpatalan@redhat.com>
Fixes: 6b658c4863c1 ("scsi: cgroup: Add cgroup_get_from_id()")
Cc: Muneendra <muneendra.kumar@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/cgroup/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e4bb5d57f4d1..5f2090d051ac 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6049,6 +6049,9 @@ struct cgroup *cgroup_get_from_id(u64 id)
 	if (!kn)
 		goto out;
 
+	if (kernfs_type(kn) != KERNFS_DIR)
+		goto put;
+
 	rcu_read_lock();
 
 	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
@@ -6056,7 +6059,7 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		cgrp = NULL;
 
 	rcu_read_unlock();
-
+put:
 	kernfs_put(kn);
 out:
 	return cgrp;
-- 
2.31.1

