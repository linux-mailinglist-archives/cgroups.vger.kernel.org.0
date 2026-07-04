Return-Path: <cgroups+bounces-17478-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U1ICHWdaSGpkpQAAu9opvQ
	(envelope-from <cgroups+bounces-17478-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 02:57:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5470650D
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 02:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b="SYk/KA7F";
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17478-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17478-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1907A30135C6
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684A1FECAB;
	Sat,  4 Jul 2026 00:57:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907A1C5D7D;
	Sat,  4 Jul 2026 00:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126623; cv=none; b=HZWZsfl/aWgwnRIc6x1TyjvpR+3FGMeCFYavSBw8ziqGVcmzI86ulJokGeTaAudN8scW5IQwGcZZKUmuV4wXLL267AJXEt1Nfq0clYGyG8CbPAhNAj0K4/QE3DZF+w6RPaD+w5px0nDZ9j/BElDGtaHH6/Mi1Rx/yZaShdroAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126623; c=relaxed/simple;
	bh=N8lXNuaZTzbmWMSZiVt2o+4+ApoJD19xes+M4ax7tnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/qVSxGvlLokRMdkExiE0AxSKO5pIWYHwoA2SF30WHWhJPT1FDFTSQUp2xufI6B/V90RUqToJMVYpBj4BIjP0HbhlWjf+AN0UGR/Z5WGZVK2C2M75rO/ixsPxmh+xDT6T7ExB84xOjqOMwCdJd947j7eFupe5XXhPr9dtXd4ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SYk/KA7F; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C1EN6rIeWL899rhI3FjLhGXZyIEwiV09wTr+KM4FDTM=; b=SYk/KA7FP2Njc/3Os3mIlmBBrQ
	1OPq+arUCKlVVRVccWIL+WJEXCjmq0Q6n7VKu2KePL3pmbUrmwD64SGtIlek7q4gVkqy8pd5ADts5
	A7AeTdtK+imV0kXiQZepZPH9jOvXqprXb6mWAECqjK81XGx+InJubX6UQluBb7A2zfWkdt02u81hG
	1UKpo6MRmgWCqmHoenzMBq1In+k0xYR9XLb2/ZhTXYmBYepSxthyxCkzwtxNit7Oma5UHqURansxO
	aU6Q+iFWdT1JkjbW9fN7LEGhJu3j03o5eDDdGdJTArlb6WVj7tETonMARJ5UEl67JqCdkUYR36eCJ
	V2QzSZ7w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfogl-0000000B6IQ-0SfH;
	Sat, 04 Jul 2026 00:56:59 +0000
Date: Sat, 4 Jul 2026 01:56:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org
Subject: Re: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
Message-ID: <akhaWrUHXcubQQab@casper.infradead.org>
References: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
 <akZEjH2Hf8-RR8yQ@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZEjH2Hf8-RR8yQ@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:agruenba@redhat.com,m:brauner@kernel.org,m:djwong@kernel.org,m:gfs2@lists.linux.dev,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17478-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:from_mime,infradead.org:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61A5470650D

On Thu, Jul 02, 2026 at 03:59:24AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 01, 2026 at 10:51:06PM +0200, Andreas Gruenbacher wrote:
> > Do you have any suggestions?
> > 
> > The above is on RHEL-8, but a similar code path exists in cgroups v2,
> > triggered via:
> > 
> >   echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim
> > 
> > That code path starts with:
> > 
> > memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pages ->
> 
> PF_MEMALLOC is a sign of direct reclaim.  cgroup code is doing really
> weird things when it is set and it is doing writeback.

If we're going to blame the cgroup people for doing weird things, let's
cc them so they stand a chance of seeing this ... original at:

https://lore.kernel.org/linux-fsdevel/CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com/

