Return-Path: <cgroups+bounces-16615-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DtMLKPxqIGqg3AAAu9opvQ
	(envelope-from <cgroups+bounces-16615-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 19:57:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB463A52E
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 19:57:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HkVO97m0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16615-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16615-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D93F3035152
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAD37F8A5;
	Wed,  3 Jun 2026 17:53:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4535B636;
	Wed,  3 Jun 2026 17:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509205; cv=none; b=fdPW8O+0vhPXC3kft+kd/v1qv56d9CKqWvexSbtcbZpgfz/fdj+XWG7K/VR5JZE2cRGKGq/1Zv/5UWcmUJpu1PKhIaDR4bhaL+oEsVWb+G9MHU/EEgJcogZEqGjyDojq/tQoGfQkRziZ9gJfd/9PqOPseSBr4Kmq5z+Cf3GnObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509205; c=relaxed/simple;
	bh=vppiZd/qtcCRgVLh1QMM9EF7Mw0qPVoVQ41j9MIeuUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q99U4ihXl52WlrW4tQQV39d5M7EC5fXE0LZeqkT3wAEc68JA71N7zB+mJBoTZ5Qebahi0gDSrTB+5FVVdVovVnQF12svYUUKfEuMyVFkoVr844ODDwXSH60APZb9uGZrrfD5cnU5Xygaoh3Akh5zLmj6aA/PR9G1FI0J+IGBnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkVO97m0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F1B1F00893;
	Wed,  3 Jun 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509203;
	bh=Kmw2GG270O/WDwV9f+xAk26aPfN3D53RPt/2qsfOh+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HkVO97m0JsKg+Wm02hgp6BASGf3hGqiwuLrba0GeSiPaD3J7Aa4WBjEyu35tjFpz7
	 +ClWT+Gq2KkgPeVhp6NPeZS5XFRt8WPhUKT041BRbyZ0gwdfekfBr1NlRf7QspnF2Y
	 xATaeyWAFn94pFEFUsZx7/Rf9K7PWJpofAYTGnRV63L6cqsbrX+nqUBpH4U0L3psZP
	 7H+Rn0P85Cgo8HmdiRhxiBYG6R7r8qjpNLTwXM8V4dmVtogbw1f0LTM5bwxpLQ98qa
	 GiBl9/XsnrCropM9xKs1JBwV3ZPVv0jVj372YBuXtNKdEXF1/terVlR4zDgaXMhxOO
	 02t21aRkpBsdA==
Date: Wed, 3 Jun 2026 17:53:21 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <aiBpibRNi0BcM1Zu@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
 <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16615-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ACB463A52E

On Wed, Jun 03, 2026 at 11:02:54AM +0800, Hao Jia wrote:
> 
> 
> On 2026/6/3 07:19, Yosry Ahmed wrote:
> > > > > > > Proactive writeback also wants a similar per-memcg cursor that is
> > > > > > > scoped to the specified memcg, so that repeated invocations against
> > > > > > > the same memcg make forward progress across its descendant memcgs
> > > > > > > instead of restarting from the first child memcg each time.
> > > > > > 
> > > > > > Is this a problem in practice?
> > > > > > 
> > > > > > Is the concern the overhead of scanning memcgs repeatedly, or lack of
> > > > > > fairness? I wonder if we should just do writeback in batches from all
> > > > > > memcgs, similar to how reclaim does it, then evaluate at the end if we
> > > > > > need to start over?
> > > > > > 
> > > > > 
> > > > > Not using a per-cgroup cursor will cause issues for "repeated small-budget
> > > > > calls" cases. For example, repeatedly triggering a 2MB writeback might
> > > > > result in only writing back pages from the first few child memcgs every
> > > > > time. In the worst-case scenario (where the writeback amount is less than
> > > > > WB_BATCH), it might only ever write back from the first child memcg.
> > > > 
> > > > Right, so a fairness concern?
> > > > 
> > > > I wonder if we should just reclaim a batch from each memcg, then check
> > > > if we reached the goal, otherwise start over. If the batch size is small
> > > > enough that should work?
> > > 
> > > Even with a small batch size, for small writeback requests triggered by
> > > user-space (e.g., 2MB, which is batch size * N), it might still repeatedly
> > > write back from only the first N child memcgs.
> > 
> > Yes, I understand, I am asking if this is a problem in practice. For
> > this to be a problem we'd need to trigger small writeback requests and
> > have many memcgs.
> > 
> > > This could cause the user-space agent to prematurely give up on zswap
> > > writeback.
> > 
> > Why? The kernel should not return before trying to writeback from all
> > memcgs. If we scan the first N child memcgs and did not writeback
> > enough, we should keep going, right?
> > 
> 
> Yes, this issue is not caused by the kernel, but rather by our user-space
> agent itself.
> 
> For instance, suppose a parent memcg has two children, memcg1 and memcg2,
> each with 200MB of zswap (100MB inactive). Triggering proactive writeback on
> the parent memcg will exhaust memcg1's inactive zswap pages. After that,
> even though memcg2 still has plenty of inactive zswap pages, it will
> continue to write back memcg1's active zswap pages. Writing back active
> zswap pages causes the user-space agent to prematurely abort the writeback
> because it detects that certain memcg metrics have exceeded predefined
> thresholds.

This will only happen if the reclaim size is smaller than the batch
size, right? Otherwise the kernel should reclaim more or less equally
from both memcgs?

> Of course, real-world scenarios are much more complex, and this kind of case
> is extremely rare in our environment.
> 
> That being said, your suggestion of using the global lock for the per-memcg
> cursors makes the writeback fairer and would resolve these corner cases.

Right, but I'd rather not do per-memcg cursors at all if we can avoid
it. Will using batches help make reclaim fair over all memcgs without a
cursor?

We can always add the cursor later if needed.

