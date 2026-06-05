Return-Path: <cgroups+bounces-16681-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/+gNtlRI2rhpAEAu9opvQ
	(envelope-from <cgroups+bounces-16681-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 00:46:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61964BB56
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 00:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ceUAvQxO;
	dkim=pass header.d=redhat.com header.s=google header.b=W0yMXwmD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16681-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16681-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC1B302E7A4
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE83E3C47;
	Fri,  5 Jun 2026 22:46:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8736607C
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 22:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699562; cv=none; b=TpEN+1xz16Ra7PGSjt4PpeYbRqv50jLuNqCT6Vkd3UrU5oVSJy/TdED2KL2QfRBaqj7WMNfDIx0zuJVmakpSaoX+lR9I2IsiJTRPYKcMze3+k34C/Wj0hq8tdDWDbCbXHhRvN0Az0vYI4+qcCZ5Uj1H9573qlOcWP3w1r/uzyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699562; c=relaxed/simple;
	bh=DSA/lhu9ZaTXbGt/Dy/7AnuFFkOEAsrvmPfCMetX+vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XfTrRbRWRGiz0Q5Ls6HrlzWa0sFTqrfHBuaABiHxLDhbJ0u197TeXyqmlUHl9az+yXTMQKYlKIBuWPHYnbGIpX+aMRwbbqofNi/KjXBeRMXvg6txyJVMJykI0u7gC1AVGgPoYnjq5+gqvTNzJWR6schmG5NzXhwScurYW5jzjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceUAvQxO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0yMXwmD; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780699559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dV6PAZLoEmUptgQeuUHBOKnlcyuL3OCus7UUkvZbeZI=;
	b=ceUAvQxOp5H18OlkY1J/6imhvCxHDEWhducMUPGv1KTs0MgeN5btqqGnXPvw9iLRjrWFAK
	Qx7ki3T8uG7TG4mKMo2B/mLfqWnFwwN737oq0xxvYWgtuMhOjM7u0ykMpw+KUtW78Q2TCa
	5Y7lnmuwnriv28cntLDD5/d189BJ6so=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-r5T6LkpNO8mCEmw2Jn_SYw-1; Fri, 05 Jun 2026 18:45:57 -0400
X-MC-Unique: r5T6LkpNO8mCEmw2Jn_SYw-1
X-Mimecast-MFC-AGG-ID: r5T6LkpNO8mCEmw2Jn_SYw_1780699557
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cecb6dee57so68291126d6.1
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780699557; x=1781304357; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dV6PAZLoEmUptgQeuUHBOKnlcyuL3OCus7UUkvZbeZI=;
        b=W0yMXwmD9yupTejuuTvyxiN/bO3OyHrVmJJOsVfT3Zy6l2I61SmfriKxFMrRkZGl2Z
         sQnndPVvjYZjmBqLXyNNW0DlVvDdDOgfGW9dpf8aXGhEFLDC8RgOST5jV0OEe2u5/9Ko
         AkyIxZoX7fSynSFgxAs4v5M5R3RDdCWiTIeFt4vDyh3RIRPvM1LybrTRnmICpI7MIgtH
         1w6NacfF5rQjx2HqX/O73qTbWfXsS+gmvpHaJoUJCiHbjo4p02Fe/NeKiMEiyiTDjP7W
         /XPUACi0hoL/qTV7Si7g3NP8iTCIb8iIiGKMW6cMaWpnSGXoGgEnyeV1KL9TSgxO65s9
         L1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780699557; x=1781304357;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV6PAZLoEmUptgQeuUHBOKnlcyuL3OCus7UUkvZbeZI=;
        b=pu/d9K00c2ghTlfY+w73GDzmnS3CH6WWIwaCodJ4b2CA+JTfqBos5OjmGFFpzwJ68u
         ApHZ8v3gDtYeZcMawDvh5qR71mS2tHZZndeTc3Q1U/z0BXeUH6lFiAjFPPY4Ov1UyJ9z
         QTRnW+zFD+pvaS5rOG0Wtz8k2WhS0YLT2zKdtP3LNy7H8WxHCf9yNEOi9tNj6O9YEgij
         h28CDB/4qezjs0eCr7G2xhokzRROek0U7GzEjgNWNboZhxvsQQGv0c+NngwT5sezekcn
         x/6pr09aOgCq0gbq08pZ/X8BweeV8FtcrBCO2c9B6A9Kh/XfpSZwOlplV4blXd2m/tYa
         80Vg==
X-Gm-Message-State: AOJu0Yxsg62RioXMkxu9bRb3qcUtsttYuOO/07ydjax7xGQ/arqa2OGF
	Ol5yz798ba6ZQOvehIkkPfwt61gwCbvdOLppBTxwLNLf+vnwBJEUQCiYp6D/ZAM3drGoPHtEV4u
	qfUallXt8UMBK/RaqvueCotzF8EBptTuB+iqaelPACHGJkXVv7AgJjGVCJTM=
X-Gm-Gg: Acq92OHGt0EJC1b8aCaVpknwa2+tP7j3EPQrtBh9hYH4wXyR2Bo1ymgpjhpgd7MBuD+
	8ebMC+SrPK3wIEg9yBMa/L/9XdriyjFQJR7k+oRfsURdfTrOjAe7wW/b2oBKdv5EGMc87Vrf16w
	ylXqTdBO2Z14TIew7Ae5Rl7Ol/MmzDRPgl4CRCiJVYFMo8QigYOgabJvZOSrQY8UFkqeOuoSE/H
	HLsMsR783789HgmKecn/BbzqsMNADbekmkG67Zscshd96XtJ33uFWikIS8RYTFfcRq/+AnXyJjI
	bBklaD/MzcTBv7/Jk1tk+DQyIO3448v7sm+P464MsEmXXZSE0pFo0Aw704RhGzfXsnKdI7qm5xM
	6a78MVuc9RrSzeEf3PvBs9IGeuZC3FBtJS39BbCOGis4qW3mK2py72Ks5Be23ACjP6K3aH8mxL3
	Wq
X-Received: by 2002:a05:6214:45a0:b0:8ce:ab75:9d69 with SMTP id 6a1803df08f44-8cee8c44538mr60333406d6.21.1780699556950;
        Fri, 05 Jun 2026 15:45:56 -0700 (PDT)
X-Received: by 2002:a05:6214:45a0:b0:8ce:ab75:9d69 with SMTP id 6a1803df08f44-8cee8c44538mr60332996d6.21.1780699556434;
        Fri, 05 Jun 2026 15:45:56 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06f5eesm94985466d6.37.2026.06.05.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:45:55 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 05 Jun 2026 18:44:55 -0400
Subject: [PATCH] cgroup/dmem: accept only one region per limit write
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NzQqDMBAGX0X27EIUEkhfpXio5jNdqFE29QfEd
 zd4nMPMnJShgkyv6iTFJlnmVKCpKxq+nxTBEgpTa1pnnLE8RJ3XhcOEiXeVPzhLij+wIhaXfT8
 a27vgvQ1UKotilOM5vLvrugFgY1X4cQAAAA==
X-Change-ID: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16681-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,m:echanude@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F61964BB56

Accept only one "region value" pair entry for the dmem.max, dmem.min,
dmem.low files.

This changes the UAPI that otherwise accepted multiple lines for setting
multiple entries in one write. No existing user is known to rely on
writing multiple regions in a single write.

Processing multiple regions in dmemcg_limit_write() could quietly change
first limits before failing on a later one and returning an error to the
writer, with no indication some changes occurred.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Follow up from discussions on a previous thread[1].
If Albert's series[2] lands, I can cleanup and prepare some kunits for
these as well.
[1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
[2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
---
 kernel/cgroup/dmem.c | 70 +++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def546adf5cc175d7f0be 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
-	int err = 0;
-
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
-
-		/* eat empty lines */
-		if (!options[0])
-			continue;
-
-		region_name = strsep(&options, " \t");
-		if (!region_name[0])
-			continue;
-
-		if (!options || !*options)
-			return -EINVAL;
+	struct dmem_cgroup_pool_state *pool;
+	struct dmem_cgroup_region *region;
+	char *region_name;
+	u64 new_limit;
+	int err;
 
-		rcu_read_lock();
-		region = dmemcg_get_region_by_name(region_name);
-		rcu_read_unlock();
+	buf = strstrip(buf);
+	region_name = strsep(&buf, " \t");
+	if (!region_name[0] || !buf)
+		return -EINVAL;
 
-		if (!region)
-			return -EINVAL;
+	rcu_read_lock();
+	region = dmemcg_get_region_by_name(region_name);
+	rcu_read_unlock();
+	if (!region)
+		return -EINVAL;
 
-		err = dmemcg_parse_limit(options, &new_limit);
-		if (err < 0)
-			goto out_put;
+	buf = strstrip(buf);
+	err = dmemcg_parse_limit(buf, &new_limit);
+	if (err < 0)
+		goto out_put;
 
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
+	apply(pool, new_limit);
+	dmemcg_pool_put(pool);
 
 out_put:
-		kref_put(&region->ref, dmemcg_free_region);
-	}
-
+	kref_put(&region->ref, dmemcg_free_region);
 
 	return err ?: nbytes;
 }

---
base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>


