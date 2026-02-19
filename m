Return-Path: <cgroups+bounces-14019-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFcGAsssl2nmvQIAu9opvQ
	(envelope-from <cgroups+bounces-14019-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 16:31:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D51602B1
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66825303A844
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B7347FF8;
	Thu, 19 Feb 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gg2Uv3Mq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A80347BC9
	for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514921; cv=none; b=nad71iTl0EE0dosd2qA8XB9tezH+wY2vOyClKAgI52LqU9HtTZyRSncPvqisTu3iKaS83uHn+j/WRADrF7KEmM845VWnk0sh+qZTm5j3ziDWCae1Nscq0TCSz3sYa2az/rQBIlKgRr4xbphzjM6aWcS0IE3YzGl905DGwyDorZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514921; c=relaxed/simple;
	bh=rtR+KzzxzKBYIqWs3B0KVmtFGefZcqWIU6doNPDIn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/fB2LSj+Tgs+odxKo7XDGkX1xZ+J85IXRHEFhAOiFnnUvZ5s1ufxLzCrb9ra23KOQudqfTyXCc101fJKcu0Zt74uEvLIeFwjVezKikzEYT1XnrVO1sNCQMy0wzrZNlRLiziSgXHu4oDI2sj1jkI1owwScSH0s7aKL/aMjkNSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gg2Uv3Mq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771514919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/MYhX9u18ZxQhXovryB0Eh7LFOheskfwpriZ+MbSug=;
	b=gg2Uv3MqCm9gXOWpsfOgholmi+rDFArv1CkBkkALQ/4fP1HWSH2w3ZpaF/xaoo5tHDa92g
	e9UBbntKfLkS66lztatCS4Oy0wSgjAZ1c7MrX+tpnBJNUa3v/tR1ou//7IKM7c+KP3+/ou
	WbgXVoNbk40Sgp0eENwmLcjGkCTtffU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-nuJ9k3mtMk66GG3N1gk6Ew-1; Thu,
 19 Feb 2026 10:28:33 -0500
X-MC-Unique: nuJ9k3mtMk66GG3N1gk6Ew-1
X-Mimecast-MFC-AGG-ID: nuJ9k3mtMk66GG3N1gk6Ew_1771514909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BC7E18002DE;
	Thu, 19 Feb 2026 15:28:28 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C87211955F22;
	Thu, 19 Feb 2026 15:28:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id BC8EE401E2101; Thu, 19 Feb 2026 10:15:41 -0300 (-03)
Date: Thu, 19 Feb 2026 10:15:41 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
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
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZcM/X6vnzhjPTVm@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYywl1hdBQP2_slo@tiehlicka>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14019-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 711D51602B1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> [...]
> > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > have requirements as strong as RT workloads but the underlying
> > > fundamental problem is the same. Frederic (now CCed) is working on
> > > moving those pcp book keeping activities to be executed to the return to
> > > the userspace which should be taking care of both RT and non-RT
> > > configurations AFAICS.
> > 
> > Michal,
> > 
> > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > boot option qpw=y/n, which controls whether the behaviour will be
> > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> 
> My bad. I've misread the config space of this.
> 
> > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > (and remote work via work_queue) is used.
> > 
> > What "pcp book keeping activities" you refer to ? I don't see how
> > moving certain activities that happen under SLUB or LRU spinlocks
> > to happen before return to userspace changes things related 
> > to avoidance of CPU interruption ?
> 
> Essentially delayed operations like pcp state flushing happens on return
> to the userspace on isolated CPUs. No locking changes are required as
> the work is still per-cpu.
> 
> In other words the approach Frederic is working on is to not change the
> locking of pcp delayed work but instead move that work into well defined
> place - i.e. return to the userspace.

Michal,

I can't find such work from Frederic. Do you mean:

Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a user->kernel transition

From Valentin ?

Or if you have a pointer to Frederic's work.

> Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> paths like SLUB sheeves?

Doing that, will post results as soon as possible.


