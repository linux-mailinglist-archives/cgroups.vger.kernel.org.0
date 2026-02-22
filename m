Return-Path: <cgroups+bounces-14105-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePI/CmTDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14105-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:50:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887516EA8E
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFB1B303933E
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4621CFE0;
	Sun, 22 Feb 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BwR5OqEE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF2214813
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750151; cv=none; b=PubL1x59tHccWW4TpwBN/rboaaucfOiAc/xyVHRAHfxEhJoQSmPaYsjwG7K+ERxpZU1pDmRXApMAncXaqS5e8UkOqe/THH3XcBaMP43rbLCbbyj7rJCgkxgVYU/5NWleee/0yRC2nx2bHOtHl8gVBTVNuqbxUvzt0IEzJPeSvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750151; c=relaxed/simple;
	bh=o1uIXG0iQdOCtI30tu/L41w3N6UZHqstojSncqQCHfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L44VX/NSYn4u49VvKC3picRaTnSEFByLIGl/ubWXDH6Aj2tdTL0BxpBKmsg3ypFAjB24iGXPa19ymkJJTM3pPPsIrnoxYYUibDRpCk4c+iDcBHSI07c2uMW+jOm0dEioUGPCG2LtyW34bZcympUJmVKslzYdb1RcNqNrp8OTcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BwR5OqEE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a747448dso28328841cf.0
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750149; x=1772354949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGcIZ9Wm+WSSeosg9CDJTkTmHYD7k8AbIJs84ojn3vM=;
        b=BwR5OqEE2Y8vC7qmhlGoGNrr8k8dZ3djpOE11UwLN83Ev8kbqqjme8p2bjgZtAolDv
         lq8PNNmXflFihcmSfy6XKFT4vS7n/t0YjGT7NMDFOJYUVXMlL4s3FqDFE903/pRst9po
         0MR68OM/qO6d/8LCohX3Sofjd06NnBzQDJncqLi5qRJIWXatZqhV0TzGOCS61ZaH/Ugr
         eDc08Rh4t/6dPPjJr8Odt3OqFWLSJN2v2L7qPG2ksqK0ODxRna8Rrl2GMo9qrPhslLSZ
         jRzowAtXcFbwsUwP8mhyhstAFbGS9kkgTu9EnUNPaPlntsPukVJiaTPL6qJYmhG8cxrw
         lETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750149; x=1772354949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGcIZ9Wm+WSSeosg9CDJTkTmHYD7k8AbIJs84ojn3vM=;
        b=veP/Ek40Nj7Ec4hp8/u9PX0+lCjSgLFiTdIuvmo2T4irJrUnC92lZS2fWPSWO0uVqC
         dz9oLzTaNr0OZGZxyubSA/HnEboKn9aqd5fLmRt/Mq7YPiAuN/aZP5ZRwkH45y0INW6l
         0KZrfZFObgvTZs+t1bJSLAsMuk78ckv2mMK6xSLgc2t41fNsTqddU+DmZguYXeli6P8R
         32W+nJFVrn+1F9iP/IgImDmNT64MXDfGEdXl8N8SMTSWApS6xW7zXF0k+gPMG9Ilrs8p
         swLam/RZpXXvVo3DjXj49bvj1xKx/FXU6ETRiBDJWDsU13MuF5L68hRZjbiJcdjnJyR3
         z6/w==
X-Forwarded-Encrypted: i=1; AJvYcCWe4elPD0K7OFnF+j+vYS/9NKZ6lcFDsPyJ9jDaN/QvDKzxbFE/iJuK1dc/FlwRATEnylbqbH6A@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjXdB4etr+A+qGMd+cbiKWoURtH3YtTb7//N80ot2ELzNcnKm
	Zg5NjrrM8Ng8riIoqhHxafqY5mWPiyP9iOGlhMHI8WKFmpemgtCKhJ6Lq9BxTcNMKl4=
X-Gm-Gg: AZuq6aJfbHMpoS9lh4baJ62aVqFXet64CiC8izdVVQ097Dai2PVksN9Xma/KbT3W20R
	HpO69QEYS/kE3cv3T0aoCBCDTb/sm3VEcwIrwiopzxsqhuVTrDDcp/oLMXajdIkWzqlC9SEDxj8
	7wf3X2mA49Agdp3oDu47hJQpvSzjfqaWVJ6sEIJFqaJL8/G9Yh8hWiRyAe2beoHaBLdWiHDSOXv
	iaE76bmkgAutqs7HGNC6c4Ps1eUUu/lSSegYXYrT28Cwm9/YRP5f+Gcqy+PTS45YVijo3lznCP8
	sfFyaKvueAO4jRTGjxdFi1z2R1eu2ZjZoM2sem08fx2p02UECCGrNiW/KTSKFLHSpYxlv2jEZYA
	DlJ/D/9mQziMvtp/gHaHWJE5wy9nvwjezLnkrMh+fnywPednTi5bEyYazIs07BUFS+dj+KP45YY
	FdzJUCLQojh3gAqMtoSTbiLwFt1Y+dcg8Hj++z9Ua1LJO+N4gwaByo9M2/cah7I5j0CdDPMStnQ
	HXXGjyeR0RXTfI=
X-Received: by 2002:ac8:7fc9:0:b0:4ed:1948:a8a2 with SMTP id d75a77b69052e-5070bc68c0cmr70819951cf.40.1771750148853;
        Sun, 22 Feb 2026 00:49:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:08 -0800 (PST)
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
Subject: [RFC PATCH v4 04/27] mm/page_alloc: Add private node handling to build_zonelists
Date: Sun, 22 Feb 2026 03:48:19 -0500
Message-ID: <20260222084842.1824063-5-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-14105-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 9887516EA8E
X-Rspamd-Action: no action

N_MEMORY fallback lists should not include N_MEMORY_PRIVATE nodes, at
worst this would allow allocation from them in some scenarios, and at
best it causes iterations over nodes that aren't eligible.

Private node primary fallback lists do include N_MEMORY nodes so
kernel/slab allocations made on behalf of the private node can
fall back to DRAM when __GFP_PRIVATE is not set.

The nofallback list contains only the node's own zones, restricting
__GFP_THISNODE allocations to the private node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47f2619d3840..5a1b35421d78 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5683,6 +5683,26 @@ static void build_zonelists(pg_data_t *pgdat)
 	local_node = pgdat->node_id;
 	prev_node = local_node;
 
+	/*
+	 * Private nodes need N_MEMORY nodes as fallback for kernel allocations
+	 * (e.g., slab objects allocated on behalf of this node).
+	 */
+	if (node_state(local_node, N_MEMORY_PRIVATE)) {
+		node_order[nr_nodes++] = local_node;
+		node_set(local_node, used_mask);
+
+		while ((node = find_next_best_node(local_node, &used_mask)) >= 0)
+			node_order[nr_nodes++] = node;
+
+		build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
+		build_thisnode_zonelists(pgdat);
+		pr_info("Fallback order for Node %d (private):", local_node);
+		for (node = 0; node < nr_nodes; node++)
+			pr_cont(" %d", node_order[node]);
+		pr_cont("\n");
+		return;
+	}
+
 	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
-- 
2.53.0


