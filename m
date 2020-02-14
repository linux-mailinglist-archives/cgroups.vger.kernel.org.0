Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28115F95D
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 23:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBNWYe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 17:24:34 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45312 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgBNWYe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 17:24:34 -0500
Received: by mail-pg1-f202.google.com with SMTP id c2so6955487pga.12
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gqPN6rca6tQbB2wbaK3mUEwUJIuY7eBrM+y+4z2O/UE=;
        b=IBiQ45SugGiYgT2pAGmSYKd2rySIEgvA5tF8RFPtcJAYQzPcRnZZQr24PUCzcN/nOy
         fuH+tT2GGPHZ/JMiRmG1u9zClkRghNwblFj7VdyFHxNkqGOW7qmcfVMZSDe0HIS0nK0R
         fk0Ye33LfaW/FfzbJvH+2/9aeoq0Ew1e2MkVST/thn104F3pBTElosxodPQEzWRLm1SW
         T0qx/k/kdqkGZ/0scvEn7yc1YnSSuFmlsfYPk6xlcBLpGJVFHI7EPaMWi01x19xcxP9c
         8Wesjy05hYcLRq6fCWOiqpxwsjtTmDR5fDLTKl2BYzX6v59fF2uCPKJFma+ZaAmJmMj8
         7HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gqPN6rca6tQbB2wbaK3mUEwUJIuY7eBrM+y+4z2O/UE=;
        b=cTce6z6SrNypDrDB4YZtoev08A3gFcDvapxwXu0n5z9tB57hMyIG51JA/ERGDj4Mg7
         LuA2C2kJVf+NyhovYQNPevUPfhT7iR902/AZHMkA+MhRYNX1XOyuzt+uMrV8cf0Tq+cI
         d9SaJ5o3XuIwf55eae+uuDmMOBCk9OBRLcsHTA2E1Qt9gPGkOqw9MduT5sYGtbzbF28Q
         gVYwiR+4WgJV2zAnO0kQAf6rQGRaLr9DFIQ0P6+azMlp/YtKmZHzZnGJ5XU2XNLSKp36
         XEF13yxmbxAKuPsBRS3dF5ep1/3B+750j8NTWpFE30XMzMArCwLFeg00OSZh8P4keAV5
         1brw==
X-Gm-Message-State: APjAAAUVkS0kbww0w8I60Y7JwB8bzpSlTrDWFjKWg7kqWg6AZ9Rf0sn6
        P8PWx4iZdS6BA6hcR33vPstklPTv0Wpbag==
X-Google-Smtp-Source: APXvYqz1w47plUwAsWnS2MYEj+vEOGzWFxpavAEQRWVDTVZ5Umn3Vx7wAYsP5+JGpIHHx1RiRMb3+syCObAY7w==
X-Received: by 2002:a63:778c:: with SMTP id s134mr5559980pgc.451.1581719071824;
 Fri, 14 Feb 2020 14:24:31 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:24:15 -0800
Message-Id: <20200214222415.181467-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] cgroup: memcg: net: do not associate sock with unrelated cgroup
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We are testing network memory accounting in our setup and noticed
inconsistent network memory usage and often unrelated cgroups network
usage correlates with testing workload. On further inspection, it
seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
irq context specially for cgroup v1.

mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
and kind of assumes that this can only happen from sk_clone_lock()
and the source sock object has already associated cgroup. However in
cgroup v1, where network memory accounting is opt-in, the source sock
can be unassociated with any cgroup and the new cloned sock can get
associated with unrelated interrupted cgroup.

Cgroup v2 can also suffer if the source sock object was created by
process in the root cgroup or if sk_alloc() is called in irq context.
The fix is to just do nothing in interrupt.

Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
Fixes: d979a39d7242 ("cgroup: duplicate cgroup reference when cloning sockets")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---

Changes since v1:
- Fix cgroup_sk_alloc() too.

 kernel/cgroup/cgroup.c | 4 ++++
 mm/memcontrol.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9a8a5ded3c48..46e5f5518fba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6449,6 +6449,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		return;
 	}
 
+	/* Do not associate the sock with unrelated interrupted task's memcg. */
+	if (in_interrupt())
+		return;
+
 	rcu_read_lock();
 
 	while (true) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..f500da82bfe8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6697,6 +6697,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 		return;
 	}
 
+	/* Do not associate the sock with unrelated interrupted task's memcg. */
+	if (in_interrupt())
+		return;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
 	if (memcg == root_mem_cgroup)
-- 
2.25.0.265.gbab2e86ba0-goog

