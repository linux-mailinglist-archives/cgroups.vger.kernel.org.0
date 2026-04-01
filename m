Return-Path: <cgroups+bounces-15151-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCB4NS4fzWnOaAYAu9opvQ
	(envelope-from <cgroups+bounces-15151-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 15:35:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526637B502
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1EA5301A2A3
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D1402B81;
	Wed,  1 Apr 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPFAPLuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2NnAtDtW"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CE363C53;
	Wed,  1 Apr 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050059; cv=none; b=t6JyrISx7kDtCtc7DaWRbSh+M77hOyvbpL9KgxaRaaEW2dCZ+v8eV1Ik5ZmmnGlu9c3+XDV7nPBe/jbcqFc6hZpsIzDmRovxL33dsa097QSts/kND39SQmF84pg9qwnQsFVeqSfPiXT5BmdSK71Dj/rZtic2weW+i0PmIZipR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050059; c=relaxed/simple;
	bh=MGYfHI/VK96cylgHV5RTluaS0pxn/k6RPVF4wqbnFi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftgsbm+Z5vOXCEQffNYV0FkT9wf46Uz92Qg+jppIzr7cKOj080U/cB6LeEEBTdJpiSuY1WO5qMnpyBj8W+zxy1tUVOxI8vC1KSDZbVZ4DfcAGUJwg11ZfepvkuFgf98RTzYztiatasVi/gwCN67hZ5N10u6YznOSIOCUcLMzstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPFAPLuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2NnAtDtW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 1 Apr 2026 15:27:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775050056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4+Olcqmvi+0+dfpMQs4zkCIa0CRkPud+Lj6I1SOjEM=;
	b=yPFAPLujVWLCh94VjMJukv4KjYbdK+0aBDMkgmSdm74xpzO+7hdiCFXAuRDd2ubeagizRc
	94bC4Q0CgnezbBFqhqf8saGzcPuqOhn9VCOZPxY29C127Ik9PrYUDAXJEE45J/7Dne5F4+
	rsxFQg2UJKwy85OBXNes38buU+5nwP4/7phmeawWo+xecSdAcpB6KlPtcu5FsYlAGjk7on
	b3510mbpaO+ntfiovhdqU691MdWsIzcXLuWz7xe1ZxWun+ztqoOaU34AEWraxSArqib64O
	zcRV/EkSPkjtlGdkFyPml6B3+FrgJ9SgJ3j5jvsR8AN4+qWJhkpZ27HEn8eoZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775050056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4+Olcqmvi+0+dfpMQs4zkCIa0CRkPud+Lj6I1SOjEM=;
	b=2NnAtDtWAq0edIy/9y+vcqPwXVwFpxjtvpkvzECm5hC1JI86ivTM0t3SVYpDSMZ8BWxzV2
	GsISqzDHZt/H+JAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix cgroup_drain_dying()
 testing the wrong condition
Message-ID: <20260401132734.QQ8M2KA2@linutronix.de>
References: <68d8881fd985a410c0f619f009334c28@kernel.org>
 <20260325180623.EcyNsp2L@linutronix.de>
 <acR3fYVD_blwD93_@slm.duckdns.org>
 <20260326073511.0rcA5AGb@linutronix.de>
 <acbmKQR9hSGhLBmh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acbmKQR9hSGhLBmh@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	TAGGED_FROM(0.00)[bounces-15151-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 5526637B502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-27 10:18:49 [-1000], Tejun Heo wrote:
> On Thu, Mar 26, 2026 at 08:35:11AM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -7141,7 +7143,7 @@ void cgroup_task_dead(struct task_struct *task)
> >  {
> >  	get_task_struct(task);
> >  	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
> > -	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
> > +	schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), HZ);
> 
> Can you try schedule_delayed_work_on(smp_processor_id(), ...)?
> schedule_delayed_work() is using a percpu workqueue but the delay timer can
> still migrate.

So, this works and I should have known about this. Well. No more race
then.

This keeps the option open to switch to queue_work() if this approach
ends up problematic for isolated CPU folks.

Thanks.

> Thanks.
> 

Sebastian

