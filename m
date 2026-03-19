Return-Path: <cgroups+bounces-14927-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDjmJj1pvGlQyQIAu9opvQ
	(envelope-from <cgroups+bounces-14927-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7872D29E4
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63C9830071DE
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AD3FE353;
	Thu, 19 Mar 2026 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oZAMIiDT"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6682DF14C;
	Thu, 19 Mar 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955386; cv=none; b=Z7KLh7CPlXaGPCVX343//ordw5Oe/ipDWpIeGkLlh/K4enAyZSBacY99LNZzfXzPQit4vXt/kptFdHXVfc7UkE/h4gdu0/FPhBQtjwOFLCOgU7wyBzC0P/q9cuw6ahDu+M5JvwRGsoA92zXhidbj2w+UUPF8csfHxtGrvSjDKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955386; c=relaxed/simple;
	bh=jFshgU6n2M2QnL9j4QSG3k07/tMyHE9KEs4QensOt1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNHznxcsodLdtVAZv40IT1pI33oK3K4HkjOZZdvQqiFVtdRMflRihUFUo7ZrYYHQTzIMe/46d93kVCY3KZZXMtWnKCohSeZI22lvnMZjT31gc88us4ZO89MVzFJul1nFwPVO7Lfk8ayHjmE8UDTnNGpoqhSilqs6OmiplZyTM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oZAMIiDT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LqaSmuwy6pHyDiJ04DyLgwnky/pg3ari4nRAMo6yRdg=; b=oZAMIiDTni+k/UcrP/bfXGrUSy
	0GjwRHt7V99SL7NdvpruQ8bP1dEWarEj8onLhN3sx9QgNxUH7rS/Kh4aC61daUiMzFpZUT1Cv5Lse
	ob3rLbRrjLB3ZSHr1ezmpVP4kLrSneerzxIXmHSH6pNRXnIbyO6r3sRM/RyAMkzQC8Gi8bSis+amv
	Ij1PofzUmJ8Jl6z1wMp+wKculqnBXOx0Wlq2jzpT2hPO+V4pJRFga5NcN/6Qly3NQP/KoqQEkwT8j
	nbRxLYy56fCkaf75qlKgDyM4adToyvJH9xRCq0o6PTAPYEper4iPv1GX0snX8POSI8pG7klODVI/5
	n+lIA5ew==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3Kpa-003VvC-0O; Thu, 19 Mar 2026 22:23:02 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:42 -0300
Subject: [PATCH v2 1/3] cgroup/dmem: remove region parameter from
 dmemcg_parse_limit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-1-b5ce97205269@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14927-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.694];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid]
X-Rspamd-Queue-Id: 2C7872D29E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dmemcg_parse_limit does not use the region parameter. Remove it.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -707,8 +707,7 @@ static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
-			      u64 *new_limit)
+static int dmemcg_parse_limit(char *options, u64 *new_limit)
 {
 	char *end;
 
@@ -762,7 +761,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		if (!region)
 			return -EINVAL;
 
-		err = dmemcg_parse_limit(options, region, &new_limit);
+		err = dmemcg_parse_limit(options, &new_limit);
 		if (err < 0)
 			goto out_put;
 

-- 
2.47.3


