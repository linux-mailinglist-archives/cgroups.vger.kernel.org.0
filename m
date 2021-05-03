Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF66F3716CC
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhECOlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhECOlR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 10:41:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 199466108B;
        Mon,  3 May 2021 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052824;
        bh=6Sf1JD7r+JgTYZS8K/J2qUYaOsenxFzh+TJhtjMKVCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqpNc3ZvgN4cXp1Ru0F1DLJHflD0heZFRKV3i5HuYJx5VclfS27QcXJpRbKxOstDV
         rdVj9pUhi36fcuL8TqitF/tLZj5KDm8pitzOiFEc/1HeFiOmMLAIQtQ8WfnXwmXmcq
         H7OX7YiTYFgX9ym8sY9te0reLYSPiYpCQF53C2dW1P2cF3XAI7ZzL6KVzWvcwlHop9
         L/NYGolgcoN07DokUGCrMmoMeMWvIZ/OBWdZQXFVO43b1FLWcvBOvsEKL/aNJId3UE
         a78s0wcuQfO5bxnr2WjYmJnOhNPXN8iW36mQRZhLpwXoZlc3Gcus6EbQWQFfg9KxjL
         jsLrOI8w8S7dA==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 3/5] tests/cgroup: use cgroup.kill in cg_killall()
Date:   Mon,  3 May 2021 16:39:21 +0200
Message-Id: <20210503143922.3093755-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
References: <20210503143922.3093755-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DIB/9pEGy9llyw8JVnB5N3xonNHMlykb1jj0N6tKKZc=; m=N4CiSeYEjjigDgiqqFvr6DAlj4IvG2/Qdx6umJFFRGk=; p=DHUt07yqiAMnkkMUKU00TMtgEeY5ceCRlyT9YTuFjfA=; g=f9f764d90d255b615ede51d62b8fdc79385ad80c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJAK7wAKCRCRxhvAZXjcoqmkAQD2ULp GEK3wx+KT0VzyGkqqgAYQKw982ZetTna/kDmE/gEA0QDCOmbPNaHHS75MVt9T8RBAdp+RU9zyTMKk 9lNuSwA=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If cgroup.kill file is supported make use of it.

Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Roman Gushchin <guro@fb.com>:
  - Fix whitespace.
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 027014662fb2..f60f7d764690 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -252,6 +252,10 @@ int cg_killall(const char *cgroup)
 	char buf[PAGE_SIZE];
 	char *ptr = buf;
 
+	/* If cgroup.kill exists use it. */
+	if (!cg_write(cgroup, "cgroup.kill", "1"))
+		return 0;
+
 	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
 		return -1;
 
-- 
2.27.0

