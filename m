Return-Path: <cgroups+bounces-12624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D21AECDB11C
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD4783009974
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50726D4E5;
	Wed, 24 Dec 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rGTkxZ8o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386041EB5F8
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539211; cv=none; b=UtBbmcPX6yA/gqnBYczm4m4omsKcK63DXvaPHRNeafvKPJjwAXF0zADKMKUjMJr5eFVFow2YN1rm3vGoCbH1H8ISM02oRKYJB9GN/7vtb8PLZFaxo2blJvRXX7nSphb0q7oR2pWgqKvuxHHhzd6400xjDVaoC6OVxgaiNx/9mF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539211; c=relaxed/simple;
	bh=pEEje7VV4vEFrHac8YIHRR5jfS0PSMQIk01EuNJtnAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxFv71DlocX/y40xReD/uEunzlrGMQ7snpGT+9eK+GZrd5uTf/fbGApqv+AwpgcmgZeHvUem0j++UxgSyY4dhtnQUvC0y3OO92vjq1AZzueH08A+C3uxHYv1WKE/Z6gwZCSawvF/Vmm6nM7Sb3Q8nL5TCMeiLdZwgGBSWEiP1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rGTkxZ8o; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c0f15e8247so445458685a.3
        for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 17:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766539209; x=1767144009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFObj5r7cwRvtCEi52qvIAAFXzZpppZhq6YoRYQI4aw=;
        b=rGTkxZ8o85uxgpTLAEk5fpXRlY/krbC9kKOd78KUUj5A5PTXi0jLY01vncSQtAsu1L
         OXp6Afhdwc34NPLbnGXHKRlelPuToocpBQO4WJ0HIetLDAZLc27bqF7jCoEFFJOHBXHk
         QFf71XbKhV+1kmjqAUaqsSJ2tRvVG0a7fwMRz8MRy49rYPMahkCUS+RenzSGZNr0BSmM
         5KxSmZ0cc6jzMBp7jSNpU/+4zhH25HXHYmNbiMueL7PXUjswrsAaUMpiyMkC5GaSkNp9
         6le9PLozUz6iKLLc0H1S6jHk+rjtqekvo+LfZTlfPSirLNFQ96P1BmIcX91mhvI4LD1h
         afZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766539209; x=1767144009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFObj5r7cwRvtCEi52qvIAAFXzZpppZhq6YoRYQI4aw=;
        b=KZZGBZkw/FNkIXzG6yBou+BgobQVG1PzK9LWxZFzBNj75aNptI7PbIWZKQze2T/1ws
         KBiu8Mj1DsgekBnDUokiJZR3RRIBgcJSogveNbOo2kJQQMXgP9I1xtf5EtE+Lpk0CsvP
         a63J+/pwNY9B1YIUKaTISoxr/wKHy4mBMQkIy3wGlwUoGjvzB37yWh2VMHvLVexz/gfJ
         xsL6ioguxJJXiak0GCgsF43vcZ8StGd0PyrSgOQ6/bWPFGsgdVeJmhHCEehWvA0f0Jta
         HbYtOZyJvb2t79WVcvZHSTpGf6SpfbNPtTbeRe0ravPriK7P0n0iSOhpeXz3pXlOutuj
         ksTg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ebq5BplZaWLJ/lHYeax4TdZ2M0BoV7VAKtCUJUsEsUQ3oysx2FNTxwahKuq2O1/ucJ0u6FQg@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdTjVBLnCGLq+y2w3oykVDIRPqlMhFynMoT2Z8f59WVJZCNvN
	vQgspf0cxPePGjxD3oHKSi6tKwaQxJZcdq4DUZgS/bUIU3rcr6zh+Dn+0CtprQ9rEk0=
X-Gm-Gg: AY/fxX7fmiywKWuAd41ylV6eEPeXWZwz0pv3lrXuG7QLgUF+A+W/5w/PKGRnk78lAEy
	P3xu4filpygUvpi6HX7n+0JjqaDGSayuthwhGQxGhWldFJbcmIAR/PygiUO+YYj73U1inN+r6ZF
	H5qLI6iFVBIrw4+j9IlnBVB79bes5ZfX5pUcI2SVH9QKq8/KEFtFAa9M30FyV442dCJ8/plMSwN
	xiOsE8nbWoFOGZdtaQxfUDf7wYntXWXHInNCz/4LAYPxB++G5U3aQ7lgw5YFMAgxaZho2z2Y2Ul
	nqEWmRm0nb0KOya9FkvCzpFbi6yPiPyPwHdcXytD5A9faFnwYClygvxWUxHPXaRrHuEPrB8P9dc
	GBA5kwkX4+lRZn+QiSTPHHPrfAMBOVKdKV+dsOv8Wk1F8vC6zSpe3pXABKhE0ZqkzUUqcdQ0Hg0
	NArNxD7pDjHU7tZCqFcj4yK6uBCenAuXKcyEHAnrjICCnRCH6CpVTCWMhjYXd6o2zPppaSkTunT
	aFFuj9c
X-Google-Smtp-Source: AGHT+IH83buBAwf70kUxOa87xFJIKSb6f+lCqy7gWQ1Yx6Bx1CKse53IrzVNP6DC3zlxCVvPSHTOaw==
X-Received: by 2002:a05:620a:46ab:b0:8be:9050:8548 with SMTP id af79cd13be357-8c08fbba66cmr2422303085a.33.1766539209066;
        Tue, 23 Dec 2025 17:20:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm1195174785a.41.2025.12.23.17.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:20:08 -0800 (PST)
Date: Tue, 23 Dec 2025 20:19:32 -0500
From: Gregory Price <gourry@gourry.net>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aUs_pLTcsVK8zf0g@gourry-fedora-PF4VCD3F>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223212032.665731-1-bingjiao@google.com>

On Tue, Dec 23, 2025 at 09:19:59PM +0000, Bing Jiao wrote:
> -static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +static inline nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
>  {
> -	return true;
> +	return node_possible_map;
...
> -static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +static inline nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
>  {
> -	return true;
> +	return node_possible_map;
>  }
...
> -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
>  {
> +	nodemask_t nodes = node_possible_map;
...
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
>  {
> -	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> +	if (memcg)
> +		return cpuset_node_get_allowed(memcg->css.cgroup);
> +	return node_possible_map;
>  }


node_possible_map or node_states[N_MEMORY]?

The latter seems more appropriate to me since node_possible_map will
include offline nodes.

> -	allowed = node_isset(nid, cs->effective_mems);
> +	nodes_copy(nodes, cs->effective_mems);
>  	css_put(css);
> -	return allowed;
> +	return nodes;
>  }

I saw in vmscan you check for returning an empty nodemask, may want to
at least add a comment to the function definition that says this needs
to be checked.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a4b308a2f9ad..711a04baf258 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -345,18 +345,24 @@ static bool can_demote(int nid, struct scan_control *sc,
>  		       struct mem_cgroup *memcg)
>  {
>  	int demotion_nid;
> +	struct pglist_data *pgdat = NODE_DATA(nid);
> +	nodemask_t allowed_mask, allowed_mems;

Only other concern i have is the number of nodemasks being added to the
stack.  Should be <512 bytes, but I've run into situations where builds
have screamed at me for adding one nodemask to the stack, let alone 3+.

Have you run this through klp?

~Gregory

