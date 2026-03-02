Return-Path: <cgroups+bounces-14520-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAKmJ3nDpWnEFgAAu9opvQ
	(envelope-from <cgroups+bounces-14520-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 18:06:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B8B1DD7F7
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C54DB3095942
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA7A42314F;
	Mon,  2 Mar 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QM+FemWK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD5421A14
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470830; cv=none; b=FzVjHnUXBC44jea1xmuGS12qXb+gMUzLyTSkNYH2D+FACme99JAB1oy8s5fToqruzK4kB3JkpfQphixS8hjatwMssXUY6EfLL5UlXy+/6UXNsHi+UTdR2dJ5eKjGelYI+PHM1hSICSKRU1S5Ig6YzlLpMEiRp6jGiiWWWgyKfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470830; c=relaxed/simple;
	bh=qNDFaM+YfYwiLYlicpcDxZluGw6w/AEmiQ+6S3VzBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct784MEOjoJeNYAOlTsSU3mu+auHFsmTkSG4jbnOvp7d7H83hgKkovYU4GTHhABH1n6f+8QTk73uvPz+BXciAaf7haFCPZJwEb2JRa6i1NvBOtP8Q0tMVUPcnyDWpvBY8Ao0Z6vLNkQF+jjbdVpL8w6Z0UaaU+CVss1xa4II4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QM+FemWK; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Mar 2026 09:00:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772470826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbAs9ykKjGj1acVkdZLpnTflSlmI29KTifSwOcqBl6o=;
	b=QM+FemWKuEjzR06V0+l7g/FTA9BP0C/iPlSfw9pkv9G5M1hdQfOly2TwTD4+rNwMhqH/bn
	T+8kvhEDBbuIhVFJ8GbNVA5bJCEsWUXglP1KG0rc5R/dx16wW2t2fj/+Z3PO0epJAgbm6B
	/qIfXUGfLqj4AceUt5U7OJ0Eh/hTSwA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/3] cgroup: add lockless fast-path checks to
 cgroup_file_notify()
Message-ID: <aaXB0A7eTbyZ4wA_@linux.dev>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
 <20260228142018.3178529-3-shakeel.butt@linux.dev>
 <40c77bba-0862-4422-b23e-2a10cd01c728@huaweicloud.com>
 <aaW2feETIF7I65i1@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaW2feETIF7I65i1@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D6B8B1DD7F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14520-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:14:05AM -0800, Shakeel Butt wrote:
> Hi Chen, thanks for taking a look.
> 
> On Mon, Mar 02, 2026 at 09:50:53AM +0800, Chen Ridong wrote:
> > 
[...]
> > > +	last = READ_ONCE(cfile->notified_at);
> > > +	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
> > > +		return;
> > > +
> > 
> > Previously, if a notification arrived within the rate-limit window, we would
> > still call timer_reduce(&cfile->notify_timer, next) to schedule a deferred
> > notification.
> > 
> > With this change, returning early here bypasses that timer scheduling entirely.
> > Does this risk missing notifications that would have been delivered by the timer?
> > 
> 
> You are indeed right that this can cause missed notifications. After giving some
> thought I think the lockless check-and-return can be pretty much simplified to
> timer_pending() check. If timer is active, just do nothing and the notification
> will be delivered eventually.
> 
> I will send the updated version soon. Any comments on the other two patches?
> 

Something like the following:

From 598199723b50813b015393122796f6775eee02d7 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Sat, 28 Feb 2026 04:01:28 -0800
Subject: [PATCH] cgroup: add lockless fast-path checks to cgroup_file_notify()

Add two lockless checks before acquiring the lock:

1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
2. timer_pending() check to skip when a deferred notification
   timer is already armed.

Both checks have safe error directions -- a stale read can only
cause unnecessary lock acquisition, never a missed notification.

Annotate cfile->kn write sites with WRITE_ONCE() to pair with the
lockless reader.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Jakub Kicinski <kuba@kernel.org>
---
 kernel/cgroup/cgroup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2b298a2cf206..6e816d27ee25 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = NULL;
+		WRITE_ONCE(cfile->kn, NULL);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 
 		timer_delete_sync(&cfile->notify_timer);
@@ -4430,7 +4430,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = kn;
+		WRITE_ONCE(cfile->kn, kn);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
@@ -4689,6 +4689,12 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	unsigned long flags;
 	struct kernfs_node *kn = NULL;
 
+	if (!READ_ONCE(cfile->kn))
+		return;
+
+	if (timer_pending(&cfile->notify_timer))
+		return;
+
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
 	if (cfile->kn) {
 		unsigned long last = cfile->notified_at;
-- 
2.47.3


