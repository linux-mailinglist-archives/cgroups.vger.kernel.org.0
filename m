Return-Path: <cgroups+bounces-5485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE59C2703
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24201C21A6A
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C401F26D8;
	Fri,  8 Nov 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcC9T+S6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC91D433B;
	Fri,  8 Nov 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101391; cv=none; b=JnvjsHexTLVLXg0fSvJtjHkvCG+5y7Vg6AfKkMfkBprloqxS6ZiIZ4CKW4NXvvFwA8uSfEeSQHuaDzzNvWkv3ZmxY+lvPVUrh8I5Azk0zRfK23Nuyia/pC9JrToUGuUL58Wm9pnLs/9wV385hWFnuGxGEnb6x+Ok+5IxK/E0DSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101391; c=relaxed/simple;
	bh=uDe75mGVAgR4Zl0Pa84zl9hX5eEEU4/X5U/C46L3p2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irCebkknP3/TR9ongfq2lzTgMsLzTiFSbyQZHwG4rhLk9wW4HZXTDKiH9QjWHNaiRIcjapLCdVdWRTta8AAzho+Iw3fpPZSU76wK15PdS5LUGEajTOeURlET57xTq+oza/29a0pkLze7IWPJCkOlQXk9tRGLkcnyFMuU32F6FgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcC9T+S6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2974743675so2488069276.1;
        Fri, 08 Nov 2024 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101389; x=1731706189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN+w5UJnH1OJ63mHkAqq0SxDq06prIp4qqjizUvyrVU=;
        b=TcC9T+S6FU/OzQ/8UcBg8Od32LjzcrByNFCShnKvaS+TGhMJXscXM0MCdx95xT+gt5
         c6qBY28GOghb6IHO/jwg5q8N3oqzCoPkr+hLqu2AQTRWL3eGrLA/VVbU/a0bp+59DCcX
         Q6d1SYxYPAsZQRMJcSoHWrdROXfu/UUbhgjEaTs1cEYLAehdu0HXEmmsVjnX4K45oDp0
         ddRp+p/hLQcnRCrm3wYcXRvDm+wx2zQ7J5VivdtK4pitjoEUvWogewKx+UTI8pbvz+oX
         yhXXVCnRB+k5FVS3dattK/sE8ZSeQ5M+P+C4rOlXbJjrCAV+aZOFMuSjSei/dJNmtajD
         dMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101389; x=1731706189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN+w5UJnH1OJ63mHkAqq0SxDq06prIp4qqjizUvyrVU=;
        b=KclNXfk0VL7kRZx+M5ASolEt1YOR2aK4N0UBKouiJHGStEGERBVY6NQT3NCE75mwyB
         JIjNFq4nUqv/xQ80RO10GI6qjnUKPE5216EdoZCteoLlimpNJ/JMmFGKBKfFe2ioodtW
         H+0kr19amH/ZEx3Ds23HZIDtgckYZ3uKUx7IufVnARk5mZ+STjDG3WpcwFwDqcw6UNTi
         K3eXiXCiCZDzFX9WYjnLOxkrewocECY5/kQnZzhJVC4fQ0TzhLj1xE0xLXGd/IT2b26m
         7ra0qOXKVx5cKqm4kxdRATmrgkyApaSyf/7g9fE+OiZl2cxzNatUkXdLQMTuQXYXs8IZ
         2W3w==
X-Forwarded-Encrypted: i=1; AJvYcCUhJ4sLVpOTyArNCeE8UvRpzcd2Y0rrvOqXdl3cw09B3OP/epg3tJkZfyBo/XBwD3pQWBdKFX7+WfVf0Ik/@vger.kernel.org, AJvYcCW4bUzPz5eUHIxvKMAoSKNjteeQr6MfmDaPFVs3D2cADP8MlTJxaXKCGQvMRTyV5dazS/PmZWma@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wLK3GdHgAZufNVSdi4A1+LsoPsS57iBbZ0YsnfSpx39lZ5hR
	CINRMd80tXKDHvNhE6tVS3LoDVXIO9C6Wo3sW+JcH4DrxbyipAHhUkSpxw==
X-Google-Smtp-Source: AGHT+IF01KDV23z8HCRAEbhxmD/lQoqCQ1DCmjSyHkvYxXH6OJ4PaV9aA0NGxTGCRf0Ixws2pRdvog==
X-Received: by 2002:a05:6902:124f:b0:e2b:9967:6363 with SMTP id 3f1490d57ef6-e337f8f200dmr5284036276.37.1731101388953;
        Fri, 08 Nov 2024 13:29:48 -0800 (PST)
Received: from localhost (fwdproxy-frc-013.fbsv.net. [2a03:2880:21ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba829sm888330276.40.2024.11.08.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:29:47 -0800 (PST)
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
Subject: [PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Date: Fri,  8 Nov 2024 13:29:44 -0800
Message-ID: <20241108212946.2642085-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
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

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 mm/memcontrol.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f3a9653cef0e..97f63ec9c9fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1425,6 +1425,9 @@ unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
 		memcg_page_state_output_unit(item);
 }
 
+/* Forward declaration */
+bool memcg_accounts_hugetlb(void);
+
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
@@ -1446,7 +1449,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
-		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+			!memcg_accounts_hugetlb())
 			continue;
 #endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
@@ -4483,6 +4486,15 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
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
@@ -4508,8 +4520,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
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


