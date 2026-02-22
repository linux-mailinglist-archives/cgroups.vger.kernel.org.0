Return-Path: <cgroups+bounces-14110-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPxNHOfDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14110-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E174F16EB03
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35715306C7D1
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96486218EB1;
	Sun, 22 Feb 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NWrp7Hpc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A3223336
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750172; cv=none; b=rRgQTPl3gsFNJgJrOuFkZC8o0c9qErH4D8mQ7axKRugwSVP0HJob5holpjqjy8RB/s4hHBKTpLu/3nlnIzi/qBiuYmuislcJqV+67qqRLDB39BStQgUFefhDXHnRP4oDgJIyjHwIP/I3HcQzLYjYTpRG7aPwiZzhNHZfqkM35Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750172; c=relaxed/simple;
	bh=fY2O2ukegsBDPZTxA7RgjpegM4UC0FoSjHYp6ZA4CME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2I+U07Z4gQUyGM9s4/JIc9rBuPa7c5/4BuFcQzn62WibAvGmWUDBCOrPSjTUFfCZGcCMG/tz36Yqm+QU5m5FRtEw3hoWXQkwEnOa1sZw216Skio1aPXt9aLOJGmT5BrQR+0FPoPhm9Zn+SuOUZz13Wrf/sfsP0v7kpo4GYR4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NWrp7Hpc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-503347e8715so43170911cf.2
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750170; x=1772354970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=NWrp7Hpcvpj9mkZbKrSc0+P2vmdVV65cXSZPjH+K2Xh+NIPAfvZv+vXn493H2JUVGK
         T+4IlHJrum2kMjxxdrho7R1HzdFdlbOHn52axMOxi+/aLi7rg1VbMIkGKaFgclTaAdq5
         TkKro0I9ybhO7cvYf9JxuGiLVBVlTjJvkpfaffqxeAFD1gG+4Afr5agcoSt87ynUDttx
         gjsL7v1JhGmXCPFpqnmNth/ykpxkv+ePTr0ikdfRbs4URShBKADvBLf48Y9emXLhteyK
         GF+doUpTnEg6Wx8nQF0SFOhkJFKLVjwM50YLYqUQBOle4bItkN5G9xZdpmQZ6FA9pmmp
         xiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750170; x=1772354970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=xGeDn/yf6cHUJV1Rjr++VNY3T0PAv4qg5cfHSL+6SqZTcYfRq1hjgRvn8Jymwu7FVI
         O8UxacNUjTV3v+eycgVO5GusShx9I9MWLm/9L27XNx1nLLuLtnTqqt7vmf3ybBuWFucv
         YrEm34foWY9xlABjjb41dn7+3ZJxrPGOfkL7piE81nmvBpnuBmQkE6O8oU6LrAdZTYOh
         +EDbOyBx4wYeAr4jjCNC4yp1yLIRdJ1K2g6KUBa0cGhchgPzIPQjvVcA+H/CL9Kcc02+
         NBl1UnxbXOjlv2Y+znv3MEjB/DDK5kCgfTo0cCx6Xns1zo5PpOsw18X6VJQ/t1RrjXB7
         E11Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQwRiAzQp5f8iPy5wGXgCnHxHTyTQe5XMLm8Ne0fvJizIfi6ONiF5pR0sxI6lK64TSw8wdK19x@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAwHoSESFkKwxMLL4/lOjUzJf4r+C0NPrQsY3onucDRNBPbvY
	vfdhO9e5WUt13jflpBv7JcXwzXIBwkaYz0tEc7LB0KgOSTTAilb9YEc1vuqJSvYKFvw=
X-Gm-Gg: AZuq6aKMszUu4sigB0yErFRp3H99byZ/f1PV4uFUGn4p1fD+3we0TYDUg2PD4VqWMVY
	MMcHWzWPYqAFCIZ7Os7f9wShy2aArG4ZcN19/mWfOOsU9zUiwxJV6UhMBI+/IdxzaMBmSx3/59F
	oBHfCXRSWJ3o1SN57mvPwzByNqNIa2lQwfcYwf1vvjUmWUBrx9cuJrCvM/sCQ1pUk55hH8DUrwn
	9SqXOKPDBZTcuORLV4FrEKFBEKEWv8jmVuVnZEkTHLYr+9F3DHaJyUjLDHSwrtELiqKSDss0NlU
	aj+8De26zaUpJXeqENIUUslrNS4RXT76StIqXV8mI9naOBCO7AJIYMhF6lG7shybS4qBrslHs33
	3/0aW+dCsS1rjYPzePE99XA1uBl29Vk6gRnQLztiArQrNp2WbxDd54W9Yd2geHbd6QGbj1NmhzN
	cvagpfsmaEnjHk1oH9QYzI2kH8e0V2uJ/APSxoNbR5GOfCFUOua5rAD1gk6xM3zZcjkjXYG3TPJ
	0sB5M184akIDAg=
X-Received: by 2002:ac8:7d84:0:b0:506:8a2:b1ca with SMTP id d75a77b69052e-5070bcedb32mr65601961cf.73.1771750170035;
        Sun, 22 Feb 2026 00:49:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:29 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 09/27] mm/khugepaged: skip private node folios when trying to collapse.
Date: Sun, 22 Feb 2026 03:48:24 -0500
Message-ID: <20260222084842.1824063-10-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14110-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E174F16EB03
X-Rspamd-Action: no action

A collapse operation allocates a new large folio and migrates the
smaller folios into it.  This is an issue for private nodes:

  1. The private node service may not support migration
  2. Collapse may promotes pages from the private node to a local node,
     which may result in an LRU inversion that defeats memory tiering.

Handle this just like zone_device for now.

It may be possible to support this later for some private node services
that report explicit support for collapse (and migration).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/khugepaged.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..36f6bc5da53c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -21,6 +21,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
+#include <linux/node_private.h>
 #include <linux/pgalloc.h>
 
 #include <asm/tlb.h>
@@ -571,7 +572,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1323,7 +1324,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -1575,7 +1576,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		}
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+		if (WARN_ON_ONCE(page && page_is_private_managed(page)))
 			page = NULL;
 		/*
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
-- 
2.53.0


