Return-Path: <cgroups+bounces-1067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819EF823A0E
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 02:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F894287EB4
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 01:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9346B3;
	Thu,  4 Jan 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8BOTk86"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B74432
	for <cgroups@vger.kernel.org>; Thu,  4 Jan 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36000a26f8aso45495ab.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jan 2024 17:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704330470; x=1704935270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m+H9c4RKS2/XKxU5xixK4qV5pHJenGZp2+iHHRxZ8I=;
        b=R8BOTk86mUfgzMbzcUmvPBCCI3FOzdXj16BvlPiBHZCbR06gmypwpAa85juK7wdmgE
         Y4QbYdXP7gUQ6Zbr4ismQqYX4uWEnf2W+1oDnihdIgWPmIOWfT+yjfgQD6QcEs54jSKD
         8SedaBQddx6rqtyVDKHegjRuW6q/7NGd/gFmLf9nIlVHvg7g5uI/JE+Z81grJmTLOvqF
         1t+YuP0OY98y9I5re6kgPD85Cesw07kDK0WAwtC+a895N0LCEmPZm3LbXTLRLJqCBlae
         ltpp4NvhVadI8EoJgd9nP8xal/cyudzaBZLcfqM0VJ/V7gAhW7+TGFhy/1FhBAQX6pst
         qhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330470; x=1704935270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m+H9c4RKS2/XKxU5xixK4qV5pHJenGZp2+iHHRxZ8I=;
        b=Qy6R0AmjoogisU4qdjFpYJC/mSv7gNwt7feMOoOe4QCMaKREALF5tG8uC0bKr+xwkn
         GS+XjOMJzLepvRV8iLOfmWuQy4zo+ZsWSE2l0hgOxwBqVcAh6ym7GSoIUaJxXISgcCZS
         rH8GZkwQYFP1+32KNvT6OOqySTDMVm6Py6Vn1Plrw9bejQMhcmjoDDdMzqax6UwRy2Xz
         6Gur+hMvWP4AA3rPEnETftMiH/g0K5wXS4iBd8PvkdMI7GmqVn4qGpz6TJkiqKjtpcOS
         8P5Dvyw2xO1OEfC6SM6/YZp3Qo/pCOumPZMOkB9z8GDYCgRbT/gv6q6xVyIfQBA8s8GI
         0jXw==
X-Gm-Message-State: AOJu0YyiPFtJ2/5rO7G6h6URXiFUI3F0XB3T1skIuFyhyUKUNnGCCcPC
	JgQy+g8LBSf7kxudyqAJXUDJhTdJDsv8
X-Google-Smtp-Source: AGHT+IGRuUGkfMLL656tWkrl3gVsRL5YUSK9Aa3dv2YOfuY5Fqt+InY0LH5LQvbxFNvicz1QowE59g==
X-Received: by 2002:a92:cccf:0:b0:360:495:20e9 with SMTP id u15-20020a92cccf000000b00360049520e9mr302785ilq.8.1704330470029;
        Wed, 03 Jan 2024 17:07:50 -0800 (PST)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id k11-20020a02cccb000000b0046ddbd7b67fsm760485jaq.93.2024.01.03.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:07:49 -0800 (PST)
Date: Wed, 3 Jan 2024 18:07:43 -0700
From: Yu Zhao <yuzhao@google.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZYE36e0BFFzi0X3@google.com>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com>
 <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
 <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>

On Wed, Jan 03, 2024 at 01:19:59PM -0500, Dan Schatzberg wrote:
> On Wed, Jan 03, 2024 at 10:19:40AM -0700, Yu Zhao wrote:
> [...]
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index d91963e2d47f..394e0dd46b2e 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -92,6 +92,11 @@ struct scan_control {
> > >         unsigned long   anon_cost;
> > >         unsigned long   file_cost;
> > >
> > > +#ifdef CONFIG_MEMCG
> > > +       /* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
> > > +       int *proactive_swappiness;
> > > +#endif
> > 
> > Why is proactive_swappiness still a pointer? The whole point of the
> > previous conversation is that sc->proactive can tell whether
> > sc->swappiness is valid or not, and that's less awkward than using a
> > pointer.
> 
> It's the same reason as before - zero initialization ensures that the
> pointer is NULL which tells us if it's valid or not. Proactive reclaim
> might not set swappiness and you need to distinguish swappiness of 0
> and not-set. See this discussion with Michal:
> 
> https://lore.kernel.org/linux-mm/ZZUizpTWOt3gNeqR@tiehlicka/

 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
                              size_t nbytes, loff_t off)
 {
        struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
        unsigned int nr_retries = MAX_RECLAIM_RETRIES;
        unsigned long nr_to_reclaim, nr_reclaimed = 0;
+       int swappiness = -1;
...
                reclaimed = try_to_free_mem_cgroup_pages(memcg,
                                        min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-                                       GFP_KERNEL, reclaim_options);
+                                       GFP_KERNEL, reclaim_options,
+                                       swappiness);

...

+static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
+{
+       return sc->proactive && sc->proactive_swappiness > -1 ?
+              sc->proactive_swappiness : mem_cgroup_swappiness(memcg);
+}

