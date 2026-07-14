Return-Path: <cgroups+bounces-17794-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xp/jETJJVmpx2wAAu9opvQ
	(envelope-from <cgroups+bounces-17794-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:35:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71E755E69
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=fqZ6Rgph;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17794-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17794-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F6FC3045ACF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6347F2E9;
	Tue, 14 Jul 2026 14:30:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5547DFA6
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039424; cv=none; b=TXYrdj7L/hJPpODZdYHZnBjEMnbtR4fjlo/duBjFGMMJppzjdnfYcfqDkRj2uo+sdvg2L/lv3X5gs9eEnSjwoAX6ixEkK22Xo3VEywFsGpvp+caQKemZrKrYgNwuFim68TyIcooEZk+hkd9kNDqPUJZWmexOfa1ugkT1T/CjCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039424; c=relaxed/simple;
	bh=zFeWDdafDoYi7ea+8KDHKiNyfn2RCWSEnlN5ywMFr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRwkp8Pfuibi/zcgOcSph5G2Nso0pqR8p5MaEZ4fxd7fhOIfb6JUc5yU5JeujgEFqJTIKTZv96fR6wus3KWv+FCBletcncWfbAjQakzgJd0u2wh6rtJmm4VKR6+MZifkEB8bSEducPyiuFrFVK+9YVoBgGkgLMILWp7/L17mLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fqZ6Rgph; arc=none smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aea9d606f0so4498241e87.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039420; x=1784644220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myAuJMzKK/4iG9Cmnf7VPvLoMfqifqNKwX3ebA7nias=;
        b=fqZ6Rgphmp6BfB1w3zQfLmRui03bV4pkN21UgZ8ba5Gcn1E10qX919G0ei3ilz0vOL
         yjrfDDypdVHXPgxRRGPSLzNySRnqryAZl4sQNNFNo1XWXKs3M2/iTaRsYl9rtqeVuQlw
         aeOqsAnJBNv6qDiuKHkJJaxQzqdknxGgmYoSglXffqwf4LsguOXRdQC0UQ9i3Sm8sCbP
         HFrOeq3bdbjAsXd2WDs8+Xz6m7tykP9OD9Zb6QJU+cxN0OtuDK1DRr2YGYOlTt+zD3M4
         dm18+Qdy4iEm7ZsIwvi6xmdis4jmF4CJGyxqHBO8QyUXFcsryoQxRzNmhCy6Kpyy4fsl
         4olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039420; x=1784644220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=myAuJMzKK/4iG9Cmnf7VPvLoMfqifqNKwX3ebA7nias=;
        b=l6mwVjhX05ETN9gbelkwUnyxYnw/X+cjhia9EqdHFnxkuqzd6VZ2/97jZSU5AdVKms
         sfK1oMU5QqVQ+TccYS84Y1dXjz3/avJgagUd61nRhgkiauTMrwtDREkD8UoRY/XQlQ/V
         UH44lX0NAvdukpeS+pVTvDwUR3fsKt1HUuSdr97n+T8OQSulzIsScoVZXApMn13JoCqi
         h/4SVHERVMHmlqLF9bbmzJGz31U+y9yIOgg+9dXVLT8eFdaHkNqIN7yWyz/z0TX5uzHs
         b4Dkpb2ovsvyjf4Uu4QgABx4WgG0JvR+lGvCSRm9UALgTAmtAw+QM8mGhyxK+mQrreHf
         kxhw==
X-Gm-Message-State: AOJu0YwOcb/96N3nKZd0Io/8MRa4z+izPVkMSU4qTBj3vRBzKxtj0WsY
	FErCaTgzKLMeo3Z8Dmu4UEaQpZk1i8lbdH6uQAuCAdCELFi62Nm+Lk+kQBudsNvoZYk=
X-Gm-Gg: AfdE7cl+r/6EjKQXqV6KTtSJqCa9U59P4Yp9Bji4OkyTBp7s860CllZX6u5rRd0GRuv
	A+S9J2FvhYxVePVITnjPfTe6rIRNDSeyChVsVs4eV6QgRS02QtYqoLj33EmYNF2SkVzZpPCHw4H
	1jIfcdzJfW4zV5gA4WsdLU7/ujBwoqoCuttKCt9kQynHfZOBFkooaJ8fMRITiDc8Y2KFNRMgUrR
	N8PSGUx115psZDGAWDt2o78GVE3pvuIiwISoHRE+NPuJo039BJgNHE4SNGPHCSOb3I2gJT1kiPp
	aR72RHD1Wf78fDnobMz20Ci2jDEddT2mTy6toREwpuebHQPWv5Hg7holOlI8z2CZVmJcT+hKXHM
	JI0a0f+lAJmqF8hcNw8kqU/PpUiOVzDwl3/lN9tJQZx4W5AkYxfipg0+Abq/6SUsBID1mZrhm9J
	/dQ+zM9/+asYD9620gfomXXg==
X-Received: by 2002:a05:6512:21d:b0:5b0:1428:cab9 with SMTP id 2adb3069b0e04-5b0236bb426mr2001205e87.50.1784039419732;
        Tue, 14 Jul 2026 07:30:19 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f90csm3589518e87.21.2026.07.14.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:19 -0700 (PDT)
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
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 12/14] RDMA/rxe: Allow queue VMAs to outlive ucontexts
Date: Tue, 14 Jul 2026 16:29:25 +0200
Message-ID: <20260714142927.1298897-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17794-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli.us:from_mime,resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B71E755E69

From: Jiri Pirko <jiri@nvidia.com>

Prepare queue mappings for asynchronous ucontext disassociation during
device disable. Rely on the VMA page references to preserve mapped
memory until the final unmap.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/infiniband/sw/rxe/rxe_mmap.c | 35 ++--------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 7f723a2f3700..a4ead89ccbd3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -11,7 +11,6 @@
 
 #include "rxe.h"
 #include "rxe_loc.h"
-#include "rxe_queue.h"
 
 void rxe_mmap_release(struct kref *ref)
 {
@@ -30,29 +29,6 @@ void rxe_mmap_release(struct kref *ref)
 	kfree(ip);
 }
 
-/*
- * open and close keep track of how many times the memory region is mapped,
- * to avoid releasing it.
- */
-static void rxe_vma_open(struct vm_area_struct *vma)
-{
-	struct rxe_mmap_info *ip = vma->vm_private_data;
-
-	kref_get(&ip->ref);
-}
-
-static void rxe_vma_close(struct vm_area_struct *vma)
-{
-	struct rxe_mmap_info *ip = vma->vm_private_data;
-
-	kref_put(&ip->ref, rxe_mmap_release);
-}
-
-static const struct vm_operations_struct rxe_vm_ops = {
-	.open = rxe_vma_open,
-	.close = rxe_vma_close,
-};
-
 /**
  * rxe_mmap - create a new mmap region
  * @context: the IB user context of the process making the mmap() call
@@ -106,17 +82,10 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	list_del_init(&ip->pending_mmaps);
 	spin_unlock_bh(&rxe->pending_lock);
 
-	vma->vm_ops = &rxe_vm_ops;
-	vma->vm_private_data = ip;
-
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
-	if (ret) {
-		vma->vm_private_data = NULL;
-		vma->vm_ops = NULL;
-		kref_put(&ip->ref, rxe_mmap_release);
+	kref_put(&ip->ref, rxe_mmap_release);
+	if (ret)
 		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
-		goto done;
-	}
 
 done:
 	return ret;
-- 
2.54.0


