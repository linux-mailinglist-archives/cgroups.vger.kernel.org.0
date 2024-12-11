Return-Path: <cgroups+bounces-5828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C299ED75D
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C191640FA
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97120E010;
	Wed, 11 Dec 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwE6kdvC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FD2288CB;
	Wed, 11 Dec 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949596; cv=none; b=eWq7hKqe4pq5Tdl0HOjDdxrouwg5ARdXSJWXuHbIHOAieWkODk9VeEOfGengk5qxZjNVMgtRXiQcHa7b/1vUv71/2oLJQzjtvF/samiaNYbYlM98GLGRsdheSOvOdrbIToBT0pXsj/0aslTF2feNRgy0PYW6Pp2JjfaL9efRntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949596; c=relaxed/simple;
	bh=vYKGqCrghO03UwSp2whEgKHoH6CDYHYyd59nBm5u0x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFOjlpuI8AZEb4rHzJfRtHoQKitJsgPyq91H2wCYA5wnzBXd1RFG5XYrc4CKKKsOqBlPlueWEs8gWTnZeY6KFHCtSDFUr1Qmz/DBi+1qC0wsJROYz9tzBprTuO6ycGnFMkCiwOYaUchF0PYwE0uAkLnu6z7m/sTfe/K2hjc87U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwE6kdvC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7f8acc33so65629687b3.1;
        Wed, 11 Dec 2024 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949594; x=1734554394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/fpH6v9netOl4stZyFABUBGIIZaGTv9D9Clx9j8z/8=;
        b=fwE6kdvC1zUoSH91oyuGR51pQ/8Rvz3ooQoZ8m6xtcW1cPd66k14iJ6IBw641L7wkV
         COL/yALJKUwsnyBYQ8eTI+CxiziGnZySCUmg7xpSJUjSv8Xqxx19KaLswLixhfnj9pEW
         uKoZulEtqsFR2uL8WlBXoW+NPdh+HXLK0jselxEprjZd4OSjLmYWKFtOZ1oDAameZMdP
         v9/l+vNam9zuzwswNHJxupbDU6dfuYZ+DqlXWCX86clpmFhaJDsK6bXeJV57POoqFCIh
         rpeSlwjGW7eGE9OyCgpNErh/ShbZq3ub57mWmqRoXggjR85GIaJ3CU7m/f9htO5M9eWG
         mTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949594; x=1734554394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/fpH6v9netOl4stZyFABUBGIIZaGTv9D9Clx9j8z/8=;
        b=HSBazGChW2mLPZi3+RZ7++E8AcBz6/Q56V2WpmDCWe9w3gvbzBIfVb1h/rEwArv9lc
         yx4hlPOUEUJJaMiTkJ7ZxdbVL4pPsq2olbaxQA3IY6Zy4dd1C+H4ZnlKVEoIsxIahUjD
         qE0eWfm/Vseg+SGHMksoPrRiINuMTs6POsPnCuBERyIiBZ250ww3pD7tjFgn81gUgEup
         Cmo0/ZU4Q7o49pPgZTJeCmPObGOB44EVCiK6WoF1z3NoDDyn9Cv/TPsc73+tjJ2O15oN
         0YcRQqQmJwN6G2CvNdhChPDTbKBTIphYgoN/8Eu9bakew8J3wU0Lsnfbbdr6KU0UOs6v
         ahvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/0vvGvYpM9f1DNU24zSSuBQOf66AMJfvGcVhQCyNTRR9u+06/XLmLrOKHOCS8tVBJm0sDOgT@vger.kernel.org, AJvYcCWdX8+DBzMjOH9miE7YZLqHf+0JwlR1saHAxrVcnDS9cFZtfWInaT26pQZ+3jUTdAxu/apBRse99CujKhv2@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSN5xk2AKjcJHpXSCcKORo4fOkJSUZZLTVOFR5l0KbVZI6Jde
	EVwlHh3VdN1p5U1wRD/+YqEoZieS+2o8KCeXWH1VBUpXhMX4t/rL
X-Gm-Gg: ASbGncs0ibqrzmLwBNvdmudii2TqevkVL44jB9RQJklSGCddFKpp+GyKLKdpCi+hIIi
	PXScREqhAf1uLlDTr2qGo04TLR7j+cVx1hlSR0VtDuUsrozza/ogLobKzDhgSDA61MlkGnalcRS
	am3B1th/Ut0UCYKkQ9X8Px8iYt9j3FhoZznZyupYmbqKAmEziilEaDeZN7rHPcZIQawrU6xHVTy
	RrZAuDmfurg74CsLStmn7Su7M3rvs7M6Av4Ykvo5GH5ZawbZZu0T7KkWk7yiTGE9stEgvyebkEQ
	cFIvoFkHQQNUMg==
X-Google-Smtp-Source: AGHT+IFjh1B7FesLgwVZ8NbRhB6v4JhL21WCugQRgRvU5yKBoLTE4Ii4DA6DYdGbfcfCWzLWySHbVQ==
X-Received: by 2002:a05:690c:4c13:b0:6ef:6ec2:ac62 with SMTP id 00721157ae682-6f19e4f2690mr11106417b3.15.1733949593961;
        Wed, 11 Dec 2024 12:39:53 -0800 (PST)
Received: from localhost (fwdproxy-nha-006.fbsv.net. [2a03:2880:25ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cebffeesm4012597b3.126.2024.12.11.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:39:53 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sj@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [v3 PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Date: Wed, 11 Dec 2024 12:39:49 -0800
Message-ID: <20241211203951.764733-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
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
index 7b3503d12aaf..b25eab9c933e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1448,6 +1448,18 @@ unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
 		memcg_page_state_output_unit(item);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static bool memcg_accounts_hugetlb(void)
+{
+	return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+}
+#else /* CONFIG_HUGETLB_PAGE */
+static bool memcg_accounts_hugetlb(void)
+{
+	return false;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
@@ -1469,7 +1481,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
-		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+			!memcg_accounts_hugetlb())
 			continue;
 #endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
@@ -4540,8 +4552,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
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


