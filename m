Return-Path: <cgroups+bounces-11067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEFC038F4
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 23:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10793B121D
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B7226CFE;
	Thu, 23 Oct 2025 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="js3riS21"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA9EEB3;
	Thu, 23 Oct 2025 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255319; cv=none; b=LsBEclzJ/aE+RMLQNgWxj4YcQHowaWnDweWXEO0SPQBB3hmFqgTyjVgJs1sykkjPXGTuQfP5WF4QKc6zFO2tIUx9Ysk8sOY9eKfLTLUF/MnVZyyoqPxweiWeGB4zYQR2YhvbZlBd90WVcmHs03nvlHd8PpHZUkNT+pY/hiAy3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255319; c=relaxed/simple;
	bh=ZamVdUSILnPeyXRyMlRxKlWxFuBToagv7jcffP0neYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1dphsFVG+Q5+VCo8Lv0yH3ISaOnlRS5qVmLKfn4ZRz6v5VfqULvHHJ/BAjTdfIihOcfdYf7EwsHIwOcc6V0PghhNmfTFgxO2ui8IQjbsHagd0L+bYgGPbaYTA6XeRF2jZGZWVfu41+rjty38S4VweBGa/BAlmf48mlu7wATHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=js3riS21; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Oct 2025 14:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761255314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErOQJZYuBYGdBpUlkz7xxYDD/7HNDrO9In4Qqb0EuxE=;
	b=js3riS21e66az6Tr38Wp8ZB1PttEvYubbxImrS9U11/r3WOoOSUygYo+4HZmx20Bia1XmG
	vY2PhoZc1GDaXnexuFX7GVOQy1zV1Cf8mfxBbuf7LWncUCkny89N7J8htGD88NU1E/0i8r
	qzsKb/PlZx3RailoFTTtJ6clPPEAe0w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <jnzfiyojjwvrj3eemqmpigfyjxucdqe44fjy36nxkly6urtn7u@a6pfcppla3r6>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
 <aPorFhxQc7K5iLZc@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPorFhxQc7K5iLZc@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 03:18:14PM +0200, Michal Hocko wrote:
> On Tue 21-10-25 16:44:25, Shakeel Butt wrote:
> > The function __memcg_memory_event has been unnecessarily marked inline
> > even when it is not really performance critical. It is usually called
> > to track extreme conditions. Over the time, it has evolved to include
> > more functionality and inlining it is causing more harm.
> > 
> > Before the patch:
> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> >    text    data     bss     dec     hex filename
> >   35645   10574    4192   50411    c4eb mm/memcontrol.o
> >   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
> >   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
> > 
> > After the patch:
> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> >    text    data     bss     dec     hex filename
> >   35137   10446    4192   49775    c26f mm/memcontrol.o
> >   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
> >   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> 
> As the only user is in tree should we make that EXPORT_SYMBOL_GPL
> instead?

I just followed the file convention i.e. all other exports in
memcontrol.c are like that. I would keep this as is unless you have
strong opinion otherwise.

