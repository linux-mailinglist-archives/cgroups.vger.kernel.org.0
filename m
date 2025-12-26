Return-Path: <cgroups+bounces-12753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9ECDEEB4
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 19:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C07330053CB
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24F1F12E9;
	Fri, 26 Dec 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOOeuskU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7631448D5
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766774908; cv=none; b=QBbksmeDespKPwQrCu5kh+HYNi+ULoRKWqZpZM5W7D5RgRw7/tlaQ3/cDuQq9pEo3ZOQ1QGRz33uPNChucgGUKsYFfL3I0wCYHyqjBV4bbAJGWfRWssHr4CTps38CaQQiMc4joEQLq1nANHeMajsO8FnllQoeL+ILW7IdG2XMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766774908; c=relaxed/simple;
	bh=06BKZ09iHpjMBUebpArY/Ng2QU4bUPs25PZ10YMBoCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWG+8MhQBNwo/Beo2u2WFvSnt87MWStE4bDV9G165wgahlZho9dFbIb9TffQL+lWPql3oHssu52RW1Xu4/moLhw4JBueC2+c49R3SUYSlQWqgbOCMj74DRm83hKUzkEYhInSghRXhLVHd/ccAIm/kdbvUl7aDm1jkAi9XPIiGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOOeuskU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f02651fccso1120835ad.0
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 10:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766774906; x=1767379706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djYExfQ2m4DSgDlbkjbYXQXDI3fF2Fqxya+fA5npzyY=;
        b=WOOeuskUt4s5R6aH6R1j1utepCjaGvClVonqD29OlZzp9ORyCsrgQyjZSVmr61BB4w
         7F16Sy2L6XxDSuZ0ezhCvcX3ntoXSxP/XaumcWnaUHZX86Z1N8o7SIMcxbBEBWSgQj/O
         IVeMAU39xpaTraL9FxAJAwBlzqoiRszrzr9aASTBjwK4rI/dLLFfNIgZzxHuxInfKwor
         QO40RTx4QcMMvyLZJKSodrGHhIM5sZrQMSY+3rIePwF1+NNZnlLTrWXwUwC/v+2sDCMu
         GKs972neBB3nrpfoxwWqnEtw58m3avYA/higi+Fshd5aLi2wp5rK2ve2+/PnStzBlB7G
         1nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766774906; x=1767379706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djYExfQ2m4DSgDlbkjbYXQXDI3fF2Fqxya+fA5npzyY=;
        b=gD2Ff4iQOYt/+RJ6EQR5AxWEXsSJ3IvfjGjhj1gbXUo6azv0z+8mjDW6M5JatSDKWv
         j1536o2aV8DIgEPULNC9fApp9DUABVA68JZWUI2Tht6rjXmTqSRJGAZlgjcfqkwd/yXy
         hIPd+LobhP9UR6Kp3Y/CGE/ulA6qkmMOyCN6INTmT39q5HzFC0YxunDVcucuLlfjwJPW
         6VA89egkOOh73u4qKVh2bdj4/NzBTOtVdpymhgr5SDThCVv1pVf4V6QcMIsn+R51lyng
         1C6dc+JiL7Agij0oNgVhpt3/FiXIBLKL2iLXTjCmN6b392C+luR75C7egspHpKT7sNTq
         rAUA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUz3FGn5/6pO5SWvsoGWqYE7dhu0Q5W5DtdsaEtmPHstiM9ECCPZG7FT4q0bu4aJPWaUE4SOM@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMhSLhMhU6IdfgvJltzP9O+65n2lE3FlmL7W5twY7lvYoICLZ
	7KFRjOlTJ4VcKuRGhLSwaygf8EHyqJeYtAgGgtowOb3RnMjV+qEtPgX2jcJ1uEepdQ==
