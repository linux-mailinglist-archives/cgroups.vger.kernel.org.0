Return-Path: <cgroups+bounces-12344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5116CB7D10
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 05:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC443007AAA
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 04:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888042E7179;
	Fri, 12 Dec 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9ypQ6VR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nS+DDiXr"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441C2D3A80;
	Fri, 12 Dec 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512073; cv=none; b=HKV1/PJrjUMrpCGGz60BGLIpDtLMAjMKjioDYiTNQszNJVkT+d6zvp/vwDi3yO/MboS06W0e4xKj5nARZHMUbZLBaeEbM/OqxKkO7Wv73sqCO17sUdBf+IoKOI2ehb5771EhbislqaU246qgRzNFadXIvKQ9XexVg2GXMwKV5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512073; c=relaxed/simple;
	bh=M1MXTq6khZ0mBBbsR/NvZrA+QAnSBwPz6H2xDQRZpic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhAgHznOGrcr5bG8CwGK8+73SUIJcQcRwKjhgZEufTJYYGrBVtE7rYwbG7SDIHCEWhCnLTxY+qY4sdQJkkc6t3/F7+cPJJURyjGww5BwqIi5adsQ+idVGPnaV3hdZ2+0JNM3LHxraTk2HWuzoqdfASiXF/zdjeFgMPKk2PiY13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9ypQ6VR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nS+DDiXr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765512069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Peetuaq8QBsA+6kTVKwkW4IXVCkvgfmZs2jbziI9Asg=;
	b=N9ypQ6VR5PSPjOT3EnOoq0c2cSZo4hWU+U1G7lR12R33TU7F8IGVpxoWhWqyPu/F+rsTrE
	cdexsGWFBUbzq4yW8sZfCwhzEaZoNrtLg0uSWI5gpzDGAfUAnv8hvYblHH2VgeX/PFwszI
	R3OkaWRLOztmKACBCwM6TTpEe8UXy5pKgpGaAuRlBE8EjOPS/CyYSFuSrmxcWCT6UfcI1B
	81hbMiNk6BRnTjEJHvVCfND3WMZeMbl18aZGnV5Nsnejqovn5B6m9BJkoVlf0tLLzvZvMG
	NfKSTNaxWMXYUz0er/V9a65uJ1Oc5sWOuTRAAReu3Ki+MvrTQyQ3RgLpSla8+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765512069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Peetuaq8QBsA+6kTVKwkW4IXVCkvgfmZs2jbziI9Asg=;
	b=nS+DDiXr9oNcisRHBFiRg8d+rQdbl4yeRMwRgvC4WMgWIDLBiHM8pQxtXQIJcLqqSqEzOB
	AYLWDE2NW86BbNBg==
To: Chris Mason <clm@meta.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Chris Mason <clm@meta.com>, LKML <linux-kernel@vger.kernel.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: [PATCH] genirq: Don't overwrite interrupt thread flags on setup
In-Reply-To: <87ikece8ps.ffs@tglx>
References: <20251212014848.3509622-1-clm@meta.com> <87ikece8ps.ffs@tglx>
Date: Fri, 12 Dec 2025 13:01:04 +0900
Message-ID: <87ecp0e4cf.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris reported that the recent affinity management changes result in
overwriting the already initialized thread flags.

Use set_bit() to set the affinity bit instead of assigning the bit value to
the flags.

Fixes: 801afdfbfcd9 ("genirq: Fix interrupt threads affinity vs. cpuset isolated partitions")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/20251212014848.3509622-1-clm@meta.com
---
 kernel/irq/manage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1414,7 +1414,7 @@ setup_irq_thread(struct irqaction *new,
 	 * Ensure the thread adjusts the affinity once it reaches the
 	 * thread function.
 	 */
-	new->thread_flags = BIT(IRQTF_AFFINITY);
+	set_bit(IRQTF_AFFINITY, &new->thread_flags);
 
 	return 0;
 }

