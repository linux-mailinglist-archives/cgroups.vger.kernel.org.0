Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01228377199
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhEHMQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 08:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhEHMQ6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 08:16:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73E8E6147E;
        Sat,  8 May 2021 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620476157;
        bh=7eUgs0ekWyt837T6LcGkgs858Rf04B5QX6Bu8MJC1M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlWtUUcBhcUYyLTFNnIpiQz2INQqQ+j8PvRiTBdB6aT8IHclKvX+sGHML1HcJBVOx
         KnFt2ksYnEpo5M5mjRbI4fIm3Phqrgfn4muJDdt/hnP1JHX/ZzT7ItKkye3mDXYO5N
         aUYsu7S3EB4n4SkCTRgR5fvaZHHkoEmDgr8TQeFxH5l/yvIOizdB7ap9gIZiq8PPHh
         W/Q2Jir97d28xsTG7QGV5VoLS9anCsqPpmV2sCtGR9wA5/BG5B40EcA7Op4VFpVYOh
         3CTejniEES/tWhIhb+zdZaDxxwdoTxMXzEDqsfBgoHyyiCO9Uykg8dEJ1h5xYtYI92
         RXpct/e2EjaXA==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 3/5] tests/cgroup: use cgroup.kill in cg_killall()
Date:   Sat,  8 May 2021 14:15:40 +0200
Message-Id: <20210508121542.1269256-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210508121542.1269256-1-brauner@kernel.org>
References: <20210508121542.1269256-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DIB/9pEGy9llyw8JVnB5N3xonNHMlykb1jj0N6tKKZc=; m=AINvc3b3JybbVUtUd5efhWEUs+WExpok1nDwV9EPyE0=; p=DHUt07yqiAMnkkMUKU00TMtgEeY5ceCRlyT9YTuFjfA=; g=f9f764d90d255b615ede51d62b8fdc79385ad80c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJaA0AAKCRCRxhvAZXjcomliAQCaGV/ jhSrBqNku77s1VvRiYCZ6tdf4oxEd+YuN1z+7fgEAy/WBfg/6Tj0e6t5RHgICoVpUSRBJNGrbRQ3B bxR7agc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If cgroup.kill file is supported make use of it.

Link: https://lore.kernel.org/r/20210503143922.3093755-3-brauner@kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Roman Gushchin <guro@fb.com>:
  - Fix whitespace.

/* v3 */
unchanged
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

