Return-Path: <cgroups+bounces-4550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80529636D4
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 02:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ABD1F23C01
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31F125BA;
	Thu, 29 Aug 2024 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEfWSVSL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F2BD19
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890849; cv=none; b=WGQ3AA0gNBv72hfDc/CEZtKufTwpkrp6R4xc7M08ncGU28oaBoN9iZCki7+Um0rqoaF68RswkS8cg8L4XxQQ8yt7MQrjr5ME2vKhgTEckSrdyiXJWyhJPvpubvtPuzO5OjkQnAANtfGQoNJYrCDA/jsS9V1+d+E/bIRRjMFT1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890849; c=relaxed/simple;
	bh=LF6T8AcFzxJizs1RNCrNj0Wn0KwlYf0KoRJaWjlDoSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abtwPZqtA0YdSkibhAUfmhiAf+lPYDI2YDldQvb1bZAqaVV8fTyp0maczDT59eJnKcZ9sCaEfXgMgSxhCRq3fkgZGaDrLPxynxgXMYwaZYa6HRsWlYWFd/VrYcQty+gqkLvJBkuBvUG3hVv9AyKwjZbr0jZvxs0MRrL+dWX61lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEfWSVSL; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 17:20:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724890844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLXGCrNct9jGqEI7ms61SYRJsNBSmqcaMgAuOY37bXA=;
	b=wEfWSVSLfFpu7JERnDYNjiiIwW4JZQsCwl4xp8Syd1XmPU8IE/Irj0KslMKizlipQuShWx
	5T8jRqwGe8wgiCwQsQa3Tl0rqCQb8+Wdw8Ylgxw8Ti0A1lTYqkbH2IJP+TmIQYE9fpQh2x
	0WhlCBfkY/CW+AUV00RfKzHiTPlEfcY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 04:25:30PM GMT, Yosry Ahmed wrote:
> On Tue, Aug 27, 2024 at 4:52 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> > +
> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> > +       if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
> > +               return true;
> 
> Taking a step back here, why do we need this? Which circular
> dependency are we avoiding here?

commit 494c1dfe855ec1f70f89552fce5eadf4a1717552
Author: Waiman Long <longman@redhat.com>
Date:   Mon Jun 28 19:37:38 2021 -0700

    mm: memcg/slab: create a new set of kmalloc-cg-<n> caches

    There are currently two problems in the way the objcg pointer array
    (memcg_data) in the page structure is being allocated and freed.

    On its allocation, it is possible that the allocated objcg pointer
    array comes from the same slab that requires memory accounting. If this
    happens, the slab will never become empty again as there is at least
    one object left (the obj_cgroup array) in the slab.

    When it is freed, the objcg pointer array object may be the last one
    in its slab and hence causes kfree() to be called again. With the
    right workload, the slab cache may be set up in a way that allows the
    recursive kfree() calling loop to nest deep enough to cause a kernel
    stack overflow and panic the system.
    ...

