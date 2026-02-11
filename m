Return-Path: <cgroups+bounces-13861-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHcROeKjjGlhrwAAu9opvQ
	(envelope-from <cgroups+bounces-13861-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:44:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61591125CEA
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3364F3072A45
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AF31353C;
	Wed, 11 Feb 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKVu/p8g"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99F31195D
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824596; cv=none; b=HgfzOyk0zA0PcF1u5UkB0bGQoTsaaB9NOo+Xov5PdZ+Q5JP+Y15dVd82X1l2h0l8gfSyDce4EcmGBHqw2lgyj7FsSc56nESeHMK4yxzS47bpFW/2ZhvJvcYZYCCMDyvDctUw/od36ysK8imTJllAYZPUz43ZUKzUQzfEfjODYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824596; c=relaxed/simple;
	bh=cx5p1N0pxNkNyb36JTGId6j7cNzPbI2HBY0TDNnjvyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgwLvnlekmKL1Zfqsirf8U4HHKjVbt/xnMHpcc7kTSe7ZMSDJs6uuI0biH2Inc0OOiccjmYvUy9zKx69VWnJ62sb31M707odjBDTErP06DLix0D/gaXOncLjxjbp50U4tgWImwI5f1Js1UikYIYHzh52Z9ZqfXuK3mAlcqbPLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKVu/p8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770824593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jx1hsuuG7ObMhO/uK+TRbv/qG1QFFvi3Ae/jdkXmec=;
	b=gKVu/p8gLhfHc6dtBBwuIWU4BjNVSkuxtzgWPdqb1SxDmfaDxUF8BhRLXGYhrlb22a6inO
	iwLMMdb3tFG0gwcah1v7fqXPFyEN1mynogooHsVTFiqosH0BBX8ZPOjfVcfB4tImgUWlY3
	7gYgyfNvt12WKIwSJiQ7JWIzljbt1pM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-hUcKwGwXPeOaG_WdkWuOAw-1; Wed,
 11 Feb 2026 10:43:06 -0500
X-MC-Unique: hUcKwGwXPeOaG_WdkWuOAw-1
X-Mimecast-MFC-AGG-ID: hUcKwGwXPeOaG_WdkWuOAw_1770824584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCECD1800370;
	Wed, 11 Feb 2026 15:43:03 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 057AA30002D5;
	Wed, 11 Feb 2026 15:43:02 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 492B8400DF78C; Wed, 11 Feb 2026 09:09:02 -0300 (-03)
Date: Wed, 11 Feb 2026 09:09:02 -0300
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
Subject: Re: [PATCH 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Message-ID: <aYxxXrG1UVvHUGHP@tpad>
References: <20260206143430.021026873@redhat.com>
 <20260206143741.525190180@redhat.com>
 <aYaEZGImn7qayP12@WindFlash>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYaEZGImn7qayP12@WindFlash>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13861-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 61591125CEA
X-Rspamd-Action: no action

Hi Leonardo,

On Fri, Feb 06, 2026 at 09:16:36PM -0300, Leonardo Bras wrote:
> > ===================================================================
> > --- slab.orig/MAINTAINERS
> > +++ slab/MAINTAINERS
> > @@ -21291,6 +21291,12 @@ F:	Documentation/networking/device_drive
> >  F:	drivers/bus/fsl-mc/
> >  F:	include/uapi/linux/fsl_mc.h
> >  
> > +QPW
> > +M:	Leonardo Bras <leobras@redhat.com>
> 
> Thanks for keeping that up :)
> Could you please change this line to 
> 
> +M:	Leonardo Bras <leobras.c@gmail.com>
> 
> As I don't have access to Red Hat's mail anymore.
> The signoffs on each commit should be fine to keep :)

Done.

> 
> > +S:	Supported
> > +F:	include/linux/qpw.h
> > +F:	kernel/qpw.c
> > +
> 
> Should we also add the Documentation file as well?
> 
> +F:	Documentation/locking/qpwlocks.rst

Done.

> > +The queue work related functions (analogous to queue_work_on and flush_work) are:
> > +queue_percpu_work_on and flush_percpu_work.
> > +
> > +The behaviour of the QPW functions is as follows:
> > +
> > +* !CONFIG_PREEMPT_RT and !CONFIG_QPW (or CONFIG_QPW and qpw=off kernel
> 
> I don't think PREEMPT_RT is needed here (maybe it was copied from the 
> previous QPW version which was dependent on PREEMPT_RT?)

Ah, OK, my bad. Well, shouldnt CONFIG_PREEMPT_RT select CONFIG_QPW and
CONFIG_QPW_DEFAULT=y ?

> > +boot parameter):
> > +        - qpw_lock:                     local_lock
> > +        - qpw_lock_irqsave:             local_lock_irqsave
> > +        - qpw_trylock:                  local_trylock
> > +        - qpw_trylock_irqsave:          local_trylock_irqsave
> > +        - qpw_unlock:                   local_unlock
> > +        - queue_percpu_work_on:         queue_work_on
> > +        - flush_percpu_work:            flush_work
> > +
> > +* CONFIG_PREEMPT_RT or CONFIG_QPW (and CONFIG_QPW_DEFAULT or qpw=on kernel
> 
> Same here
> 
> > +boot parameter),
> > +        - qpw_lock:                     spin_lock
> > +        - qpw_lock_irqsave:             spin_lock_irqsave
> > +        - qpw_trylock:                  spin_trylock
> > +        - qpw_trylock_irqsave:          spin_trylock_irqsave
> > +        - qpw_unlock:                   spin_unlock
> > +        - queue_percpu_work_on:         executes work function on caller cpu
> > +        - flush_percpu_work:            empty
> > +
> > +qpw_get_cpu(work_struct), to be called from within qpw work function,
> > +returns the target cpu.
> > 
> > 
> 
> 
> Other than that, LGTM!
> 
> Reviewed-by: Leonardo Bras <leobras.c@gmail.com>
> 
> Thanks!
> Leo
> 
> 


