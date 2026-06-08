Return-Path: <cgroups+bounces-16735-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bocrCNb4JmoUpAIAu9opvQ
	(envelope-from <cgroups+bounces-16735-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:16:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69229659240
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EtFzJ3iN;
	dkim=pass header.d=redhat.com header.s=google header.b=JpzgZUTU;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16735-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16735-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D3F352420E
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563FD318ED6;
	Mon,  8 Jun 2026 15:54:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F732E9729
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 15:54:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934055; cv=none; b=CDaaHRcFLDQGYyYll9Ezqh6XDnFKTlgSrj+5gHsWR4OA5FmEUIwap90l2AmIOO5AWH1G1kLnq3XF1eSq+VHp4qEsd9/XkY/r3cKrsCavB7wxYDoictHjE1/+FgyXbiwVe1G35/h+nGY57Ar3sy4Gh5rqJQm1+/3x7iqJxhCR718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934055; c=relaxed/simple;
	bh=MM08eiNikXKRrk1jVyirSHPVfnUE2TsTPLR9YKWptZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OGSW4oNhyMcmUb1148yNIlxZbJm+OT1Ffoy0ugRVDPWdyZmjMVoNOpeJQFXNrdFx+RY/Tb2EQs8zdbLO4gPIe/ov1mnPlMyLvH+0opkDInvvzPoTaLktPpfUuhGgUnlXgFPi98CyCvIT7mBcelGlMeAEKxZK6oHR0xVI6lIsBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtFzJ3iN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpzgZUTU; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780934052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5eWzdVvtwrg/9Udw9VbeX3BPtsMxiS3OGz6xe4/WajU=;
	b=EtFzJ3iNTw/9NR0iL/wzANWC3d0JPzyhvag9n9JpNK/BRXVPUese1F5C/fyvNB7Eli3bYE
	UxfE6eXV/ifA4/ta+20YXw4hoGOYXjwVowwJqa+9+gHrS/3epaCIyfft4pyGSpWyCD2KeY
	+MRYhFNrjsDuSDUVc4R9sY1/XEZGaOo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-bXvLdZGaNy2Yd0yfo4DF-g-1; Mon, 08 Jun 2026 11:54:11 -0400
X-MC-Unique: bXvLdZGaNy2Yd0yfo4DF-g-1
X-Mimecast-MFC-AGG-ID: bXvLdZGaNy2Yd0yfo4DF-g_1780934051
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91579011fd1so665608785a.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780934051; x=1781538851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eWzdVvtwrg/9Udw9VbeX3BPtsMxiS3OGz6xe4/WajU=;
        b=JpzgZUTUGCSk0AhUcixaUx57RX+B9bp2XnM7ieqGolx9gmWgpzB/qgwuFrmtNtrGuq
         2M9MAqlZSiRoyU2waIetaGTvgjl2POB40cRi/paUPQtk7F5Ljd94kcpg6/qIXTuja0ma
         b4Nd8XIpaoV1hF+FBev9YXB6bMiG2vUgsbCyFVc9Om/UigDWDP+hCRP4YI/ktd9lgaBb
         NtkxLDNXI4oYlmgb7LXlGOYbC8RXoF/MWHUxcCIZUo/Mf6ODbKEWdZ8VT6QTpS0PPDmp
         p7hiJS638aMBjz0YgbbmLB+vQecNeKp5Z4lKw9bh670cQGLvRUWV9CykWbPCHPeN+uWg
         X8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934051; x=1781538851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eWzdVvtwrg/9Udw9VbeX3BPtsMxiS3OGz6xe4/WajU=;
        b=LxpZAY4VMo02aJ4N3j1MwVxUhc4exv40o45KfhcKvtLuto90WfQh/MS4tvqLiCjs8c
         i7A2BCTsHQ+Q0KepegFBLm9K5U26IIhOQTV+1985P26MVB6+H4MmW6wM9OxdeiGswCL5
         P39/TzrI/hbz8fzl3uW6O5fCt8AbD66En5etIajhqE7XWBCVdsiqsmtOmNqiYFqmLxZm
         LS1p0qq4rqNz3m2MXL5oZudHiPJNy8siCD8lD6ObjD3mdya9PGzoT0477iU9GBinf0qP
         G5GRf2KSFP+LR7mguy8I7LY+5vlkgoCCZ4r/+9AkmYvljsKbPcOqrQhrwgxhf2bdw40b
         1j4g==
X-Gm-Message-State: AOJu0YzW7VJ8allUNmQ0hvnAFOj537DmhactXwgvlUTaKF51pppqDe2E
	BI5mupK+eDPrzfzrw7JRbuPkwyTOirUQzAydw4ZkCdXYTd2xv0yKMyG3ZW68yo6lTsjuhvyTAE1
	1XmonGJAD5znrpAgR2JWzDvJ4NhOwKsjVR5F57WxWSdErR3P4qNTwlJOByg4XxmLUjU4=
X-Gm-Gg: Acq92OHFIo3CDtfprNnMp/Lkl8NgoR39ucvStqz0gbsWeI8PCGrKCfQMME6lF03FXH5
	oaWMU39HTe7TCF0rlBRwUfeWjZD8mzG5riJkrkSfyH62XQBKAsuwR39MzVFiw89Q4VzDN5Bt80X
	8LrOHHtO+52vWEU9Q0SWGa4BQYtvrIr9lag4LmLr+BykOnHJA9X1sdlv+DOUhyUPOK2udICzIZb
	kwpOoVrDUSuwmaRmW4MZt1kHPMiz5/1XfBgL4+IxUM9k9OJGNJ7GTbgolq+gPyIciV2sPSEnmLo
	xd5idKzDRizW3YTOG5lN/halyEFjt5b/uQRp0T+W/U4dQr4QB4wH2YlPEyHhVobUsDW2A/LYrmQ
	by2HY/Be09UA92GU4XgQ38Uqojavk2/+30zefSl9sRWTEzpavKoF/xYqhQdM20Djn95eJVAAViG
	p4
X-Received: by 2002:a05:620a:270d:b0:914:b518:577a with SMTP id af79cd13be357-915a9c741bemr2489281385a.21.1780934051015;
        Mon, 08 Jun 2026 08:54:11 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:914:b518:577a with SMTP id af79cd13be357-915a9c741bemr2489275885a.21.1780934050376;
        Mon, 08 Jun 2026 08:54:10 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net. [100.17.17.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm1802802485a.35.2026.06.08.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:54:09 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Mon, 08 Jun 2026 11:53:51 -0400
Subject: [PATCH v2] cgroup/dmem: accept only one region per limit write
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxb05K68h6GBbRDmUQomSJqC
 He3cgKX7yf/vU1kZMIsrtUmGFfKlKYC+lQJP7RTRKBQWGiprbTSgI+cnjOEEUd4MS0Imab4QGC
 M5Quu66XpbHDOBFEsM2NP76NwbwoPlJfEnyO4qt/6v3tVoMCpS91rZ03t/I0xDO1y9mkUzb7vX
 8q1ufbPAAAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16735-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,m:echanude@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69229659240

Accept only one "region value" pair entry for the dmem.max, dmem.min,
dmem.low files.

This changes the UAPI that otherwise accepted multiple lines for setting
multiple entries in one write. No existing user is known to rely on
writing multiple regions in a single write.

Processing multiple regions in dmemcg_limit_write() could quietly change
first limits before failing on a later one and returning an error to the
writer, with no indication some changes occurred.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Follow up from discussions on a previous thread[1].
If Albert's series[2] lands, I can cleanup and prepare some kunits for
these as well.
[1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
[2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
---
Changes in v2:
- Handle buf == NULL by testing !buf first after strsep (Natalie)
- Don't allow extra spaces to separate key and value (Natalie)
  Other cgroup files don't (rdma, misc), so stay consistent.
- Link to v1: https://lore.kernel.org/r/20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com
---
 kernel/cgroup/dmem.c | 69 +++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..39930c59cb769a505a5852a5644a371fd5596f59 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -734,57 +734,38 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
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
+	if (!buf || !region_name[0])
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


