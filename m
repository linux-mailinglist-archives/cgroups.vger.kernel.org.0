Return-Path: <cgroups+bounces-12341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E4CB793F
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 02:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91D873016360
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C371285CAA;
	Fri, 12 Dec 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lMK13D97"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF62D27E;
	Fri, 12 Dec 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504299; cv=none; b=UpakWpjyLd/gWk+TBiT2vAusOIObD1jbnZmjx/5U4ZI1TE5fAXdd5YrVsNYdq3yz+Ri6felVfhdGc3p11pnuMYoJ5u+f99boHqQ8MKJ7VZ16fAWX+2pMp34r1SDKw82Iij5/g0gPhxh7qzndr+eIPvZrpxeqtLswM+enooMM7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504299; c=relaxed/simple;
	bh=e8OMPmPEvM6+jZ2KMi1V0F5GVocQAnRAQ/KUJUAdx2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GatZfywfwiza9jteL6s3//oRp6XrTYEJFbsXjvR74ijGL50CRzhC8Awm3PKQDZFyvQATa0ZoYgSYC2GYTMN6ZS31BL099asmnFqGDnjHomh2nL9RQORRn0jhMxyHRKCGgVDuE3AUx7T6gRQaH6dO9PDjUg95Mvnvug3Da3EfKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lMK13D97; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBMtGYY3758554;
	Thu, 11 Dec 2025 17:51:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DsP0sR7RO0MsOgdqRluFf1PhZbJndx8XPOwmE1GhOLE=; b=lMK13D971vkV
	8JWikSyaO4QbSTLq5AFpvqv1mBFhT2iLzwOJXj8AKCWciwPpts/Q0ryXl0zZvk+8
	xfbAX5FxsuzCsQ0dBGqYeQYZKmjA1/e8ogG44bpMjHqI5RV7EQ2e81y/F0lFa5sy
	1AMWKFtOfMAkfOeWq7q8D4jm+2kx9wf5f8gxD5QBCTe/5IqhIT+d+NzeZzDrsRcp
	Brc758U6Zaugp+E9HvycQG7poBtBce1CebF3RttDFCNv99OE/7KmwMe7AuCJdg1M
	Cm7DlWvwKbMoXBZwD9/quKYdu/YSeCNiqiwzvLtlgw3DDk/FjFelCNudMtKNke1B
	GJdjeVGqkg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b03aekuu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Dec 2025 17:51:15 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 12 Dec 2025 01:51:14 +0000
From: Chris Mason <clm@meta.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: Chris Mason <clm@meta.com>, Thomas Gleixner <tglx@linutronix.de>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Waiman Long <llong@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/3 v3] genirq: Fix interrupt threads affinity vs. cpuset isolated partitions
Date: Thu, 11 Dec 2025 17:48:44 -0800
Message-ID: <20251212014848.3509622-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121143500.42111-3-frederic@kernel.org>
References:
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDAxMyBTYWx0ZWRfXzMP/EEDF369O
 4fRP68Nkf3VTw5hMTde4nH/vpvgfb8/b+CebCT3yq7pTynQGeAZ9gL3D+G5Sg+bGSc11s0yiH+D
 oJj5mX/j+EZKyaR8kkzpZTBpmlP5QIizE7l8fhYAinHZ6ymFO2Sq8PvrKSPaqqwxM/1Xc+DUVGp
 2wGaVMjvWQIjc8IO6qEBFGC7D7Z0/1qg356JrE/GehskuxzM01XSChaOJ+9E/rRC6Vr8pKjuDqA
 trMnWvbEH93R2YqXxpNu4M2F+Ph4Pb/GSKw1rQyBdtUAlJaXplUxelZeWILPvsYinm/AcvO05AF
 9b886bMUfo0++ltVuH1a8w63eUEp1Wee21an6zioyxSeGYtLmKwTSw+W78G69hGOe0ofaTBhmG4
 yNbFWxrCgQux8BUcejOTrk3C1FCE/g==
X-Proofpoint-GUID: S2Lnf-0Nh8kiLTn35f6IWEMveBB-BM2f
X-Authority-Analysis: v=2.4 cv=ZLraWH7b c=1 sm=1 tr=0 ts=693b7513 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=iwC55-sD6TGeIifvq-EA:9
X-Proofpoint-ORIG-GUID: S2Lnf-0Nh8kiLTn35f6IWEMveBB-BM2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01

On Fri, 21 Nov 2025 15:34:59 +0100 Frederic Weisbecker <frederic@kernel.org> wrote:

Hi everyone,

I ran some recent commits through AI patch review and it flagged this one.
The comments below looks right to me, but I might be missing something:

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c1ce30c9c3ab6..61da1c68ff82a 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1408,16 +1408,23 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>  	 * references an already freed task_struct.
>  	 */
>  	new->thread = get_task_struct(t);

[ ... ]

> -	set_bit(IRQTF_AFFINITY, &new->thread_flags);
> +	kthread_bind_mask(t, cpu_possible_mask);
> +
> +	/*
> +	 * Ensure the thread adjusts the affinity once it reaches the
> +	 * thread function.
> +	 */
> +	new->thread_flags = BIT(IRQTF_AFFINITY);
                          ^^^

Can this clobber IRQTF_FORCED_THREAD?

In __setup_irq(), irq_setup_forced_threading() is called before
setup_irq_thread(). When forced threading is enabled,
irq_setup_forced_threading() sets IRQTF_FORCED_THREAD via set_bit():

    set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);

Then setup_irq_thread() overwrites thread_flags with a direct assignment:

    new->thread_flags = BIT(IRQTF_AFFINITY);

This clears IRQTF_FORCED_THREAD. Later in irq_thread():

    if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
                                       &action->thread_flags))
        handler_fn = irq_forced_thread_fn;
    else
        handler_fn = irq_thread_fn;

Without IRQTF_FORCED_THREAD, the handler uses irq_thread_fn() instead of
irq_forced_thread_fn(). The forced-threaded handler then runs without the
local_bh_disable() and local_irq_disable() protection that non-threaded
interrupt handlers expect.

Should this be:

    new->thread_flags |= BIT(IRQTF_AFFINITY);

or:

    set_bit(IRQTF_AFFINITY, &new->thread_flags);

> +
>  	return 0;
>  }


-chris

