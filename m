Return-Path: <cgroups+bounces-11930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3EC58BF6
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 17:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA0A536020D
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DE3587C1;
	Thu, 13 Nov 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="omCJXR4f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF192FBE02
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050472; cv=none; b=qwiYXCXgn5cyUK8m4pqwhsKItSf0gcvN+dUcgefnJYhcH6cyRUGeWBBfYRg9qJQDHFGUvqL8lmc6pWMOqAmiiOu8V3mZLR4udSXDmES8MHAGo2MBQo53GXbFZFZY5TnIgZ3qHHt68UQqeiA3pkc7a4lM/6rAVGDC2B3yF6SBg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050472; c=relaxed/simple;
	bh=hpWdQhE+X4U/BSfVtJpDtI0Q6SDoIsxzjMyzA9sI5O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpDhZbzVO7olli4mwpMr2pyuOX8BTUuc/qlWN6lg71Rf1znEZ1GZcLwI0yrRPPZzL+r5qmDQdFa3t1gksNPOBChaEw7zRVLHKD2YiNYOE+OgGEh19OgabAH7EkWwqpY3Ra1+y7tmQdziuRWElK/FhuGjVDVzmv/af6sLVQJaDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=omCJXR4f; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed75832448so11856431cf.2
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 08:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1763050469; x=1763655269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D69TLdbxnknJEodHNFVGBdjN3TtjlITr7+VI+AqAV5Y=;
        b=omCJXR4feyVnH1oUFhALuyESi4c/ll4DSS61LKaDFOt4GyLbbKlI8PK+KnNmCzU8/h
         cYhQftiMS5CGJK6KvP6QjFVspXh0ehDN66Ok9QtiOs3chPqAi56q8cr9vnSNn6L6nHC/
         xtItC3aYyqJ9spCPAZFMkyql72HkjMinYgLYYRSlvTUyMxk075HuQou+WU0RvP9u0tUa
         uX4zgmM9MHz667B/0vHTnL35qdgBem6tQomic1VZ5YBrOcg3zxbFsLf2vB5dLTf/cPcg
         lMHFU+9KqlRbcB7G0Palbu6fdQtfFTKtCQp/BSq0zoTSBk/YzM1UzJDa549QgfnwQyq5
         FkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050469; x=1763655269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D69TLdbxnknJEodHNFVGBdjN3TtjlITr7+VI+AqAV5Y=;
        b=DJ8euLcFHzsytQRdW42fU8ucq2BUlGtKMSz8MpSTRvOwbRnlH3cWZO6yZrgVQNthtZ
         jAWjK47rSNQMWqhlbcvZKc421f9ElCnIrmXqShQhJkTpEKCtw32XZMsa0Vf0EyTA38WA
         kTaGiA8KZIGY7F0o5HQCi9by5F3e/NvPFFRpRsONmi1raIHDuQmnz7WdeO5iqFN112WU
         nNWANUkmERLvK0jYvAvI47N+oa2ZG+d9WK/G+WorbywQQgAMETfQ3yFXMRH7MSL6F4HQ
         fsYDh4bQomOngAeqcT8FI3fTgj1sJC/CfKFAqeC2P85GJyWngr2/JZd0BkgLEMEqKJLb
         9Cow==
X-Forwarded-Encrypted: i=1; AJvYcCWlUijm5t+HWY1A590eOYmZs1z6nUORahFQ68WhQwkq2ll6anhOp6g9lE8s5t7hcCsaYoastjlj@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvPZhTkvxiPXUcXuq2DXAwb3dBlP7WfYkUJTNl+UbNYJ01l1e
	aPrRaBxq2cNlINq287wkXV1G2xFhKmwisQi57dhRg41xbrYz1ySwAhGz9ZrrdDwENbpchZ7pD8B
	uCW/b
X-Gm-Gg: ASbGnctV1C38GxlU9EF0YVOp8eAivnCA7nRdSJwuRlXr0w/Fns6zbHm5neaWmVe6leV
	xRwcdZu8x3pKSxfuKqpWSCCy4nFAc1WCPOJ6a7u4fnNurTZoX2a09mMrBXYXK94XuvW+4fV6ifk
	ro9/wRsBsivI6RbyxnIkcoFq/nujtF4vSJo0Ylh7/z6Jx5UuLcnMJPB0pvbpPnyadP7iOQ3jIk0
	ZgdYIoKZWPOkNsAzMoMo3r4KVSz5+euSDU4tz/kuioM3rLSXGXvnyTChZJ+ifEU9cx8nc6h2lkX
	lT/LlTU8VSXuGsp+3IOcUAACwisTvPV3U1Bp3n1aZkmATjk1S9lB+ZfUQptMSFbtAwdmkoX29xW
	0IUr4li2AROYWuoihjQ1xM6L2Q/SjYUab65fIq6g35oEgpDP49PIVuyrdFKMJ87mQISjKs0Qwli
	mRyrXjLjj+9w==
X-Google-Smtp-Source: AGHT+IFMoZ5CF2EVUYFz6bRcYn8UYY+zeUZ6tQhwL5YOc3+o2Saf1JPdJPogRlkyrwZ23BIM4+DEVQ==
X-Received: by 2002:a05:622a:4f:b0:4ec:f073:4239 with SMTP id d75a77b69052e-4edf2048873mr2996101cf.6.1763050468712;
        Thu, 13 Nov 2025 08:14:28 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede8816ab8sm14289731cf.26.2025.11.13.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:14:28 -0800 (PST)
Date: Thu, 13 Nov 2025 11:14:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <20251113161424.GB3465062@cmpxchg.org>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113000932.1589073-15-willy@infradead.org>

On Thu, Nov 13, 2025 at 12:09:28AM +0000, Matthew Wilcox (Oracle) wrote:
> -	/*
> -	 * folio_memcg_check() is used here, because in theory we can encounter
> -	 * a folio where the slab flag has been cleared already, but
> -	 * slab->obj_exts has not been freed yet
> -	 * folio_memcg_check() will guarantee that a proper memory
> -	 * cgroup pointer or NULL will be returned.
> -	 */
> -	return folio_memcg_check(folio);
> +	off = obj_to_index(slab->slab_cache, slab, p);
> +	if (obj_exts[off].objcg)
> +		return obj_cgroup_memcg(obj_exts[off].objcg);
> +
> +	return NULL;
>  }
>  
>  /*
> @@ -2637,7 +2627,7 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> -	return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
> +	return mem_cgroup_from_obj_slab(virt_to_slab(p), p);

The name undoubtedly sucks, but there is a comment above this function
that this can be used on non-slab kernel pages as well.

E.g. !vmap kernel stack pages -> mod_lruvec_kmem_state -> mem_cgroup_from_obj_slab

How about:

	if ((slab = virt_to_slap(p)))
		return mem_cgroup_from_obj_slab(slab, p);
	return folio_memcg_check(virt_to_folio(p), p);

