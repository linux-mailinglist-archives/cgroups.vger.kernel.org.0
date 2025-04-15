Return-Path: <cgroups+bounces-7549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD1A8920A
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7078A3A788C
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807AE20C47A;
	Tue, 15 Apr 2025 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g7TnzUTo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73E2066F7
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685174; cv=none; b=iWF0KtDRF1Ag72ezFsqLoi8I+qnUFLHqTIMFs6/qktWmRHdW9rrGKrOVCBsJB4WQM3pDISFRy5Jk7Tl14/J/dGomd1cQb9jRFD4cBQH2iNlabYSriEOQHhRKpW8JQcbLe/xhVGNNwEdR0ADietNM0xWECgw9Cz3BYgb+j4lRO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685174; c=relaxed/simple;
	bh=coPa0VZ+lz8ATwbtZkKdsUxWQhC+KKG60nOSR2hGqUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQfYYDUj3r4uroeOEJhphuKoJhWkrKROltRy5O1UpSzIVYrK9DoXP6y5nUGrNv/i/MJWNL9EEsekPwDfgUZt0mpSmaXvy1enk4R+TAbyNxPboNrG7rBG9pEmx1/QXMcLh54H93iAHxm4QRSPKLBv9FVLMI3wYyeSHph5LLemQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g7TnzUTo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225477548e1so48378065ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685172; x=1745289972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxEqDGFZMUmXVsS40Ac89DQGDSUswXt+C8ij+v7lQJA=;
        b=g7TnzUTo27NnuNpVdGbuY2kPLu+ed9HtSEaBn+VMpJZksRwEKRafjaQzmAkmtk4z8v
         flY8QSCqyV35m9dLFRN55bfxL0rw2k5or062olD03Hn1BvEVmPEkvbUq0ZFDbdJz5RIb
         pbBmUFeyLOqEdqdt9/2+VSItJdczW4ESgtNKUxk+KziSBkcx/XWWaxQVJ+kKtIUwGVdY
         TvjA4nNb9d+/iqyChMhFoAflXuJIaYbfsaiKY/RgWC1NETIn90lEzQesRzX8JBLyYXk3
         OFc4eT+FBOYjSUPkLIjMOHLFlcnyMkQIN+edV5CrspNcQARFFZutJPiPKJ1Skd6+iIRz
         j9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685172; x=1745289972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxEqDGFZMUmXVsS40Ac89DQGDSUswXt+C8ij+v7lQJA=;
        b=RxZoMlm7Yzm/gULiWqHH3jFgIrYpM+UgIbhpU8s1J4fDL91N7obb+JeragCKqRUJs3
         zPcK8+BzW4doWX9HZduUJUAmnpeq4hDdyjGykrBBwUo+Kxgg6V6NKwKveetuITHpQhcM
         zzH4kP9HdqA5X8a+xRfwBwKob4pap1X3s0c1w9MKznZzUOln3D2y47DxVaCMyX1xOb3s
         vukeoE6ncdcKsh8iFuWcKReKZv0FJTxj0puQcl9FhIjR742kuxUshYF/1CMXHJXEnXIf
         c4J32zHY7KRiimIjVEAOWTX+HSu7EYseRfiwlB629BGruilLtzDjaJleSY6TKwW/xd9w
         BDLA==
X-Forwarded-Encrypted: i=1; AJvYcCV2mfP0rQ8jv+Z1LHxQCpuzLkncgUgx9QK7ikcWdCUQ2NXcYwXRT0S5GLiorQgTxd1P5CPZhc7X@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgcZni5G6ytd0JuCu7KZJmc6lSxksE/bfTdDUkII73CtuCH+C
	vr3rx33GZ8Wfo5zZfkQCbXWl4orTIjSio9/IKH+2iGIlOLuB+sDxoOk/edWzf7k=
X-Gm-Gg: ASbGncvhtxeRIp01lPNljyAp4TSH5VZLIlfR99seASvrQH4ex9bRESOTfNnHgDvPJm4
	lL0VdBSANEtfqKv9H+886EubX/TbSnzqKOTuDMXt6x1fhWGMwJgoLLuNYotiNadVH4qbAGQR4lx
	EPSX25KPHLKkQ+WsgznTwu+P68YkKe5EGvnaBzECsgCpTDFmleZYXwkvnr1ajCshFJRDp/TzeYO
	mY30IWWhyhN6Ra/vdCZaydET4VS488uqJhL2UiyLkrp08nfQ2g5CLnOtAnShFA1WrfJDrnUxvEj
	Q2ygMYyDTrRgO64NkX2edtmVS7j+Zb+1qM4hlcb+aEftf0zfDvTNry6t4CfdUQ1fxVjzgybh
X-Google-Smtp-Source: AGHT+IEIXidh/WytIqsVeM73H2bfcV0T/EuPMcTn2oTZb/fVqTSwur1YIJZD8NROyg3NAghPl0x8VQ==
X-Received: by 2002:a17:903:228f:b0:220:bcc5:2845 with SMTP id d9443c01a7336-22bea49548fmr180452435ad.7.1744685172229;
        Mon, 14 Apr 2025 19:46:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:11 -0700 (PDT)
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
Subject: [PATCH RFC 03/28] mm: workingset: use folio_lruvec() in workingset_refault()
Date: Tue, 15 Apr 2025 10:45:07 +0800
Message-Id: <20250415024532.26632-4-songmuchun@bytedance.com>
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

Use folio_lruvec() to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/workingset.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 4841ae8af411..ebafc0eaafba 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -534,8 +534,6 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 void workingset_refault(struct folio *folio, void *shadow)
 {
 	bool file = folio_is_file_lru(folio);
-	struct pglist_data *pgdat;
-	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 	bool workingset;
 	long nr;
@@ -557,10 +555,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * locked to guarantee folio_memcg() stability throughout.
 	 */
 	nr = folio_nr_pages(folio);
-	memcg = folio_memcg(folio);
-	pgdat = folio_pgdat(folio);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
+	lruvec = folio_lruvec(folio);
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset, true))
-- 
2.20.1


