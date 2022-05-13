Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03351526822
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382847AbiEMRSp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376269AbiEMRSn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339A3B2A2;
        Fri, 13 May 2022 10:18:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B440B1F970;
        Fri, 13 May 2022 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652462320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s4UvaoqQhOvXVFcayQAcYm+9aULoAvV0U7raXaG3hU=;
        b=hAxfeK1s31Q67Yk2BZX0bHSa1CN0N4iFjkC2N/+vcsFLQO0AYGFP3CR6BxH8eZeRpwNAXS
        m/WiwKNmEAsTzuLDH+wsJilbG8PMCyNq+zmMFeu72BzEjxOO1SOeBcyk+DxrmpsybuTgjx
        OSZLD8vRwQIce1z/5LbVgwRpfnmxr1o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74B0113446;
        Fri, 13 May 2022 17:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oMB5G/CSfmIeUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 May 2022 17:18:40 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     void@manifault.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
        shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 2/4] selftests: memcg: Expect no low events in unprotected sibling
Date:   Fri, 13 May 2022 19:18:09 +0200
Message-Id: <20220513171811.730-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220513171811.730-1-mkoutny@suse.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is effectively a revert of commit cdc69458a5f3 ("cgroup: account
for memory_recursiveprot in test_memcg_low()"). The case test_memcg_low
will fail with memory_recursiveprot until resolved in reclaim
code.
However, this patch preserves the existing helpers and variables for
later uses.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4958b42201a9..eba252fa64ac 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -528,7 +528,7 @@ static int test_memcg_low(const char *root)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		int no_low_events_index = has_recursiveprot ? 2 : 1;
+		int no_low_events_index = 1;
 
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
 		low = cg_read_key_long(children[i], "memory.events", "low ");
-- 
2.35.3

