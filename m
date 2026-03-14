Return-Path: <cgroups+bounces-14823-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2GGtMntWkSxAAAu9opvQ
	(envelope-from <cgroups+bounces-14823-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Mar 2026 10:18:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7828C522
	for <lists+cgroups@lfdr.de>; Sat, 14 Mar 2026 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64F0F300B444
	for <lists+cgroups@lfdr.de>; Sat, 14 Mar 2026 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5DB2580EE;
	Sat, 14 Mar 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4PzGEU9M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7BzrdUhT"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B514EC73
	for <cgroups@vger.kernel.org>; Sat, 14 Mar 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479884; cv=none; b=Uy61ya1BLWuevwxuJEWRmN7VMOkH1aFr2jolYnE7lyOyoZIPmfgZrVFlyhJIT5090bBxqyWSlFVXdMpbDxuuBOWvP3GHUAi2+XGuXiGXSqCE4qzYOz+/tHmTZqXOFmSheU18ESG2cYseH0Oke1gByXW+M9SSrlenOLH53lqhuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479884; c=relaxed/simple;
	bh=QWYHgF2U0wYDzLjZRZsKk1Sb2dueEXut//IM2sWmukY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1gnmzj5hAyIxPh5g958LiCeQeaiXBZyyv2xC/rWiPVvNtFc8wBO3/BBNmqg9GWw6/G80dmJ6VY2P9LXcTbOXOA6793EtCtP2BCXUgrfCDQMwVDkpQHKIWyxYrtp7TvNc70xrOgD5no3zw1WOMVY2ncDd95dZHB3D8ZMIokFV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4PzGEU9M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7BzrdUhT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Mar 2026 10:17:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773479874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqH/l6bYhrPe7oidKxX4BdHLqO0dpH8/I+brV0dWCsI=;
	b=4PzGEU9MM0/fidlqUf8nUl9uwjZm8fSi0anfV9F4vTxDDCaJzNymi8gIp88Tj3SrHoOUiB
	7aqA3boagCFM1KWRihOJtGU59uCoOCmcyHVOACmyZox3gqj4iKqtT2ixWJgfjIQ3n+mqjt
	VLTJZJhCBikRwui5Vn8eACotZjNfNxmdXpaPuYAvHpkz2woth1FoKRVxy3hFVxZpO6+3ot
	LyAkpfmwCpHPs7W73sSZ2nT+zmJrxuszX5U2fri4dXVGb8x1iZbDT+jRsQFo4w+tum5+Wn
	rtQe0aVXB3iYEmp1lnQvrOTxWfuKIRyfIn/ckDKVAL+qDzfDIVcRQgQoZpu6sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773479874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqH/l6bYhrPe7oidKxX4BdHLqO0dpH8/I+brV0dWCsI=;
	b=7BzrdUhTrZxwwRmuiezFIcVk34DmmrfhOMpRDXMgUoAENJW3uD/t/2+6d9tz9aty50qPjR
	RWGdIXYiSlVoqoBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <20260314091752.B7CXvQxn@linutronix.de>
References: <20260311120829.rEHY-xh9@linutronix.de>
 <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14823-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid]
X-Rspamd-Queue-Id: 66B7828C522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-13 18:33:14 [+0100], Michal Koutn=C3=BD wrote:
> Hello.
>=20
> On Wed, Mar 11, 2026 at 01:08:29PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > @@ -7084,6 +7031,7 @@ void cgroup_task_free(struct task_struct *task)
> >  {
> >  	struct css_set *cset =3D task_css_set(task);
> > =20
> > +	cgroup_task_dead(task);
> >  	if (!list_empty(&task->cg_list)) {
> >  		spin_lock_irq(&css_set_lock);
> >  		css_set_skip_task_iters(task_css_set(task), task);
>=20
> Erm, isn't this way too late?

My understanding is that the point is that the cgroup must not be
exposed to userland once the task is about to die. This has been moved
after the fine schedule() which is too late because the parent is
signaled before that and the removal happens after that.
So now we hide the tasks in the iterator once the task is PF_EXITING.

> I see that cset->dying_tasks is appended in do_cgroup_task_dead() (which
> I was used to find in cgroup_exit()).

So this could be probably removed later on if this is the only purpose.

> (Also, whole cgroup_task_dead() becomes single use thing so it could be
> open-coded in the place where it belongs.)

If this what we want, I could inline it there.

> Thanks,
> Michal

Sebastian

