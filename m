Return-Path: <cgroups+bounces-12529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474FCCE662
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 04:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF3F304484E
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 03:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95C2BE029;
	Fri, 19 Dec 2025 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="hRcoc9nF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9C29E0F7
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116441; cv=none; b=PAFFwu3iKmW+ApxVeQFrA/6Mr2s5BxnyVx4v+1kj0ulkpA1m84OIOjkO9cUyYDHB96WRyMRF9wMqDhwDtj9auDmOwcyu8Mzq/d4zrUMyWEu55hs2C7iKRDAPpqeUAgtWecpxaRZ9QsqgpOAo81zbxgdWovFL3/zAeDRSJ3uTyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116441; c=relaxed/simple;
	bh=m8ZL37y0DIZeNwZv7PopgpSgmg4+LbNmSlodWcrWwnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RisDWdGaziZmei3RDJxuWiT+fcFN5KCDCeg4tSxOW79joMajWHWaJDOXrA5VMAd2HRsNfUAPxf+K6UMkrKlq4F1HF7PWZTF98n9rVcGid+gcTC2ExRz+VkNd8Drybr5485tL3LsYcE8I1wUYumZfHJJuw0TOlMihLMhwB9SCa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=hRcoc9nF; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a2d21427dso12782276d6.3
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766116437; x=1766721237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wO8ZD48aUCpKc6SiZGez/drh8VR8QFTGkKklbJiyBj4=;
        b=hRcoc9nFPOMC3LyqBhmfLePHPgwIfEFE6LDuTV6c8SaYCeA9fxWJU2D0chayz6E2Jr
         go7WV4AHkTRsWNI5EvselxNeNn49xvUd8yggep+nw0ve5Umr9/WV/UR/WCOiG0tHK4j5
         d5pe0+Cer/ajFdsvvP0NXqeDCiD3h264g2kd51H2adthv9kJng8LkQVIPcZCB49sXNDf
         S92K2SqeAkX+IfG9eIrLmWdXJYfXrEMhnDs3CYDgKlRZqA3wTJB0F0zypmQSSzE7s8VU
         2b0ht4hKVAjjF960/vlv2mjIQyJCugZO4sC2XwF7NpnKmVtzg1FNTFpY4j4par5iXln6
         pmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766116437; x=1766721237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO8ZD48aUCpKc6SiZGez/drh8VR8QFTGkKklbJiyBj4=;
        b=LYf9CuCXB20H9Y0eXui47GeA9JNKRkewPTumI5L4qdCPqWvFBuDE6QZhAYr9GBSthZ
         xgpT5vsvUb7WDZy72nSYtJPll2UHLzAXrOB6HsyPeNKdCekN0gdcnf1rQR2KacJUYNDN
         syLjAEw8dwHo6JjsUq8WbFDH3s7VhcVF+Ke0IeTI9nxnAq1SRHV5w2StSoohPcTVtf2k
         bDKQKmpBA1PJAiO7KtHacTj8lDVMCerELzb9YmFK0L4rNwfw/hEP+m+Xcwd3SKtyWhQF
         quCwOEY0NQBbrOFnIpIm38PMP3PTupLLlKAFxMAt72t0zSQ38kFQKnv1LhOIBXClxB9x
         Deog==
X-Forwarded-Encrypted: i=1; AJvYcCUTpccTCpbmKnUB69qMNFdXSngYZAs6JNoKwgjtGIG9Ny2OFsay7HvxfNONZ4eJ750/pvASmVRG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Lr0D3DGhD1o0905OFJntdUPNHbjLc5iLQcL0gZz6T4dk7jGX
	oTqISWyZRiJiYdTg/5mtjYdPZKMgXjnUIpWHQ58FFiejVcCjUDogqBoON8VFOjmg7ks=
