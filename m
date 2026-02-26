Return-Path: <cgroups+bounces-14517-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEtlNkO3pWkiFQAAu9opvQ
	(envelope-from <cgroups+bounces-14517-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:13:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892851DC7E9
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8583128F43
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A152423A90;
	Mon,  2 Mar 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZeLSDdS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86441C0DE
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466818; cv=none; b=e7k/zdTTUr608fH/BcFqRib6h7JHBVpMgORLzO6MnP5IaJ/lAbhHvU/ta8HomMOHwfRPGdwG4xAWawOEqB5EK82DiCVVi8IQGbaoqmgFbxrv2RKd+/31ZH1MWSb4x48ifEjlHPUYyLsoW4GxVTJKPYGZcUWNrZcHM7y0XrJbTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466818; c=relaxed/simple;
	bh=3hTs6TdlYIZr2CVpEVhU2U0naEH31kgEN2TXKH8ea2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya2HKo09EecQLreNMAL1tLW4EPHJsvzBNigA3Qa7/bz5FbDB7z/tKhwYeSZy2kSXT0XIO0m3TEAf4oHZMuMCo24xM4aL1ntzHbCMnBIsi78aDgct69ViULuuuq1KzCjgD/b74cKeVJp8ypILcmnwObeYsY77CHugfI4MJmOfhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZeLSDdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLbuFPWOWGHaHFWL2ILwbNpXfhNKBfkyvba0iiQAlY0=;
	b=XZeLSDdSWtRQSpIuotJ/0D9qV4f1mY6f2QdXqDbns0rZj/rg8VVOBWGCMsHHjvieowNgm9
	t6TmCf7CeYo6+Y4LQM/W16lSzxR3jPlLRgwWQokMHaYRCtzioj5+uhGJZauqG5dvtWoIPQ
	L32pYMSvmA2+4j5uaOayfHNnGc9gz34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-h8wrkvvyNiGreQWPAh48UQ-1; Mon,
 02 Mar 2026 10:53:25 -0500
X-MC-Unique: h8wrkvvyNiGreQWPAh48UQ-1
X-Mimecast-MFC-AGG-ID: h8wrkvvyNiGreQWPAh48UQ_1772466802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7682819560A2;
	Mon,  2 Mar 2026 15:53:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3D2A1800592;
	Mon,  2 Mar 2026 15:53:20 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id C42E64014FBC7; Thu, 26 Feb 2026 12:49:18 -0300 (-03)
Date: Thu, 26 Feb 2026 12:49:18 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 3/4] swap: apply new queue_percpu_work_on() interface
Message-ID: <aaBrfg0ozWK4moxC@tpad>
References: <20260206143430.021026873@redhat.com>
 <20260206143741.589656953@redhat.com>
 <aYaQFM9sBbauUn5c@WindFlash>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYaQFM9sBbauUn5c@WindFlash>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 892851DC7E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[96];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14517-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:06:28PM -0300, Leonardo Bras wrote:
> > +	cpu = smp_processor_id();
> 
> Wondering if for these cases it would make sense to have something like:
> 
> qpw_get_local_cpu() and 
> qpw_put_local_cpu() 
> 
> so we could encapsulate these migrate_{en,dis}able()
> and the smp_processor_id().
> 
> Or even,
> 
> int qpw_local_lock() {
> 	migrate_disable();
> 	cpu = smp_processor_id();
> 	qpw_lock(..., cpu);
> 
> 	return cpu;
> }
> 
> and
> 
> qpw_local_unlock(cpu){
> 	qpw_unlock(...,cpu);
> 	migrate_enable();
> } 
> 
> so it's more direct to convert the local-only cases.
> 
> What do you think?

Switched to local_qpw_lock variants.

> >  {
> > -	local_lock(&cpu_fbatches.lock);
> > -	lru_add_drain_cpu(smp_processor_id());
> 
> and here ?

Fixed lack of migrate_disable/migrate_enable, thanks!

> > @@ -950,7 +954,7 @@ void lru_cache_disable(void)
> >  #ifdef CONFIG_SMP
> >  	__lru_add_drain_all(true);
> >  #else
> > -	lru_add_mm_drain();
> 
> and here, I wonder

This is !CONFIG_SMP, so smp_processor_id is always 0.

> >  	drain_pages(cpu);
> >  
> >  	/*
> > 
> > 
> 
> TBH, I am still trying to understand if we need the migrate_{en,dis}able():
> - There is a data dependency beween cpu being filled and being used.
> - If we get the cpu, and then migrate to a different cpu, the operation 
>   will still be executed with the data from that starting cpu 

Yes, but on a remote CPU. What prevents the original CPU from accessing 
its per-CPU local data, therefore racing with the code executing on the
remote CPU.

> - But maybe the compiler tries to optize this because the processor number 
>   can be on a register and of easy access, which would break this.
> 
> Maybe a READ_ONCE() on smp_processor_id() should suffice?
> 
> Other than that, all the conversions done look correct.
> 
> That being said, I understand very little about mm code, so let's hope we 
> get proper feedback from those who do :) 
> 
> Thanks!
> Leo
> 
> 


