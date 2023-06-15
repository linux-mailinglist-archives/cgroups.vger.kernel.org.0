Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60517730C87
	for <lists+cgroups@lfdr.de>; Thu, 15 Jun 2023 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFOBR3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jun 2023 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOBR1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Jun 2023 21:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3671FD2;
        Wed, 14 Jun 2023 18:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC8161200;
        Thu, 15 Jun 2023 01:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D52C433C0;
        Thu, 15 Jun 2023 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686791845;
        bh=jC/V/5wTuDMjSNiSOnA5excD/Pg4jzWuQwRXLi7lZ5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=LNn3r6SsDlIceMsugdzXzyHk9WrMjwzuxupyyplrVHyioNpMJdpql/gLeE+cky74M
         7/gIN433a9Az+BryjDhdebV9l6Mnw4rB9+iqI6K5ce3PdjuOyjyiwgS3o4L1jcdmQY
         t9PY3TpynCOtMjyn4mXp6Wga7IIu/2AZoBsp29aMD6JYTeKrrQppEc0MFMTKtgNwMF
         krwRXUZxh2Vchb79SSKMEvvLrj7xm3Q1Tb5PktEXXLDaadwmoVq5AWvQv4qwKOV4hQ
         Rs0JFIB02Mjw2n30gUblEh4OxBCw19+eCBmlKcuJ9iIvOLsYjFdW3V8a5voebM/9Ed
         mRzHWmC4lfCxA==
Date:   Wed, 14 Jun 2023 19:18:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZIpm3pcs3iCP9UaR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Address the following -Wstringop-overflow warnings seen when
built with ARM architecture and aspeed_g4_defconfig configuration
(notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]

These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
warnings with no subsystems").

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/cgroup/cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cd497b90e11a..1ee76e62eb98 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1200,6 +1200,9 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 	unsigned long key;
 	int ssid;
 
+	if (!CGROUP_HAS_SUBSYS_CONFIG)
+		return NULL;
+
 	lockdep_assert_held(&cgroup_mutex);
 
 	/* First see if we already have a cgroup group that matches
@@ -6045,6 +6048,9 @@ int __init cgroup_init(void)
 	struct cgroup_subsys *ss;
 	int ssid;
 
+	if (!CGROUP_HAS_SUBSYS_CONFIG)
+		return -EINVAL;
+
 	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
-- 
2.34.1

