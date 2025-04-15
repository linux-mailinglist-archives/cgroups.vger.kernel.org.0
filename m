Return-Path: <cgroups+bounces-7560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17856A89220
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5733B693B
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665F219A86;
	Tue, 15 Apr 2025 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JZHSpRdH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB115219A81
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685234; cv=none; b=moMnI4yky6X2rdDUcZPcgU8rvGEsQmLWxj6BG/PWGFsHlt8qmRyyQWqREGQZYcdOTe9akOcGj7RRo8ykXBinNfUBQAe3qaHircci2R8x5QDBaztQ+q6hdJdCq07tSqDE9UVCk44hIM29wbRL5X1smiqRX3m6vSuxpR3PvO6b5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685234; c=relaxed/simple;
	bh=HuKS97oFEuuG+wDz4Y7AeIlRQjvWQlQVDlFIdpSjOu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5unS+G/dwTWrO3BE6G25OX1IGu5t//qqJreP/cqsXaLEIuUDin6Nug8hPG7KpdvvFQTW5/zMOTbbF/vwugCURu9Y0Ri5JVLde6Zu7r6wf9DRgyU9ndoDRtjf1vN+jomKNBll4Z6cKJM3zMED1JsFztIairRn+HjUnQCe1yWoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JZHSpRdH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227aaa82fafso39527965ad.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685232; x=1745290032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg/Q9PeJ3a0fPq4jQ400Y/OgBu3oFR0wAT2gCDp4D5Q=;
        b=JZHSpRdHY8uZnr7Uac6F8fijK+voc0kTBhBrjdqHflYMBvGApQUQUWAD2KfKT7C/f9
         wldL4VW9zYPnaOLjIO/Gm1H8DKySvpx2sYl/6PT6GgBmFXBFLmpG10R/TKWcKJj/IpW/
         ZKcJdnfeevCyReCdlKNKb76+XoEpdkO+XqZCDKukOPbpadaD8TbjByKMk/a25Kn7Nb6J
         ENePShNAPX2HcnstFCNwSete79gBxnKjQxWGIWcEbdQyt5nkueyce7Nw65z/pWcNH8Wp
         YgievKHSiTlOco3M/QbvMaMQjFX0ArQLzZdNt1oNWVcKpEk0ZcMhmlfobNv6japNXc0g
         Jt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685232; x=1745290032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg/Q9PeJ3a0fPq4jQ400Y/OgBu3oFR0wAT2gCDp4D5Q=;
        b=S/+14TBmMkPcC7xxx8pTeEatwxAHF4uFv9QQ+H4BFq18hGWoYLyW8HeBs++vECImri
         u5QQ4RsM37D2ZZdv/1Z19TH2XeIE2OMWvTV5xdgEEoVzqWnmImR34gxmPs+BBUwA8Zl+
         tAQgXi3jZMCc0hZhSnueG1wi7NchObzWsL/qmnSF7K1ObyGpYAOPm/qhui6c/CQj0Eri
         4N7NlPOQnVuR1zhc9ht16gpFEzp0f+kGY9Suws75k8Demjf80wiUTcqb6HLy6fWh3jIG
         KKKXfiYFDNrEFWpJKsCwnUMVzP13EmscsBhLTh7mGFNub4m706Ou3AkYSbs0HuJ0xteq
         2VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0iEhpDPe/TTkRsXlacbuyBtC0Vhq2d6nnBoL7sqKQ3rXdMUdmoGzLn5fLGBKz36a8IYgw9yhK@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6KrIBXztGeRMdQEizYHT/aepKk2sW+hkt1ToC70n7/Ld0p5F
	95C4KIVcmh5nkXtYjjdUy8e+gOJg24a0ty1GIVSyVIq5Hdw0PcTDfoy7aVvYB/4=
X-Gm-Gg: ASbGnct5+6wlNQz+uzJYMC5ZMQB1S4DH5qUSlXhna+6TaFU5bZf6m7OG8luVdviMl0e
	3Eo3NgvMeJEGZwMd4qbnCvyxMjiFag4kv877lTbBRNGI99NiLWC7cyKc2+1MS/jhXu0pth2uBVr
	jGoh8G6zkKq1vHtOR5irsUzytmCFh3kCVIMyG/4/szDbS0N2eh1kea/yUG0csEew5t2xPKnZ3zA
	ab4JyN7jogcnU1GdMHW2C2Nku/gNr6C++rmb5wyd8/UM8I2XdJnn7uHEfoVWhlVFyBz1hA4fZb0
	i+Tn7nFq+4aHDOvcX61Egn4cTW9iSjMPFiifYoISxpduDA42q0VkElqkUUVbe5/mtzlsistrhNJ
	szY1Vx6Q=
X-Google-Smtp-Source: AGHT+IEzkWcKa2ct6W+m99WRXOgiOEymvJ30CBNBOfWjsGr2/iLsdVh+Li4JvemGEyYH2iRVm2MWrA==
X-Received: by 2002:a17:902:d485:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22bea4bf561mr197033565ad.27.1744685231866;
        Mon, 14 Apr 2025 19:47:11 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:11 -0700 (PDT)
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
Subject: [PATCH RFC 14/28] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
Date: Tue, 15 Apr 2025 10:45:18 +0800
Message-Id: <20250415024532.26632-15-songmuchun@bytedance.com>
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
against the release of the memory cgroup in count_memcg_folio_events().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a9ef2087c735..01239147eb11 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -978,10 +978,15 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
-	if (memcg)
-		count_memcg_events(memcg, idx, nr);
+	if (!folio_memcg_charged(folio))
+		return;
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	count_memcg_events(memcg, idx, nr);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_events_mm(struct mm_struct *mm,
-- 
2.20.1


