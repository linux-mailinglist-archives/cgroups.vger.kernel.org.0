Return-Path: <cgroups+bounces-7557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D6A8921A
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1111917D133
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76480224B05;
	Tue, 15 Apr 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="izAJHX7h"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67EA224AE9
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685216; cv=none; b=fjJM7YPLmhP+RfJWNLA9Rbsmsgh5yZZQDnjE2yhIIesTQhXPP7wsIfHiRaP9+ReAPxxg18u51B1L96pJgeHNnCrKzrnyo7GzvSQ/DHAP5uszDda4XvDAikHAPTlT9aPdY5cviQi4WPA1vHkXvnIL7GfuRUt69h3w0t1muzBtBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685216; c=relaxed/simple;
	bh=zozmMIIkyQB7vfg2WW3vcLqWkxJHli/zl3aRM3CRPPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEZ68d2ar9+vS/Vn6u6JkBTyGqt6OEu1jrC/GJTUI+iMMJy8B4m5Yu5IUisoDOvaQT70Xmt5lv0GhO8jSEsfUHFo2WVrhkOHj3E7U3lFrxbJtiTnJmIH/Y52TEF0c2by1868ndTJ5SPC7ZkQ0pIDjlMETNwDW2A4E+Od7r1FrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=izAJHX7h; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241053582dso69118115ad.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685214; x=1745290014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDFiTtsYE3vsXL9LKCv2J9wFa6MHITbi7MDnimw67RY=;
        b=izAJHX7htiBVyb8xAlCgBvEPj9eNwRXIty0+c3vv6IRU0PDTSTRs2NV8dsNzx3CwCC
         m2X2OOXjuq6jLVgJaIgxhsk3VvBvIzVAmrxaTqFpCdX/D55HKLkNLtYJ+dBalryk75Qs
         SXca/VIquUgJOsSwJXVA5fR4vws1DaciGlcPgS01T4U1F9RuFXVJCs7rhqmvT4QWR3Gr
         bRKuhrAvnD/FSSQxY8NaZmevRQcXPcozOJ1woSPEgszqE7gkLq0iLYs0E934Dhj1vtnQ
         it6wlms5CnZQmya22svuodlg4tt7CEaLxf0EFktqox/Y1dq88etZOfbHeHxJw4VjHuM5
         o/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685214; x=1745290014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDFiTtsYE3vsXL9LKCv2J9wFa6MHITbi7MDnimw67RY=;
        b=ptnappH6n3a+krZttHRdOsYtSonvlddto3bhrAksNw7eQaGLb+h1cC4CKAhjLibmT9
         HRA5/eV/qZAKcyDWSmXF8QwfArcHJRcooR2tBIeYhtbC2bz2+qKbVNCtycAmO2QcSJYR
         wyjmw11Il8chfsOlSa7+RjhmY8NmlvXon29kB30AYNrvczOalUlG4DVUU7g7v/OAoZwV
         R+t3UbJsYNXTVwfAhMcPknebtHE7anH0CgEGfnA3oUo3jLmK6IzAxFjfS4cHIXgNvFUo
         dkd0s/1BwhDpVUPw9PqCASuUn/SSlb+n+l7HJ0lvJTEiWKa/SXRUUzG+i0ubC6qFKg97
         ZqoA==
X-Forwarded-Encrypted: i=1; AJvYcCXTu+IxxlhcZZOT8Ds178JlxwGmaOs+FannVbG39K6PeZgwiSFsEVjirtJjQkF7CiClE/8KrRwW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8mCymsnwFfx3AS95F1Y7MHTEGuCRbqJR3+6sEheWwUGon2/9
	4HZ3fVXF6u3d4dgUWiaItGIkPk2XycJtBPtVXUtzzuxC3ukXEwA0jakpfTMpIoA=
X-Gm-Gg: ASbGncta6794oWwRL3DI8rT5NPN+1tHucd5l26GmYpHgyHb0XQfLvJSUrCto/bPITYW
	VaC27MWPSw8AiS47oEuTMNx4KwnKqyUfzMFcP+6eOnFNQh63Th8U7Tb+syOt61fvvZBbNlDWxkC
	frteLhta8C/ZZmNTI3A0fsnTDtbaILXP6ZZlkQOhw0mVIGXvM0Mypr6AYY9TAxWgOT8FQNpfw32
	x1EmXZyyH/+2UQYy4Res/FNPCbIR+mWpVdPJFMoUVyVIIhwiEHHIOBqA+b9JxPKvUhXZ+F9LRJy
	YIt3Oxc6WYF3k0YRH5EvzUKtyU3FpBYgviGjOkXHVvAbsCnF7r8sT7t5+ScrMnX0WNhWu4R2jG7
	5dnfLsLY=
X-Google-Smtp-Source: AGHT+IFH7dR3wBmfihakVorT6Qxxwq/ncIuMTxmwaVROxMgkaq6cZIV7iNxi0oFb9UgfVvElafvYJA==
X-Received: by 2002:a17:902:eb8a:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22bea4b6141mr200724475ad.16.1744685213756;
        Mon, 14 Apr 2025 19:46:53 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:53 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 11/28] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
Date: Tue, 15 Apr 2025 10:45:15 +0800
Message-Id: <20250415024532.26632-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in get_mem_cgroup_from_folio().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4aadc1b87db3..4802ce1f49a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -983,14 +983,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  */
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	if (!folio_memcg_charged(folio))
+		return root_mem_cgroup;
+
 	rcu_read_lock();
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
+retry:
+	memcg = folio_memcg(folio);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
 	rcu_read_unlock();
 	return memcg;
 }
-- 
2.20.1


