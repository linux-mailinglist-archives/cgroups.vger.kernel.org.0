Return-Path: <cgroups+bounces-8813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B777B0CF32
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE81C20AA9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59A1D5AB5;
	Tue, 22 Jul 2025 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNDFkUvt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AA1BE238;
	Tue, 22 Jul 2025 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148452; cv=none; b=NqiLPcWWSlRRvCGk3lCeXUNYJPQG+2X1CYrHimjA3LcITkaQYHzfSUEw+ozzHwUgDwHYaDsRgiDw1TBEusRhk9FTdMKX8cgQEDLzkIJTUaJKfEOwNFBJY8btZTWr+rjkuR+XSuwCDNXEeZhWXRY9txAmwVBoEpwjOOY9qEhtWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148452; c=relaxed/simple;
	bh=qNXCaNPgvsWVIPwi//yyskzPWPkGW+HCMHmUQPY2xjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhZHu7mdGBVn1ozHgh4n8PIXUxJqRD8p7aV8T9vPcCLoNHB1l6YGQDjshrgSJMNQvc6Jwc/X0EjuSg9qxLaiW0q/PSr/QKXxc4f4v5iQkFDWEmvACgCZTQNuaENbfGGb7XDK+RvbAFjyRj74wLWjKhwXB84RB0skwc+Yu235HZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNDFkUvt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3365501b3a.2;
        Mon, 21 Jul 2025 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148450; x=1753753250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hACIdTG8BKAR62jfoHAS+U9Tvdlt+mbDlCD3cFo5QMk=;
        b=ZNDFkUvtKLwm5X7GS2jNBa1aEjK/WzpnwPRNJYI0ONXNELjKw7PVClEdkD2U671b2n
         8kiis9FbZws1PHZwjg8SjEiMKwgqG8NuKFNaCxdtZAYdjKOcFN0B78fykOL20PWE2JwF
         bRoO9ym1X4+A+fZkknrerOTEmE9jK/2w1l3v+D84p7SB56zz+cQ8PsRst0stglsyKvqu
         uJjRSnN4hpIa+6VUPAyq0Awn0XCiuwm9a/szrFfHnR2U/CQmQ38s9K4n0I/of5l3Yq+J
         zaCk1A94hExRxGrkwn+E5iWN8nbklbR+d6o4T+igNdYpxivM1z/AgwvXanGHbkfWRSl1
         cOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148450; x=1753753250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hACIdTG8BKAR62jfoHAS+U9Tvdlt+mbDlCD3cFo5QMk=;
        b=Ugbr+jr2Cw8Gf+mh06aZW6n64pHZ0YQj7Nqbll4Vfr0mIZO3G5wr4+cawvpV60oyLs
         5tAndWZcs/RVvWuCD1g1dNMNyNrn9u7rVME1YWLYvLaOOJKscbEc++OXZwbT65i1O5bE
         /KrRgIj7CTuNVO4PRPHdpyRGVh8DWGzyCbH9lg62q6tpOgh0S1ToTjcONwk/3nd32kZa
         Hbd4H/XjL+Paj0zpyrtpZZfY6n3g75g9wujxiEJP/VNRt9AyxvF+sqrWg6fMWoX5c2/n
         d5DLH6rmu/bxXMUqvu+r5K8Asmq8fN2ZtpC29JDlShYXU/iZPbNXX4QYAlfeFc1ihmcg
         kYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVJMNeL295rS2ecRCmYWjzlMvTYBk/VhNx6fW1oYHIcP4Tr83CxJ4xSAKQ5gjuI28LWoiX0QyxX@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtPNqoy5OhspyQGIRMdyI6gSXLwo+hPaz60MQgEeQpy/RUB+d
	BlcvceLD+T6I6Oqk/LVKwHV5cXz+JlSNez5f1b+RadsZQJ2IgXy0A1Fm
