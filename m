Return-Path: <cgroups+bounces-15910-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL+NMADMBGrMPAIAu9opvQ
	(envelope-from <cgroups+bounces-15910-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:07:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46469539977
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77487306A962
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C60393DE2;
	Wed, 13 May 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="orlkbFi+"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32918E025;
	Wed, 13 May 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698746; cv=none; b=YWlmSnWT2j/C5dteucOXI3V7/O+01dDfpgeOZMYzz929ji5rLhiqgZRanoNjK0fPq+PoM9beypH0k0Q79VhD5pQQ5a/5NqCQ1N5S7R4yfh4vA8zC5HMidwiwBf1pkSYPqQs8B33gR3c2lNR9CU4E36yKEeHhKUoggBy24VwOrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698746; c=relaxed/simple;
	bh=tla75cfkTRlC9T7SUkt5Cuky8it/PEoRF7zOfP/TpWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E9mZQcieSdabFRX39vvIt5uxDJBi8czMPx9tICEoXeJZCf3XF5uEO4ilR5dqVoTJZz2/hKey/H97QDn5+9WGVPOzaGfpNys8Fqu86RySt6/9seXIwWj3IVjIEE7DZXgZiqM0qD7Gvur3WenYc5aKL6LY9vPA+E4DxGywxlzVrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=orlkbFi+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hLDHDw6L2XoumT6hL0NwUBbydY/pK2g/zR84qPtzVV8=; b=orlkbFi+CfrTOJx71uAU8+bYfM
	JPsP2pe1y/uO1CMN/16vVmCBmOctgZMP/PYiEHuF/djxfy2oaokqktP2wIOEzcls7T/9pt55+cflz
	gPV893jmQDhGrvkXpAxwfYGrhIJMjKLg2Jhjg5BUbRqxrtzmpisDMD7e6jJyGT6XcRw49Zrto3YtX
	600LJNkANS23l9ZpCnUe4Gesh5dtELWtWmSDON2GF4JvMmkf6FqvdxHaChDrkA5jMkKbV+yebaq8X
	ZPqKodOldA9vSDAM99OdORWiw7dtcUM/cGjC+QJPEN8ngToe4mb1rXD6JgexBHYbpUYgCbKnLKdDI
	WndYMfwQ==;
Received: from 179-125-79-241-dinamico.pombonet.net.br ([179.125.79.241] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNEn4-00A6HS-Qv; Wed, 13 May 2026 20:58:43 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 13 May 2026 15:58:16 -0300
Subject: [PATCH v2] cgroup/dmem: introduce a peak file
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
X-B4-Tracking: v=1; b=H4sIAMjJBGoC/03Myw6CMBCF4Vchs7ZmKBcpK9/DENPLCBMtkNYQD
 eHdrbhx+Z+cfCtECkwR2myFQAtHnsYU8pCBHfTYk2CXGiTKGktUwnny15n0XRTa2NyQqvAkIf3
 nQDd+7dalSz1wfE7hvdNL/l1/SoX1n7LkAkXjGizIFGWp7Jl7/WB9tJOHbtu2D8g3jGWjAAAA
X-Change-ID: 20260409-dmem_peak-3abc1be95072
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
X-Rspamd-Queue-Id: 46469539977
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15910-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

For now, make it read-only.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Make it read-only for now and adjust documentation accordingly.
- Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 kernel/cgroup/dmem.c                    | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..d103623b2be4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2808,6 +2808,12 @@ DMEM Interface Files
 	The semantics are the same as for the memory cgroup controller, and are
 	calculated in the same way.
 
+  dmem.peak
+	A read-only nested-keyed file that exists on non-root cgroups.
+
+	The max device memory usage recorded for the cgroup and its
+	descendants since the creation of the cgroup for each region.
+
   dmem.capacity
 	A read-only file that describes maximum region capacity.
 	It only exists on the root cgroup. Not all memory can be
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f..6430c7ce1e03 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -182,6 +182,11 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_peak(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->cnt.watermark) : 0;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
@@ -808,6 +813,11 @@ static int dmemcg_limit_show(struct seq_file *sf, void *v,
 	return 0;
 }
 
+static int dmem_cgroup_region_peak_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_peak);
+}
+
 static int dmem_cgroup_region_current_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_current);
@@ -856,6 +866,11 @@ static struct cftype files[] = {
 		.name = "current",
 		.seq_show = dmem_cgroup_region_current_show,
 	},
+	{
+		.name = "peak",
+		.seq_show = dmem_cgroup_region_peak_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "min",
 		.write = dmem_cgroup_region_min_write,

---
base-commit: d3b0a7f21119f5a66cb76aa28fb8cc13206aaf7d
change-id: 20260409-dmem_peak-3abc1be95072

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


