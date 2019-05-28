Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE02D163
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 00:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1WQS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 18:16:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfE1WQR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 18:16:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so161028pfo.11
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SLwBA8MbvD2QC0ep8E6TWiO4osZD4fu2h/9Z2V53XVU=;
        b=1U+7o4fD7tmYoGz+yUlK3xEC1BolyoWKEYDkAchX/oKTIdCJ03mkyuokQEfbvRSu2J
         aGd9YozwjkbKIRGDOUx6V5TNQV10fBydRP3/Rref/HmapwqQZiV9R4GRFjbMDQgluno+
         0zHhUoORAlPNG66tv0aBbi6J1l5JMOKKBFrNXSeq1LkzuGBuaLOfIVr2A802gf+RC1pL
         +oa0FYRQhTCfhF5qx4XRkKaaxYuVA6TXhvlkdl7eTRQtFWHk8AIvAGmY8XmG0Lr5F0w0
         2GAmIemcB/o8diV8Hr/dq8X+6wB9bHxgvYLAnWqThhUoTxyo31DHn2/FkNsat0MFD2go
         3t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SLwBA8MbvD2QC0ep8E6TWiO4osZD4fu2h/9Z2V53XVU=;
        b=G/mKaJjRKIkiJvrYMV6lEXROelo+7NjB/OvqBKNTblp0UjDvfaRh1ACp9w9Rx2Xvwb
         KGSrpN6OxGYUSFWGbenCDrHEgLn5bUgiroHtGCho2Xq9bNSzwIwcrpsJrQ9ASShAL1k/
         w2PJOB01ZEPCP229gs2LP815xmjqGYLdFfA9sFIx5HaKFblcNwueFHZF/xoj9bdrpxl+
         BAAb+EcZGErABqAujmDQWR8AmyEVsBIXBkfbhyFD4G6Xzu1TFx4OCGMlP0pWAVTZdSfm
         5AS1pVewCDhQBXIxbP7Kaf6PQ4zW8IGOW2F5aDMQ+D+W9tr5XuyNUHbZaiAH5mpOa8Jb
         uu+w==
X-Gm-Message-State: APjAAAU7gbZ2tyL8o4Myxsd9SvTiac9L6o5CuX+TvopjCqc7tCRX+/Tj
        +TvwqhEsgMbzFBRteWVWeAgw0A==
X-Google-Smtp-Source: APXvYqzGLAcNqO9DPhr8ZWvyM2uL60NP5y+iK/RNsjZJ/jpP+ybbd9xpym9mO2p60BjMJe5T0FHE3Q==
X-Received: by 2002:aa7:8e46:: with SMTP id d6mr117346607pfr.91.1559081776764;
        Tue, 28 May 2019 15:16:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:77ab])
        by smtp.gmail.com with ESMTPSA id f30sm3238124pjg.13.2019.05.28.15.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:16:16 -0700 (PDT)
Date:   Tue, 28 May 2019 18:16:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Message-ID: <20190528221614.GD26614@cmpxchg.org>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-7-guro@fb.com>
 <20190528183302.zv75bsxxblc6v4dt@esperanza>
 <20190528195808.GA27847@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528195808.GA27847@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 07:58:17PM +0000, Roman Gushchin wrote:
> On Tue, May 28, 2019 at 09:33:02PM +0300, Vladimir Davydov wrote:
> > On Tue, May 21, 2019 at 01:07:34PM -0700, Roman Gushchin wrote:
> > > Let's reparent memcg slab memory on memcg offlining. This allows us
> > > to release the memory cgroup without waiting for the last outstanding
> > > kernel object (e.g. dentry used by another application).
> > > 
> > > So instead of reparenting all accounted slab pages, let's do reparent
> > > a relatively small amount of kmem_caches. Reparenting is performed as
> > > a part of the deactivation process.
> > > 
> > > Since the parent cgroup is already charged, everything we need to do
> > > is to splice the list of kmem_caches to the parent's kmem_caches list,
> > > swap the memcg pointer and drop the css refcounter for each kmem_cache
> > > and adjust the parent's css refcounter. Quite simple.
> > > 
> > > Please, note that kmem_cache->memcg_params.memcg isn't a stable
> > > pointer anymore. It's safe to read it under rcu_read_lock() or
> > > with slab_mutex held.
> > > 
> > > We can race with the slab allocation and deallocation paths. It's not
> > > a big problem: parent's charge and slab global stats are always
> > > correct, and we don't care anymore about the child usage and global
> > > stats. The child cgroup is already offline, so we don't use or show it
> > > anywhere.
> > > 
> > > Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> > > aren't used anywhere except count_shadow_nodes(). But even there it
> > > won't break anything: after reparenting "nodes" will be 0 on child
> > > level (because we're already reparenting shrinker lists), and on
> > > parent level page stats always were 0, and this patch won't change
> > > anything.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > 
> > This one looks good to me. I can't see why anything could possibly go
> > wrong after this change.
> 
> Hi Vladimir!
> 
> Thank you for looking into the series. Really appreciate it!
> 
> It looks like outstanding questions are:
> 1) synchronization around the dying flag
> 2) removing CONFIG_SLOB in 2/7
> 3) early sysfs_slab_remove()
> 4) mem_cgroup_from_kmem in 7/7
> 
> Please, let me know if I missed anything.
> 
> I'm waiting now for Johanness's review, so I'll address these issues
> in background and post the next (and hopefully) final version.

The todo items here aside, the series looks good to me - although I'm
glad that Vladimir gave it a much more informed review than I could.
