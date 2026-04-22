Return-Path: <cgroups+bounces-15460-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPcxJ73U6GklQQIAu9opvQ
	(envelope-from <cgroups+bounces-15460-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 16:01:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47D44703E
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC903069FF9
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BF3DB626;
	Wed, 22 Apr 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b="Rq8iuJ++"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2663B27EB
	for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866228; cv=pass; b=MfMDnpFZ+MgC5vgMQUxZos7HKphpQZrFoYDwauEFwJViG3Rp8+NjGCQu8u5Fb6NbWg5pVn8ZYfdqzYJgp4nM0pl1NXc5T71MHIGh/B5Bv9M0Et5iOddZjqPYgj+F+VFcB9etWw+45V8oGzrhH/8Z6j6e/KC87vT57t/1hXnpg0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866228; c=relaxed/simple;
	bh=l4YU3bB4RJnlC8XPxjBgonIaVQqpVmuVMJX+gjvuQ78=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=AC81GW+frGTMl+g+q5HBrXrzP8QWz2lcVlwVXrpy/p8CugHtymUL48C27CvAh2R44ZWf8a0UW9EJG2FADSE+sOVLjBRy8lF+BRsfR2rKPXZwADc7A7JHJFyNNST4ARQUhdMDlPl7lHYUaIR2IfflKl7Zrn1KZGEJal8uZx3eYC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b=Rq8iuJ++; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-953ac1602f8so3804315241.1
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 06:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776866225; cv=none;
        d=google.com; s=arc-20240605;
        b=M48blgAGC4XyZbMaFcUVjycKXfe1tQg4vm+bHLlUg2kQ83fqNxMCKN3klsdOZ7cjNA
         +BY3Jyj3o3tR/rOMxqi5yf8UhQJYeOTKwfDZWQrs5xx1F+B6D2tir3z9jKyA1JHuYa4g
         /VP6BdwJbunUX7gi18NO1QUBuGwj2JUt4EuSYBc9KFyhcxNQI/5wg4lFku1eouKxnyL4
         yG3lFIkg+qO5cTuExUDjiiqLR0Wq9EUg3keq75DNczCaEW2hNQSV4c+mSo+nU0udn6gg
         BAyt0F0OHTARyrnBlYSkZ2yCJp69HHRolPEqN4K3rLbVRXcomvkRaPmxdhyZm5KPRqMS
         2UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=xGFyCFFG1EkWA/b2EA9XlJUl05rNyK01irvoWYc32Bw=;
        fh=JXicV0gJ9suSKGEfX89+Vg3T/sMWy3CY4UnXqixp7dg=;
        b=R7RxfQBkQLJUoDsl6iB+JOqeTeywDTlTXUcb3BYmNxPCuPp/JtM+onpQIXqVOWRgny
         2NeBo/6zEBCfA6aiW1XMvNHiBqFKfQyGxiljhIS5wQmSLMsXpSc2fA1ErcO3Zesce5GO
         3zJL2Pg+jUOrNMBkcLlvoa3HC2+tlPhgrzwQosXsQEIGsqd6ZSLbUsRJ+L35akdHSW9S
         sNiqOyuS1ECwy1f1+XWzAO+2oiDDXWPTFW4/pLITZ6w78lNVoK5IpM84dW93bkkrwpZs
         lAzQGIWe9mbdp0YuZlb6SyZY311LpIBlmXzRMOnbOCvn8fuEID0MvkGGmugnOH4kzYZ8
         F/wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20251104.gappssmtp.com; s=20251104; t=1776866225; x=1777471025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGFyCFFG1EkWA/b2EA9XlJUl05rNyK01irvoWYc32Bw=;
        b=Rq8iuJ++Cc+dJe9yypHhmqVCVEFPYRaanI61zGT5WuzuMl/Ej4cm0oQZ2RL+Q3MKm1
         VlFoonVecv9aPbyjB+Aiv4EZu55v5eSVjhqunB9RZUf5QCHRywbVlTdWXv2viLcc/FR9
         vBJwuxp788jc/Mk/YxhfCvAHIZVy6tIq49TQ2xSOWBM3ufQGyEQmRSCPWD80x5dS5B3t
         3xyVwg51XCVJeImLvVqI1W6uMofgKT+Yh2Mr31rp8MWFqYIygpRyQg77EnCWxn/5stlJ
         0MPzLnQ2A3dXy5O/V3aM+Tkxcn2tGE+AcXGJSt4sEIezxvDpaNhnLweg55wvSngjPLbP
         HBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776866225; x=1777471025;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGFyCFFG1EkWA/b2EA9XlJUl05rNyK01irvoWYc32Bw=;
        b=InFGHxe0zcoka9l7TEsbvJBmkwmhAWpY9T1ewFRFZCvDTbcfb/LsPIZGeENPJhiFc+
         ODTHLb779rodk7Hy02YR1vFgvyuMR+Z2/oITXYz5oDP/jMgwEBSeRNA8iDkGCPc7z9CP
         IimPSAga9tBRIm4LFHp2fPYMzHiE1dyHZ6bdLeRz8w7Cygx2wRzgiCsRDV+czkBzwh0h
         Iv+0WRszrYKeshLtR0xZHlq4uoI4JGPptqohqxqbzU0ZuWb/GMszHItUTAAn1sqPX69Y
         PLpg4wYaqdicmGCtzVnxJ/ahnWHV/tyokeLm5JNzMw06q0sX4srmc1XMy9sWSzfi8Vee
         ix6A==
X-Gm-Message-State: AOJu0YxQgIRQEgjDNjS95uzdWCW8rcLLHC3ii6/+IGLyV2BQ7wMHt2dC
	7yzAp5CSDPnOY8XSBaDOXFXxxRUBtY5qjlc6EDWB9vdracblSyoq7d3E71dZT3oN3D/q9ETDVv/
	mlIGY4jO7HLLEhk01m3h1A6d/xbxjtATut5YTy/dBZECihw+3XyA=
X-Gm-Gg: AeBDiesvftJd9MQhVACDxPRKMAPpljaV6uuuS3HCxNylVaJ8PVeKi0S/50NrqMlpwKm
	wuHmi4eQD7/yLPnOmC+qyd55Rwo+4sWUKH7iow4/z2lJwMwOnUuPZXPekpRTdYfnf3ZwQwWvpGz
	/TubxLGNg9xaQcip8pjXzj5PsKj+r1mfM6zaoWimbDJTa1MZUgqBtcBSpJxuHVQaRANEeouzIsA
	fWvyPcmYO+8zeBAb8CD1Qkxl9e8zO1LPwwEMLMYUoYipzwadELxnxSkVM6XUV1vxsOtmwSEbkZp
	9kUfyTkEvT7TBPwfrSaz/bw/ncuN
X-Received: by 2002:a05:6102:5114:b0:608:ce6d:4db1 with SMTP id
 ada2fe7eead31-616fb5837a1mr7192460137.3.1776866225012; Wed, 22 Apr 2026
 06:57:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 09:57:03 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 09:57:03 -0400
From: Petr Malat <oss@malat.biz>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 09:57:03 -0400
X-Gm-Features: AQROBzByWVjqbDioiwjxGKchCnZcXzf3X_5K7tde9xekXZrg1zTRSaqXxKf-3-I
Message-ID: <CANMuvJnpVSHNJ1=6Auw7zYnZ9w32J0mn+dw6PkdXi-WDU4Lrqg@mail.gmail.com>
Subject: [PATCH] cgroup: Increment dying descendants from rmdir context
To: cgroups@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[malat-biz.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[malat.biz];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[malat-biz.20251104.gappssmtp.com:query timed out];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-15460-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[malat-biz.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	FROM_NEQ_ENVFROM(0.00)[oss@malat.biz,cgroups@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,malat-biz.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8D47D44703E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Incrementing dying descendants in offline_css(), which is executed by
cgroup_offline_wq worker, leads to a race where user can see dying
descendants to be 0 if he reads cgroup.stat after calling rmdir and
before the worker executes. This makes the user wrongly expect resources
released by the removed cgroup to be available for a new assignment.

Increment dying descendants from kill_css(), which is called from the
cgroup_rmdir() context.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 kernel/cgroup/cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3243c2087ee3..c928dea9dea6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5724,16 +5724,6 @@ static void offline_css(struct cgroup_subsys_state *css)
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);

 	wake_up_all(&css->cgroup->offline_waitq);
-
-	css->cgroup->nr_dying_subsys[ss->id]++;
-	/*
-	 * Parent css and cgroup cannot be freed until after the freeing
-	 * of child css, see css_free_rwork_fn().
-	 */
-	while ((css = css->parent)) {
-		css->nr_descendants--;
-		css->cgroup->nr_dying_subsys[ss->id]++;
-	}
 }

 /**
@@ -6045,6 +6035,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
  */
 static void kill_css(struct cgroup_subsys_state *css)
 {
+	struct cgroup_subsys *ss = css->ss;
+
 	lockdep_assert_held(&cgroup_mutex);

 	if (css->flags & CSS_DYING)
@@ -6081,6 +6073,16 @@ static void kill_css(struct cgroup_subsys_state *css)
 	 * css is confirmed to be seen as killed on all CPUs.
 	 */
 	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
+
+	css->cgroup->nr_dying_subsys[ss->id]++;
+	/*
+	 * Parent css and cgroup cannot be freed until after the freeing
+	 * of child css, see css_free_rwork_fn().
+	 */
+	while ((css = css->parent)) {
+		css->nr_descendants--;
+		css->cgroup->nr_dying_subsys[ss->id]++;
+	}
 }

 /**
-- 
2.47.3

