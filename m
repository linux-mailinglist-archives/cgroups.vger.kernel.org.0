Return-Path: <cgroups+bounces-17476-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4apCL3wR2qXhwAAu9opvQ
	(envelope-from <cgroups+bounces-17476-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 19:26:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CB704A46
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 19:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MNRWvWee;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17476-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17476-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C733027979
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB32F7F0F;
	Fri,  3 Jul 2026 17:25:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9A2BDC05;
	Fri,  3 Jul 2026 17:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099551; cv=none; b=i9mVUmBwU3uEmzml7kqXuQ1S/uaybndNZDKsTtps/VADN3P4QAMGGxgmo06Yn+v7SE1lz9DK/232wgTr0VTA4JdQb+EpXJ+oZbewMJ2fq15jxrO/+1HFKUQsglLyKwvG89XBreR3OvKoiG9aFcP/rR+AREKS32LpJ7R+6g6Nffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099551; c=relaxed/simple;
	bh=7K9RmVYbGp40h+Ep0Di+RHjbX7GJseyMs3XYdqrm3y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mViS7T+BirFls1AKm3/99MvgQqoxDSu9OdaOZbpX84x1+QFoxBijS6vBCCmCF/psBxThDRQKBakg1hnev8PJZygy06XiRaxMVtMzv0zuJCVp2QQhz44qvTuWlHbeOH3XKS8xQxGxjBImlxZltGDTdNqwOZN+NWz4BqGk28GdLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNRWvWee; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649371F000E9;
	Fri,  3 Jul 2026 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099550;
	bh=Yl6BXtff9NNLZZEGSACN98CKaLP0+6iDhiHs02YS8BA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=MNRWvWeeqT/1YabcJX9BBGr6X6OFjvnJ1hkWHBhmQu/e7lQTemc22YhtF4SrB3khP
	 7heK7m14ROaef2ZMC/0UfVPiQ+LgSgMZSNU4UA8W5XlQ0MJ50EPpyzFKQziLxXMzuJ
	 GfvUErPvrMF2Ta2HLN+O9YNzWLDv8ZrnDIrQmhqNjdkPSMT3VgcGrUwDg6A4tEaPw5
	 zpYApQLun4nZTzyqL/xMTOW2FGyTEKcAg45uZRcUsxVEVAr5XGpXVngNV7u8S+V/HN
	 eh9hXZUhSpTI+l7L9zD+TUpYDLrrcCWKdIBTMx4l04EcopUZIu3v+UfIHqMpdA4kfO
	 HjcPuKhbedDng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36BD5CE03CE; Fri,  3 Jul 2026 10:25:50 -0700 (PDT)
Date: Fri, 3 Jul 2026 10:25:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jing Wu <realwujing@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
Message-ID: <dcd36af9-0418-4997-815e-9e03ae52bde0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260421030351.281436-1-longman@redhat.com>
 <20260702033934.984512-1-realwujing@gmail.com>
 <871pdlphcc.ffs@fw13>
 <4b9bfc1b-2724-4507-b2b2-81d71eb79841@paulmck-laptop>
 <20260703061143.1658605-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703061143.1658605-1-realwujing@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17476-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:frederic@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paulmck-laptop:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 665CB704A46

On Fri, Jul 03, 2026 at 02:11:42PM +0800, Jing Wu wrote:
> On Thu, Jul 02 2026 at 16:07, Paul E. McKenney wrote:
> > wouldn't it work better to just leave all CPUs in RCU-callbacks-offloaded
> > state?  Then you can adjust the nohz_full state of arbitrary CPUs without
> > messing with RCU.
> [...]
> > a continuous stream of race-condition bugs inspired the current state,
> > which is to allow this state to change only for offline CPUs.
> 
> Thanks Paul.  That is appealing, and we would much rather not wade into
> the online offload-switching races you describe.
> 
> Let me lay out the one tension it creates on our side and ask how you and
> Frederic would like it resolved.
> 
> DHM's aim is to enable kernel-noise isolation purely at runtime, on
> machines that did not pass nohz_full= / rcu_nocbs= at boot.  "Leave all
> CPUs offloaded" needs the candidate CPUs to be in rcu_nocb_mask, which is
> only populated at boot.  So the RCU part seems to come down to two options:
> 
>   (a) Accept a boot hint: require rcu_nocbs= (or nohz_full=) to cover the
>       set of CPUs that may later be isolated.  RCU is then never touched at
>       runtime, exactly as you suggest.  tick / timer / managed_irq /
>       watchdog stay fully runtime-adjustable, so the "no boot parameter"
>       property holds for everything except RCU offloading.
> 
>   (b) Change the offload state at runtime with no boot hint, which is
>       precisely the online-switching problem you and Frederic hit, and what
>       Thomas's lightweight-offloaded + CPUHP_AP_RCU_SYNC sketch would need
>       to make cheap and race-free.
> 
> We would lean towards (a) as the pragmatic first step: it keeps RCU out of
> the runtime path entirely, per your recommendation, and only asks the admin
> who wants runtime RCU-noise isolation to declare the candidate CPUs at boot.
> (b) / Thomas's mechanism could be a separate, later effort if a truly
> boot-parameter-free RCU story turns out to be wanted.
> 
> Does scoping the RCU part to (a) sound acceptable to you and Frederic?  If
> so, we will drop runtime nocb toggling from DHM entirely and just document
> the rcu_nocbs= expectation, leaving the other housekeeping types runtime
> adjustable.

For the time being, I will defer to Frederic on this one.

His point about interrupt handlers invoking call_rcu() is a caution.  ;-)

							Thanx, Paul

