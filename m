Return-Path: <cgroups+bounces-17160-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aW7hC2HJOWrnxQcAu9opvQ
	(envelope-from <cgroups+bounces-17160-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:46:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 768636B2D98
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EKui55gg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17160-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17160-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC03303BB18
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F93368263;
	Mon, 22 Jun 2026 23:46:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAE7260F;
	Mon, 22 Jun 2026 23:46:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171995; cv=none; b=otl4XRIeal8FwsDWVGuumrKEw5tdWWnyHItQlQ9qqfkvDFr+Jp3DL637E/VtzOXp5g3W69TdBAnp7RnNIZ3I8eJtFm+ABKgcSNL726QO6dc0HeqPwPlu9RyZJQnEts7JGBdCgIiw9pwa3RELdw1KnXA9jkJH9EbE+RM9r5usREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171995; c=relaxed/simple;
	bh=seabZtbNOCNAPG2R67d3UdknIP2NESiGXOEo8r5SZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzbyQ1DCtvQ03bGtIT4Q/DyFBoa+keDln0GOxL4am3yftPrzTPmHXj8xBZ8bCOpgwLocJ1/SvkC9R8lkfOB0HJS/5lbVGyxl+iVF2dJj/0hG8Z4Fa5/py5V7MkNQKQYUarWH/BEk7MywNUVwG1wt4JOXXX8mcn3fE1JDogoPMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKui55gg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238551F000E9;
	Mon, 22 Jun 2026 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782171994;
	bh=ZSHJBLoJ+dWJVwc5iapW1lVBZzDPVPjrz4FsQ/5Y1tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKui55ggl68KS9bfibjffBO4ATEI/oVW9g/Pk10ECXU+bxP6g2lkFTMq8djcKoU90
	 VDG5MKH2LnbbMyouefWJ9gQUjJHX8x34FnrAoT23uTQLur2JLKUDEPV3q0s/sLDIbX
	 RiNeGidw/W6BATanNE+zDxALUa0711gHkM6ugW1VpZ9VrHtDJVvFj6jpnEAdIOXfJa
	 rEAbm4LwbPbTPeyXzpgSsNTIXrD/bKxPWtS/Qy73vFd5iMFMmXzFNACWfk54Gg/TtN
	 7TsitNVIHlwCMDldQcFSxmuivvqJpjdo30zwWlJtOV1xMU+SHUY2i3Vq2iBhCr5SO/
	 Oce8IZRL+oROw==
Date: Mon, 22 Jun 2026 23:46:31 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Youngjun Park <her0gyugyu@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org, chrisl@kernel.org, 
	youngjun.park@lge.com, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, baver.bae@lge.com, 
	matia.kim@lge.com
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier
 selection
Message-ID: <ajnIasdb6j6yDUdy@google.com>
References: <CAO9r8zP6zDshSGU4chaHiPocahQZpiK5Z-eP9VKH+2_xjNM+4g@mail.gmail.com>
 <20260622231948.1002174-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622231948.1002174-1-joshua.hahnjy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17160-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 768636B2D98

> > > If that is the case, I think auto-scaling makes sense but can be a bit
> > > tricky, since there is no universal tiered ratio; each workload will
> > > have different tiers it can swap to, so they will all have to calculate
> > > their own ratios. Tiered memory limits escapes this difficulty since we
> > > assume all memory can be placed on all tiers, so we have a system-wide
> > > ratio : -)
> > 
> > Hmm I don't follow. It's also possible (maybe not initially) that a
> > memcg cannot use specific memory tiers, right? I am not sure what the
> > difference is.
> 
> You're right, I was speaking more to the current state of memory tiers.
> The majority of the feedack I received was that we already have too
> many memcg knobs, so I just opted to make tiered memcg limits a
> cgroup mount, with no ability for individual memcgs to tune their
> limits or opt-in/out.

Right, I think this is similar to the approach taken here. We have a
single interface for per-tier limits. The main difference is that we're
allowing 0/max values to disable/enable different swap tiers per-memcg,
as there's a use case for that.

Seems like for memory tiering there's no use case for that yet.

> What do you think Yosry? Would it make sense for us to be able to 
> tune these values? Personally I think it makes sense but just wanted to
> make the basic features merged before I went to push for making those
> knobs tunable.

Right now we're not proposing to allow tuning swap tier limits either,
just enable or disable a tier. My main question is about the default
values.

IIUC, for memory tiering, if you set memory.max, then the limits for
tiers are auto-scaled. I think it makes sense to do the same for swap
tiers for cosnsitency. Or am I wrong about the memory tiering limits
behavior?

> If we want to make the tuning the same across swap & memory we should
> probably align on the file names and how we interact with them.

Yeah I think we should make the interfaces as consistent as possible,
within reason.

