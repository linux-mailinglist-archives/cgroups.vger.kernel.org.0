Return-Path: <cgroups+bounces-13835-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F+RCJxdi2mYUAAAu9opvQ
	(envelope-from <cgroups+bounces-13835-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 17:32:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC811D352
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978AD306FCC4
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03201624D5;
	Tue, 10 Feb 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDBNiYK3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73429168BD
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741025; cv=none; b=h9XcJKjOZ+TLfjukueZ5sQNmfp7Lf3oLEOdP3dsz1aRyvOX3FKDizEF1uCRSMj+BYCxURn2pvok5jNA9EFK1vP9PSbWCFLC9kVZYC++xNkCxiqikR1SlrhfmfdQ7MzWb/Lz40+c43xHXNcwCq5V3U2HFHT8kEWyb5N08vogEmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741025; c=relaxed/simple;
	bh=apf+WxV7DF9xXs7mg57Z4stowwqhdNdVzUotm2+M5fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAe/Ov6Cnx9a3tANuOg3PeOOFGhS0JEwwkYUGZ6UpFgdHgyDdda2/ouOqyiTfI4PnSMDfjSsDuGsJP/7tsVidsoHfzrLRi2v/JEIRPRQDnfN2601G2A+fAZZF3XXyPiBVRoQlTBajy0PJKmhdzAqcxbCIy/XP0AGuStqRtG60U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDBNiYK3; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Feb 2026 08:29:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770741012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciUjhVvToHNuGHTWYUtNytWkQjP8xnn0ronWwShe/v4=;
	b=dDBNiYK3kAcBNyjmK6tAsif/GJhG5jdJ6YP36U3pdsspXExzOFwt0xJmk971+m1noj6eBs
	QZcarLuLNpMR2MvCWsG+jNIfEbgwuGDnS3piJxgnie6cUiXA6SytzhmUoZ+V00noIJdLz+
	sGQN6ankIQEd6jfvWZverOQFyGwElss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dev Jain <dev.jain@arm.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYtbevHEwx_3fn0Q@linux.dev>
References: <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
 <aYAmGc6lu973jRwu@linux.dev>
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
 <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
 <aYQuj6Ot-JS4tXvY@hyeyoo>
 <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
 <b77dc11e-fe09-4f0c-a912-d05faa01ff1c@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77dc11e-fe09-4f0c-a912-d05faa01ff1c@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13835-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 68FC811D352
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:08:49PM +0530, Dev Jain wrote:
[...]
> 
> >>
> > Oh so it is arm64 specific issue. I tested on x86-64 machine and it solves
> > the little regression it had before. So, on arm64 all this_cpu_ops i.e. without
> > double underscore, uses LL/SC instructions. 
> >
> > Need more thought on this. 
> >
> >>> Also can you confirm whether my analysis of the regression was correct?
> >>>  Because if it was, then this diff looks wrong - AFAIU preempt_disable()
> >>>  won't stop an irq handler from interrupting the execution, so this
> >>>  will introduce a bug for code paths running in irq context.
> >>>
> >> I was worried about the correctness too, but this_cpu_add() is safe
> >> against IRQs and so the stat will be _eventually_ consistent?
> >>
> >> Ofc it's so confusing! Maybe I'm the one confused.
> > Yeah there is no issue with proposed patch as it is making the function
> > re-entrant safe.
> 
> Ah yes, this_cpu_add() does the addition in one shot without read-modify-write.
> 
> I am still puzzled whether the original patch was a bug fix or an optimization.

The original patch was a cleanup patch. The memcg stats update functions
were already irq/nmi safe without disabling irqs and that patch did the
same for the numa stats. Though it seems like that is causing regression
for arm64 as this_cpu* ops are expensive on arm64. 

> The patch description says that node stat updation uses irq unsafe interface.
> Therefore, we had foo() calling __foo() nested with local_irq_save/restore. But
> there were code paths which directly called __foo() - so, your patch fixes a bug right

No, those places were already disabling irqs and should be fine.

I am working on adding batched stats update functionality in the hope
that will fix the regression.
> 

