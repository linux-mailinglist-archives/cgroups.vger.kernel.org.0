Return-Path: <cgroups+bounces-10880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245EBEBCCC
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BBA1892795
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327503112B0;
	Fri, 17 Oct 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVMhyYb7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50230BB9A
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736087; cv=none; b=kjBnlwCpYk3t8ScKIj/3eRJP8gfJIrIDARS1Zyu+xFAZE9O8KIEx395TYX+bSRyXROJPSu036NiJFAjY6lJ4nVwFavs2m/FrsDhIThKpXBoTaidbKgbmmHZ014aBVLZdRfHqh4Oxopq2QFRKt1MEMxi95jQrFmptc7/yXUAT2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736087; c=relaxed/simple;
	bh=T4OYMvTdftxqFeyP56L6EtPT4hQ212hpYAZglMGTiNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1XlGzVa/4Xs4GeM9xvIoGqPE+1SzQXcU6wjbY9MTV16qnY1JD6Yc2VIGwauqiLKBOntd0SGlyiEAWt0Q5ZS9M9Dyu7bWH8jd/5Oj99KltmuZ60lR7cdHtj+g9riAJuwKafTMqdnlJ73I7iXZXPHNpNyGbvrjp3nmCsYQ5VSizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVMhyYb7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Oct 2025 14:21:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760736071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrDL0c/M+J3ZU+1YrOf5u7VfSDUST8z9dw2cDkrdgtQ=;
	b=cVMhyYb7hm2NG2noNVsHxfNZoFjbk7DYfg8bEDXc9k/szYHZqW3C+jIj6+SOEfnqf3XzBT
	fmGJWza+QDJZTFeIMiFJPnSvZ7lXpsVMhijyqBvUKirYWxPZ88gsco4LplzoQdQ8VI+yCG
	f/k2OAlWePwj/uG0Ps9Rj0RbLohCGOM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weibunny@meta.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory
 pressure
Message-ID: <cyg7k36ohtg3irtz7qqlyzsgh27ewibbsornq6xe2cjw66zsy7@cjpxycqwgigy>
References: <20251016013116.3093530-1-shakeel.butt@linux.dev>
 <59163049-5487-45b4-a7aa-521b160fdebd@cdn77.com>
 <pwy7qfx3afnadkjtemftqyrufhhexpw26srxfeilel5uhbywtt@cjvaean56txc>
 <209038ea-e4fa-423c-a488-a86194cd5b04@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209038ea-e4fa-423c-a488-a86194cd5b04@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 17, 2025 at 04:15:18PM +0200, Daniel Sedlak wrote:
> On 10/16/25 6:02 PM, Shakeel Butt wrote:
> > On Thu, Oct 16, 2025 at 12:42:19PM +0200, Daniel Sedlak wrote:
> > > On 10/16/25 3:31 AM, Shakeel Butt wrote:
> > > I am curious how the future work will unfold. If you need help with future
> > > developments I can help you, we have hundreds of servers where this
> > > throttling is happening.
> > 
> > I think first thing I would like to know if this patch is a good start
> > for your use-case of observability and debugging.What else do you need
> > for sufficient support for your use-case?
> 
> Yes, it is a good start, we can now hook this easily into our monitoring
> system and detect affected servers more easily.
> 
> > I imagine that would be
> > tracepoints to extract more information on the source of the throttling.
> > If you don't mind, can you take a stab at that?
> 
> We have some tracepoints that we have used for debugging this. We would like
> to upstream them, if that makes sense to you?

Yes please, send them out.

