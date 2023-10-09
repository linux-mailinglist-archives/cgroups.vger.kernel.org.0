Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68BA7BE1F4
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376890AbjJIN6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376852AbjJIN6R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 09:58:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB199;
        Mon,  9 Oct 2023 06:58:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEDA81F381;
        Mon,  9 Oct 2023 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696859894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7OgkSL2KmvIM/AbVLqY0l7mLuBK7eG7eLJyEbA5Dmic=;
        b=lIh9JNcNFzDdUWqqH8dgPFjtVoPjAPJ09+D6/ZnUe8PNohHlnvGctLowI4oJOpavAYxv7F
        ma3yxEFptZfEIw+MDkv0aIq9J4oaFF/RR6rFuDoa+qftptY8yTsVBnCjMIdO7u2fGZYmTx
        mhr3/E0pYJ26quX4KXWSRf1+fUg5cgQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93BCE13586;
        Mon,  9 Oct 2023 13:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M2NmI/YGJGV6fAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 09 Oct 2023 13:58:14 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: [PATCH] cgroup: Remove duplicates in cgroup v1 tasks file
Date:   Mon,  9 Oct 2023 15:58:11 +0200
Message-ID: <20231009135811.2627-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One PID may appear multiple times in a preloaded pidlist.
(Possibly due to PID recycling but we have reports of the same
task_struct appearing with different PIDs, thus possibly involving
transfer of PID via de_thread().)

Because v1 seq_file iterator uses PIDs as position, it leads to
a message:
> seq_file: buggy .next function kernfs_seq_next did not update position index

Conservative and quick fix consists of removing duplicates from `tasks`
file (as opposed to removing pidlists altogether). It doesn't affect
correctness (it's sufficient to show a PID once), performance impact
would be hidden by unconditional sorting of the pidlist already in place
(asymptotically).

Link: https://lore.kernel.org/r/20230823174804.23632-1-mkoutny@suse.com/
Suggested-by: Firo Yang <firo.yang@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c487ffef6652..76db6c67e39a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -360,10 +360,9 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
-- 
2.42.0

