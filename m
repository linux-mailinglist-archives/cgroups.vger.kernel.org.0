Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB42C4142
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 14:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKYNhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 08:37:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgKYNhm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 25 Nov 2020 08:37:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606311461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1g24Rgp6aqa6Ka3pxmGa5G0dKc6hKcPeknu8BPGfcI4=;
        b=KRSsdr+NVduHNlWpHMcDky+6b+1SginL8vAJp2N/Syqhw+rPnjhccnUhw2OXVNSc7mt9nj
        GrNUI1h/tfiB0lpQjhRgGBhZZbEQjaAfXwHG7o+Oc9Bkb48GbOmjjD9qK6ix095ZgeYA9F
        IvWKwuwQHAcFIfsj47r3r1NCkeJOghQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47CF4AC23;
        Wed, 25 Nov 2020 13:37:41 +0000 (UTC)
Date:   Wed, 25 Nov 2020 14:37:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Regression from 5.7.17 to 5.9.9 with memory.low cgroup
 constraints
Message-ID: <20201125133740.GE31550@dhcp22.suse.cz>
References: <20201125123956.61d9e16a@hemera>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125123956.61d9e16a@hemera>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,
thanks for the detailed report.

On Wed 25-11-20 12:39:56, Bruno Prémont wrote:
[...]
> Did memory.low meaning change between 5.7 and 5.9?

The latest semantic change in the low limit protection semantic was
introduced in 5.7 (recursive protection) but it requires an explicit
enablinig.

> From behavior it
> feels as if inodes are not accounted to cgroup at all and kernel pushes
> cgroups down to their memory.low by killing file cache if there is not
> enough free memory to hold all promises (and not only when a cgroup
> tries to use up to its promised amount of memory).

Your counters indeed show that the low protection has been breached,
most likely because the reclaim couldn't make any progress. Considering
that this is the case for all/most of your cgroups it suggests that the
memory pressure was global rather than limit imposed. In fact even top
level cgroups got reclaimed below the low limit.

This suggests that this is not likely to be memcg specific. It is
more likely that this is a general memory reclaim regression for your
workload. There were larger changes in that area. Be it lru balancing
based on cost model by Johannes or working set tracking for anonymous
pages by Joonsoo. Maybe even more. Both of them can influence page cache
reclaim but you are suggesting that slab accounted memory is not
reclaimed properly. I am not sure sure there were considerable changes
there. Would it be possible to collect /prov/vmstat as well?

-- 
Michal Hocko
SUSE Labs
