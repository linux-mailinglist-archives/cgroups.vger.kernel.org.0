Return-Path: <cgroups+bounces-15063-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOR+IChPxWlH9QQAu9opvQ
	(envelope-from <cgroups+bounces-15063-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 16:22:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A183377E6
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AD86303833B
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A104B3FB7C2;
	Thu, 26 Mar 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QZO+7ZZ+"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AC3FADEE;
	Thu, 26 Mar 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538400; cv=none; b=LPducvo/MYfWdNJt+kOQv6HX1J2l9hdsyh5aS1YuOnzLgHPCxWXnWT0hBgaMJMLToexrsZHIWIhUGrcWnP7QZTYOcazO/qTl+1fENAtRDCIcYTGh4nrogbKzkdKXGI2jqPWcphDAMQWKoww8Fj2CkP+Hh4DN64H+QLiyBU5M1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538400; c=relaxed/simple;
	bh=MKABcl1xYQBjO/+BCPU/IAqj6VyCkl6ltNnKxbRcUnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OhyzBLz9MNe5OGGap5FcUcq+Znw9eMJi9kT6FJVEw6Un9XZpSluwxIcWRdHp9gU+6am+if2NcH7NxmM7Hk1YC5OwQnG3TA6ZQbBfI2p3OkX9cEGNER5d7HqUgy3Aa1eeL6t7Sqvbl2wsAel5ipxat1hHGN9ImKo6K3kgA5YFMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QZO+7ZZ+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PB0cZCa+SKJ+FVAYJfPEjxtHc/PtdAEF/6TChF1yelk=; b=QZO+7ZZ+ECwfLcHURjcQ04jmBi
	Cf5107gb0LMsIGPjA+kcPQYORULuu35xCzKovoQWEIZTtitslZgCFJp4ytUwZv5uJcZ9JmxG1jNwi
	R89mUBBLxgE+jxGiBks6hGCEps+w++D9wbzNUPVgjOgQa0lAWQknCtFXPHmhkGEnF5IgFSLxhvBUN
	sjkPYfW5Sn2afqvkoVLoJZ2oS/xSNkBPukUj0O+7xB3Qxhcl5lFE/xivfxWsOKMvK1t28FaOonZ7V
	y6f5yfN/bpEskCXWRVJpfx+lQaYvTrvR+iHyfdmk+W39iPjjHz6KftJU2je+xfBFUW5Jd0nODi4U7
	jq5n6LBQ==;
Received: from 179-125-71-253-dinamico.pombonet.net.br ([179.125.71.253] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5mUy-006O5l-Ut; Thu, 26 Mar 2026 16:19:53 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 26 Mar 2026 12:18:17 -0300
Subject: [PATCH v3] cgroup/dmem: allow max to be set below current usage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
X-B4-Tracking: v=1; b=H4sIADlOxWkC/3WM3QqCMBhAX0V23WI/bmZXvUeEbPNTP0iNrYYiv
 nvTqyK6PAfOWUgAjxDIOVuIh4gBxyGBPGTEdWZogWKdmAgmNJP8ROse+qo3UwX2FWZqm1pKpfN
 GOElS9PDQ4LQPr7fEHYbn6Of9H/lm/64ip5zaAnLNuSqsKC/Ymjuaoxt7sr2i+OzLn15QRq1yU
 BaCKaG/+3Vd3/viEHPtAAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15063-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.462];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22A183377E6
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
When writing to dmem.max, it was noticed that some writes did not take
effect, even though the write was successful.

It turns out that page_counter_set_max checks if the new max value is above
the current usage and returns -EBUSY in case it is, which was being ignored
by dmemcg_limit_write.

It was also noticed that when setting limits for multiple regions in a
single write, while setting one region's limit may fail, others might have
succeeded before. Tejun Heo brought up that this breaks atomicity.

Maarten Lankhorst and Michal Koutný have brought up that instead of
failing, setting max below the current usage should behave like memcg and
start eviction until usage goes below the new max.

However, since there is no current mechanism to evict a given region, they
suggest that setting the new max will at least prevent further allocations.

v1 kept the multiple region support when writing to limit files, while
returning -EBUSY as soon as setting a region's max was above the usage.

v2 only allows setting a single region limit per write, while allowing any
new max to be set.

This version (v3) still allows multiple regions to be set, and explains why
page_counter_set_max is not used anymore.

I am sending this version dropping the multiple region restriction for now,
as we continue to discuss whether it should be supported or not.
---
Changes in v3:
- Dropped first patch as it was already applied.
- Added comment explaining why page_counter_set_max is not used.
- Dropped patch restricting multiple regions to be set for now.
- Link to v2: https://lore.kernel.org/r/20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com

Changes in v2:
- Remove support for setting multiple regions' limits.
- Allow any new max limit to be set.
- Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com
---
 kernel/cgroup/dmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..c00aa06759967a8f8977aaf036dd7966ddb55718 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -159,7 +159,15 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	/*
+	 * page_counter_set_max will return -EBUSY in case the current
+	 * usage is above the new max.
+	 *
+	 * Since, there is no current eviction mechanism yet, setting max
+	 * irrespective of the current usage will prevent further
+	 * allocations.
+	 */
+	xchg(&pool->cnt.max, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

---
base-commit: 6ffdb01db6d5d785e7278c6d98fd4ef8598b0fc5
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


