Return-Path: <cgroups+bounces-4571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE7964AA1
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6384F28342E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294981B3F26;
	Thu, 29 Aug 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y98tF+x9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4E1B3F14
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946644; cv=none; b=rLl+z28JWRWNVw8myqa8vWOA+hDHpuBgn+pYnRV+BnSPW7r5Rm0ELSCJqCy4S7NIkpWEuCD2h7VM+T/6wDmHUICv641r4+ShJ2Wplwu5KhJCj5Fus40kp+lUi267nmDUgMZUdhcRlmNIzhiAJBU6Yd9T307Owx4mdPXlWp/3+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946644; c=relaxed/simple;
	bh=7GhPUQ6q64hFexUsXq+ZPTqAgyhBvdGjvxVnQ4uqWVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFx8nzPBcLSrLoF/x/LiAZVjvKwlfl+uNY8m7sj6I8w/sToGsanUBTzEdhpePs+8TaMtqKR7JXLNTtUFqJDPgq9m3skxlAK87Yl/Ql6NcN/7gkkhakXOxV20W94Pu76HrXSadnIWH5BkosQD6+sswk+zDAEO6Gi04mXQU8/+0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y98tF+x9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 08:50:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724946641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPvXQD4BCJq+MDpwmNo5dOSJNnMv53fu4MweHVYAXuM=;
	b=Y98tF+x9Bup3yWhEkcT4ZeQ6FDxNx/2jeVpecnAHOk7/2BELrk6vJjAXtG0Z62It7ykFYV
	y4AzX5zl7qEqB1fMYgg7ZE6LkVoHlM9aFK3l3FOdyrRGY3dHLt8Bmi8JunAbNLLtoqnf26
	txufsS0ND+4fhyXs/asLPeao5/6gqSM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <kraufzzyddwhttf3tneavdr3iclslmpbtfyrh7iuqkh46uslaq@k7c63pni4ae6>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
 <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
 <CAJD7tkY88cAnGFy2zAcjaU_8AC_P5CwZo0PSjr0JRDQDu308Wg@mail.gmail.com>
 <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 10:42:59AM GMT, Vlastimil Babka wrote:
> On 8/29/24 02:49, Yosry Ahmed wrote:
[...]
> > 
> > Personally, I prefer either explicitly special casing the slab cache
> > used for the objcgs vector, explicitly tagging KMALLOC_NORMAL
> > allocations, or having a dedicated documented helper that finds the
> > slab cache kmalloc type (if any) or checks if it is a KMALLOC_NORMAL
> > cache.
> 
> A helper to check is_kmalloc_normal() would be better than defining
> KMALLOC_TYPE and using it directly, yes. We don't need to handle any other
> types now until anyone needs those.
> 

Sounds good, will update in v3.

