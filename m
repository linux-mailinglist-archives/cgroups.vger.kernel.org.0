Return-Path: <cgroups+bounces-15950-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id micbILEIBmpOeQIAu9opvQ
	(envelope-from <cgroups+bounces-15950-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:38:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF6545668
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6FE307FDF5
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604C391833;
	Thu, 14 May 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O+9A/8aK"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA09391E64;
	Thu, 14 May 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780221; cv=none; b=lWQ60k4VovPyxsuDVavPpyd86KXwdJnhenoi+FJ49If914HxGT7/0XrdqNKCXNCFEjaF1ZPOq4+u/ripRODT/75KLu9WFhzRhvGsR3qk5yY40rOhDrV23r/2z8qJMIJaEtz+HlJWn3sk+QMHUlYieEaSreBhp/h8l8EsXoEIpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780221; c=relaxed/simple;
	bh=7HohLcAzsKGZ5rIceGtsELpREYzhOEuYqHkzWH5kjcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cYcKrJrOhiojv4F4X8CPHJHu3SUU3TLcJbTicMcgoLbAEiMAK/ymEw5SS1fjuPrwhyjQJu+O0B2Zg+ZE/QbXcyaAlHRylRscMsOukbr2hy8lCkS/Ynsv071tTltghAxaGzg9PPiE/b+bX0+u+jmWPDrmmWauFpHTst9a2T75B3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O+9A/8aK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GwwUeKFsKyVyc2+pTaKswdPzG1/YgpdUqtqHsE9uC3c=; b=O+9A/8aKWex7YSsZulUvCRbT22
	LS39rgmpP6xjmZFVNSpkoI67QDvh3fbOJvgPayTkCWw4Rn0Na3KxjTkUHhGZVFZUIOn6MzsutEncE
	33O19MnrHYpx3Yt3NhNYfz/KFLz3k3iGqycn2laA6IryKLQuX+gX6RbuosFqCnXFxv9S95+U4q+K6
	wgb5OguCJO6p55H62aR/LmtJbiJjCVVKRa1tFq31rv3Z0Xa0PVPZpFF4PBjqRJQKs2fg3GZ8VwkvI
	1gFMAIHQVUyMe7l+/NHpi5c4xogIy1NDC+zPejjuTuP+NhD8tEk4ft1FY7g5WJn9gWPNCO+31zjnf
	x9aARObA==;
Received: from 179-125-79-241-dinamico.pombonet.net.br ([179.125.79.241] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNZz8-000Aig-0e; Thu, 14 May 2026 19:36:34 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 14 May 2026 14:36:08 -0300
Subject: [PATCH v3] cgroup/dmem: introduce a peak file
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAgIBmoC/1WMyw6CMBBFf8V0bc20BaSu/A9jTB8jTJRHWtNoC
 P9uwQ0uz809Z2IRA2Fkp93EAiaKNPQZ1H7HXGv6Bjn5zEyCrKAAzX2H3W1E8+DKWCcs6hKOkuX
 /GPBO77V1uWZuKb6G8FnTSSzrr1JCtakkwYHXvgaFVhWFdmdqzJPMwQ0dWzJJblShtqrkgnvjo
 NJae6vxT53n+QtDElqX3gAAAA==
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
X-Rspamd-Queue-Id: 04EF6545668
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15950-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid,msgid.link:url]
X-Rspamd-Action: no action

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

For now, make it read-only.

This allows for memory usage monitoring without polling dmem.current when
the information needed is the maximum device memory used. That can be used
for capacity planning, such that dmem.max can be properly setup for a given
workload. It can also be used for debugging to determine whether a given
workload would have caused eviction or system memory use.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://patch.msgid.link/20260513-dmem_peak-v2-1-dac06999db9e@igalia.com

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


