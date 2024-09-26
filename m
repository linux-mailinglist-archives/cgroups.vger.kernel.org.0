Return-Path: <cgroups+bounces-4959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76D987B6B
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D5D1C232A4
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B941B0105;
	Thu, 26 Sep 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="S4QfuG3t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCB15B137
	for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391343; cv=none; b=WaXcb155cgkvjgfXemPc1g6v9ulyDQYB0GJYYw2k4FCiOGi5rgIZ4e/X19ArsWQ6eCRIXlbiPONH76pvyviLpUbYZZ32GLP3hFfr1gkewzp3MzfoO8hqugyzdlJhh/sbGHMRFuSILfrfZmAsN2Y4Rbc2voYZct8yrpmjKrg0cM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391343; c=relaxed/simple;
	bh=Nv3DoYcBFp3OWn1ATypV+pn0w7OqgyhCkvy8HLahMHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ML4/CdN46ldkntca0C1XuPAYb9V5BOMoyCg2pcR1V/bSppol8sjMiiPhR9YAFGJF1PKyl2euvsFszZ2CBw7c5Ts5tGOS1lUPcUfah7qJ2eUTm5QmUtkeBT49WqAVZStWfSlywrLvQ+mxXD9pIFQw1FuERsVd1mfx34N5ulxU344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=S4QfuG3t; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso18233491fa.0
        for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1727391338; x=1727996138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qUguF1WrTtWK/hZPra6odgRc7M73fCw096rk09LDH0=;
        b=S4QfuG3tp8slMFMhm6uB/x11VrQueqP3/YZncB/qIlQPSNJsOe5GMM+maxOdx/W8fw
         pUNI1eobv2sVuiR24VLG3RDZBYfEcqbx9YmKLoNfTcwJdy9tQgVnxV3hRsm66exEZOZ4
         OY+0EI/uFYQCR+G5qZafTdXuWqUCWtr2yYpsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391338; x=1727996138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qUguF1WrTtWK/hZPra6odgRc7M73fCw096rk09LDH0=;
        b=qiF5Oqv9NlguxHPw2oLGMVXtBNKSb1O3Dn9EV5YEEkdXyL45Z2wuY9L9ye8+hf3zKs
         uNfSOHN1jryM2fTtRWUYfpzyOc/GelI5CEmLvKyLBP8ibVRJdvdWq0+SB9tVpI1O9Tg9
         0ccwWj9O2LileGPvXnQKlkc155uI3AQWJlXdMVwpgprEb/ETzmA8qYdq2y06C7YnBBzq
         zQRkQ0yLpAlsS+gZRs0e5kNpVXFlwJ9zY7PP7HCLX57aOECxMBlJhZJzmrxt4ojA9JuS
         iEYtLxSttD4ETlKm5kgLKkslHgsNLTj3ngfoV9XES4GHemhoZLwWIJOs/dJYPFkY/UxQ
         h5hg==
X-Forwarded-Encrypted: i=1; AJvYcCWtOPcO1spFmDpwbV7rrsiOF7uw15KFx862A3/YnIp1WVCCCTeEOdpygqNkab779torhCwm3pG9@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIvF35FovGzavgSvUt8rhd3Xc8FwkDwxyeVjPcaP8pvZbwg8i
	krETWjKgc3d9BeWot4qdze4FZqLl6tAR9H4F32NbYDlOiIdOSGGUmCw24xcEsac=
X-Google-Smtp-Source: AGHT+IGwUMWdUp0o0aHg791Fonu8FwXG9GKopXkJI/AU2LTdR0oYW3XsDjbJHS2DiFmo0bVpxWj2Lg==
X-Received: by 2002:a2e:4e0a:0:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f9d4197b0amr5428481fa.40.1727391338181;
        Thu, 26 Sep 2024 15:55:38 -0700 (PDT)
Received: from able.tailbefcf.ts.net ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d45d789fsm990061fa.37.2024.09.26.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 15:55:37 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-kernel@vger.kernel.org
Cc: Mike Yuan <me@yhndnzj.com>,
	Ivan Shapovalov <intelfx@intelfx.name>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] zswap: improve memory.zswap.writeback inheritance
Date: Fri, 27 Sep 2024 00:55:28 +0200
Message-ID: <20240926225531.700742-1-intelfx@intelfx.name>
X-Mailer: git-send-email 2.46.1.5.g6e13a7cc9d
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the inheritance behavior of the `memory.zswap.writeback` cgroup
attribute introduced during the 6.11 cycle. Specifically, in 6.11 we
walk the parent cgroups until we find a _disabled_ writeback, which does
not allow the user to selectively enable zswap writeback while having it
disabled by default.

Instead, introduce a third value for the `memory.zswap.writeback` cgroup
attribute meaning "follow the parent", and use it as the default value
for all cgroups. Additionally, introduce a `zswap.writeback_disable`
module parameter which is used as the "parent" of the root cgroup,
thus making it the global default.

Reads from `memory.zswap.writeback` cgroup attribute will be coerced to
0 or 1 to maintain backwards compatilibity. However, it is possible to
write -1 to that attribute to make the cgroup follow the parent again.

