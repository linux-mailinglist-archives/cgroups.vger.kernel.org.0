Return-Path: <cgroups+bounces-12432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484C3CC8D7D
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4556A30AC3E5
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114C34E765;
	Wed, 17 Dec 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YSQRfYX4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0234EEEB
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988885; cv=none; b=Wehg2AuOzKnjJG6O88XPn7E0lCINi2Ri5nqqFpQ7EXjWWE8o0mvrfyzjlGCDIJ0nPHixJ4busyCkIvpcIbl56rVwPlZctvglAY9KXdSHNsn3mtiw4MI9LRRUxjvp5siAF0TqbQj2xNWddzJDx8i9sA2X7IlYlKeAAv9/fevz/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988885; c=relaxed/simple;
	bh=8N1NH3gvQgT8EJmKCkddKOj6r6h0v+SQdz9mI6/X5NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUjnLE8HzWuX4DuF1cy1V5BM0vS02AtMHY27ysXl9AFsiDgblmkqaUMyhtQO0BqrvvrZbVtWKg1FuYoiNPeO67jOZRL6dZSsZLj3djh1CBFUAao6Qe4yNo1bX11hrODVIsqfZrDLgyDH3p6x64cTxQyVGNkKqGMQTJ4YTvC6atY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YSQRfYX4; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso3047262f8f.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988881; x=1766593681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miS4ss3MDPMSZCVnSoPtKejAYQtVb4qQrc+Jf4/2A6E=;
        b=YSQRfYX43BQLOzgtpGn5en6mTceK+gUxvdgrUcw/54adk0PAT0twU1rfpNw+LkihDZ
         xLF9+30DAM8bH9PAdRvaQomTw30Og8NBHsKo4o0ng1fvrxdoTV15+tWb2ZMv8rEFeW0S
         m3JlE13pXes0pP7tyvbIQqgCZaZ/1qAPXlitL5An5t9knJKSaWg1zwoL+TDE3WuzfoV9
         lJ8NoN8cnhdplXHsxGeLhWzRda+WKUKsqHrBke2Jbl9osrkKLdEuV4HAaE9millgRKS4
         QsYkKhnT8PvCbnBwCnsrzgHRK76OHdWzkaFREPO1W7FtM7FnpHKKnCy69lOCcUvrxU1A
         sTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988881; x=1766593681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miS4ss3MDPMSZCVnSoPtKejAYQtVb4qQrc+Jf4/2A6E=;
        b=ta5eYgfZIwYpl5BLQgLnDBQgxYuiHwIuCdkmmbqrvh80A7kdsHHjSEQIoqRAbkAWgA
         0xH2IIKEs0FmpSckqAWP7E2BNCnrgz6B0zhL4u1r20TLQMscfBZktDmOKJKGB/o1+Iyb
         0+Np1vUIO7BgSKwxQCPuJ65KUdT61XkXqt/52uA4lLj/TU5ErHoQrwz5E7R8wNgHWIi2
         twK+1y6YabFLPci5zH/esOq+WIDDr7Kv3vCGE11scAWfMvztoHm6RePEtHsk3hTbZxaI
         dqZqswwVQzBKPL4q4dFb/iCe8jK3Nid80p6Wv20IiUe40RjhbBJKPElWlRDoRuX1CpHc
         XNAA==
X-Gm-Message-State: AOJu0YxchX195llMF4YuGe5lJoJZoF9t0IoJZmG2U1kMLwjYglZDkayZ
	SSBvA7lxzrSuk+KEej4HzddSG+FJifoRg2t1gQ/UhOLbqkdqkyKLmlEHNEiAeoioEt9dDrQBrIt
	L+chS
