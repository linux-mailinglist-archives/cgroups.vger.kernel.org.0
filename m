Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA579331A
	for <lists+cgroups@lfdr.de>; Wed,  6 Sep 2023 02:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjIFA5f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 20:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFA5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 20:57:34 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E3DA;
        Tue,  5 Sep 2023 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693961849; x=1725497849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=biqbXsW9nrY9n3xsgQFeD5SVYgTJLmYOGUVzEh+tZWo=;
  b=u8ixTLSHaVxJ5IvjaO9WVhCWmj2a+8SR2IEOW4TsYQ5ftw58GDeuPWTg
   AsQ6n3y4aedXx4TvktpWRWAxswRRD3oRZ6Re6mwdZbHD0ZGp4RapVeIMr
   yYSyKpiz9lhXLgyPPdnrlOgYAIzrl9PDj6NKioDHox30uDYeJPHR0jot8
   k=;
X-IronPort-AV: E=Sophos;i="6.02,230,1688428800"; 
   d="scan'208";a="349603744"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:57:26 +0000
Received: from EX19MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 23A1F47C5D;
        Wed,  6 Sep 2023 00:57:23 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 6 Sep 2023 00:57:23 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 6 Sep 2023 00:57:21 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>
CC:     <lcapitulino@gmail.com>, Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Date:   Wed, 6 Sep 2023 00:57:12 +0000
Message-ID: <20230906005712.66461-1-luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have a need of using favordynmods with cgroup v1, which doesn't support
changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
build-time is not an option because we want to be able to selectively
enable it for certain systems.

This commit addresses this by introducing the cgroup_favordynmods=
command-line option. This option works for both cgroup v1 and v2 and
also allows for disabling favorynmods when the kernel built with
CONFIG_FAVOR_DYNMODS=y.

Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/cgroup/cgroup.c                          | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

o v2
 - Use __ro_after_init [Waiman]

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..8b744d39d393 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -580,6 +580,10 @@
 			named mounts. Specifying both "all" and "named" disables
 			all v1 hierarchies.
 
+	cgroup_favordynmods= [KNL] Enable or Disable favordynmods.
+			Format: { "true" | "false" }
+			Defaults to the value of CONFIG_CGROUP_FAVOR_DYNMODS.
+
 	cgroup.memory=	[KNL] Pass options to the cgroup memory controller.
 			Format: <string>
 			nosocket -- Disable socket memory accounting.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..2b7d74304606 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
 static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
+static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
+
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
 	.ns.count	= REFCOUNT_INIT(2),
@@ -2243,9 +2245,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
 	fc->user_ns = get_user_ns(ctx->ns->user_ns);
 	fc->global = true;
 
-#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
-	ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
-#endif
+	if (have_favordynmods)
+		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
+
 	return 0;
 }
 
@@ -6764,6 +6766,12 @@ static int __init enable_cgroup_debug(char *str)
 }
 __setup("cgroup_debug", enable_cgroup_debug);
 
+static int __init cgroup_favordynmods_setup(char *str)
+{
+	return (kstrtobool(str, &have_favordynmods) == 0);
+}
+__setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
+
 /**
  * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
  * @dentry: directory dentry of interest
-- 
2.40.1

