Return-Path: <cgroups+bounces-14875-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMcjIVX+ummAeAIAu9opvQ
	(envelope-from <cgroups+bounces-14875-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:34:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 276402C20CE
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B9AE3022048
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093B3F1665;
	Wed, 18 Mar 2026 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lpFpgvzi"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2537C90F;
	Wed, 18 Mar 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862477; cv=none; b=jPbtByfxvk6KB/GDxdH+uXHrl17Mj1O4x5lDq5qktavIfroV3xgXdwU0/5s1Hn4JTILoUfTDPwLt/2bA/sOs1C6xjq9udmVxD5wcn8WAAtI55enp+m47R6bwKoS8cHV1TQSSqw5QB2yVEIOyZEbM38srq2YCs9SSuGTDHq3vPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862477; c=relaxed/simple;
	bh=PBO/gpUQYndZ48CBvinr6DZ2jI4mfHF9rSfOJZgrHzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M5WNNy2COOoUEQPDDCJiXOIQ7xpRJuIcAEWAF6sqaN/QSb6d0I2HNcHcRHvUxA0j9QzUjWlC5I8JvBz7lLZHDuJYWIS8gvfj52hlShyV2OKZjfAE3Gp567IPAvJsrS2+o2WtvsAuBsyN91RwZCQq9KvJEWd1Y4XOOCUuQ/VJNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lpFpgvzi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=55X8CA1iQ9nTwcAu+NQ9pAPvGzkL1fzYJpuO5trNdQg=; b=lpFpgvziFa4QA50ip9YJV0Id6W
	wQnBGk0IfBjWNeyfyl6OluKa7juCvyOT2jiuBbherlSHsBBoVsbdbB2KWKESY+911VKLyXPY0B1aU
	z+0eJVxYUQuDxYHj3vupZWBdjCgEVXZLAi2fBlI7VRsDISgE9ThOj59WctzCc22LASw4cBDa7YYVo
	pDFx+hv5BiuY9kaQpPIrvb45e4FKwVh+KnnhM4DQ/eQPthH+uFtGinQxuiXBEF8ELarwxq3NH5aEB
	J4f6nvgG37urV66Eq7DRHB/yrDm/5duthSUMm1BEpUbbDBSOmvPT6qoi4p+iX/Ufuh9uVeU5/c4xy
	L/DJ7Mpg==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w2wf2-002xcw-0S; Wed, 18 Mar 2026 20:34:32 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 18 Mar 2026 16:34:17 -0300
Subject: [PATCH] cgroup/dmem: return error when failing to set dmem.max
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
X-B4-Tracking: v=1; b=H4sIADn+umkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3ZTc1Nz43MSK+NSk0uJK3aS0FGNjUzOTNKNkYyWgpoKi1LTMCrC
 B0bG1tQASy0R5YAAAAA==
X-Change-ID: 20260318-dmem_max_ebusy-bfd33564f2c3
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14875-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.747];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid]
X-Rspamd-Queue-Id: 276402C20CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_counter_set_max may return -EBUSY in case the current usage is above
the new max. When writing to dmem.max, this error is ignored and the new
max is not set.

Return as soon as setting one of the regions max limit fails. This keeps
with the current behavior of returning when one of the region names is not
valid.

After this fix, setting a max value below the current value returns -EBUSY.

 # cat dmem.current
 drm/0000:04:00.0/vram 1060864
 # echo drm/0000:04:00.0/vram 0 > dmem.max
 -bash: echo: write error: Device or resource busy
 #

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..3e6d4c0b26a1f972b6c6e875f274a091fc9e2b75 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -144,22 +144,24 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 	dmemcg_pool_put(pool);
 }
 
-static void
+static int
 set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_min(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_low(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	return page_counter_set_max(&pool->cnt, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -726,7 +728,7 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
@@ -773,7 +775,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		err = apply(pool, new_limit);
 		dmemcg_pool_put(pool);
 
 out_put:

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


