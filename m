Return-Path: <cgroups+bounces-7450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111FBA83C95
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62FC1B665EF
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1620298A;
	Thu, 10 Apr 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g922euQT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951C1D86DC
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273161; cv=none; b=qjDnVaAlJJ6+M0gTafS1PhF9ZBMWNvEcrdjtm0gGb1K3YjzZjnaQgfnrpB77+JSsJ0/PcTPg6NVZn5qPrNZk/cN9GinK/gySrgN21S4e5E0j6QGYBAoDAKzqIbzWPe+xrSbA/Eb1JJSWgZvhK0oxfo02qPq8bFrkQ1t8qOlcAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273161; c=relaxed/simple;
	bh=nWkV06hzLZs0d4VDgM6vwSU+B51VIwbN1xrlKxQrLmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlz3e0GkQDVFb5OT7GDDaE902ouTxRE6fyPIwJknDnAHMFZfMe5+BJrGfrl3NALI0dZX9IqwNkptP65xpdbypqgfOTrIfHZZtDl3kJNodwa/5ze9Y4ONg7QzEhJmcDePdcpx9qWTR0nQzC0w+0vPDXWprA7voormkQp6UyAOkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g922euQT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2295d78b45cso7352115ad.0
        for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744273158; x=1744877958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WMNK4T/HAXbxP0c5nSxB7WqEQuDCDLUA/LOjFIKTw8=;
        b=g922euQTreOET4oAGCidk9h15LBqjGx1BdtRPrQoBbDNWqiDN70H122gMpO/Kg5BK7
         jo43UECOkdKfF7h3GOx6BUGJmbB8XeiVUAy7JPmPS/md0+6WvSbU7BhpZhl0Ois7wKrA
         gKmv8CPESmvp8IOt2dmDXE7fV+yrI3kUvJ7MsRnmu0EOwc5pOvq+vcTDTk/syEXgtQA5
         OqEwi8ljltABH8vQ2ROqxR6Qg6RmT989Ax1P0rQ1Q1HD9D1cPvlCmOP0Ni4t0wCjP4n/
         4JFCNDK0q+knA+m4uUiZCIECMEyZs2qILILbFpVzxKVbxPtbyeGtFcxydhe2DfVFbcr6
         qflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744273158; x=1744877958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WMNK4T/HAXbxP0c5nSxB7WqEQuDCDLUA/LOjFIKTw8=;
        b=bUhi5qlB+xyy73RKyDim2RbiTvrH5d7SlSZG8tXo1+/pf74S7QIteENN+M2Wcedk/O
         5gfbkXvSxEpv06bSjy2b7ZmD7SOO0Z2L6FSPqydj8Q1Gdrs4Joqa6F69fDY00Yl/41WO
         tFN5ECo1ryvSXvAJuoNZojvUATUc5F4m4KQHlM8VoTbMQv0IlZRE3zk3RwqVXU6Zf0aw
         Rv+jI5m9TcCO1XzKSLGEYDs+htwWwFLD0kUE5YVu4wbe7z9X3i36DGjnbwv5ONgLods1
         LD/MF4IoiRfE54JnFGtkCRIu0rk0W8vN5zh3M8wh974l46VGE2CTb5w2NVsuo7hr1HTS
         YjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCFStDudWw3Z0DiKPQqVwz7Pdcfks5sd2MvSPVNpH87zZq29bT2Ov3q2IXcalB0S8vGVNLH5Kj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bK8lGLF5kS38eTm6WAhWiJHJ9Pot2PjbfviVjmiBxHUoY1vI
	sQVhdipQofk/ph63QlqM0OpsS2VAhRubSKvvKE4PTK6xNqxZz0jBhYKUvQon6fI=
X-Gm-Gg: ASbGncu4rBo3Zc4KQv6cK4tmOH+kvqqn2CbO1svMhH37IxB7b/MTNMX2CvteA0Sql+o
	K7fYw5Nyakg/LaPwYHKErExrIycFM4z8K5HuIS64hiNrUH60nMr1qBViHj0EeiPum9v2zMSNSUo
	PDB3G0mj1Qfl8WX3IuQNxuyn5BWE9iVVDEubkDDD+LKU7vRjVUfiluDIzKT568f/v81fvwbAWvw
	Pf1JwG1rP1oNXZDCFBm5Hjj59BQskav8kwFazmbvgTKIkMTHE7tbpJ58WtH7UomTMmSM02b/4By
	E2ATjbtjrLA1nl97WQAD3rwB6sfxf1Fw3yEKBWHtMYtSFUGviBtHEGIdT6ixpyQWDhY6vzQFPw=
	=
X-Google-Smtp-Source: AGHT+IGtxCPcjlOxTXUr2/79MqVJQWBnBVjOCUpd/dINEd2Wk8WKKzYVYItvH6r2Re1mb6kWmGXZnA==
X-Received: by 2002:a17:903:2a87:b0:223:fabd:4f76 with SMTP id d9443c01a7336-22b37e1af80mr28407585ad.30.1744273158539;
        Thu, 10 Apr 2025 01:19:18 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6284dsm24806755ad.38.2025.04.10.01.19.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Apr 2025 01:19:17 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
Date: Thu, 10 Apr 2025 16:18:12 +0800
Message-Id: <20250410081812.10073-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 73f839b6d2ed addressed an issue regarding the swap
counter leak that occurred from an offline cgroup. However, the
commit 89ce924f0bd4 modified the parameter from @swap_memcg to
@memcg (presumably this alteration was introduced while resolving
conflicts). Fix this problem by reverting this minor change.

Fixes: 89ce924f0bd4 ("mm: memcontrol: move memsw charge callbacks to v1")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 8660908850dc8..4a9cf27a70af0 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -620,7 +620,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
+	swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
 
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
-- 
2.20.1


