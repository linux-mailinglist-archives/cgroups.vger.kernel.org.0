Return-Path: <cgroups+bounces-14154-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMLSLb58nGm6IQQAu9opvQ
	(envelope-from <cgroups+bounces-14154-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:13:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B91797CF
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB4730D81B9
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60649309EFA;
	Mon, 23 Feb 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9pVaPN/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119D28C869;
	Mon, 23 Feb 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862945; cv=none; b=tu8UD6wMo/hVdP+EMVeCNepHq2i0Qt4owF/WVtRELei9CpM4Trjqoy5BRRnX4TqeVXqYasWfoMI+TS9I4SqVPr3xhnk7KDackJi7KxEGfHioBDGvmq97nm0Z3ksFxZVvSx+Q/lNGDjiAJU4Zj0H4g0mIA57smazg3CJPuHWJQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862945; c=relaxed/simple;
	bh=U1f4VUWvlVoHVRzjSsvSj6+GTfFekKDeqZn6GrwXI0o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/BOkjva8uPoNlA87lW1vnTJV0L42mPpMMwkGRvuYmqENEHrzwDUeeEEUve3dhXf4L0WulaToDpFbsNE1ihtn/MzJkZAQFdKXAJfE6nc+8JiTT94YWQFfs/0clxtyH0yZ+a81h5JoUfJDhq3pcZAnpJqZwNRaEku1tz8+NjRDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9pVaPN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C5AC116C6;
	Mon, 23 Feb 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862944;
	bh=U1f4VUWvlVoHVRzjSsvSj6+GTfFekKDeqZn6GrwXI0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9pVaPN/cxEh/suCVhuWE9zKuRvobiCEGJ0txgkBo9PpXkl47x3YeBE24NtYlHPBp
	 Z9MvnO0WtjK2zPWfQ/IfIVLCZffKJlqemIihS/QeSLhwIJq8IdOPIU+1f9688A4XMp
	 gwlAn+/8UAVE4a0QW6Jp5dz96715FKWMWVIWgA0sngCXHv+7g87EwavNZvdprMhmg7
	 MahbRAl/A4ygOiEtD77hedrDSCJEvgQIk8RNwhzzo9fFOFuUA/+QEBobC2lco7cD/+
	 etfl/NJ7Xp0yiJtecEPjRZB5hFueUHK0rlemZus13jXbfPV+sMsHDxL+4n4NsgZMVR
	 B+47pl7GCN5cg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vuYUX-0000000D3Lu-3QOf;
	Mon, 23 Feb 2026 16:09:01 +0000
Date: Mon, 23 Feb 2026 16:09:01 +0000
Message-ID: <86jyw3a1cy.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,	LKML
 <linux-kernel@vger.kernel.org>,	Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>,	Andrew Morton <akpm@linux-foundation.org>,	Bjorn
 Helgaas <bhelgaas@google.com>,	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,	Eric Dumazet
 <edumazet@google.com>,	Gabriele Monaco <gmonaco@redhat.com>,	Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,	Jens Axboe <axboe@kernel.dk>,	Johannes
 Weiner <hannes@cmpxchg.org>,	Lai Jiangshan <jiangshanlai@gmail.com>,	Marco
 Crivellari <marco.crivellari@suse.com>,	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,	Paolo Abeni <pabeni@redhat.com>,	Peter
 Zijlstra <peterz@infradead.org>,	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,	Roman Gushchin
 <roman.gushchin@linux.dev>,	Shakeel Butt <shakeel.butt@linux.dev>,	Simon
 Horman <horms@kernel.org>,	Tejun Heo <tj@kernel.org>,	Thomas Gleixner
 <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,	Waiman Long
 <longman@redhat.com>,	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,	linux-mm@kvack.org,	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent isolated cpuset change
In-Reply-To: <47be2ff3-c25a-4aab-89fc-53921af8b0a9@baylibre.com>
References: <20260101221359.22298-1-frederic@kernel.org>
	<20260101221359.22298-5-frederic@kernel.org>
	<47be2ff3-c25a-4aab-89fc-53921af8b0a9@baylibre.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: dlechner@baylibre.com, frederic@kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com, akpm@linux-foundation.org, bhelgaas@google.com, catalin.marinas@arm.com, chenridong@huawei.com, dakr@kernel.org, davem@davemloft.net, edumazet@google.com, gmonaco@redhat.com, gregkh@linuxfoundation.org, mingo@redhat.com, kuba@kernel.org, axboe@kernel.dk, hannes@cmpxchg.org, jiangshanlai@gmail.com, marco.crivellari@suse.com, mhocko@suse.com, muchun.song@linux.dev, pabeni@redhat.com, peterz@infradead.org, pauld@redhat.com, rafael@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, horms@kernel.org, tj@kernel.org, tglx@linutronix.de, vbabka@suse.cz, longman@redhat.com, will@kernel.org, cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-14154-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625B91797CF
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 16:01:03 +0000,
David Lechner <dlechner@baylibre.com> wrote:
> 
> On 1/1/26 4:13 PM, Frederic Weisbecker wrote:
> > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > runtime. In order to synchronize against vmstat workqueue to make sure
> > that no asynchronous vmstat work is pending or executing on a newly made
> > isolated CPU, target and queue a vmstat work under the same RCU read
> > side critical section.
> > 
> > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> > workqueue flush will also be issued in a further change to make sure
> > that no work remains pending after a CPU has been made isolated.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  mm/vmstat.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 65de88cdf40e..ed19c0d42de6 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
> >  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
> >  		 * for all isolated CPUs to avoid interference with the isolated workload.
> >  		 */
> > -		if (cpu_is_isolated(cpu))
> > -			continue;
> > +		scoped_guard(rcu) {
> > +			if (cpu_is_isolated(cpu))
> > +				continue;
> 
> I think this might have introduced a bug - or at least an
> unintentional change in the program flow.
> 
> scoped_guard() is implemented using a for loop. Now this continue
> statement will only exit the scoped_guard() scope rather than
> continuing the outer for loop. This means that cond_resched() will
> be called when it previously was not.

Yup, I've been bitten by that once before. It lead to very subtle
breakage that took me a while to figure out. I've now mentally
banished the use of scoped_guard() inside any form of loop, but that's
a pretty brittle strategy...

	M.

-- 
Without deviation from the norm, progress is not possible.