X-Gm-Gg: AY/fxX5aMNYyzS8RDOw2z6TTWj9CK+x5OmO7b9/eXrI/JTzBnBoSSVAIjNQaC7YwVOg
	SZKytesSvFgETWPoy89GOrjpOnDtw1TLtYObAmKumv27nOaRT5DfcbNKEkJASx02ckNlo/tWY7J
	CqbFe62vkrWkiy0rBW9JoUYuuHPoC7onsDuE2H2crb4Nr1BlWMS9M4rYhRozbxb4QJYLRq7Cr9B
	8nTCHDHLK0VMm59NKs6t/OH8xDXmQlr0c4gWALGpGRQ1pyMIrD7MsyrdNgDyOt0XrkB1hvBVNai
	7+y7eSOpG6Yq/b9AC4Kl0oxLjFH52yRHryf3zhx1cQsBnFP8iuGAEqj+YMnQDvo0f7b3iH73Stt
	fTEWmAo34fQuLDadOgTKNlEraZzmklH63RXSW5YavxrxwHz9uMAJzJg/5PkwDlZqHZLOrPH9Cgz
	3jPiECOUfA5GudjubHvQqeZzz1Gp2JNFfbsRJpk+WwH5exi2JFzbWdSDmKgtpI5qM=
X-Google-Smtp-Source: AGHT+IHmIPSPLMo1hA02PAzK6JQzto61+CEQElBIyOOAThagpL/yC/1XBoIoO0pQxTmfbDSihk3IEw==
X-Received: by 2002:a17:903:2a8e:b0:295:3f35:a315 with SMTP id d9443c01a7336-2a353a370demr3454615ad.5.1766774905999;
        Fri, 26 Dec 2025 10:48:25 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828dbsm208456505ad.22.2025.12.26.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 10:48:25 -0800 (PST)
Date: Fri, 26 Dec 2025 18:48:20 +0000
From: Bing Jiao <bingjiao@google.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <aU7YSXnoBTFRy-KF@google.com>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
 <aUs_pLTcsVK8zf0g@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUs_pLTcsVK8zf0g@gourry-fedora-PF4VCD3F>

On Tue, Dec 23, 2025 at 08:19:32PM -0500, Gregory Price wrote:
> On Tue, Dec 23, 2025 at 09:19:59PM +0000, Bing Jiao wrote:
> > -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> > +nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
> >  {
> > -	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> > +	if (memcg)
> > +		return cpuset_node_get_allowed(memcg->css.cgroup);
> > +	return node_possible_map;
> >  }
>
>
> node_possible_map or node_states[N_MEMORY]?
>
> The latter seems more appropriate to me since node_possible_map will
> include offline nodes.

Yes, I agree that node_states[N_MEMORY] would be better.

> > -	allowed = node_isset(nid, cs->effective_mems);
> > +	nodes_copy(nodes, cs->effective_mems);
> >  	css_put(css);
> > -	return allowed;
> > +	return nodes;
> >  }
>
> I saw in vmscan you check for returning an empty nodemask, may want to
> at least add a comment to the function definition that says this needs
> to be checked.

Will add a comment to say that it may return an empty nodemask.

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a4b308a2f9ad..711a04baf258 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -345,18 +345,24 @@ static bool can_demote(int nid, struct scan_control *sc,
> >  		       struct mem_cgroup *memcg)
> >  {
> >  	int demotion_nid;
> > +	struct pglist_data *pgdat = NODE_DATA(nid);
> > +	nodemask_t allowed_mask, allowed_mems;
>
> Only other concern i have is the number of nodemasks being added to the
> stack.  Should be <512 bytes, but I've run into situations where builds
> have screamed at me for adding one nodemask to the stack, let alone 3+.

While having 3+ nodemasks presents a risk, utilizing two nodemasks
should be acceptable. Given that the maximum number of nodes is
1024 (2^10), two nodemasks would require 256 bytes, which should be okay.

Otherwise, we can keep to use mem_node_filter_allowed().
Only update it to return a nodemask when subsequent features need.

> Have you run this through klp?

I have not run it through klp. Will do it then.

Thanks,
Bing


