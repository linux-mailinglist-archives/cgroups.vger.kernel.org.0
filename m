Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE722734B45
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFSFRW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFSFRV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 01:17:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98493FF
        for <cgroups@vger.kernel.org>; Sun, 18 Jun 2023 22:17:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so35859627b3.0
        for <cgroups@vger.kernel.org>; Sun, 18 Jun 2023 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687151840; x=1689743840;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIJtbiNHWORZFFJvZlaFdgy0aymB8UjaLQ1n2ZbqAGA=;
        b=gF61XMV36bH0I0OFvVtMJMGfMqtsf5GRLhWCa6KadS7mbkOfJd8Nx9f6fyfD0xONPr
         gWmimxA9RjSurXO02roA0UblNhg0/LzFtfe/76MNLOqk8f9E40XXbrQ+OXLQjhme9er0
         6CVWLC/hLBlwKdhfotjAtiyH1l14V+xB12eI5kJJf84Jn36fg+DSVCh+xi1dPFJmsGgw
         6oXNg/F33JJmP82PkyDzdux+9ZZZBoRQOXweSvCZJwPQafOLvflD1OXS0vtB8Si0QDor
         NrjaREvL25r/7Hjs1fV4HN2tV5ZQ0H55KOrMpxqUn40TA3clVeMbmIoNBPOWMcYoU+Gz
         x87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687151840; x=1689743840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIJtbiNHWORZFFJvZlaFdgy0aymB8UjaLQ1n2ZbqAGA=;
        b=N8QVvWYnPZVUC4AEgmvKK94QuTe+I5En57TNXM/UAJ6r/nvCI3+XKEm1ioRDazcLTr
         r0GOjlqIysecFrCdrB0n46FHjRWodEqOxBS2hJt46n9JFVZrTV2tJCLTjTZK4kMa8TpV
         zDhBSzo4Uhs0JtOYQaeUocygkoQSJNPKA5bV2zpK6i4oCPnRk3LBeD/2QzWrpE27s0cX
         S81MTEsKtt3L6FO9vFZK30yhMBsjip5aYNTeIE5HIc2GvDEe1EtRm+GgPhjeppZDDNyI
         RBdx4cc68Vna8vQLsV0+asndLi+GRM7Lm5hgA8JO0D6VLRkj25HNc2sA55wJ5tUGCHbd
         zUEg==
X-Gm-Message-State: AC+VfDz0bwuuUkW6cA/CtZJdFNDOgt4gWmIzCipaOhUXTyS8zcLmwrmD
        I62aZYVNT8zBtVOWHfWAg/ejp0NP3n/t93mQ
X-Google-Smtp-Source: ACHHUZ4bERXIPoat5d1IzHXmL6LrgMtKb/8unGaeig1J8SlCYu4NeAeG5s68/yZupgeGKDfJMDcTzlOYVExCpEWM
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:e709:0:b0:568:f589:2b4e with SMTP
 id x9-20020a81e709000000b00568f5892b4emr3820382ywl.0.1687151839830; Sun, 18
 Jun 2023 22:17:19 -0700 (PDT)
Date:   Mon, 19 Jun 2023 05:17:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230619051715.2306134-1-yosryahmed@google.com>
Subject: [PATCH] selftests/cgroup: allow running a specific test with test_memcontrol
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is handy during testing and/or debugging to be able to run a single
test from test_memcontrol. Allow passing in a test name through a
command line argument (e.g. ./test_memcontrol -t test_memcg_recharge).

Change-Id: I0e0d74d81fdd9d997987389085a816715160467f
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index a2a90f4bfe9f..d8f8a13bc6c4 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1308,9 +1308,36 @@ struct memcg_test {
 
 int main(int argc, char **argv)
 {
+	int opt;
 	char root[PATH_MAX];
+	int selected_test = -1;
 	int i, proc_status, ret = EXIT_SUCCESS;
 
+	while ((opt = getopt(argc, argv, "ht:")) != -1) {
+		switch (opt) {
+		case 't':
+			for (i = 0; i < ARRAY_SIZE(tests); i++) {
+				if (!strcmp(tests[i].name, optarg)) {
+					selected_test = i;
+					break;
+				}
+			}
+			if (selected_test >= 0)
+				break;
+			fprintf(stderr, "test %s not found\n", optarg);
+			return EXIT_FAILURE;
+		case 'h':
+			fprintf(stderr,
+				"Usage: %s [-h] [-t name]\n"
+				"\t-h       print help\n"
+				"\t-t name  run specific test\n"
+				, argv[0]);
+			return ret;
+		default:
+			break;
+		}
+	}
+
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -1336,6 +1363,9 @@ int main(int argc, char **argv)
 	has_localevents = proc_status;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (selected_test >= 0 && selected_test != i)
+			continue;
+
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
 			ksft_test_result_pass("%s\n", tests[i].name);
-- 
2.41.0.162.gfafddb0af9-goog

