Return-Path: <cgroups+bounces-2778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A78BB9C1
	for <lists+cgroups@lfdr.de>; Sat,  4 May 2024 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55586B20E8A
	for <lists+cgroups@lfdr.de>; Sat,  4 May 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37B12E48;
	Sat,  4 May 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKGbaUgh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A68BF3
	for <cgroups@vger.kernel.org>; Sat,  4 May 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807850; cv=none; b=S0evvrZfteqvchYMHHuW1u0/f9daeUk3Bzj1BYe/VSNYKB71SY/LB2ALbgSWCYcnJp+JU7BNutp0v/V0pUS7xIoXotT/JRLT4Rr3Cz3ktsgMttN85/Ku+E1MmoxrW0LQKQdtlcXdjgAcgQZEdoaw2FNL5ig5zwCrcOGT/WJTP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807850; c=relaxed/simple;
	bh=ZKj25IG7pniPh/0wD4wqB4Mjlk8/8o0tO/bn/N0I1og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOYAnSD7JarvEiRFfuFpVWfr0dg32NcjFy/B1LAgqlRzvPiD7edX/OBYdt4J5gTLt44EltI5RE31eleenXlDNhmS8q9xXAZIcY6U516kQz2Jp2OQxiN+436/F7Q4+YGll1HOnFxnCI6QgVeCo8mYwrysvHXvEzZ//uLnRx8e0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKGbaUgh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so715452276.3
        for <cgroups@vger.kernel.org>; Sat, 04 May 2024 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807846; x=1715412646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRNmge9VPkattIC8VKnofvZP4QSD6CRqtGoSzsf/P0=;
        b=WKGbaUghCePr+7vm8VaXl/hEEFNeDzPpg5jHtvxl4c+dJeKXQytTjo+y7mGJOTAq8v
         kJbHZSat6NpBXYtCJ+6eL79OFyjP7ZLDsMW86hA2SjBtmFov7PytjtvlIDg1wkBNUrtd
         +121aYx6ljjiDUDR6PT/Esn81Nee6Y7Ji6gy06YitZiYLrriLDlijTWMj//0WXK+vALq
         g0nchDQuP3B7+hcOFUe+dNl+xjWnPhvykkRqxoqhuES+qYysp18W6RaSoj/p8ZP6ceoH
         acw39kIHwYUqnwYNVlyX2xB+mvMyDMR/WptVabehO+JHxsp73O7/icXoDFPql5YK2GJk
         M4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807846; x=1715412646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRNmge9VPkattIC8VKnofvZP4QSD6CRqtGoSzsf/P0=;
        b=M5vfc5WridE5RHQ/nsZrleGnQKt65VJrLoCy1gU94Ww742m8wuf/sFhtx4syXq08Bf
         xGRfODPDXze6ucuOUDOERyGgnhm6us44wmnGgwDfD+AQsvcmeVfmLJylavwcQtzu6f10
         n6YCnIIMdfpMH84bFK34zCNyPZjQGgtnTjSSMCp7b6Ykk0BBG/yzMV8apmz+g7DH+o2D
         FDVb5djN3iLC3syj7dklLljZiqwuMvtNxgBZx6ubT3uaYtQFoMSX0olhvVPsVSyej9Ba
         fD0FYEOw+k3OJBcU37OrnR2qfs8KrqOKkHxpIw9BkfkY6OEBl3xFhoQEsFD/q520n4g1
         IcUg==
X-Forwarded-Encrypted: i=1; AJvYcCVPaSsOMjJoP20GLrH42fL+NMQVG/349YVm4qdN4YT4focoBp+U29lKTShfXLA3R9hYHvWmlmjbfZ0wpQLLKAagi4cTo2mzOQ==
X-Gm-Message-State: AOJu0Yydjx5cPSLq/V907AOVWc69LIrAWykeN1iWx1jb9OpbOBUGnBAe
	ktPtHirODzKSdWwd0jTyLq5H4GI3cajoGLBWiWkBM5b12ALJawo/i01JEFqjV3i4sP7Xt9dGRcX
	lh9vqXA==
X-Google-Smtp-Source: AGHT+IE9krkIkSbJnvwj2NL+PSHxSR2wSCv1KndjNbNT83C6ldeF/Rb3CC7Y0V2+f15W7Gb9F6OShS6x5yDQ
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:726:b0:dd9:2a64:e98a with SMTP id
 l6-20020a056902072600b00dd92a64e98amr544178ybt.9.1714807846444; Sat, 04 May
 2024 00:30:46 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:05 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-2-yuanchu@google.com>
Subject: [PATCH v1 1/7] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the non-leaf pmd accessed bit and ignore the accessed bit on
the pte if it's on a different node, skipping a generation update as
well. If another scan occurrs on the same node as said skipped pte.
the non-leaf pmd accessed bit might remain cleared and the pte accessed
bits won't be checked. While this is sufficient for reclaim-driven
aging, where the goal is to select a reasonably cold page, the access
can be missed when aging proactively for workingset estimation of a of a
node/memcg.

In more detail, get_pfn_folio returns NULL if the folio's nid != node
under scanning, so the page table walk skips processing of said pte. Now
the pmd_young flag on this pmd is cleared, and if none of the pte's are
accessed before another scan occurrs on the folio's node, the pmd_young
check fails and the pte accessed bit is skipped.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..1a7c7d537db6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


