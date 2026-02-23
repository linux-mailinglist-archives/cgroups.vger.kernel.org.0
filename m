Return-Path: <cgroups+bounces-14228-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFwxKqXunWncSgQAu9opvQ
	(envelope-from <cgroups+bounces-14228-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:32:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E618B6BC
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A423131F81FC
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223923ACA4B;
	Tue, 24 Feb 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikHv1j9R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459393A1A28
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957597; cv=none; b=EbTRarkiDSNl8Ne4b/TIP6eq2YVyOkEOXxCC4OtS1M1gQO0gpgWpVRH8EYqrbatNpncuKodYUp7NLkO3r8AJ32hSso4/PDIDFzVMoAFFpR566nUD6XK+ipVdE8/mCN/ppGk99ze8YH78CNCBzz9EAOH7QvLMwOJPKX20dxKxwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957597; c=relaxed/simple;
	bh=ujg4JwIYLvspkvuyEEPh1L3eQ2IzutQT2hoqTvgB6zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+hNH2WYlG26+hNuMMHFJAPVKPlpHoldqkOq6VknGrqUGze6yFLRa4L/klTSQAXlsZnf+XgNKvPE96sJ8WfsKYWBQytnOoKWBtxyeilrn7OYf3SgReUEBonbPAO2lm+b7XlDwlnIiH8pMXuCFRdM+v0Mk9zXh2nmbnkZQnF/9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikHv1j9R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771957592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Uf5EJf+Tw5nbDLapVKw8M9tfsonMMBNq6SuwMEXglI=;
	b=ikHv1j9RgVuBVPSnBFHJihg8CIcM7hkeclLRTYYhYaPcc1yp8i+mAhvbplMRyAdWS5VgfB
	bTl0OqaMUNTnHovMrvkK/UprpvsQX2mNz+fhzKAV6pOj9ibU7j4QgJRon+tJWxAK0IWG7Z
	7frj3xoDQjTSEKUf63z+3/3sGRw3/B0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-58eZhZIcMliTHgOPkvQPJA-1; Tue,
 24 Feb 2026 13:26:26 -0500
X-MC-Unique: 58eZhZIcMliTHgOPkvQPJA-1
X-Mimecast-MFC-AGG-ID: 58eZhZIcMliTHgOPkvQPJA_1771957582
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08FF21800578;
	Tue, 24 Feb 2026 18:26:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CF1C1800370;
	Tue, 24 Feb 2026 18:26:19 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id CBBF340164D27; Mon, 23 Feb 2026 08:20:51 -0300 (-03)
Date: Mon, 23 Feb 2026 08:20:51 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
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
Message-ID: <aZw4E9+aN3QjMZsB@tpad>
References: <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
 <aZibbYH7yrDZlnJh@tpad>
 <a1c11a09-da88-4edd-9571-0f792b59e9c3@suse.com>
 <aZivpwJnIGKdAMYE@tpad>
 <aZwZrw_LTilXsPd4@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZwZrw_LTilXsPd4@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[31];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14228-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quantvps.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 530E618B6BC
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:11:11AM +0100, Michal Hocko wrote:
> On Fri 20-02-26 16:01:59, Marcelo Tosatti wrote:
> > On Fri, Feb 20, 2026 at 06:58:10PM +0100, Vlastimil Babka wrote:
> [...]
> > > >> So if we can assume that workloads on isolated cpus make syscalls only
> > > >> rarely, and when they do they can tolerate them being slower, I think the
> > > >> "avoid sheaves on isolated cpus" would be the best way here.
> > > > 
> > > > I am not sure its safe to assume that. Ask Gemini about isolcpus use
> > > > cases and:
> > > 
> > > I don't think it's answering the question about syscalls. But didn't read
> > > too closely given the nature of it.
> > 
> > People use isolcpus with all kinds of programs. 
> > 
> > > > For example, AF_XDP bypass uses system calls (and wants isolcpus):
> > > > 
> > > > https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE
> > > 
> > > Didn't spot system calls mentioned TBH.
> > 
> > I don't see why you want to reduce performance of applications that 
> > execute on isolcpus=, if you can avoid that.
> 
> If you can avoid that by making performance bad for everybody else then
> then it seems safer to sacrifice those workloads that are much more
> special - i.e. cpu isolation.
> -- 
> Michal Hocko
> SUSE Labs

Performance is not bad for everyone else:

Without patchset:                                                                                                             
================                                                                                                              
                                                                                                                              
[ 1188.050725] kmalloc_bench: Avg cycles per kmalloc: 159                                                                     
                                                                                                                              
With qpw patchset, CONFIG_QPW=n:                                                                                              
================================                                                                                              
                                                                                                                              
[   50.292190] kmalloc_bench: Avg cycles per kmalloc: 163          

And its probably possible to remove those 4 cycles.

Which makes reduction of performance of isolcpus not necessary.


