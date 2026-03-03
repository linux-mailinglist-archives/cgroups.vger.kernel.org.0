Return-Path: <cgroups+bounces-14577-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BYzDZJGp2kFgQAAu9opvQ
	(envelope-from <cgroups+bounces-14577-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 21:37:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6871F6E1F
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6542F30F6651
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B472349B0A;
	Tue,  3 Mar 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPoPJmvq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA72351C32
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570184; cv=none; b=lk4GIyBmnZrADs8u9sHDO+KEKKVO1uH426UR54wHGwO516npdiZTlFf7uXg7l/P7g9FD1Yur0HNw+l5n72NaGz+bospEAIvcZtp4gvvt0J7rc5cQCDX2wJH4RcAuj8JcOV7SXZy7Bx+q3er1/vlzFRlv+4T4aORjyl2PX4ndcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570184; c=relaxed/simple;
	bh=0WXiDpchtAH8bVqvBLab1zkx9xLMSEgnhOTNf0nXPyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADzIJaaaxTmwI1tppUEOU/VIrtHAsYGSd9TVDUS0pwSKOKriu24SIMet96rLf6ZjAq0GUTbzQy8s+6dJaBKoV5KvFaZcdaLoZERdS/kCPhuthL41WTpeMG8lf3aewNuI137lQO4dEQ/7+po6/i6wiR3U50TGBDeHUY6n1fu2rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPoPJmvq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1020890485a.2
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772570182; x=1773174982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSMo5+Ht+OJv6fxlprT7RhyGGgmGe3zydeGluTTF1Sk=;
        b=jPoPJmvq78g+dz55Aepd7ikVipZMlI0Osa0jjLmZQsj15+VwqhnnAUONGn6cG5gzTu
         in0FpfpwHh+R+csZOndc80iKq0zo1NTn9NaX+MMzho/4eQVzKPUdvRHWC5jKYBd2CfHS
         BI/fg5l1zHRzVwCUd1R5+taqm1bSHLUM6kmibt4G7VxLG1aEX6nXqIXrK2GRkx7n3d7Z
         xu80v5DghZda3D9hSaRTm7hk6ieiZpshjkd22fpYTazE9xAzYVYtMgSVe+a1WXTLJBnq
         XDzLBpxqyfwuoZkSzS1BU0dcUBNfDcgNi5IoblPgSy6WVFjPxnzwX4CmvtE1qk0xoYAj
         27fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570182; x=1773174982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSMo5+Ht+OJv6fxlprT7RhyGGgmGe3zydeGluTTF1Sk=;
        b=DdXDgBn7onR+G3keu+SLgn01j4CwKEiWEn5b4Wj9x3AMlCKjYIF3yUyt6dt+H/WM0+
         8RyE4OG/Ts6KQPqDxvM0fpUTH01S/8dqvpL+kKQfGV0H9TN8mJ5EviyXgrqIanZK3voY
         7xiNfE5TZdE7GWJj9dk2YByFL3TzrO6urMHY3dJu7alElKaFFS3dmGkZtD6xZ/rLezbR
         OSczMZOJLSUomOW3/u3/mVvtscjLVo6m8tlV8LBr0tdI2LCwvBEJIxrPkJzSXQLOAyEV
         SstmjHkDvn0tI9MpTRI10uvdz1BV+5JZB0hXFLAAqh49qfvEd6YckCQU9tlEicCF8PY/
         qicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5BzfsSoH8KPsGOLz7+rJuJC2IckIjR7alMpyg/IhDphIPxBnVP6A5ItlB3l4JvrvGUrHlwTf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywig155UOGK5wCFE42q2kPYtgpI+LDJBM9+ihSzXGbKz9AZ3Rma
	+w1P+6pRScPpj5aXMYz5gZNzp+ha2L2SyycbempafBUTevKaQ6d+ytA980bVK7NYsN4=
X-Gm-Gg: ATEYQzwNGqIy0Uc1NdV64S8EfcjvZed4V00Ldqi43fBPHS6cFp+d5GuGBKMnDZVSUnS
	lpiRjR0NYggWY+8T7lHtKCXXwCGCM5k+BmeyDWxuLaDizdWMzLGDY+iStnHI77B/DNmFokCbuz0
	H5u76KKuo5zvkH1af8lcjZ44xeRS1NSV8kacx2uKSCBW8jzy+YKxv/5kEgt3aPTg1Ys4NK7J+Py
	IRyD78OlwBL7UiRy6eqyCgebseYsaHR71l8Ln/TFNQ2VLVt4ZYvh1e46f9qXVN38nS7MWj9HSlK
	kSfE3OT6L85UbDiXc9MJIONvGfcDqh9jBUrY/Bhp+DD4x9n/mCUvn65yVxSsJuTiTYqHiWsKhmz
	0m6AJ8FaxIZyr0u7BVeYG6bciVdqA3dDMrFq3qBiz388RItJiZlKW9u8s6LIcZy6UEfl53qQ+AD
	Wf6seDmoXHpJ1Nl+gKw+bbikF+/kgVM+0hYM1DhVyh/o9/fulre5SOAdhSkiknka7V5FvvbJQBF
	tYTGx0uOA==
X-Received: by 2002:a05:620a:4720:b0:8cb:5442:d539 with SMTP id af79cd13be357-8cbc8dc28b1mr2313709285a.2.1772570182058;
        Tue, 03 Mar 2026 12:36:22 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e89bf39bsm79243066d6.18.2026.03.03.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:36:20 -0800 (PST)
Date: Tue, 3 Mar 2026 15:36:17 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aadGQXXpayvFOZpy@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
X-Rspamd-Queue-Id: AC6871F6E1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14577-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim,gourry.net:email]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> On 2026-02-25 at 02:17 +1100, Gregory Price <gourry@gourry.net> wrote...
> > 
> > If your service only allocates movable pages - your ZONE_NORMAL is
> > effectively ZONE_MOVABLE.  
> 
> This is interesting - it sounds like the conclusion of this is ZONE_* is just a
> bad abstraction and should be replaced with something else maybe some like this?
> 
> And FWIW I'm not tied to the ZONE_DEVICE as being a good abstraction, it's just
> what we seem to have today for determing page types. It almost sounds like what
> we want is just a bunch of hooks that can be associated with a range of pages,
> and then you just get rid of ZONE_DEVICE and instead install hooks appropriate
> for each page a driver manages. I have to think more about that though, this
> is just what popped into my head when you start saying ZONE_MOVABLE could also
> disappear :-)
> 
... snip ...
> > 
> > You don't have to squint because it was deliberate :]
> 
> Nice.
> 

