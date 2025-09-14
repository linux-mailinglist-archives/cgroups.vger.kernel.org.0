Return-Path: <cgroups+bounces-10060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00DCB56799
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A3416E392
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88596235362;
	Sun, 14 Sep 2025 10:09:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7038FA3;
	Sun, 14 Sep 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844572; cv=none; b=M42s/Duo8YRv3jKK4FowlvFnn0zvKf5UxbBiCO/K8Tznzs/4tvLFaQRfboAAKi2KVu8ERbxBtm9AIhnmuabZYELmbapwkHDETzRxAC8I+cL0xt8HywOhtKiNfHAGo0ZiCSEIsnjFSsqdO8K+Br7TohI9eUinaKSJUWBUqNEL9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844572; c=relaxed/simple;
	bh=M2ThSKpzt7GdA/27mjv6ElG3/dqKz2T0xkiCRUebYSo=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=RgbPQhGaHR+VSN+5pcVKIMmxh9gRPCpbDGzzAox+bHrfbb72TlHQIOggTtSRJvcVsJX4axIbrpFtSvH2LwQvzelYagkAAqqHjtm4tvi6YxmFujZgFZr8NvuhCE3LE4p5Kr0eBVEEElr1FklJGzTzs7Dof55iEKJH9o3+vjt5G8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkRB344fz8Xs6y;
	Sun, 14 Sep 2025 18:09:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 58EA9Mnv094684;
	Sun, 14 Sep 2025 18:09:22 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:09:23 +0800 (CST)
Date: Sun, 14 Sep 2025 18:09:23 +0800 (CST)
X-Zmail-TransId: 2af968c69453eea-683f6
X-Mailer: Zmail v1.0
Message-ID: <202509141809235737ZDUkOKaORJCGqQOQhM9q@zte.com.cn>
In-Reply-To: <20250914180031197jk6ngo5pQjpXkNtNsjzSo@zte.com.cn>
References: 20250914180031197jk6ngo5pQjpXkNtNsjzSo@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <akpm@linux-foundation.org>, <shakeel.butt@linux.dev>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <david@redhat.com>, <chengming.zhou@linux.dev>,
        <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDUvNV0gRG9jdW1lbnRhdGlvbjogYWRkIEtTTSBzdGF0aXN0aWMgY291bnRlcnMgZGVzY3JpcHRpb24gaW4gY2dyb3VwLXYyLnJzdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58EA9Mnv094684
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 14 Sep 2025 18:09:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C69456.000/4cPkRB344fz8Xs6y

From: xu xin <xu.xin16@zte.com.cn>

This add KSM-related statistic counters description in cgroup-v2.rst,
including "ksm_rmap_items", "ksm_zero_pages", "ksm_merging_pages" and
"ksm_profit".

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c..c8c4faa4e3fd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1776,6 +1776,23 @@ The following nested keys are defined.
 		up if hugetlb usage is accounted for in memory.current (i.e.
 		cgroup is mounted with the memory_hugetlb_accounting option).

+	  ksm_rmap_items
+		Number of ksm_rmap_item structures in use. The structure
+		ksm_rmap_item stores the reverse mapping information for virtual
+		addresses.  KSM will generate a ksm_rmap_item for each
+		ksm-scanned page of the process.
+
+	  ksm_zero_pages
+		Number of empty pages are merged with kernel zero pages by KSM,
+		which is only useful when /sys/kernel/mm/ksm/use_zero_pages.
+
+	  ksm_merging_pages
+		Number of pages of this process are involved in KSM merging
+		(not including ksm_zero_pages).
+
+	  ksm_profit
+		Amount of profitable memory that KSM brings (Saved bytes).
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.

-- 
2.25.1

