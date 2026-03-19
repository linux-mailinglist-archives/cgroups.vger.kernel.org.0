Return-Path: <cgroups+bounces-14929-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDPnHAtqvGlQyQIAu9opvQ
	(envelope-from <cgroups+bounces-14929-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:26:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93B2D2A7C
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B19F231F0FBC
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 21:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC79402B9A;
	Thu, 19 Mar 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LMpFtUUO"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C864402459;
	Thu, 19 Mar 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955394; cv=none; b=R57YCV+r88e5Y1K7g/NOsGUAkCReW6ghT3bRUvN4G4ksSeO/PknCRtcsVePs3JNF6IR/TzOGb21XlW6mwl8nn0fOyD6mU2sHS7z4b+dJ9rlgmJZ+jcApOBoeeB/0qjuJcDakkRSXak9N955j6ENGyuGMnj+NkDmMr1QJVwzDKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955394; c=relaxed/simple;
	bh=VvMsIIeDvHubQIh6pouwIc6v/ijLQKebg1s8Sh1NjP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNNqG22IOpx6Bt71g1VuP5sfCgOqpxQ7keB8XJxK4bMy+Vem8OSVTmDk5WpFyMlfbnOhPz04N3zLPGOdjtRH3NuIE1relqal1XyEZZyLjFv0psYcppO9nFrtElwHW7r360HN6IaH7w0YLFCrpEjYs1dACw4QOn6xS7nvdOm/oMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LMpFtUUO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=41Uqa2RC7e8RnridV7NcZa89g+tR7DrEjBJo4ZJoKfg=; b=LMpFtUUOVWSRIZzlFDX2PsOh5v
	4FVXZUMoSWNgRFRRF++SE32KrZTjbHGsbKrg9D27SeDKJePa2miGCo2hfFhYfx4poAuA3V2w7Ksbq
	ZcjYmf+5jRkhR8wy2W/2qvoTQ2oeptzV/dHCME2uDG8vFOLJJrNVFjNri2SvfHjiKdW/gwfQmo+UJ
	WY6Nyu3oAuXNFc/jKV8fDrXlJUvYPGJpNhXyjCbFPxB0yRws9fTwfvlUXTyWYHv39Tr2IYA170fwe
	vu8CKXVLJgyFNQqMQXtZf8Fx6zeQL71E27ihGcK6IZL0I9j2A0HcArMBUbscjTmmi/dCrtdVfj9Ni
	kiDje2Ew==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3Kpi-003VvC-J9; Thu, 19 Mar 2026 22:23:10 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:44 -0300
Subject: [PATCH v2 3/3] cgroup/dmem: allow max to be set below current
 usage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-3-b5ce97205269@igalia.com>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
In-Reply-To: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14929-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.723];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB93B2D2A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_counter_set_max may return -EBUSY in case the current usage is above
the new max. When writing to dmem.max, this error is ignored and the new
max is not set.

Instead of using page_counter_set_max when writing to dmem.max, atomically
update its value irrespective of the current usage.

Since there is no current mechanism to evict a given dmemcg pool, this will
at least prevent the current usage from growing any further.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 695d2b7516081256da030c80b54ec1c5fcd6ca16..bf9e0d11e46156a437196c77fdfde84250e65420 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -159,7 +159,7 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	xchg(&pool->cnt.max, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

-- 
2.47.3