Fixes: e39925734909 ("mm/memcontrol: respect zswap.writeback setting from parent cg too")
Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback disabling")
Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++------
 Documentation/admin-guide/mm/zswap.rst  |  9 ++++++++-
 include/linux/memcontrol.h              |  3 ++-
 include/linux/zswap.h                   |  6 ++++++
 mm/memcontrol.c                         | 24 +++++++++++++++++-------
 mm/zswap.c                              |  9 +++++++++
 6 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 95c18bc17083..eea580490679 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1717,10 +1717,12 @@ The following nested keys are defined.
 	entries fault back in or are written out to disk.
 
   memory.zswap.writeback
-	A read-write single value file. The default value is "1".
-	Note that this setting is hierarchical, i.e. the writeback would be
-	implicitly disabled for child cgroups if the upper hierarchy
-	does so.
+	A read-write single value file. The default is to follow the parent
+	cgroup configuration, and the root cgroup follows the global
+	``zswap.writeback_enabled`` module parameter (which is 1 by default).
+	Thus, this setting is hierarchical, i.e. the writeback setting for
+	a child cgroup can be implicitly controlled at runtime by changing
+	any parent value or the global module parameter.
 
 	When this is set to 0, all swapping attempts to swapping devices
 	are disabled. This included both zswap writebacks, and swapping due
@@ -1729,8 +1731,11 @@ The following nested keys are defined.
 	reclaim inefficiency after disabling writeback (because the same
 	pages might be rejected again and again).
 
-	Note that this is subtly different from setting memory.swap.max to
-	0, as it still allows for pages to be written to the zswap pool.
+	Note that this is different from setting memory.swap.max to 0,
+	as it still allows for pages to be written to the zswap pool.
+
+	This can also be set to -1, which would make the cgroup (and its
+	future children) follow the parent/global value again.
 
   memory.pressure
 	A read-only nested-keyed file.
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 3598dcd7dbe7..20267b8893db 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -126,10 +126,17 @@ Setting this parameter to 100 will disable the hysteresis.
 
 Some users cannot tolerate the swapping that comes with zswap store failures
 and zswap writebacks. Swapping can be disabled entirely (without disabling
-zswap itself) on a cgroup-basis as follows::
+zswap itself) either globally, using the ``writeback_enabled`` sysfs attribute,
+or on a per-cgroup basis, e.g.::
+
+	echo 0 > /sys/module/zswap/parameters/writeback_enabled
 
 	echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
 
+All cgroups follow (i.e. dynamically inherit) the parent configuration
+by default, and the root cgroup follows the module parameter (which can
+thus be considered the global default).
+
 Note that if the store failures are recurring (for e.g if the pages are
 incompressible), users can observe reclaim inefficiency after disabling
 writeback (because the same pages might be rejected again and again).
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e5bf25d324f..ca0510057040 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -202,8 +202,9 @@ struct mem_cgroup {
 	/*
 	 * Prevent pages from this memcg from being written back from zswap to
 	 * swap, and from being swapped out on zswap store failures.
+	 * (< 0: follow the parent/global default)
 	 */
-	bool zswap_writeback;
+	int zswap_writeback;
 #endif
 
 	/* vmpressure notifications */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 6cecb4a4f68b..7d121fdb3521 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -37,6 +37,7 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+bool zswap_writeback_is_enabled(void);
 #else
 
 struct zswap_lruvec_state {};
@@ -71,6 +72,11 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline bool zswap_writeback_is_enabled(void)
+{
+	return true;
+}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d563fb515766..1e0aca42e5a7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3613,7 +3613,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
-	WRITE_ONCE(memcg->zswap_writeback, true);
+	WRITE_ONCE(memcg->zswap_writeback, -1);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -5318,15 +5318,25 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
+	int memcg_zswap_writeback;
+
 	/* if zswap is disabled, do not block pages going to the swapping device */
 	if (!zswap_is_enabled())
 		return true;
 
-	for (; memcg; memcg = parent_mem_cgroup(memcg))
-		if (!READ_ONCE(memcg->zswap_writeback))
-			return false;
+	/*
+	 * -1 means "follow the parent" (root cgroup follows the global default).
+	 * Walk cgroups until we find something, otherwise return the global default.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		memcg_zswap_writeback = READ_ONCE(memcg->zswap_writeback);
+		if (memcg_zswap_writeback >= 0)
+			goto found;
+	}
+	return zswap_writeback_is_enabled();
 
-	return true;
+found:
+	return !!memcg_zswap_writeback;
 }
 
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
@@ -5365,7 +5375,7 @@ static int zswap_writeback_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
+	seq_printf(m, "%d\n", mem_cgroup_zswap_writeback_enabled(memcg));
 	return 0;
 }
 
@@ -5379,7 +5389,7 @@ static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
 	if (parse_ret)
 		return parse_ret;
 
-	if (zswap_writeback != 0 && zswap_writeback != 1)
+	if (zswap_writeback < -1 || zswap_writeback > 1)
 		return -EINVAL;
 
 	WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..724d8a02d61c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -129,6 +129,10 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+/* Enable/disable zswap writeback globally */
+static bool zswap_writeback_enabled = true;
+module_param_named(writeback_enabled, zswap_writeback_enabled, bool, 0644);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -139,6 +143,11 @@ bool zswap_never_enabled(void)
 	return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_ever_enabled);
 }
 
+bool zswap_writeback_is_enabled(void)
+{
+	return zswap_writeback_enabled;
+}
+
 /*********************************
 * data structures
 **********************************/
-- 
2.46.1.5.g6e13a7cc9d


