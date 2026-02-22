Return-Path: <cgroups+bounces-14106-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFhnL1XDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14106-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:50:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43516EA7E
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FEC73021C0D
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D1204F8B;
	Sun, 22 Feb 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="o3cWCvJ2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCA2147F9
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750155; cv=none; b=f6RI1khCXwWtPoLkaXfzy4+SuiZ0CmRZYpiMU00oC/It2rplF29F2hmFG0aiDq0QLxgG5XRkq+5fbUakkSxpLSadYj/K89Q2CbF1vGY08Lcouhq1mfOkDTjKYWletqTpzsMbQzT3JBSZlA82y28Gn3YlrOi1DT1DErAiL4mje+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750155; c=relaxed/simple;
	bh=MuywZZqjbsDPW/ovI/OCTMqxWg2NlbhEOkNx8sr65qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXA4CrOC0V3OGqzrA2hkasjxcEJvI7KCKsQowUv60jXY1ZT3iLmeIEe3qqKdjgukQ6SOt7Kb9hUWV4dp9J9PWVdrHYHmLmSV8THNVg9KllZVOM2RkShrTsa7EKZv0U4LD+GH7kthuWX6Ud7jBIklktzln5H1qy+RS4JaCZrlpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=o3cWCvJ2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506362ac5f7so32421141cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750153; x=1772354953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=o3cWCvJ249TD53qdrNw3U79RdwQQzHlb10zj7cMr6gbST/FXfVXE81zQbxwhIW1XNJ
         p0Fgy42nooHtKhFwcVgIH2IdA2R13/MhC9DNZag5qhYC6lQy4GADcq1XX5lBsc2ogBfc
         U0ADrPLu2Au6b/0Br7BQjlNT2fPg1s++g7dJoc5nKZ6xS8wKMqsWLDWS8oE0m37YoZaz
         fI3Mkg1UdxOjEZ5oy8A+j4pGdB5KJ8PqHO62z5tB2hwIY2MHjdy2qd/7KyQpTvKRsBgc
         YM1T3mKrcnNQiXVsE0fS5LLB464q1c2bBPd2k2w37Jg1s+ygUPBHUlagCPtaIfXD19OR
         Vshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750153; x=1772354953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=KzlMtemz8H1ai4rboF299CLD3eF8ISQFDekHrtIh559lX2joGXRzbNOc2XYi4/syoM
         T1N4PmoQNxJdHjAmHu7HLAmF6ksWuB9MUy0l97boekHME3okxx0l6Nd6BZJE6M0J9heu
         UNCKFHSd22IMnkiO5Xmgpx/xeYIm2n5cIlyQsLnPzfa91xtiRRD2f1I1KRG0OBFuhC6G
         G91wq/1mooHMCsr7OgISWdIaFMa2GIqKWrHyCguEkRHyGrTu5GLKnHIKwn4xiz3CwYaK
         nftmxZfgepDKskjlaMYMPw4OmMU6zCbOB///9TVxohGvGxQKBjwSeU84q0zDftDq+A9L
         EWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeE12yl8fs0KXfF+nAdfpcAjkDwdtg8Mg5bjH/QEcOW0CVsjx+7p/cEwzEQB00PYscfUSpAQGb@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUWOF8Kz04FR3WCzjGZQEQsrirMx65LkmAlYBuojTv+NHlGhl
	dsm9/93HA4k2gzVxwGu/PTTm+CqjtbS1Pb1pfwoIflGtf+/JMV4qu08UoC+r61oVx5s=
X-Gm-Gg: AZuq6aLI1pwGaY7A+Ico6SdVSx987/HzX2Vf8lLZ2XhAJ1IkBd8kTVZw4DXskFR+7kA
	kRC0VY7JfZlCMHiD9sukqJzLXJ7aRjoR4jqKQifICUOJUW7GZSOoFqnlwt/MBGJFY3j8UrdJ7AA
	7G2nf1sn+A8NJo4aUK6LsHGdjICac8q6kWP2ZDf/jW2D/5CaxjOb4XQd0PB/naD0Nk+To9B4s3f
	xImZ/MGSH+NZEgfiQ4n/N/1+hqCQ8bEsWnpsQ2Zo8xcj2VXzR7fuuFRGe+Cs6inD59jM1d2Qj3p
	HnYQac1eWjwdaPfptUaR9zYISZv7FSQjPaO084v5ERfrot3jgb2hHN6Aur9jizeLjFuy/smv2pJ
	GnOek/kNp0Ccv/uI+I2MRd4Ko54anMafGJ03cfeiDtDYT0tTQMxCWL5qYtctr3/6Oa9A4PkZs68
	61vJ88w6ptXBNsi+7JYgHoK0QuwdWyu8QG7IarbLeJr2zmAe3mtK6qv9ym8e4cg1UoKwrsK3hDP
	2sTn71GMsAGgdFzctP9X4L8pA==
X-Received: by 2002:ac8:5d0e:0:b0:501:4f3d:1469 with SMTP id d75a77b69052e-5070bca9b16mr59670661cf.52.1771750153314;
        Sun, 22 Feb 2026 00:49:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:12 -0800 (PST)
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
Subject: [RFC PATCH v4 05/27] mm: introduce folio_is_private_managed() unified predicate
Date: Sun, 22 Feb 2026 03:48:20 -0500
Message-ID: <20260222084842.1824063-6-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14106-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF43516EA7E
X-Rspamd-Action: no action

Multiple mm/ subsystems already skip operations for ZONE_DEVICE folios,
and N_MEMORY_PRIVATE folios share the checkpoints for ZONE_DEVICE pages.

Add folio_is_private_managed() as a unified predicate that returns true
for folios on N_MEMORY_PRIVATE nodes or in ZONE_DEVICE.

This predicate replaces folio_is_zone_device at skip sites where both
folio types should be excluded from an MM operation.

At some locations, explicit zone_device vs private_node checks are more
appropriate when the operations between the two fundamentally differ.

The !CONFIG_NUMA stubs fall through to folio_is_zone_device() only,
preserving existing behavior when NUMA is disabled.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 6a70ec39d569..7687a4cf990c 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -92,6 +92,16 @@ static inline bool page_is_private_node(struct page *page)
 	return node_state(page_to_nid(page), N_MEMORY_PRIVATE);
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio) || folio_is_private_node(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
@@ -146,6 +156,16 @@ static inline bool page_is_private_node(struct page *page)
 	return false;
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
-- 
2.53.0