I've had some time to chew on this a bit more.

Adding a node-scope `struct dev_pagemap` produces some interesting
(arguably useful / valuable) effects.

The invariant would be clamping the entire node to ZONE_DEVICE
(more on this below).

So if we think about it this way - we could just view this whole thing
as another variant of ZONE_DEVICE - but without needing the memremap
infrastructure (you can use normal hotplug to achieve it).



0. pgdat->private becomes pgdat->dev_pagemap
   N_MEMORY_PRIVATE -> N_MEMORY_DEVICE ?

   As a start, do a direct conversion, and use the existing
   infrastructure.   then expand hooks as needed (and as-is reasonable)

   Some of the `struct dev_pagemap {}` fields become dead at the node
   scope, but this is a plumbing issue.

   There's already an similar split between the dev_pagemap and the ops
   structure, so it might map very cleanly.


1. "Clamping the entire node to ZONE_DEVICE"

   When we do this, the *actual* ZONE becomes completely irrelevant.
   The allocation path is entirely controlled, so you might actually end
   up freeing up the folio flags that track the zone:

   static inline enum zone_type memdesc_zonenum(memdesc_flags_t flags)
   {
        ASSERT_EXCLUSIVE_BITS(flags.f, ZONES_MASK << ZONES_PGSHIFT);
        return (flags.f >> ZONES_PGSHIFT) & ZONES_MASK;
   }

   becomes:

   folio_is_zone_device(folio) {
       return node_is_device_node(folio_nid(folio)) || 
              memdesc_is_zone_device(folio->flags);
   }

   Kind of an interesting.  You still need these flags for traditional
   ZONE_DEVICE, so you can't evict it completely, but you can start to
   see a path here.


2. One dev_pagemap per node or multiple w/ pagemap range searching

   Checking membership is always cheap: 

        node_is_device_node()

   Getting ops can be cheap if 1:1 mappings exists:

       pgdat->device_ops->callback()

   Or may be expensive if range-based matching is required:

      node_device_op(folio, ...) {
         ops = node_ops_lookup(folio); /* pfn-range binary search */
	 ops->callback(folio, ...)
      }

      pgmap already has an embedded range:

      struct dev_pagemap {
        ...
        int nr_range;
        union {
            struct range range;
            DECLARE_FLEX_ARRAY(struct range, ranges);
        };
      };

   Example: Nouveau, registers hundreds of pgmap instances that it
            uses to recover driver contexts for that specific folio.
	    
	    This would not scale well.

	    But most other drivers register between 1-8.  That might.

   That means this might actually be an effective way to evict pgmap
   from struct folio / struct page.  (Not making this a requirement or
   saying it's reasonable, just an interesting observation).


3. Some existing drivers with 1 pgmap per driver instance instantly get
   the folio->lru field back - even if they continue to use ZONE_DEVICE.

   At least 3 drivers use page->zone_device_data as a page freelist
   rather than actual per-page data.  Those drivers could just start
   using folio/page->lru instead.

   Some store actual per-page zone_device_data that would prevent this,
   but from poking around it seems like it might be feasible.

   Some use the pgmap as a container_of() argument to get driver
   context, may or may not be supportable out of the box, but it seemed
   like mild refactoring might get them back the use of folio->lru.

   None of this is required, the goal is explicitly not disrupting any
   current users of ZONE_DEVICE.


Just some additional food for thought.

As-designed now, this would only apply to NUMA systems, meaning you
can't fully evict pgmap from struct page/folio --- but you could
imagine a world where in non-numa mode we even register a separate
pglist_data specifically for device memory even w/o NUMA.

~Gregory 

