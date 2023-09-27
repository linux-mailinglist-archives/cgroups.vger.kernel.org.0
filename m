Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D07B06B3
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjI0O0O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjI0O0O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 10:26:14 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1BE12A;
        Wed, 27 Sep 2023 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695824773; x=1727360773;
  h=date:from:to:subject:message-id:mime-version;
  bh=bF86Jsr4UsRLbjrkpS8N1tTTbCkokOYDSGQM/g+5iNc=;
  b=pzcASaOxEL9/ECi9ylitPInrUfd4DL0QLz+9AXuLahmK5ibu3Pz1/zPx
   sOiaRej8Rg/U0UZwS8CM82fk9NFxnn1gTXOMqv4cuV2D6ePtPgFOxKoMf
   r1++6kIV80Yywjo+dgt3wAITuLUMD+H4D6jZrD2/J7Eo0uB+wbpm+kNoH
   E=;
X-IronPort-AV: E=Sophos;i="6.03,181,1694736000"; 
   d="scan'208";a="674844881"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 14:25:47 +0000
Received: from EX19MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 7CF358A5E5;
        Wed, 27 Sep 2023 14:25:45 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 27 Sep 2023 14:25:40 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 27 Sep 2023 14:25:40 +0000
Received: by dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (Postfix, from userid 23276196)
        id 4E712BDE; Wed, 27 Sep 2023 14:25:40 +0000 (UTC)
Date:   Wed, 27 Sep 2023 14:25:40 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>, <kamalesh.babulal@oracle.com>,
        <mkoutny@suse.com>
Subject: [RESEND v3] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <20230927142539.GB65411@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have a need of using favordynmods with cgroup v1, which doesn't support
changing mount flags during remount. Enabling CONFIG_CGROUP_FAVOR_DYNMODS at
build-time is not an option because we want to be able to selectively
enable it for certain systems.

This commit addresses this by introducing the cgroup_favordynmods=
command-line option. This option works for both cgroup v1 and v2 and also
allows for disabling favorynmods when the kernel built with
CONFIG_CGROUP_FAVOR_DYNMODS=y.

Also, note that when cgroup_favordynmods=true favordynmods is never
disabled in cgroup_destroy_root().

Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 .../admin-guide/kernel-parameters.txt          |  4 ++++
 kernel/cgroup/cgroup.c                         | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

o v3
 - Handle destroy case [Michal]
 - Fix type in commit log [Michal]

o v2
 - Use __ro_after_init [Waiman]

Michal,

For the cgroup_destroy_root() case, I opted to keep disabling favordynmods
when cgroup_favordynmods=false. The rationale is that it should allow
for disabling favordynmods when/if all cgroups are gone if the user so wants.

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
index 1fb7f562289d..06515550e609 100644
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
@@ -1350,7 +1352,9 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 		cgroup_root_count--;
 	}
 
-	cgroup_favor_dynmods(root, false);
+	if (!have_favordynmods)
+		cgroup_favor_dynmods(root, false);
+
 	cgroup_exit_root_id(root);
 
 	cgroup_unlock();
@@ -2243,9 +2247,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
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
 
@@ -6764,6 +6768,12 @@ static int __init enable_cgroup_debug(char *str)
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

