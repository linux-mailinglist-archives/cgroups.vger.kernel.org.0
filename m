Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521758AAE8
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2019 01:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHLXAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Aug 2019 19:00:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37808 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLXAq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Aug 2019 19:00:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so17402303pgp.4
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2019 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ksXWqG62EfbmUuHI0nKd4a7rlKac00A3mrtP5kn5Ls=;
        b=clZMOrgpPeiUsSiOQGc7xPtSCJ1+tYlCEalNf0FrCYLJfEA+0uy4k2IMsGT3jc2cFu
         QPuYWIpFCQhxAals/OKuaPNf8mppQVTkf6D4zIbGyKu4gOrWVhA2o9ZKUIPwXfJVrcoG
         avMIYarRQn3GMlD+OUwXFSElhTGkglyd3QZD1GJQSaZP8jC6QiZ2xLFtEuUdnjR3mnni
         sRQtw5csmi7PfDU+Ql+QaQ1NKyhCIKJ3a40cFUmsKMpgHBOzlU8Y+4Tu8Q9zJCvCmZsb
         tOC9AwuoxVLSsc9XXteA5o+ppMTBTFjDr7sDywYo3lo2UATZPZ7kYu0zrGDtAc9pwsi5
         IbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ksXWqG62EfbmUuHI0nKd4a7rlKac00A3mrtP5kn5Ls=;
        b=TAsqvCj2o1mHWD9YxokamDxotFMlnU3JVuzThRvQ6DVNjoZrRx+R5gYW7N5YQsNiwA
         sosruPBlD9FfBMAu+CzxJOhTayD16evz2R+wQr4dPtM+5dXCOyDgjh39MaC+cVIr0aGP
         ax49wBQ2VNG2BuWv0/eIKcThIr5NzpULLVv9OUs0GZ9fUc8OYc3kmh10snqAXcBhsLma
         4jnFTU3/a+ajcGUlYfvIAGvzPgUzN8PzDgq8PT0lrgS6TqLcS8r2HyW15lfVRySIJ+EE
         goB/K2CTekDmeXdLXNIrl8k4qPzaNyaNuaoZTLNnpi2XcfXFxO87XzzS3q3+ckVgUQtC
         Ki6Q==
X-Gm-Message-State: APjAAAW6M0CJiGK9mvyzLmk8hfzo1AmHvYcYLv2ncDJii3C0nw/uqf6z
        NyxLQo6sDy1TgmhEm+7XXzMH8XtzuJs=
X-Google-Smtp-Source: APXvYqyb883Z7rrcgcBtXgV+QnSSy8ZT99o+mRBxe/N1CFP0iCEGlwsPbuGd5lBVkMaokl9X9DPeAA==
X-Received: by 2002:a62:6083:: with SMTP id u125mr37305269pfb.208.1565650845803;
        Mon, 12 Aug 2019 16:00:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id z13sm110232784pfa.94.2019.08.12.16.00.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:00:45 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:00:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Message-ID: <20190812230043.GA18948@cmpxchg.org>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
 <20190812210723.GA9423@tower.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812210723.GA9423@tower.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 12, 2019 at 09:07:27PM +0000, Roman Gushchin wrote:
> On Mon, Aug 12, 2019 at 03:23:16PM -0400, Johannes Weiner wrote:
> > @@ -2679,7 +2675,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  		nr_reclaimed = sc->nr_reclaimed;
> >  		nr_scanned = sc->nr_scanned;
> >  
> > -		memcg = mem_cgroup_iter(root, NULL, &reclaim);
> > +		memcg = mem_cgroup_iter(root, NULL, NULL);
> 
> I wonder if we can remove the shared memcg tree walking at all? It seems that
> the only use case left is the soft limit, and the same logic can be applied
> to it. The we potentially can remove a lot of code in mem_cgroup_iter().
> Just an idea...

It's so tempting! But soft limit reclaim starts at priority 0 right
out of the gate, so overreclaim is an actual concern there. We could
try to rework it, but it'll be hard to avoid regressions given how
awkward the semantics and behavior around the soft limit already are.

> >  		do {
> >  			unsigned long lru_pages;
> >  			unsigned long reclaimed;
> > @@ -2724,21 +2720,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  				   sc->nr_scanned - scanned,
> >  				   sc->nr_reclaimed - reclaimed);
> >  
> > -			/*
> > -			 * Kswapd have to scan all memory cgroups to fulfill
> > -			 * the overall scan target for the node.
> > -			 *
> > -			 * Limit reclaim, on the other hand, only cares about
> > -			 * nr_to_reclaim pages to be reclaimed and it will
> > -			 * retry with decreasing priority if one round over the
> > -			 * whole hierarchy is not sufficient.
> > -			 */
> > -			if (!current_is_kswapd() &&
> > -					sc->nr_reclaimed >= sc->nr_to_reclaim) {
> > -				mem_cgroup_iter_break(root, memcg);
> > -				break;
> > -			}
> > -		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
> > +		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> >  
> >  		if (reclaim_state) {
> >  			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> > -- 
> > 2.22.0
> >
> 
> Otherwise looks good to me!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
