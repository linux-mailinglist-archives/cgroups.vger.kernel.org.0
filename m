Return-Path: <cgroups+bounces-5278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B032E9B156A
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 08:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FB0283329
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EB814D2B1;
	Sat, 26 Oct 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wczahDW0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3013792B
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924494; cv=none; b=EiYpx2mGxJb6AvepUP1AIMJYKUln3AFdvKtiUDCVxxTYz42wAqANjohoQ4MXJoiQgWTIbVPVU1F5UVizTgQSBTQvUys9njOO4mZ/H46Pc5RzD+OrLl4nXvgutYzAk6X7hclbcT8z1yN9hmpGZv7jhC4JS0E68L7win1GW/ro1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924494; c=relaxed/simple;
	bh=8MEZ7lwX5sGzz8KdBgtWG5NX15NIfJ7Pjy5GijPHl0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJy44iMria9JbmQmyhlWUAPyU88b0gpV3dX1UOONS7aE6UoueyrNvUzGZ1af1CVTdekN5YqqxV60zyiWtEvu67aPVPBbkzdPuYAY9K0JE1Nud6lBVlN57TRoe9T/Ud9WS7sAwaX+nxC6BMcsqz0UVmo+ejyk485Uu2wqACztroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wczahDW0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 23:34:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729924489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxrrU0C1HHBfUSnsjeyhEXVDIjFovKtPgZ0TUPmLbvU=;
	b=wczahDW06h7sCwR/14RhOAhWxIUZiK9a9DHkNpFa54ZSDnpRWfSNkjci9DWRCMM39T3yFY
	JucMbidVMqOQGS8doMn8rAbfDURpjRycJKApjaKvXDDDtGBdV+pAorShsf6DE8hljux/dC
	Td3IuC1aSRPgC4lmUR0FdWkEr9EwdWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-6-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> While updating the generation of the folios, MGLRU requires that the
> folio's memcg association remains stable. With the charge migration
> deprecated, there is no need for MGLRU to acquire locks to keep the
> folio and memcg association stable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Andrew, can you please apply the following fix to this patch after your
unused fixup?


index fd7171658b63..b8b0e8fa1332 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3353,7 +3353,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
        if (folio_nid(folio) != pgdat->node_id)
                return NULL;

-       if (folio_memcg_rcu(folio) != memcg)
+       if (folio_memcg(folio) != memcg)
                return NULL;

        /* file VMAs can contain anon pages from COW */