X-Gm-Gg: ASbGncvPBHk6+TIg6EgaVhwNJa4FSDMWrqfM8ccdiic0h95kwu97tCUSv3liLeYllz1
	UvhkfqAoqBZ5dCAsFF3cxtZGmlbNPkR4SbsFvJn3U+jQ6OVbgtT3rEtmi0aS7GfzQn7lRH/WrfB
	c1oN9wNHZyuwk8uwkUQqwZw0L3rLxYKdSsem98suxsE2l/IsIU8FcWqDqrwSD2t2iWDng4ADLoE
	mKONmJStlPiQRQ7nOV9TaVZg7gM6M+uMpXHoA8r3nJduIgY5fg0otNNLahLcxaBzTFO0Jie/KZT
	vRNntWc3F3ngJRpRAg+n39uLE7y8hojdgGeC1LT+6Vf3pwgxwYg6q1UyujMqdJN2mDpo8QZjjqJ
	ZRG5O6IUOuQu9eHeTf47UYzWqCdOAQoVeyUmFGFtMAVYj9Oxb
X-Google-Smtp-Source: AGHT+IG5c+3T6hAi7v9Hkfw0uHGwJqw2xISlFMEaOfnJnJxDre4YxxnyciqKUVm7GW4eNxA5XPdvWQ==
X-Received: by 2002:a05:6a20:3c8d:b0:222:1802:2ddb with SMTP id adf61e73a8af0-23810667018mr33711833637.8.1753148450008;
        Mon, 21 Jul 2025 18:40:50 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:49 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/5 cgroup/for-6.16-fixes] cgroup: check for rstat flush callback at css rstat init/exit call sites
Date: Mon, 21 Jul 2025 18:40:27 -0700
Message-ID: <20250722014030.297537-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The css rstat init/exit functions have a dependency on the associated
subsystem which is inspected to see if the flush callback exists. Move this
logic out of these functions and instead let callers perform this check in
advance. This decoupling allows greater flexibility in where
css_rstat_init() may be called.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup.c | 18 ++++++++++++------
 kernel/cgroup/rstat.c  |  6 +-----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d684d33236b8..b034f47580f6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5452,7 +5452,9 @@ static void css_free_rwork_fn(struct work_struct *work)
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
-		css_rstat_exit(css);
+		if (ss->css_rstat_flush)
+			css_rstat_exit(css);
+
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
@@ -5679,9 +5681,11 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		goto err_free_css;
 	css->id = err;
 
-	err = css_rstat_init(css);
-	if (err)
-		goto err_free_css;
+	if (ss->css_rstat_flush) {
+		err = css_rstat_init(css);
+		if (err)
+			goto err_free_css;
+	}
 
 	/* @css is ready to be brought online now, make it visible */
 	list_add_tail_rcu(&css->sibling, &parent_css->children);
@@ -6141,8 +6145,10 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
-		BUG_ON(ss_rstat_init(ss));
-		BUG_ON(css_rstat_init(css));
+		if (ss->css_rstat_flush) {
+			BUG_ON(ss_rstat_init(ss));
+			BUG_ON(css_rstat_init(css));
+		}
 	}
 
 	/* Update the init_css_set to contain a subsys
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 8c3cb4a989ad..ba656a53136a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -449,8 +449,7 @@ static int __css_rstat_init(struct cgroup_subsys_state *css, bool is_self)
 			if (!cgrp->rstat_base_cpu)
 				return -ENOMEM;
 		}
-	} else if (css->ss->css_rstat_flush == NULL)
-		return 0;
+	}
 
 	/* the root cgrp's self css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
@@ -484,9 +483,6 @@ static void __css_rstat_exit(struct cgroup_subsys_state *css, bool is_self)
 {
 	int cpu;
 
-	if (!css_uses_rstat(css))
-		return;
-
 	css_rstat_flush(css);
 
 	/* sanity check */
-- 
2.47.1


