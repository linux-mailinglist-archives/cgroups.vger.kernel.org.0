Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C23526825
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiEMRSq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378778AbiEMRSn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8E3B569;
        Fri, 13 May 2022 10:18:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5048F1F972;
        Fri, 13 May 2022 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652462321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGOjxaCmozTaID0zJr5Qv3xqJGJFYW6IddaRszUZ5Io=;
        b=dcwHbrpOZZGq4sZL0dOj2zRX5fkU64ob6AlrrVT/bt7LHf5Ile5wwbwVsc9cDSFohUKRz+
        QnaJy5RMBF3fbRdRRhS5l7TwtqiF+ZnIknwF4efi0G1mBDRXrrVDKWJ4EEViBOvx778RsR
        0zwUeiqRJIGqFgegSEOmB1OTPOda+vo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DD6713446;
        Fri, 13 May 2022 17:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qKJ7AvGSfmIeUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 May 2022 17:18:41 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     void@manifault.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
        shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 4/4] selftests: memcg: Remove protection from top level memcg
Date:   Fri, 13 May 2022 19:18:11 +0200
Message-Id: <20220513171811.730-5-mkoutny@suse.com>
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

The reclaim is triggered by memory limit in a subtree, therefore the
testcase does not need configured protection against external reclaim.

Also, correct/deduplicate respective comments

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 9ffacf024bbd..9d370aafd799 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
 
 /*
  * First, this test creates the following hierarchy:
- * A       memory.min = 50M,  memory.max = 200M
+ * A       memory.min = 0,    memory.max = 200M
  * A/B     memory.min = 50M,  memory.current = 50M
  * A/B/C   memory.min = 75M,  memory.current = 50M
  * A/B/D   memory.min = 25M,  memory.current = 50M
@@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
  * Usages are pagecache, but the test keeps a running
  * process in every leaf cgroup.
  * Then it creates A/G and creates a significant
- * memory pressure in it.
+ * memory pressure in A.
  *
  * A/B    memory.current ~= 50M
  * A/B/C  memory.current ~= 29M
@@ -335,8 +335,6 @@ static int test_memcg_min(const char *root)
 			      (void *)(long)fd);
 	}
 
-	if (cg_write(parent[0], "memory.min", "50M"))
-		goto cleanup;
 	if (cg_write(parent[1], "memory.min", "50M"))
 		goto cleanup;
 	if (cg_write(children[0], "memory.min", "75M"))
@@ -404,8 +402,8 @@ static int test_memcg_min(const char *root)
 
 /*
  * First, this test creates the following hierarchy:
- * A       memory.low = 50M,  memory.max = 200M
- * A/B     memory.low = 50M,  memory.current = 50M
+ * A       memory.low = 0,    memory.max = 200M
+ * A/B     memory.low = 50M,  memory.current = ...
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
  * A/B/E   memory.low = 0,    memory.current = 50M
@@ -490,8 +488,6 @@ static int test_memcg_low(const char *root)
 			goto cleanup;
 	}
 
-	if (cg_write(parent[0], "memory.low", "50M"))
-		goto cleanup;
 	if (cg_write(parent[1], "memory.low", "50M"))
 		goto cleanup;
 	if (cg_write(children[0], "memory.low", "75M"))
-- 
2.35.3

