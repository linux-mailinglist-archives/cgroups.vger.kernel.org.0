Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE978E0DD5
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 23:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfJVVmx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 17:42:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33872 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfJVVmx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 17:42:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so9382264qto.1
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UkVKcIoIjwq/4A0nvuIrRwIJe7BfuWm5uRD47GZUEfM=;
        b=RH2e1j+TaBj5hLQezyCMTCJMMgTJv8iyXFP6oi7yBda7boYLxE/75IqlCvdSqkfjKo
         UI0vJQI+QQgcRd86+pdAoij4fnL4PuIwY/xMdr7ya84mJKI0lQl+3HHjmDEiOVGMS4UY
         FGtgYoOm+eWSvAhmhs/crmTiyzht0NFTlsEAjD5ZNL99YfRZhBz50+Lqf9f80deynnWG
         Wx1Su905GSpJZxfD/2akXjNl4UKi9cWGl9eZccJhfeO16I/VQoWCRLH7nqV1MWwqgVVr
         l/LP3JAJr5reGl4bakvVttU+XEWyxTVQtiUne915oAXSj34XHfRjYFmxaI2K1135QTii
         ZlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkVKcIoIjwq/4A0nvuIrRwIJe7BfuWm5uRD47GZUEfM=;
        b=Ene9qM5Erq3yTgGGuzS0un3QMhreM45cwljSVvi+VGfL6HwSKVgeMBoI0H9t+WzKqK
         5dBVv5j5BZ5fwasmUtZ/9kQ54/HQzEGqOhOvdOjfyZqpC+xauX/qcStvo9TDQHbhb5Bj
         IbHE0IL+8EnyHnezmtqKhMaVHPybgqWzYA70IPGTHNcjB5/EsC3jrmWKoGl2vLBHP+Hc
         nuc+Ikpk8fZB/QxyHgCSrvPyRfQU8BupVDDDrVkEt2zARX+LjhGJHZHkvUeGs7M4B2RT
         3mGifk3MFOIN+9Kf3IYgZyUA8g/cziExSCRF5BZ+T3MUi1HIwb2TYYnDoVndESee+M1E
         QyOg==
X-Gm-Message-State: APjAAAWhr+0WE0IBaME+N2TuKU2F2MbDlAhKUchRD1ZNPrZjSd/Yd4Xc
        1/3mMvcgSnIU7xEJAUUsnEeguQ==
X-Google-Smtp-Source: APXvYqxB7Z1O/1QPWUmZvZR2n/xFeF+vKMTbbtldyTA1/Ksng4TKY3QDjSFoUj8HOcKtIUvzxGt84A==
X-Received: by 2002:a0c:f952:: with SMTP id i18mr5363328qvo.131.1571780570446;
        Tue, 22 Oct 2019 14:42:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id n4sm10492844qkc.61.2019.10.22.14.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 14:42:49 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:42:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Message-ID: <20191022214249.GB361040@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
 <20191022195629.GA24142@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022195629.GA24142@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 07:56:33PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:48:00AM -0400, Johannes Weiner wrote:
> > -			/* Record the group's reclaim efficiency */
> > -			vmpressure(sc->gfp_mask, memcg, false,
> > -				   sc->nr_scanned - scanned,
> > -				   sc->nr_reclaimed - reclaimed);
> > -
> > -		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> > +		reclaimed = sc->nr_reclaimed;
> > +		scanned = sc->nr_scanned;
> > +		shrink_node_memcg(pgdat, memcg, sc);
> >  
> > -		if (reclaim_state) {
> > -			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> > -			reclaim_state->reclaimed_slab = 0;
> > -		}
> > +		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> > +			    sc->priority);
> >  
> > -		/* Record the subtree's reclaim efficiency */
> > -		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > -			   sc->nr_scanned - nr_scanned,
> > -			   sc->nr_reclaimed - nr_reclaimed);
> > +		/* Record the group's reclaim efficiency */
> > +		vmpressure(sc->gfp_mask, memcg, false,
> > +			   sc->nr_scanned - scanned,
> > +			   sc->nr_reclaimed - reclaimed);
> 
> It doesn't look as a trivial change. I'd add some comments to the commit message
> why it's safe to do.

It's an equivalent change - it's just really misleading because the
+++ lines are not the counter-part of the --- lines here!

There are two vmpressure calls in this function: one against the
individual cgroups, and one against the tree. The diff puts them
adjacent here, but the counter-part for the --- lines is here:

> > +	/* Record the subtree's reclaim efficiency */
> > +	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > +		   sc->nr_scanned - nr_scanned,
> > +		   sc->nr_reclaimed - nr_reclaimed);

And the counter-part to the +++ lines is further up (beginning of the
quoted diff).
