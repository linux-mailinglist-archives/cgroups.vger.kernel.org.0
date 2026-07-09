Return-Path: <cgroups+bounces-17615-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vOI9GPpwT2oigwIAu9opvQ
	(envelope-from <cgroups+bounces-17615-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:59:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C159872F3BF
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=EK2qKbHj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17615-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17615-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6808A309B780
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FE404BD8;
	Thu,  9 Jul 2026 09:56:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C14404889
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590978; cv=none; b=UQM81G3+85E/JEBngGT+7XJrfSr4QeZnaE1I3S3SNR9dCfJM/3Jr2VbM8G9WInUjHZ3nODg9qeiV1UG6XYcR/hpTz/y9ZglZ0mFNfq6O4G9XclLHJIziTTJe/1spxjYHfteEDSrgjdsxVFEptCI2mgg788jBWRRTH6NErVvHAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590978; c=relaxed/simple;
	bh=AlWKq+WCpJ6jqrd7bHxM+xUmQDKopJjD0aSNOnzQ77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giHDDSZPX2xhK45tw51xW07GcdYO0VE4DogwJ/HqzbqBW4hlaSSXMMPZCpZedqzODjJb+JhxkUkw2ZDmBgtS4rY+p2j2woOZcPBeFbk8TN+K/pAAC7q8Qp3CCr+FIu5uGji9Z3O1K1bYcuZkVJDgSJXA6zIT+fU1NgOdbVIWF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=EK2qKbHj; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso8765295e9.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590975; x=1784195775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=EK2qKbHjF/3hyZLJq5H3dLsl0XlAQpmpHO1Y1rUF/egg5KypMZaczFPeaQRkZVsBB6
         cSlc++ZZt6IckP+7sdSpgTQhf1V453QWIahFOXEcJeIPJi3/gLJrIsJ5RxOxKEg8MzcG
         MykQH4rHxRigN65mZPXdJG6s4duuT7FTamRX9keequsaiFTxSOea0I3PTFHEaYU6/oIU
         xjkRpoKGRa1IosbPqNIlOVlzaVUcL0XJMDKgiVVHcj5yf45h8TdA+qloac8TWbnYob7h
         IC4x2FE4ceW2wfL/UfycuSnSBYT9pc4ubMvTlJw3poeC8udAHJPmMP1Wi4qb9t101Mcq
         5iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590975; x=1784195775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=TQe6NMNJQAO9D6lYC1kIHW1Nuy+l66KysF0i62jTxC49Qb1oEOGUVDDs+dhxYjNEuD
         kavQ52HGwRt8o80IgGZhfUCBQ0N3YJEVPwgrPWrPI7wGUiFgTU0eKXncgRYMPZvRyzuA
         1KURH3FjiKf4Ry7XSj+hieEOCh77j8KqW9Oc7CRIZlPQ6Rf63xogpYzgEY0Q2Wr2dSZ1
         E1IG1FWre0k23w2Gzg4zG+EAaROwRdNv8zipav7D4SMNCfgs1mACU6kkFuuWarAHWuwE
         w6qGa1d3rBXUuxuhVAvpC8NM714v0BEumXZYyiJMIcXrW3WJYq0ljdW79Cek46aOEJD5
         gBiw==
X-Gm-Message-State: AOJu0YzjnB7KTDvnwA0z807PjtBu26baW1wucZOdYhFmJ4igP7XYfsBw
	SXaUKTBylIKKCY5dlpqZd3tEgM95cL9iSD5a+iN166gXal1sHVV2eaO7rxhmzdDT7gs=
X-Gm-Gg: AfdE7cl70i+GpJBc8bsc+vt4hqauQHj18h8r+uLT6QBK+22QysF5CDyXhcAPw7k37iS
	xxTf4XbjZSO/6+8RCi3gKi7KndOH7/5sEdi2GorF7YVkLzvCuRFD/kyo4i/S6HY0KToVMlVfBzE
	bnC+lm49TfmRxyvOQWISY+LMv51lpzRQWoFcw+6vwI1yxIWXI5qZf4SNyMEVsJ0bdy7IJQBln2H
	GGUrT1lz2p575EFGqF/a1EzBkPPHgFClc7oiJVCzJ8zphOWqVvwKRyawosdRhb0ydch6YMpx5xW
	E8kBR0c0WeuUyjQWXmdOTp/7BAZ0fxe13RRDsv4skBic4GejP8DHuzRkE+GKWVFW1BJwNkzxOfl
	0MAG0IRr2KjH/5A7+oKBXpt2036Hrd170SYTCb1G0F9ZSECuwGjBMuei9MIn2urjUFRG3Jff7m1
	CG3VukFWYsBLBtoEYyg14ZjA==
X-Received: by 2002:a05:600c:628d:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493e6862b68mr59669985e9.12.1783590975296;
        Thu, 09 Jul 2026 02:56:15 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742a49sm47241745e9.12.2026.07.09.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 12/13] RDMA/rxe: Implement disassociate_ucontext callback
Date: Thu,  9 Jul 2026 11:55:31 +0200
Message-ID: <20260709095532.855647-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17615-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli.us:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C159872F3BF

From: Jiri Pirko <jiri@nvidia.com>

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

rxe needs no teardown here: its user-mapped queues live in
reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
while userspace holds the mappings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1ec130fee8ea..6eb10d2f0653 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
+static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
+{
+}
+
 /* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
@@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
 	.device_group = &rxe_attr_group,
+	.disassociate_ucontext = rxe_disassociate_ucontext,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
-- 
2.54.0


