Return-Path: <cgroups+bounces-12754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE23CDEEDB
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 19:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB11730057E3
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68924677D;
	Fri, 26 Dec 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1jjDMqK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDE18DB26
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766775531; cv=none; b=MbyJHoTIiv55Ei6Cw0bqytSIK0BMnIevbz+WCbwUl/a0voNkJhtMvoAkQYlmgAK/u+3H+nmsCn5yUY/1Ek9VSIdKPZsP0Hi6XXIKJw7B+3/Iqo5BB0tEumT5MZ2Hnvz6uw4AiAp5LPHbiiI0nfczaAYNtt2YLOluEPalVtTO5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766775531; c=relaxed/simple;
	bh=vp60nhRpjDahcte5kKH3WmAxYr3+0ZBZhwZ5SHJjH+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFWeiYkr7gi7BbkobzYY5H9JzR/DmtnwFpw3lM1ruxhFdq7eO9MaC/YFFc5xv5l5xyP8MJ+kdBDugVdOCYbcJdQwDkz8fiGm0JxATE3ZQqpJOMvT+EteVhqeKxDX/p815UpvCqi23/wcZ4fmKpYbbmQPtJm37ui09OiZdr3YtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1jjDMqK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d06cfa93so1097325ad.1
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766775529; x=1767380329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhlrA5UD6vYZ+x3JcTWZGMJmIRFbEcfDotqJPwZRBT4=;
        b=r1jjDMqKR6lV7MGk4OxS2Y77ewqYdPWW2IEpvkzBxkHWUnyRhgIXwEZp7IjcBZVrdU
         6iIZPc6OXnGT3+qL8vYjEx9EsOmpxZUK8+5bjk5c3Rcw3PdPwbSSLTWlMWfJBibpgMcD
         8eqKfWt+p8PXQHNthw6ssTBEosY1DmvDcYC+2H1cBrs+VyOkDykrDo1coICR5vwxjWpF
         QYfnl2hrRRarUPVebQ0tUyKE2XoaHAx1XwV+b0uxqGiP2oKavNY7dzY9X9SUvbj5Vf8g
         F1YgFiX/86rbDaqgPj0J6PM1XtDTRU+O4ir5JjAuVzcWAoeN1NdLzyTwz5vbxpUveub9
         LKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766775529; x=1767380329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhlrA5UD6vYZ+x3JcTWZGMJmIRFbEcfDotqJPwZRBT4=;
        b=UQxoxpQGoCHdcb9dpwNUMfLv2mbvzaCCqG94VlRcn3VBnhwoGpRiSCnz0UJJE2pB+u
         cNqmz9lJOnWtGEbkxWXyy/0m87p7VU4xBhzN4QyJIlJGHO+V8nB5BEDxfiHmmHnUNFQe
         Kc+0cXSdLhvwy8hAFR2viz3SFoJyzAPsSud+VS+G/qUnRMgWfmjAeasjw6V2mXdPSZwW
         G+ziYlxXZZ9NR6Ix4pVPvgArD8uuvt8NNd+P2JY7zvbLM3HrCiVebDvL7XDXKY7gu+bQ
         FTqbPHa3KjMpmuBVvZ5rHpeTTWH1lkzOY/Up2pNur6N0EWe8ojy4AAQpUGHUWTCdgpnn
         dOjA==
X-Forwarded-Encrypted: i=1; AJvYcCXtKOlFbWKqy/72kY4OJ4BNxXenfddPXglJOqtbV80PV1ttsEVEqkafEThuwgvmiKEgtAwEgx9L@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqctXeWOs3DH7WSgNNw/qkQ+IAk08hOHeDo1YtaqrUFBIkMLo
	zWBOZZd4OHrEXTpstOtFNXLUCqsb3WVQ0xyky9QuVSSvJJX3hLwfzno6iZsjYiOpWQ==
X-Gm-Gg: AY/fxX5gEFIuYbEIf+HK5ZWAK93OgFa3DwyaOif6jb4bv35dQ4S0trIsOUNifNATUn5
	fJ6TYzFshwXReG1ioMf0nNUuZuqWHX5jk3RIlOLMNVsepIYEx3/bP9QlA3FdC6QHoEwLi1mxoxX
	YJ1ly5DbPtRdJtd0veq7rS9nSGF4w96tBEkCU7g78o4YaO6RkfaOHM7XBYB0wfBLwdqeVUEF6be
	In5AdKqOf2Q5ZnBRx60OaEo3/2iiNW7r3ZoVxU6+/TvP1jSbqKVhmrGuJ/J9fZeDnJdoxsmo66s
	X+ipnlOga19bOne9FdsUQB5n+Je4rdLU+UfX8QiP2SyXj0nAq9ztgOVhJIzsvkofZpPN2NowGn4
	CpXbEZacAep2tFYA8meXlzYZUpsVYelIQo3N2LI3PGv0/wUdB7DS7/F9p23Iu+W04bbiLSeiR5A
	ZokHKe3DmIYE6+bg8PxROYp5BKBhJiVdKQiwyTWzwqgewFEZmwMWZO
X-Google-Smtp-Source: AGHT+IGQFAd8PfbkonRWK/eILNYIR1fN8cIZOU37eemTt6WBkj4X56w0kou5ks+d/BcUYUIqHdofxw==
X-Received: by 2002:a17:903:2c06:b0:290:cd63:e922 with SMTP id d9443c01a7336-2a353a4e3fcmr4253275ad.15.1766775528500;
        Fri, 26 Dec 2025 10:58:48 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c87845sm214750925ad.39.2025.12.26.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 10:58:47 -0800 (PST)
Date: Fri, 26 Dec 2025 18:58:42 +0000
From: Bing Jiao <bingjiao@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aU7a4t8ncmBAqjSf@google.com>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
 <646ee1fa-edd1-4588-9720-c3c1df8ebce5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646ee1fa-edd1-4588-9720-c3c1df8ebce5@huaweicloud.com>

On Wed, Dec 24, 2025 at 09:49:38AM +0800, Chen Ridong wrote:
> > +nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
> >  {
>
> Could we define it as:
>
> void cpuset_node_get_allowed(struct cgroup *cgroup, nodemask_t *node)
>
> to align with the naming style of node_get_allowed_targets?
>
> > -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> > +nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
>
> void mem_cgroup_node_get_allowed(struct mem_cgroup *memcg, nodemask_t *node)

Thanks for the suggestion. Pass a pointer is better.

Also, Gregory mentioned that the stack size may be an issue if
systems have many nodes.
Do you think it is better to use mem_cgroup_node_filter_allowed()
to keep the stack size smaller?

> > -	demotion_nid = next_demotion_node(nid);
> > -	if (demotion_nid == NUMA_NO_NODE)
> > +	node_get_allowed_targets(pgdat, &allowed_mask);
> > +	if (nodes_empty(allowed_mask))
> > +		return false;

This is a fast-fail path. When the queried node is the farthest node,
allowed_mask will be empty. Thus, I would like to keep this check
before mem_cgroup_node_get_allowed().

> > +
> > +	allowed_mems = mem_cgroup_node_get_allowed(memcg);
> > +	nodes_and(allowed_mask, allowed_mask, allowed_mems);
> > +	if (nodes_empty(allowed_mask))
> >  		return false;
> >
> 	node_get_allowed_targets(pgdat, &allowed_mask);
> 	mem_cgroup_node_get_allowed(memcg, allowed_mems);
> 	if (!nodes_intersects(allowed_mask, allowed_mems))
> 		return false;
>
> 	Would it look better?

Yes, nodes_intersects() is better than logic-and.
Will update in v3.

Best,
Bing

