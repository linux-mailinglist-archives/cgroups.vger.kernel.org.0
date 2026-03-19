Return-Path: <cgroups+bounces-14928-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAF+CkVpvGlQyQIAu9opvQ
	(envelope-from <cgroups+bounces-14928-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 116142D29F9
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B7A3019C89
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F2402BA4;
	Thu, 19 Mar 2026 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nowxwRTx"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED772DF14C;
	Thu, 19 Mar 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955391; cv=none; b=WBlVwgi2rfjrFgAhf8Bvd6G8MMyirQg2rLOqaiXvnSms5dkg0L/qReIhyBEK5/MQc+JHmG7U6zHxljNff6GMhr8XNZUj2fbQuMxKIGjnCKAG/tyHEBrVROxy0hDhBoDnvi4kvoL2yrVhY9e6YlvgFosJZY3yNSVL54u9UmdSs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955391; c=relaxed/simple;
	bh=g5/ovbO83gw3owROdHHFwAcK0U2EAjP+PJQWko9myI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFY5LFAjHfdfhcEzF8/1bZPFvzhVIO3Oykp6Ko75nNMU1V/hRRF8TyjGpkoQiw+nSkkskTQCV46F1IrKzLYVLt/ez+qqJrQvRQj672B8LOwps5ddJ6G2IVO9aGvN6AAxKQP9tGiGneTWb/m7zX2MDiqggWM4vNiHRWHyv3EP14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nowxwRTx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SPSdVVjfXYlYXJdvMtjOrLqjwSNywcgu5lDpY2FUZA0=; b=nowxwRTxSjf5akurlgjLLCkOTY
	oVO2RWolPa8D1A0+s9ZW8XRAOzqmyno181GJME8GLWnR2UHgMBn2POKCpZHn0T9H9A8P32xVKGTwG
	9sZVwdg6hoQ1Gq/juJ/ETG5OcIRjdDz8cYjSJtuJcoAj328TeP+6kYzMpe/kRFYEmp22bEtRDOvR0
	sh57FFitMtLvtgiVC09kdEyISqHAUjfnZtrZkTjRL+Kmr+EFnXbKX5PIgNdYln+RA5wiegTowZpkf
	FtwtA6bfz87MCcpNejt+IiI1rIjDUi+fwke4ZQZFv+jlDFxTucRF1Y7+J3OZr5cGSC29kJdT8TmLL
	+D5Ucj2A==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3Kpe-003VvC-JL; Thu, 19 Mar 2026 22:23:06 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:43 -0300
Subject: [PATCH v2 2/3] cgroup/dmem: accept a single region when writing to
 attributes
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-2-b5ce97205269@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14928-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.718];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 116142D29F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When writing to dmem.{min,low,max}, if multiple lines are given, one of
them might succeed while the next one fails, but an error is returned. That
is, there is no atomicity where either all changes succeed or all of them
fail.

Only accept a single region instead of trying to parse multiple lines and
process multiple regions at the same write.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 69 +++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..695d2b7516081256da030c80b54ec1c5fcd6ca16 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -729,56 +729,47 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
+	struct dmem_cgroup_pool_state *pool = NULL;
+	char *region_name;
+	struct dmem_cgroup_region *region;
+	u64 new_limit;
 
-	while (buf && !err) {
-		struct dmem_cgroup_pool_state *pool = NULL;
-		char *options, *region_name;
-		struct dmem_cgroup_region *region;
-		u64 new_limit;
-
-		options = buf;
-		buf = strchr(buf, '\n');
-		if (buf)
-			*buf++ = '\0';
-
-		options = strstrip(options);
+	buf = strstrip(buf);
+	if (!buf[0])
+		return -EINVAL;
 
-		/* eat empty lines */
-		if (!options[0])
-			continue;
+	region_name = strsep(&buf, " \t");
+	if (!region_name[0])
+		return -EINVAL;
 
-		region_name = strsep(&options, " \t");
-		if (!region_name[0])
-			continue;
+	if (!buf || !*buf)
+		return -EINVAL;
 
-		if (!options || !*options)
-			return -EINVAL;
+	buf = skip_spaces(buf);
 
-		rcu_read_lock();
-		region = dmemcg_get_region_by_name(region_name);
-		rcu_read_unlock();
+	err = dmemcg_parse_limit(buf, &new_limit);
+	if (err < 0)
+		return -EINVAL;
 
-		if (!region)
-			return -EINVAL;
+	rcu_read_lock();
+	region = dmemcg_get_region_by_name(region_name);
+	rcu_read_unlock();
 
-		err = dmemcg_parse_limit(options, &new_limit);
-		if (err < 0)
-			goto out_put;
+	if (!region)
+		return -EINVAL;
 
-		pool = get_cg_pool_unlocked(dmemcs, region);
-		if (IS_ERR(pool)) {
-			err = PTR_ERR(pool);
-			goto out_put;
-		}
+	pool = get_cg_pool_unlocked(dmemcs, region);
+	if (IS_ERR(pool)) {
+		err = PTR_ERR(pool);
+		goto out_put;
+	}
 
-		/* And commit */
-		apply(pool, new_limit);
-		dmemcg_pool_put(pool);
+	/* And commit */
+	apply(pool, new_limit);
+	dmemcg_pool_put(pool);
 
 out_put:
-		kref_put(&region->ref, dmemcg_free_region);
-	}
-
+	kref_put(&region->ref, dmemcg_free_region);
 
 	return err ?: nbytes;
 }

-- 
2.47.3


