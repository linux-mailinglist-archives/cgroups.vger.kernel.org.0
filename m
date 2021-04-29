Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1636E9EA
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhD2MCf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 08:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhD2MCe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Apr 2021 08:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B3661447;
        Thu, 29 Apr 2021 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619697708;
        bh=5qld4YO5g4c9lOG9SwrBFf2p2zt+KhTuIbqd0h3aft0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXFDhV5fgITuYrlpH8KhcGC1nqJVV1hGIgJeKqyV8vK6/egmgfYmcKud+VC0XtESJ
         abxErzL4B2CmueBckjTo7dBmjFgydPYJg21bXileReGdEUusXc0BEGx7ygbyMxotef
         5mP3ytJnMZjfvXL/3Sy2Eo3eQ2JL9/l91441oboG5fAyBfeXVhJxAZ3hp5gBtk1kPL
         gNayyHq2r7+IwkdN1meD8Mf2xgh9wZ58vRZnwiynWykJMyWqbJ3hC382qHOpIkB7Z9
         8zRkivzyOiCdBBl4o0DORuSDBamA6fD/OMVc4Zp/Vme51FkWYyZXsczEtG3mr5uonP
         dfmWJprABZosQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/5] tests/cgroup: use cgroup.kill in cg_killall()
Date:   Thu, 29 Apr 2021 14:01:11 +0200
Message-Id: <20210429120113.2238065-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429120113.2238065-1-brauner@kernel.org>
References: <20210429120113.2238065-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DIB/9pEGy9llyw8JVnB5N3xonNHMlykb1jj0N6tKKZc=; m=18eteVvaSZT+qBZQhTA1ueV+TlQ2mBt//fFsbM3Vjao=; p=fH/hBxbQMGXqPY1c+s85VMcPrrOG9llYJ2cIv0/5z0E=; g=f9f764d90d255b615ede51d62b8fdc79385ad80c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIqfXQAKCRCRxhvAZXjcokHDAQCNUnN gawCjoxp7TqW4GnK/OPNvZcyxt11TKJWXDJSZcgD+JHS2XjxGPncHhz/Q0kqK53jBKjBEWZonTTpY zdSGjQs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If cgroup.kill file is supported make use of it.

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 027014662fb2..3e27cd9bda75 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -252,6 +252,10 @@ int cg_killall(const char *cgroup)
 	char buf[PAGE_SIZE];
 	char *ptr = buf;
 
+	/* If cgroup.kill exists use it. */
+        if (!cg_write(cgroup, "cgroup.kill", "1"))
+		return 0;
+
 	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
 		return -1;
 
-- 
2.27.0