X-Gm-Gg: AY/fxX5mr1JpSEKIIZM2IcYxYbje6d0J4Is2wxwXHHgKjWaWxrHWT+G0eIwjRNgPYwj
	89VkL4j5nHI8hYqwaBGqktbOA1YwzmTx/CBmip7DkoFW1bTCkg/tR+mA+TDbBs8UxmnvGoh9oiq
	k+8aHL8u3OFcqXgxdPAbTh895w8LZ0C6ScCu4/LHoMzFTE4I5hrKOuM2F8WuQDIpIBrONYsSD8i
	KnYENKLd4B009VPXtCJTtxZ2gfzFKoHU/ukXhCEH4w6To60goSW1NyyQQWTw6z0lQAajLDLIiv6
	04R7rF2RugCRQvImMHhA4Le+B1+Ps5I+vDbmHWoEGTC6hEfdBPPQFyMgegzhl/cUXb+BNtmYOtc
	JKeTRbnhQAU2O+YL6V+L3vvgt7aQBwPg4sAZa58YJYYzDYKMCsDrbcACJXBs0UYs/NxTFwx75TL
	SUrNc7DVetAcwiClD71b4jOkg7hTB0a9M=
X-Google-Smtp-Source: AGHT+IHcvkh1m9sLAXyNB6eVc7R+7YZBCQwqFGtWv5JoMxfuEBVtQKc5wQlBYiBzOLEKXZOB0xl9aw==
X-Received: by 2002:a05:6000:240d:b0:431:9b2:61dd with SMTP id ffacd0b85a97d-43109b2636cmr5805555f8f.38.1765988881299;
        Wed, 17 Dec 2025 08:28:01 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:00 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	David Laight <david.laight.linux@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 1/4] cgroup: Eliminate cgrp_ancestor_storage in cgroup_root
Date: Wed, 17 Dec 2025 17:27:33 +0100
Message-ID: <20251217162744.352391-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cgrp_ancestor_storage has two drawbacks:
- it's not guaranteed that the member immediately follows struct cgrp in
  cgroup_root (root cgroup's ancestors[0] might thus point to a padding
  and not in cgrp_ancestor_storage proper),
- this idiom raises warnings with -Wflex-array-member-not-at-end.

Instead of relying on the auxiliary member in cgroup_root, define the
0-th level ancestor inside struct cgroup (needed for static allocation
of cgrp_dfl_root), deeper cgroups would allocate flexible
_low_ancestors[].  Unionized alias through ancestors[] will
transparently join the two ranges (ancestors is wrapped in a struct to
avoid 'error: flexible array member in union').

The above change would still leave the flexible array at the end of
struct cgroup, so move cgrp also towards the end of cgroup_root to
resolve the -Wflex-array-member-not-at-end.

Link: https://lore.kernel.org/r/5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com/
Reported-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Closes: https://lore.kernel.org/r/b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com/
Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 28 +++++++++++++++++-----------
 kernel/cgroup/cgroup.c      |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b760a3c470a56..9247e437da5ce 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -626,7 +626,16 @@ struct cgroup {
 #endif
 
 	/* All ancestors including self */
-	struct cgroup *ancestors[];
+	union {
+		struct {
+			void *_sentinel[0]; /* XXX to avoid 'flexible array member in a struct with no named members' */
+			struct cgroup *ancestors[];
+		};
+		struct {
+			struct cgroup *_root_ancestor;
+			struct cgroup *_low_ancestors[];
+		};
+	};
 };
 
 /*
@@ -647,16 +656,6 @@ struct cgroup_root {
 	struct list_head root_list;
 	struct rcu_head rcu;	/* Must be near the top */
 
-	/*
-	 * The root cgroup. The containing cgroup_root will be destroyed on its
-	 * release. cgrp->ancestors[0] will be used overflowing into the
-	 * following field. cgrp_ancestor_storage must immediately follow.
-	 */
-	struct cgroup cgrp;
-
-	/* must follow cgrp for cgrp->ancestors[0], see above */
-	struct cgroup *cgrp_ancestor_storage;
-
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
@@ -668,6 +667,13 @@ struct cgroup_root {
 
 	/* The name for this hierarchy - may be empty */
 	char name[MAX_CGROUP_ROOT_NAMELEN];
+
+	/*
+	 * The root cgroup. The containing cgroup_root will be destroyed on its
+	 * release. This must be embedded last due to flexible array at the end
+	 * of struct cgroup.
+	 */
+	struct cgroup cgrp;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e717208cfb185..554a02ee298ba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5847,7 +5847,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	int ret;
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
-	cgrp = kzalloc(struct_size(cgrp, ancestors, (level + 1)), GFP_KERNEL);
+	cgrp = kzalloc(struct_size(cgrp, _low_ancestors, level), GFP_KERNEL);
 	if (!cgrp)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.52.0