X-Gm-Gg: AY/fxX4EU+zIa7Q7jVIySE9GnDLZRuadOYUFTwogZjb5kNieo3gEzjnX39j2rLyKwUy
	JcmMwLWye5VLJsEUy6XYsSkKVQ8j/JQZY4XEsGD+454ow3X5MzLx1H6Kgj1KmTOGCtsq+fXrD4G
	kNnCVSqc5YjntBppiM/EHZEb07WjMz4IJqKMy1fQP24GuR4seds5rbcTGCAnT/rfgnmfl7X+ysc
	8K/CiKINzk24vErX9NOS8bplJ7vdRuGr4WBmnD5iMdFf0tDlFyMoYhTzIwTXMqge8Hs982HaDzc
	3Wmh380uR52j2Hy6jtqV/FjFIXUCG6c7iFQjH5DIY4m6C3Q9GCodcwbKXou9K3QfdAh5dfCzLHd
	orEFGGII/JbrUw+yw7DryjWyhJtDb7ErIHREHsO//yKHJMxIWLJVxZR3frlEFsInlY+FfZJeUdO
	Zlp9OxZME+cQ==
X-Google-Smtp-Source: AGHT+IGuYY97o/y/ARn4XW14juzlOImdtCYWCwBKScTq7uY6qi729cqFufMxSnRLQQHTYA8ofovkJA==
X-Received: by 2002:a0c:f40f:0:b0:87f:b2d8:6020 with SMTP id 6a1803df08f44-88d86290cffmr27126906d6.38.1766116437011;
        Thu, 18 Dec 2025 19:53:57 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623ffd2sm10768806d6.9.2025.12.18.19.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:53:56 -0800 (PST)
Date: Thu, 18 Dec 2025 22:53:52 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 08/28] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <aUTMUKEkGu7cEgb2@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMkYlK1KhtD5ky6@cmpxchg.org>
 <ot5kji77yk6sqsjhe3fm4hufryovs7in4bivwu6xplqc4btar3@ngl5r7clogkr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ot5kji77yk6sqsjhe3fm4hufryovs7in4bivwu6xplqc4btar3@ngl5r7clogkr>

On Thu, Dec 18, 2025 at 06:09:50PM -0800, Shakeel Butt wrote:
> On Wed, Dec 17, 2025 at 04:45:06PM -0500, Johannes Weiner wrote:
> > On Wed, Dec 17, 2025 at 03:27:32PM +0800, Qi Zheng wrote:
> > > From: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > In the near future, a folio will no longer pin its corresponding
> > > memory cgroup. To ensure safety, it will only be appropriate to
> > > hold the rcu read lock or acquire a reference to the memory cgroup
> > > returned by folio_memcg(), thereby preventing it from being released.
> > > 
> > > In the current patch, the rcu read lock is employed to safeguard
> > > against the release of the memory cgroup in get_mem_cgroup_from_folio().
> > > 
> > > This serves as a preparatory measure for the reparenting of the
> > > LRU pages.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  mm/memcontrol.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 21b5aad34cae7..431b3154c70c5 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
> > >   */
> > >  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
> > >  {
> > > -	struct mem_cgroup *memcg = folio_memcg(folio);
> > > +	struct mem_cgroup *memcg;
> > >  
> > >  	if (mem_cgroup_disabled())
> > >  		return NULL;
> > >  
> > > +	if (!folio_memcg_charged(folio))
> > > +		return root_mem_cgroup;
> > > +
> > >  	rcu_read_lock();
> > > -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> > > -		memcg = root_mem_cgroup;
> > > +retry:
> > > +	memcg = folio_memcg(folio);
> > > +	if (unlikely(!css_tryget(&memcg->css)))
> > > +		goto retry;
> > 
> > So starting in patch 27, the tryget can fail if the memcg is offlined,
> 
> offlined or on its way to free? It is css_tryget() without online.

Sorry, I did mean freeing.

But in the new scheme, they will happen much closer together than
before, since charges don't hold a reference to the css anymore.

So when css_killed_work_fn() does

		offline_css(css);
		css_put(css);

on rmdir, that's now the css_put() we expect to drop the refcount to 0
even with folios in circulation.

The race is then:

	get_mem_cgroup_from_folio()	cgroup_rmdir()
	  memcg = folio_memcg(folio);
            folio->objcg->memcg
					  offline_css()
                                            reparent_objcgs()
					      objcg->memcg = objcg->memcg->parent
					  css_put() -> 0
	  !css_tryget(&memcg->css)

and the retry ensures we'll look up objcg->memcg again and find the
live parent and new owner of the folio.

