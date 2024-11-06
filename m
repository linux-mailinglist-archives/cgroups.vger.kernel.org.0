Return-Path: <cgroups+bounces-5458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B939BF908
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 23:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9D71C21F59
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975920D503;
	Wed,  6 Nov 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjAhOQbk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882F20C313;
	Wed,  6 Nov 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931278; cv=none; b=OXxIerUs4q/n4gFpdgEM8UROfGYF4As4K0wqJElNjlZD846f6tB/z0b/gudhtB3ZAEJabRyiXtPaxXQZ4dZK3HAzaf3xGz3EpqCkrGUOyF8YIkSdL6CkSob1RCunEREcn14U9Et4EwJKuaWguc96+1wRa0mcsqZL4AFSQJgdDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931278; c=relaxed/simple;
	bh=+kHPKLgmgDnmThAfnMTonb7jhbrr1DVjxYkFmIWVn0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0VtwM0/aAam40qI3o1y3qvA53v0mUMsMqTFigkvsgXtUkip1g8ZaQ2JHnlcXIgHwKnu7WJxEo3bddodtHadeLv7gwVthR7ghKjKccoQ+Neik1VLi2YO/3N3/sFpk83EE3iVggwGNWn0NECBDWAcNAbhaeAuJcIq/06Ge0Tw6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjAhOQbk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30d517c82fso309963276.1;
        Wed, 06 Nov 2024 14:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931276; x=1731536076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+BYvY7IMf430+vWeEHCo5rwaXQ0/XpIOzOhZE2+FDs=;
        b=NjAhOQbkZfLgLTIc3k50UrQpOgRYuY2arkLSXLiVVufEoKdsxXIoSI4m139iuvTjY3
         wBhFg/KMsZxz6kjWQHRoBwKAVEIxcXMffFdf4AhSXAJQyAwOSKpxI6t5yVr3uEbHdaxD
         TsamfnDWQZyuMK1GRq16i827OJDXrQJ7oaKVx+iQ/G5UB2efXJs3gP9DlJolGlIkWryc
         KRqDscbjG2bU/h4LqZurHZ5dWESksUVdx4FZLNKU8rXm0wmCqhlx/CrN3c5/zN5dhvOa
         fJbB+L083eMJIFga46dun8CbZ4kVIra5iM4nvcgDHwnEBd/P8pf66FM2ShPDzAEtItKs
         5FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931276; x=1731536076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+BYvY7IMf430+vWeEHCo5rwaXQ0/XpIOzOhZE2+FDs=;
        b=GW07IcsgEkbBgXRx7KB24a/dinGTFc+LPOUKRtVYlW9T6iluDpNrN2bUgQh2uGQnPI
         fgQ6n56HGM73hum7OtRYTcAgVDLZWa0FhAVhQhDuOlvIRpviWi/NHwkwZzXvPL4QX3qW
         /1E2iknUqbEERZAkXiGIN7esMbY55WfOd0EBYO3oqDajqfNAGulkUxM1FXBq1iml7Ctj
         JfCkcD2+v/i2r9/v4VAWylAhLRbsphD6hc+pAW9zXANunq+6Qcf++DVWz+B8NfJ5Os6Q
         4ye1nzg2UWVJPkHbLGSCaWNqfZMclPNnW/54Y4d1Y1hz0pLTmXMuyGYdehhTdQEtc4+s
         Wn1A==
X-Forwarded-Encrypted: i=1; AJvYcCVh/akPy2NAhiaYL7JcGGSqcudb1752PCz9MYBwpEUPmKBrDWfGgnKLEOfXNrlFEvPSE4OARvak@vger.kernel.org, AJvYcCVx+Gcb0NP53bSsUqGUXl90LHRC1laa8Vc3fCUUgGxqYZJGLoRTEFJZX822sek66q3A1biXcL69dNE0BY6k@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0GR4Js95X7m/Fb+xrVpto7RBpi/c9xaIAM4WR0OUZ+w+bnA0
	Bm0I2om8/wdWTtfRXo4maxsfgUkOGfXOKhw9yulLw5RbSNjFt4Iscn3Jxg==
X-Google-Smtp-Source: AGHT+IEZB9rihXZ3AKiyPE/dIYsUpmlpyAXZCpI9bcRjC/JzUNq0GMLJ+lPD4+mXrSwJbO3Tlf6xIw==
X-Received: by 2002:a05:6902:1a48:b0:e30:7c38:668b with SMTP id 3f1490d57ef6-e30cf4d0428mr28204692276.37.1730931276231;
        Wed, 06 Nov 2024 14:14:36 -0800 (PST)
Received: from localhost (fwdproxy-frc-016.fbsv.net. [2a03:2880:21ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a61035sm3052634276.1.2024.11.06.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:14:35 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/2] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Date: Wed,  6 Nov 2024 14:14:33 -0800
Message-ID: <20241106221434.2029328-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch isolates the check for whether memcg accounts hugetlb.
This condition can only be true if the memcg mount option
memory_hugetlb_accounting is on, which includes hugetlb usage
in memory.current.

Signed-of-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..25761d55799e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -694,6 +694,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
+bool memcg_accounts_hugetlb(void);
+
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5444d0e7bb64..59dea0122579 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4497,6 +4497,15 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+bool memcg_accounts_hugetlb(void)
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+#else
+	return false;
+#endif
+}
+
 /**
  * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
  * @memcg: memcg to charge.
@@ -4522,8 +4531,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	 * but do not attempt to commit charge later (or cancel on error) either.
 	 */
 	if (mem_cgroup_disabled() || !memcg ||
-		!cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
-		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
 		return -EOPNOTSUPP;
 
 	if (try_charge(memcg, gfp, nr_pages))
-- 
2.43.5


