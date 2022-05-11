Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA836523C3B
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbiEKSKM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEKSKJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 14:10:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD25E44C3;
        Wed, 11 May 2022 11:10:08 -0700 (PDT)
Date:   Wed, 11 May 2022 11:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652292606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SgiEqe1W62i2WZKOS/4pyIuMIMG49SfWBj1MxBbC8vw=;
        b=umNqkvHUDbWe7akLjEuSDT3lOZjXZR08i0ks+6RB50MqFB/7NqnfYPgVUGtdjALN+NZVSp
        xJfFD1s1kIVcZlRlL3x97QTgCtnNcYkL9bGOs/jFGALgEX2RNRly6lJBmiy1yS06emoKJB
        Nc7S8sko/nGpYiNszr2ILHKikNJKDY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>, Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: kernfs memcg accounting
Message-ID: <Ynv7+VG+T2y9rpdk@carbon>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <YnsoMEuWjlpDcmt3@carbon>
 <20220511163439.GD24172@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511163439.GD24172@blackbody.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 06:34:39PM +0200, Michal Koutny wrote:
> On Tue, May 10, 2022 at 08:06:24PM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > My primary goal was to apply the memory pressure on memory cgroups with a lot
> > of (dying) children cgroups. On a multi-cpu machine a memory cgroup structure
> > is way larger than a page, so a cgroup which looks small can be really large
> > if we calculate the amount of memory taken by all children memcg internals.
> > 
> > Applying this pressure to another cgroup (e.g. the one which contains systemd)
> > doesn't help to reclaim any pages which are pinning the dying cgroups.
> 
> Just a note -- this another usecase of cgroups created from within the
> subtree (e.g. a container). I agree that cgroup-manager/systemd case is
> also valid (as dying memcgs may accumulate after a restart).
> 
> memcgs with their retained state with footprint are special.
> 
> > For other controllers (maybe blkcg aside, idk) it shouldn't matter, because
> > there is no such problem there.
> > 
> > For consistency reasons I'd suggest to charge all *large* allocations
> > (e.g. percpu) to the parent cgroup. Small allocations can be ignored.
> 
> Strictly speaking, this would mean that any controller would have on
> implicit dependency on the memory controller (such as io controller
> has).
> In the extreme case even controller-less hierarchy would have such a
> requirement (for precise kernfs_node accounting).
> Such a dependency is not enforceable on v1 (with various topologies of
> different hierarchies).
>
> Although, I initially favored the consistency with memory controller too,
> I think it's simpler to charge to the creator's memcg to achieve
> consistency across v1 and v2 :-)

Ok, v1/v2 consistency is a valid point.

As I said, I'm fine with both options, it shouldn't matter that much
for anything except the memory controller: cgroup internal objects are not
that large and the total memory footprint is usually small unless we have
a lot of (dying) sub-cgroups. From my experience no other controllers
should be affected (blkcg was affected due to a cgwb reference, but should
be fine now), so it's not an issue at all.

Thanks!
