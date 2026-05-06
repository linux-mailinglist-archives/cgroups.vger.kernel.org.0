Return-Path: <cgroups+bounces-15642-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO7BGtxN+2nWYwMAu9opvQ
	(envelope-from <cgroups+bounces-15642-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:19:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484A4DBFA7
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59A4430041D7
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0743DA3B;
	Wed,  6 May 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J0+CPLXT"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AE421890;
	Wed,  6 May 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077144; cv=none; b=Yvd9xL+pawjruTZuTg0Ot00yX26SpxxhGyePi3LC3MRY6zYzINlk4E0xlWFSy4vHjO87oMcQzgqx1WV639+V5Dj0bwps2mJsRLh+z9otB2r9wihpN1iYFdReIJTq5a6Uz+tITWglZu+2XWafkOmMIQauw99vMAWSGQScoDzhcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077144; c=relaxed/simple;
	bh=wCeLJZv/CdAOVODN9qsshb41mCoZhu/viwKYIgPT954=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIJTuSAWU66427vhYJ7CiRE3egfaggCDih/vEEvYO2fcUxVTCo9FB7Y7AL66WRStjNPnQ0KpcLWAPrlvQzgyfnAhzPQ9YzCyOoFwjPHjnnFMtATeAxvdChKUZp/M0C2u/RBCpbXTrz/jhqRIjHt6OYrShqLo4Ex7aNXwUD/e9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J0+CPLXT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nRaOz1lcNpsbT5rGgL5au+0YmvtZKsbg6EsSvRJK3wo=; b=J0+CPLXTtNQdpaIr6HVLL0e8Xl
	ERcF86Asw953dAX+lVYLW1no599f6dj17G6vx9xuNZy/XTr0AazOstdZ66BHYXBKoOiTrZsL5NBJB
	JKhxDu1tl/uZ1zzifPOyL+mRbBp6aHbi1syE5IrdaXrYSuFBxTodHrIZ0JjPWzh1/yEt/a4R/tp+D
	nNkNKzlwDHAcls/hefSAy7HJ3YENkstDkGe6Ch/fhAuKvDfol9x5V1I3oM753Ojypz3KX5gFhzb52
	2dh7b9pu63gswb1OlPLJnVe//JdR0494s4hqRICH5sGbmdcSChgE9t4wrnwGYm1toQwKBkWs9XHUz
	XfaqdaKw==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wKd59-006vns-Jr; Wed, 06 May 2026 16:18:35 +0200
Date: Wed, 6 May 2026 11:18:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
Message-ID: <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
 <aftB-cc5EhDXxCGA@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aftB-cc5EhDXxCGA@localhost.localdomain>
X-Rspamd-Queue-Id: 0484A4DBFA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15642-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email]

On Wed, May 06, 2026 at 03:53:59PM +0200, Michal Koutný wrote:
> Hello Thadeu.
> 
> On Wed, May 06, 2026 at 08:58:23AM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > Just like we have memory.peak, introduce a dmem.peak, which uses the
> > page_counter support for that.
> > 
> > It can be written to in order to reset the peak, but different from
> > memory.peak, which expects any write, dmem.peak expects the region name to
> > be written to it. That region peak is the one that is reset.
> > 
> > That requires ofp_peak to carry a pointer to the pool that was reset.
> 
> (It'd be nicer to have generic data in that generic structure, at least
> some void *priv. But see below.)
> 

I used void *, at first, but as the only current use is for the pool and as
mixing different uses may lead to misuse, I thought it would be safer to
use the type directly. This has been pointed out before for other members
of cgroup_file_ctx. See [1].

> > Writing a different region name will reset the different region and make
> > the original region peak get back to its non-reset value.
> 
> I'm slightly confused by this fds x pool matricity when there's only
> a single slot in cgroup_file_ctx::cgroup_of_peak.
> 
> The intended use case is that users should maintain one fd per pool and
> not mix it up?
> This stanza would better fit to cgroup-v2.rst proper than the commit
> message. Or make it simpler and start with non-resettable peak file
> (like memory.peak had started too) and see how it fares. WDYT?
> 

That is also due to the limitation that each file descriptor has a single
linked list under cgroup_file_ctx::cgroup_of_peak. To allow for all the
pools to be reset at once, we would need one list per file descriptor.

But, on the other hand, as you pointed out, this leads to the flexibility
of being able to reset only one pool, while leaving the others as is.
Whereas, if one needs to reset all pools, they can use one file descriptor
per region.

I started with a non-resettable peak file, but as memory.peak can be reset,
I added that feature too. If we want to merge a non-resettable support
ealier and need to take longer to discuss how to work on the resettable
support given the above, I can resubmit. But I guess we can see if we can
reach an agreement sonner rather than later.

Thanks.
Cascardo.

> 
> Thanks,
> Michal

[1] https://lore.kernel.org/all/CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com/

