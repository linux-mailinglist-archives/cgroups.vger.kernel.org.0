Return-Path: <cgroups+bounces-12945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98ACFF1B0
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62252300671E
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E93570AE;
	Wed,  7 Jan 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BSIwDP13"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95CF348867
	for <cgroups@vger.kernel.org>; Wed,  7 Jan 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805333; cv=none; b=Ou03XtlT6irv9aZ2qnS5qJT3oa6I2Pwe7fStdTKnq0ChZFqWBtWR+PgB/e9Iux/GXyMcvHf5QjD48L4rJR5RexOTqyEoTc8xy2pAllSwmscznM+IFvO+F3HWkrjz1GSbUQGQzoJ5wYINl3bXmSBf06Eoq2RhdHfPEpMRwxQ1YDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805333; c=relaxed/simple;
	bh=tWFeLnDDz/em1zg/E8BbEXwCSep7COgZ1jMf56WRGho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=si5iXt5MibVqP6p3fZndbW6iWpVDux6k+GnZTXrGnNuqMypzXmr7NGFI3PBCcYilfnBpw+rHiAtggEG3msh/DYNlvbTQOt9m2gtSlyMG6joxThJIr6LdXBTrO0xg62sPNvAVRckwtkHe7va9V0rb6R74fAHt79hQwR+9y5uXFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BSIwDP13; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so19832055e9.3
        for <cgroups@vger.kernel.org>; Wed, 07 Jan 2026 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767805327; x=1768410127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L49E8GK0L61Xb+Ow/6X+q4Ipvp5Im1cS6u2eq6FB63A=;
        b=BSIwDP13V9ZT/6Ty4pe8Lo2nBLjfq8yruRndt7Ac3Fy8AewH0VdfHMW0yuLJHBIQ5F
         2da3wM/wTqoEqrIoa2tdMuELM4UTUtdOX2zdvGZIpjjgvPuqCv8GSC3Olr1nKRQGAXsl
         +5IHXf7qOokkWifqL2bRmwxKc8mFvxiz1MXtLBoAyALgK33eCkrpdjAER+infMPfT5QN
         NkN6L9e7MWX+OHnZcYuOy6WUn3iwj2L0zopuadpwD6z4dgGsqlwPdRnVvCBDnU4VLIKQ
         DNEl4ZBVphVc2tiK33cO6XAdafPKn9f3B1tEDnJOynIO9nQrxKubgMEFlEOMnbh1ST4Q
         ArmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805327; x=1768410127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L49E8GK0L61Xb+Ow/6X+q4Ipvp5Im1cS6u2eq6FB63A=;
        b=O+NLHwO2qu5Fry4UEQPgtY8CNCkShuNSCbieVadXe+Fia1jBShMbde6jZaB9B2jtDr
         keTvVNvNmiMsPj71pkIpZhTeD7Y8NQSLcsHLJrU8wyBTHfmuJhbflMOlMNjcuZ/dgfna
         OtXZXL2EHujvvYSzl8fZXtpA0LX2yopUrgCiOBOk+aRuIE5Vz4JiEOGGuVUmygGl3UYs
         okShAVG5MPqCVu1l2///tX2aOg3UoyeE2Qs/UbwTkX8nGVaIWBpBHnF5BCwKhvkO/JoW
         FDaAqkljO6oDWwhzENAZ+33GduP2SOr0gYXSeyEIcvP7t4WxtGHhdSJI0clCNd5JTV+S
         tQDQ==
X-Gm-Message-State: AOJu0YwYyzi8jijSgd4hCco7EqOCFQLkWdDSD2IQ2IJey3CWqc3a2gIx
	It9jwB67NU6zb2ABv54SL+IfE37RyBTr3W2eEPyRHpyla6fM8U8QFM079/XfuHjld79a92bCPbi
	4bW8h
X-Gm-Gg: AY/fxX6U3UgpZrF3uw/SzkTr76qxKn0vgtd8zhd2nANvCfHkxjCkNYSQQQDyjZPH/VR
	w6wTsYulxtHFQ03+rEaJHHwgsHzj0xxQF5779NjsffnMVmRwk0lpmpiFWOHubzDLX5Z6VnqZxze
	eQbtbQmm29TSUt5C74i4mnGElM4JSMplGfFyrQDl2YqL53ToSnMtBELELQInEyifMtE7eaXaNUy
	WdR8RkTLUMIYvUA0egJ71psquA5yrzae/ffdiba4zbke3dgcmXACLylwX3vOPNMUK5hcPk1jBX0
	NSIdOqG9dsnCk40I3r542Ljsf8ZG5HcbONnVDq/Z1x0DGDXhntxuL5jJi31lQxPiHrYm+6T1h8a
	Kwnv3BCmurwIxw2Cg5yb5vzseAjBnjv4QArpYGq5qUlyeL42yZIjKTsaxVAbWvURVzMitwzu442
	wk/lGWrZt4EoGtmy4r2hVJZF8aA1CUGec=
X-Google-Smtp-Source: AGHT+IEg3eq4eSlFYkLOWLPuVP+Buf7OIMrTZ/OdJp8hfUfEblFjlugkX6dHGbDV+Go/PXS4KGbfpQ==
X-Received: by 2002:a05:600c:3b28:b0:477:8a2a:123e with SMTP id 5b1f17b1804b1-47d84b41bbfmr39523105e9.33.1767805326694;
        Wed, 07 Jan 2026 09:02:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6f0e15sm103041885e9.10.2026.01.07.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:02:06 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	David Laight <david.laight.linux@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2] cgroup: Eliminate cgrp_ancestor_storage in cgroup_root
Date: Wed,  7 Jan 2026 17:59:41 +0100
Message-ID: <20260107165942.95340-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
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
transparently join the two ranges.

The above change would still leave the flexible array at the end of
struct cgroup inside cgroup_root, so move cgrp also towards the end of
cgroup_root to resolve the -Wflex-array-member-not-at-end.

Link: https://lore.kernel.org/r/5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com/
Reported-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Closes: https://lore.kernel.org/r/b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com/
Cc: David Laight <david.laight.linux@gmail.com>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 25 ++++++++++++++-----------
 kernel/cgroup/cgroup.c      |  2 +-
 2 files changed, 15 insertions(+), 12 deletions(-)

Changes from v1 (https://lore.kernel.org/r/20251217162744.352391-1-mkoutny@suse.com
- drop __counted_by patches (2--4), too intrusive rework (Michal)
- utilize DECLARE_FLEX_ARRAY (Gustavo)
- trailers

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b760a3c470a56..f7cc60de00583 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -626,7 +626,13 @@ struct cgroup {
 #endif
 
 	/* All ancestors including self */
-	struct cgroup *ancestors[];
+	union {
+		DECLARE_FLEX_ARRAY(struct cgroup *, ancestors);
+		struct {
+			struct cgroup *_root_ancestor;
+			DECLARE_FLEX_ARRAY(struct cgroup *, _low_ancestors);
+		};
+	};
 };
 
 /*
@@ -647,16 +653,6 @@ struct cgroup_root {
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
 
@@ -668,6 +664,13 @@ struct cgroup_root {
 
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


