Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FBC262EB9
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIMhl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 08:37:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgIIMhc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 9 Sep 2020 08:37:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C6D4B732;
        Wed,  9 Sep 2020 11:40:59 +0000 (UTC)
Date:   Wed, 9 Sep 2020 13:40:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200909114057.GH7348@dhcp22.suse.cz>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
 <20200826011946.spknwjt44d2szrdo@ca-dmjordan1.us.oracle.com>
 <01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com>
 <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
 <20200909024432.GA9736@desktop-ziqianlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909024432.GA9736@desktop-ziqianlu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-09-20 10:44:32, Aaron Lu wrote:
> On Thu, Aug 27, 2020 at 09:40:22PM -0400, Daniel Jordan wrote:
> > I went back to your v1 post to see what motivated you originally, and you had
> > some results from aim9 but nothing about where this reared its head in the
> > first place.  How did you discover the bottleneck?  I'm just curious about how
> > lru_lock hurts in practice.
> 
> I think making lru_lock per-memcg helps in colocated environment: some
> workloads are of high priority while some workloads are of low priority.
> 
> For these low priority workloads, we may even want to use some swap for
> it to save memory and this can cause frequent alloc/reclaim, depending
> on its workingset etc. and these alloc/reclaim need to hold the global
> lru lock and zone lock. And then when the high priority workloads do
> page fault, their performance can be adversely affected and that is not
> acceptible since these high priority workloads normally have strict SLA
> requirement.

While this all sounds reasonably. We are lacking _any_ numbers to
actually make that a solid argumentation rather than hand waving.
Having something solid is absolutely necessary for a big change like
this.

-- 
Michal Hocko
SUSE Labs
