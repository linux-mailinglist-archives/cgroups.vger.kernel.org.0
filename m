Return-Path: <cgroups+bounces-10280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11AB87D5F
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 05:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A12188B339
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607E24466B;
	Fri, 19 Sep 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YdJh+eL2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34E21FF45
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253785; cv=none; b=lOe4X0+/QTNG1eMPmcllN3WfK27PPmnA9yz1jlplMUHXiuD1nruMVpcxO5GYieH4kyTu9Ky9hL8Cj96MIxzxFXMqzheAy8OTWwTq1WRkSCyEuqfU/NteyALHwaJ/CSc1wUuwViUEtSv2+5TbMCvw4r6gKIfQ8viomO304KVxZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253785; c=relaxed/simple;
	bh=fN41K4+s6c2llu5wrjnSJOVOGZxC8pLWdWdNSYRSRXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiKakpaDIZn3/eKVulmpnZ0kr8H4TnnoSbIWmPItvOZ0TTSWQ4FfmboT/T2uu12DDYmAbYuYtg//vntpCNI775tdh9cwB6jlhoq866Lb257ygEgltC7Q7DbvuYk/3Km4D3lWp1V/CIZdzha4s5D3Lw5Xc3r/sbtQD2VquhQlw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YdJh+eL2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698d47e776so10828005ad.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253783; x=1758858583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qta8j4KZvgpuCZEInGOfHTtc26DcWYqWpsrutb5sExg=;
        b=YdJh+eL2TZ0L8OtJ14r0ofNpKMOnHpM7GwZ9deDd8q+Diq1uNKFgweI2UTTrLcV/4H
         C0RYuIdIqwmNWBcbGkVhrYEgiwNsNpXSakAubXo278DJwnpouT8ITKYFI0/TMb9uMEZv
         9ymRVVZK8pLGeb/C4SxtsxzCVtkn3mCZovy9KTbjfxfRjzZ42EIVGrbPIVa4dbPK8vvJ
         BRTxBakFWiW5MiXHQG2jEakDOk/FsR26qAn7TaC84Ym7H9g9y5akw9ZHzv3sX6ANleov
         1xOAT8e96gDkiqXEUgMIjrgLQ5NbNqsQyEYVFFhAupU+kQWohlMy5/yNBuV6F6XmZiLv
         Kf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253783; x=1758858583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qta8j4KZvgpuCZEInGOfHTtc26DcWYqWpsrutb5sExg=;
        b=dv5Zqf1KBEDZl05iTwCB1c0WMGjrS34vidYTzT+O4kG+b14h9ejnLFQzfARwseYNaS
         8qPQLeggk27Vsk1G3q5JgsLajanVMvLcIJLnrUT7XiCK3AeIn1jmjhA2ZYWc17YZ7Ogq
         LNGfseXEDwd61GYFCCp2AsvB6HUK2lLwKIyoobo/5B9ExJxYczr5y9GgGNvFkTCszIpc
         kibzqwXqzEbwJJ4FBf6uyD4qwI3f75skKn012yaFQpsozfMriEymNCXEvM1VjxVnhkJ+
         30aQGq69WI0g9y1tn2pH32RG8SDgVd46ZdufXZ+q+vwkz7a2hQOBPFJ1lfw5OWl2Vz5X
         sTzA==
X-Forwarded-Encrypted: i=1; AJvYcCUHGm0e1G/9RCN9lrptRVvnytRlla1eindMpdK9A6vInXdPIwM4wIm47favD6BvedLK0VOBtxH2@vger.kernel.org
X-Gm-Message-State: AOJu0YxVn9hZBNzOoMqIaRM7R1jzkZOrm8mJ/0Fag8yTLR31IWf3xQjc
	wNRxZcukpnExobHdfhuPUuwHFbZllsARNVHfPeHtiKTT+Hax8km0RSosK9tfE2nJEEI=
X-Gm-Gg: ASbGncs11b7CAfWabYaCblMy1kHQMr7DWh7mDMrb7+ox1MhjXyX5rsaCjjSkPx1oLfY
	GF9Iy35eLLKAl27Y8jWUwrGRhTbJJ8EhdpGaLh2u9OgPPQvjPUKOQlL5tblY8L+QlYkPQaGRiwS
	KVJRAuv0hkJLnedRCU/5t7NW3XFbspxcILFFg3t0b0italKFmrg+muuui4m300ovpFR8v5xhZ40
	cMYIInJ3oquxjL2RqB3mJiUyeTowf/cDxHRVdiCG8H8u61k81KuNi5WJ2EnC/bcLejDbyolZ1CO
	S6Vv3cQLV9IQlKX5Cn2koLNnA4P81s8X4LIPLtfK3MBGAf4pEysEyK7e4vhIpgTZDNtzeTP5jEn
	qR9AmutfEIqLZm2KV/rHj4i+mqm3c9hbAx3v38K0riMkgxdnipNLdFx+P91vaiHK6fJaGG88=
X-Google-Smtp-Source: AGHT+IEKIcUFF6fbBY5OZR14G5gZ1jT642lbrLvDNjajNIskg3XnlnI32L5cYmFTm9cWzyX4rO37Qg==
X-Received: by 2002:a17:903:298c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-269ba253554mr27527575ad.0.1758253783635;
        Thu, 18 Sep 2025 20:49:43 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.49.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:49:43 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/4] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Fri, 19 Sep 2025 11:46:32 +0800
Message-ID: <35038de39456f827c88766b90a1cec93cf151ef2.1758253018.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

folio_memcg_charged() is intended for use when the user is unconcerned
about the returned memcg pointer. It is more efficient than folio_memcg().
Therefore, replace folio_memcg() with folio_memcg_charged().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5acca24bbabbe..582628ddf3f33 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4014,7 +4014,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	bool unqueued = false;
 
 	WARN_ON_ONCE(folio_ref_count(folio));
-	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-- 
2.20.1


