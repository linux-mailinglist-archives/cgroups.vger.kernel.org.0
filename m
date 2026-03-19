Return-Path: <cgroups+bounces-14926-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B+pD0BpvGlQyQIAu9opvQ
	(envelope-from <cgroups+bounces-14926-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE02D29EB
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5437C3028836
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F63B774D;
	Thu, 19 Mar 2026 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o8Vby54P"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3E2848AA;
	Thu, 19 Mar 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955386; cv=none; b=rJWfAC1ibAqGJCbrFhK/4Qpt/l9cTG8D2wysshYaOYXsiARkT9w5JiK/e8YpfXs2mpuWgSM9th8cB7XoVFl6WuZJMFoUqPaFumsOiDzZLXXvuuFtR97tz67pj2suQtcLr8XhmXSu8hcHTt3rlSz9luvHqejVYgNRlya1prWYGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955386; c=relaxed/simple;
	bh=Mb90UWxsDJhLTIClLTymzDUd/1wdyHTa4oyjlnlqFRs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gnUDSOHL4ZHc3Bby7sdOX8K9S01mgxqDYA3MxU3BgSvOQpd6EsGPLSCd6gQrjHT9o5DvDbcSm2MVDkAnuv2h8+KkMrNRX+KKPV/LjujFX31xbRYJ6pKjQ6T4L1fUmI/kqWFrjGiwOMN/sT8sWjUuVh5eKQp2mng0AkwFSQ1wCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o8Vby54P; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8/R6yZAGEx2BsCN9a2u1A7i8vpkAxC4xE8k2euMEcN8=; b=o8Vby54Pe9SvVlZ8SQmoO/mgOg
	KqDIt0YXczetkiG5y+RBhf4sW2uKbo13EOV0/gGbZN6Bm9C5rklWjBYverjCVQO/E8aS252SPqiXW
	STumDJd7HqjXZMuKc2zudV68SfgtYC3lVGUaQEBeVoCX5yRTnrWDybdD2XUzipp3Tlkp4uxHJSHs6
	wTBYv0eOHCu4IRNLW2MFrztTl4i75unPHF+4c522r6lWjXn0jlWYcMykY+Z2SsEk35Td9vMEuM9T6
	XMWwzZctrvdgO/rYg2PnjIZt6mQBR7o7ctmlJRkaeXSk2Mp1up1RGWPAxPtVlvQfryjM3PTKvnwoZ
	OIoEq7+Q==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3KpW-003VvC-0f; Thu, 19 Mar 2026 22:22:58 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Date: Thu, 19 Mar 2026 18:22:41 -0300
Message-Id: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJpvGkC/3XMyw6CMBCF4Vchs7aGabmoK9/DENLCFCaxYFptI
 IR3t7J3+Z/kfBsE8kwBbtkGniIHnqcU8pRBN+ppIMF9apC5rHKFF9E7cq3TS0vmE1ZhbK9UWRV
 WdgrS6eXJ8nKAjyb1yOE9+/XwI/7Wv1REgcLUVFSIZW3k9c6DfrI+d7ODZt/3L/G8uJetAAAA
X-Change-ID: 20260318-dmem_max_ebusy-bfd33564f2c3
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
	TAGGED_FROM(0.00)[bounces-14926-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.570];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BDE02D29EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This version (v2) only allows setting a single region limit per write,
while allowing any new max to be set.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Remove support for setting multiple regions' limits.
- Allow any new max limit to be set.
- Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com

---
Thadeu Lima de Souza Cascardo (3):
      cgroup/dmem: remove region parameter from dmemcg_parse_limit
      cgroup/dmem: accept a single region when writing to attributes
      cgroup/dmem: allow max to be set below current usage

 kernel/cgroup/dmem.c | 74 +++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


