Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9633F32324E
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 21:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhBWUpI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 15:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhBWUo6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 15:44:58 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D1C06178C
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 12:43:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 33so10422145pgv.0
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tAEo4In/0gx3aeLrRSAmN7UQ8VKqv74lEJhxcNM3pDE=;
        b=pNq6leRfIEyTpbzdvnSYqIa5/6uoeglwemLjqUX0IiWI8TeuF2G5lJMdEEeNcMegkl
         O8gXSmRbFBDs2+LfUtiO8uqvdm+8+6zCwGPlI1kuN6m/K6h4DYXcZQtK5IOqx9zVk4+n
         TUHEIgVRaat0jXeawkQ6LznVLYTsonjsmiFtth44j9oUWYUJyNwp9iM0lUduBUWN4odo
         YvTirH9MQ2knks30Akq6f3ezOTsPcfx/lQ2Z7GKBNvRzoihVWJrOFBn87IWdovViuj4s
         AYm2f0MuddRZ6VYqA/eHzlzS2FhYT/6lCwleqtKPCJpCUgCCiOF2r2v9A7ijcwQ0mMaw
         m46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tAEo4In/0gx3aeLrRSAmN7UQ8VKqv74lEJhxcNM3pDE=;
        b=JF0Co8UGz+oQUxcppkR9CyNO3zxKVpc+UueJ2YxtMmdaXVYQRiaAjgdl6MlCHlrRXg
         jkGF30bb6wOwCU+OvOwWqITlzW6/8OWHUtCWaPZVgwvUzAm9rmZOJ2HXM+W7Drh9JWlv
         PUlEaguyRlSNx2zQKoitK/fZvYWtheGLQudrWtu5OEMKtmtoCPCXUvX4HjlUp/JpVTUe
         Mg2ySADjJQtcZIK9ds4aIpQHiK1tudmKPfX4fQpiWD7irVKnj+Vd+BrftD0K3zfOKZ91
         9PtHQWTMhBKX3/cPvnyhhYb2QevjPy+H6XagqgHRyVJB9B5bonFt5EM2XZhnea0fKD0l
         c+Sw==
X-Gm-Message-State: AOAM532vwsizwZjrGSnIePAOrvtteiSPc0y3qRheZcHiulY8bocY5Oej
        qN8/RcvgEE5ilqj1+V6XhpOBvRpOIZomPQ==
X-Google-Smtp-Source: ABdhPJwwwVjOjQAH3kCFA1d6qpxNRK4AjF2+AXyqpkEicA4UtizFeD7GiN7a8129xZsdezQY7SVuuyIiRTrgOw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:8ccd:3283:c85b:61eb])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:404c:: with SMTP id
 k12mr659123pjg.4.1614113032046; Tue, 23 Feb 2021 12:43:52 -0800 (PST)
Date:   Tue, 23 Feb 2021 12:43:37 -0800
Message-Id: <20210223204337.2785120-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] memcg: enable memcg oom-kill for __GFP_NOFAIL
From:   Shakeel Butt <shakeelb@google.com>
To:     David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the era of async memcg oom-killer, the commit a0d8b00a3381 ("mm:
memcg: do not declare OOM from __GFP_NOFAIL allocations") added the code
to skip memcg oom-killer for __GFP_NOFAIL allocations. The reason was
that the __GFP_NOFAIL callers will not enter aync oom synchronization
path and will keep the task marked as in memcg oom. At that time the
tasks marked in memcg oom can bypass the memcg limits and the oom
synchronization would have happened later in the later userspace
triggered page fault. Thus letting the task marked as under memcg oom
bypass the memcg limit for arbitrary time.

With the synchronous memcg oom-killer (commit 29ef680ae7c21 ("memcg,
oom: move out_of_memory back to the charge path")) and not letting the
task marked under memcg oom to bypass the memcg limits (commit
1f14c1ac19aa4 ("mm: memcg: do not allow task about to OOM kill to bypass
the limit")), we can again allow __GFP_NOFAIL allocations to trigger
memcg oom-kill. This will make memcg oom behavior closer to page
allocator oom behavior.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2db2aeac8a9e..dcb5665aeb69 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2797,9 +2797,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	if (gfp_mask & __GFP_NOFAIL)
-		goto force;
-
 	if (fatal_signal_pending(current))
 		goto force;
 
-- 
2.30.0.617.g56c4b15f3c-goog

