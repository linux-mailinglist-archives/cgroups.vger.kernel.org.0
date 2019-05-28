Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C142CE1E
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfE1SAb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 14:00:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35488 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SAb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 14:00:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so5453985lfg.2;
        Tue, 28 May 2019 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzRimgoeRu7R/UsHOkPXtR9NqQokG6oQDoPTeeW4GsA=;
        b=K5mTZO29tbBaLBfmC9xktb9UyEHFJm7cNGH2ho7TmDNYxAatoyUag706Zd7cjqjf28
         KkeBW1GaNsqZpGtuXpPL2jgCnJM5DuHaiEWuudtfGOhqTqHMJOGDCHv8YAGmcWlXiSLK
         tvB79wzMLr5Um6QS7j3cKNsAv1752T6NIpZ/9dqKNuDh+uFqgoopmTVuvev/Ic1UEPV9
         POninSj+/FBXrDQrPHxHzYlplgfdBdt11aQdVLcmU7bI3aGISf73jtSTKnsqq7hOE1Hl
         V+x+dWvcxXzA/c6PZ2CFDN+iGZBodzbs4Zs7PsfeskXJix3j7cStbEXLgSLKM7CJ7KPj
         kKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzRimgoeRu7R/UsHOkPXtR9NqQokG6oQDoPTeeW4GsA=;
        b=h85yshqRCD1LEnsQ0HX2/pgBCBkP1RKjMmh5fipdgyWJItrphhxCJbp4GCOlrKs6Vy
         B4bIXJCnVoN1Q9EGPWKgBVADYVaQjCh+LojtYSoTgnPPlHgzzacPZWOLlt0WAxyP7uRy
         0lDrlScMMsybeXaKDkJGCYd9hHK9AzfRHjXGdBA+eeT6p1rffPtCXX0pJkk3D6X0NMnl
         uI0gJHtHEB5YGE+Z0Mli/6vSW+z3R34npZvB8Uuy3YzEZigoGTOTE2/Se6IHYl6fOU85
         EjsUeF7bKoEQnJUybK8a4YKlEpn9YIsH+tzF1Ir1vWy5hs2PgfjdN/nMKCgn9HrQ500s
         rcnw==
X-Gm-Message-State: APjAAAXyRQ+tb9sLWe9BMyDyqq90xkuJ3J7J9wspxOr5J+EGTlH09dX+
        Ga9zKhNpPaQEAtjaEiJi0FI=
X-Google-Smtp-Source: APXvYqza2BE+UrIAhAKBPOR5jKGph27QtzFQbF50zdcH09u6RqUIDrc1Df0ox4XY650tVc7LO0usqA==
X-Received: by 2002:ac2:5285:: with SMTP id q5mr8975099lfm.146.1559066429696;
        Tue, 28 May 2019 11:00:29 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id e19sm3048133ljj.62.2019.05.28.11.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 11:00:29 -0700 (PDT)
Date:   Tue, 28 May 2019 21:00:26 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 5/7] mm: rework non-root kmem_cache lifecycle
 management
Message-ID: <20190528180026.zb6yaxdeapwx5r3v@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-6-guro@fb.com>
 <20190528170828.zrkvcdsj3d3jzzzo@esperanza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528170828.zrkvcdsj3d3jzzzo@esperanza>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 08:08:28PM +0300, Vladimir Davydov wrote:
> Hello Roman,
> 
> On Tue, May 21, 2019 at 01:07:33PM -0700, Roman Gushchin wrote:
> > This commit makes several important changes in the lifecycle
> > of a non-root kmem_cache, which also affect the lifecycle
> > of a memory cgroup.
> > 
> > Currently each charged slab page has a page->mem_cgroup pointer
> > to the memory cgroup and holds a reference to it.
> > Kmem_caches are held by the memcg and are released with it.
> > It means that none of kmem_caches are released unless at least one
> > reference to the memcg exists, which is not optimal.
> > 
> > So the current scheme can be illustrated as:
> > page->mem_cgroup->kmem_cache.
> > 
> > To implement the slab memory reparenting we need to invert the scheme
> > into: page->kmem_cache->mem_cgroup.
> > 
> > Let's make every page to hold a reference to the kmem_cache (we
> > already have a stable pointer), and make kmem_caches to hold a single
> > reference to the memory cgroup.
> 
> Is there any reason why we can't reference both mem cgroup and kmem
> cache per each charged kmem page? I mean,
> 
>   page->mem_cgroup references mem_cgroup
>   page->kmem_cache references kmem_cache
>   mem_cgroup references kmem_cache while it's online
> 
> TBO it seems to me that not taking a reference to mem cgroup per charged
> kmem page makes the code look less straightforward, e.g. as you
> mentioned in the commit log, we have to use mod_lruvec_state() for memcg
> pages and mod_lruvec_page_state() for root pages.

I think I completely missed the point here. In the following patch you
move kmem caches from a child to the parent cgroup on offline (aka
reparent them). That's why you can't maintain page->mem_cgroup. Sorry
for misunderstanding.
