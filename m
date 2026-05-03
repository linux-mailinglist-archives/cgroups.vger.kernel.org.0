Return-Path: <cgroups+bounces-15581-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I6uL3hT92mqfwIAu9opvQ
	(envelope-from <cgroups+bounces-15581-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 15:54:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6724B5E9F
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB363009573
	for <lists+cgroups@lfdr.de>; Sun,  3 May 2026 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159063CB2C5;
	Sun,  3 May 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b="WbGWTHzr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.piware.de (mail.piware.de [37.120.164.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475323A875A;
	Sun,  3 May 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.164.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816436; cv=none; b=oDYRKo7aSnivWkTH1ylM7fBinmgj5NIGlYfrShpGby8l87i9TfG7IN8sE7/sj9gVaNGcx8SNjGCm3bqi+qJlPSeOMXwRuMMcvdQy3ILM+ynwikYZ9rrXiLTBJ+aoiuGtbjfnTswNmX7mizZsyRJyMHdjnxE3R9kAAd31mjFvS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816436; c=relaxed/simple;
	bh=+/QBPDKuejX5RK9MIlRm6Y6hQS92z0N8GOAF3fBZaoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psscM+ZPAtX12a2gqUW3mO2ZAy49Engp8dNqWjsY8/Z5jeCaEmQRX8vzDNh3R4DWNYomN1N+bt9oKUs5Uot6lXLF8zcmfpbHfu77Q8Vs+uBn83l+I4OSSDiRoN1BDpfokf7YX12nvMCkZTDjyUKZuxnUpRLEUs6VkpsM+inZSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de; spf=pass smtp.mailfrom=piware.de; dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b=WbGWTHzr; arc=none smtp.client-ip=37.120.164.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piware.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piware.de; s=2025;
	t=1777816426; bh=+/QBPDKuejX5RK9MIlRm6Y6hQS92z0N8GOAF3fBZaoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbGWTHzrPdPzmLCNmgDDQXwNuLINgouT2LkJze9DC8qU0QOKyeBE44UR2c7SqYv4p
	 H/NU/d2OS82GIGmrsGtk1xRdtOReK/NOYJCS4MSG+ipvgZ/DRGgAK1rTzv4RFiwZ5p
	 d94gfp0L3xKkFVknttVjE8DYEMDWmg1JwN8rhErxeDJyTHz4ggC8RwQ0BXL4WiBe49
	 2bqsIsnSYbN68MBnDflcrANzwgvR6RCGCVGsY5FwwRamUz2g5fdD0HTLr6Gy/B+SoU
	 MznmknzjoPL2v7JpoDYqEfVZ0Sv+JHw4Ro5sEZ469sTOu5Levmgej43vojEJse3Wxl
	 lZeFkxnA4kKNA==
Received: from piware.de (localhost [127.0.0.1])
	by mail.piware.de (Postfix) with SMTP id B0F4CFF854;
	Sun, 03 May 2026 15:53:45 +0200 (CEST)
Date: Sun, 3 May 2026 15:53:44 +0200
From: Martin Pitt <martin@piware.de>
To: Tejun Heo <tj@kernel.org>
Cc: regressions@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 cgroup/for-7.1-fixes sched_ext/for-7.1-fixes] cgroup:
 Defer css percpu_ref kill on rmdir until cgroup is depopulated
Message-ID: <afdTaEBPqzYGnO4n@piware.de>
References: <ad3b4597f3df81914b871618535370db@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3b4597f3df81914b871618535370db@kernel.org>
X-Rspamd-Queue-Id: 3C6724B5E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[piware.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[piware.de:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15581-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[piware.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@piware.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[piware.de:email,piware.de:dkim,piware.de:mid,copr.fedorainfracloud.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello Tejun and all,

Tejun Heo [2026-05-01  8:31 -1000]:
> A chain of commits going back to v7.0 reworked rmdir to satisfy the
> controller invariant that a subsystem's ->css_offline() must not run while
> tasks are still doing kernel-side work in the cgroup.
> [..]
> v2: Pin cgrp across the deferred destroy work with explicit
>     cgroup_get()/cgroup_put() around queue_work() and the work_fn. v1
>     wasn't actually broken (ordered cgroup_offline_wq + queue_work order
>     in cgroup_task_dead() saved it) but the explicit ref removes the
>     dependency on those non-obvious invariants. Also note the
>     pre-existing cgroup_apply_control_disable() race in the description;
>     a follow-up will defer kill_css_finish() there.
> 
> Fixes: 1b164b876c36 ("cgroup: Wait for dying tasks to leave on rmdir")

Tested-by: Martin Pitt <martin@piware.de>

> Could you give v2 a try? Same defer-the-percpu_ref-kill mechanism as
> v1, with an explicit cgroup_get/put around the deferred work to make
> the lifetime invariant obvious (Sashiko bot review on v1; v1 wasn't
> broken but the explicit ref removes a dependency on non-obvious
> ordering). Fix should behave identically to v1 for your reproducer.

Sorry for the delay, I haven't built a kernel in a decade and not ever for
Fedora.

I applied the patch to the Rawhide 7.1.0-0.rc1 kernel, it applies cleanly
there. (I first tried on top of 6.9.14, but there are conflicts.)

  https://copr.fedorainfracloud.org/coprs/martinpitt/test-fixes/build/10419932/

Usage on Fedora 44:

  dnf copr enable martinpitt/test-fixes
  dnf update kernel-core kernel-modules-internal

(This assumes a cloud VM. If you use the full kernel, update the "kernel"
package as well).

I ran the cockpit-podman test that originally triggered the bug, as well as my
reduced variant, against that patched kernel for 50 rounds each, and it has
consistently succeeded.

So this works great, thanks a lot!

Martin

