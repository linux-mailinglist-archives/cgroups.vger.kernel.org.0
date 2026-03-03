Return-Path: <cgroups+bounces-14544-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePb1MS1dpmnJOgAAu9opvQ
	(envelope-from <cgroups+bounces-14544-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 05:01:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BD1E89E4
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 05:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EF0B30217D1
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 04:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303A37DEBC;
	Tue,  3 Mar 2026 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyIuvuDu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B7382286
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510504; cv=none; b=A2sUrltzPwcpuLxOIY9FnaS5g9DTC7F4hy6F19czD7WlRlP0nwu3Fuwv7g9BxLbdcYIn2z7Ai29iD9LxUlrZkkuz/pIUTwtzHDS6ZXZz6KceIJtFh3w5IQEozuA9vIYsapGdTEbksoDeNCNbcdaISqwXOFDRjS6t4tfupeQ6bEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510504; c=relaxed/simple;
	bh=ihWsTEcR5FoPq30WiXprE/Wlo0jqWSzXKrxrzmLJ8gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMyl+6YIbQoxBv7G2senKqSOf6uBWmqAEyKNNQKPHxdtUWrg/1QUcZGijeoqVl5f2vEiO/+2rTzROwmZTHmICMzI/9Ta8OVxZhyTACEhaBf8ZX7kac8Gtm2vVQRfvn9meufA8E0/Z3YQYTw8TqtaF8BMNtar2IsLBI+1WIj4hPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyIuvuDu; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Mar 2026 20:01:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772510491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBGmF2s+SBlpG4pIc5F6jycqjWcB52xkmfpfhl7IPaY=;
	b=RyIuvuDuMThd4LbXF0ndsQw3dQna3mugcwnPflVjtV8ftPXbFGG/ezqLhplhFvmjA1yW3d
	Vbx9Xx1uEQe1PUFvClc1YAfep/On97EoSQifdLMkD7n2d1S0VoAQfDTVt42FoDG18QjGLD
	BcCzOPQP/oFzL8rhEN0Y04McZ7hFA4Q=
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
Message-ID: <aaZbz6FWxJ97kdNu@linux.dev>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
 <20260228142018.3178529-3-shakeel.butt@linux.dev>
 <40c77bba-0862-4422-b23e-2a10cd01c728@huaweicloud.com>
 <aaW2feETIF7I65i1@linux.dev>
 <aaXB0A7eTbyZ4wA_@linux.dev>
 <372e0d67-ab3f-427f-970d-5d1c7cb68c92@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372e0d67-ab3f-427f-970d-5d1c7cb68c92@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6E4BD1E89E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14544-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:18:17AM +0800, Chen Ridong wrote:
> 
> 
[...]
> > @@ -4689,6 +4689,12 @@ void cgroup_file_notify(struct cgroup_file *cfile)
> >  	unsigned long flags;
> >  	struct kernfs_node *kn = NULL;
> >  
> > +	if (!READ_ONCE(cfile->kn))
> > +		return;
> > +
> > +	if (timer_pending(&cfile->notify_timer))
> > +		return;
> > +
> 
> The added timer_pending() check seems problematic. According to the function's
> comment, callers must ensure serialization with other timer operations. Here
> we're checking timer_pending() locklessly, which means we might:
> 

That comment seems outdated. Check the commit 90c018942c2ba ("timer: Use
hlist_unhashed_lockless() in timer_pending()").

> 1. See an inconsistent state if another CPU is concurrently modifying the timer
> 

It will not see inconsistent state but it can see stale state which is totally
fine. At worst we will take the lock and recheck but we will never miss the
notifications.

> 2. Race with del_timer() or mod_timer() from other contexts
> 
> >  	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
> >  	if (cfile->kn) {
> >  		unsigned long last = cfile->notified_at;
> 
> -- 
> Best regards,
> Ridong
> 

