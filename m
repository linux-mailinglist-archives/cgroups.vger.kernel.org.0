Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DDA77FCD8
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbjHQRSc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353939AbjHQRSP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 13:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6330D1;
        Thu, 17 Aug 2023 10:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE1D6586F;
        Thu, 17 Aug 2023 17:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F88C433C8;
        Thu, 17 Aug 2023 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292692;
        bh=PUtRgHl3t9y/PCdYajGwcmizA+UGYBohYR7AEs0pjoo=;
        h=Date:From:To:Cc:Subject:From;
        b=qrg+XKqtRmV4/lmX29QP+7xjp0iql30uzjiD/+IZf66y5T9KcdewLTYZLNPMLLHyM
         zZuOu2SBecnTFBGa+i5d8VK1GcTirNqkjHGiCHxy0AtS5/VasEbdKajh/kCrAhRnB0
         ENAHlyX5uztjNp2p+SMQATfNTA0AjNScQgDEWtxMjBJs0Nfn9AgMsEYjz6kE4bNIOq
         cTF8302WgmW7xV7ayZzahJqkK2AT4OyN83DHtmaVZKbBwHcMOuAe5RmpNWN6yLRzw3
         HOiC+2xAbd3s9kXKmpB+C/kqsS3s5VE9PLJWxVPFgyuO30dXs6ROSxF9HEwlIKjFta
         iH27n6fLi5eIg==
Date:   Thu, 17 Aug 2023 11:19:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZN5WkbPelHUSTXOA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change the notation from pointer-to-array to pointer-to-pointer.
With this, we avoid the compiler complaining about trying
to access a region of size zero as an argument during function
calls.

This is a workaround to prevent the compiler complaining about
accessing an array of size zero when evaluating the arguments
of a couple of function calls. See below:

kernel/cgroup/cgroup.c: In function 'find_css_set':
kernel/cgroup/cgroup.c:1206:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
 1206 |         cset = find_existing_css_set(old_cset, cgrp, template);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/cgroup/cgroup.c:1206:16: note: referencing argument 3 of type 'struct cgroup_subsys_state *[0]'
kernel/cgroup/cgroup.c:1071:24: note: in a call to function 'find_existing_css_set'
 1071 | static struct css_set *find_existing_css_set(struct css_set *old_cset,
      |                        ^~~~~~~~~~~~~~~~~~~~~

With the change to pointer-to-pointer, the functions are not prevented
from being executed, and they will do what they have to do when
CGROUP_SUBSYS_COUNT == 0.

Address the following -Wstringop-overflow warnings seen when
built with ARM architecture and aspeed_g4_defconfig configuration
(notice that under this configuration CGROUP_SUBSYS_COUNT == 0):

kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/316
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Update changelog text to point out that this is a workaround.

Changes in v2:
 - Use pointer-to-pointer instead of pointer-to-array.
 - Update changelog text.
 - Link: https://lore.kernel.org/linux-hardening/ZN02iLcZYgxHFrEN@work/

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZIpm3pcs3iCP9UaR@work/

 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ccbbba06da5b..68e2d9812e3f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -929,7 +929,7 @@ static void css_set_move_task(struct task_struct *task,
 #define CSS_SET_HASH_BITS	7
 static DEFINE_HASHTABLE(css_set_table, CSS_SET_HASH_BITS);
 
-static unsigned long css_set_hash(struct cgroup_subsys_state *css[])
+static unsigned long css_set_hash(struct cgroup_subsys_state **css)
 {
 	unsigned long key = 0UL;
 	struct cgroup_subsys *ss;
@@ -1070,7 +1070,7 @@ static bool compare_css_sets(struct css_set *cset,
  */
 static struct css_set *find_existing_css_set(struct css_set *old_cset,
 					struct cgroup *cgrp,
-					struct cgroup_subsys_state *template[])
+					struct cgroup_subsys_state **template)
 {
 	struct cgroup_root *root = cgrp->root;
 	struct cgroup_subsys *ss;
-- 
2.34.1

