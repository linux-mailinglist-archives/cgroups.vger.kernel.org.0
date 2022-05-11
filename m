Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B4523BD1
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiEKRqj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbiEKRqi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 13:46:38 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75002562D7;
        Wed, 11 May 2022 10:46:36 -0700 (PDT)
Date:   Wed, 11 May 2022 10:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652291193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfWGrbEx+vpiAW4jPjAHNsymhcB5Wmgm7lJq6cPjfWI=;
        b=QJjafJfGauPBP/5L2wwQLmpNtuIGoDF0XoCTvtG+jnRqfVh+L7ppHELpeA0opCEedbR8A2
        MBljG3u+kNSWoAG8csp8dUGVw1o7TSx60r3wAtoD6uckkI7SYXQ6uAzLsj3tno8SbQowFO
        d4km3j9lFi/Sp6R4KKozhOUhSozCv1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: kernfs memcg accounting
Message-ID: <Ynv2b6aN5zMnJuLA@carbon>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <YnsoMEuWjlpDcmt3@carbon>
 <0eec6575-548e-23e0-0d99-4e079a33d338@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eec6575-548e-23e0-0d99-4e079a33d338@openvz.org>
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

On Wed, May 11, 2022 at 09:01:40AM +0300, Vasily Averin wrote:
> On 5/11/22 06:06, Roman Gushchin wrote:
> > On Wed, May 04, 2022 at 12:00:18PM +0300, Vasily Averin wrote:
> >> From my point of view it is most important to account allocated memory
> >> to any cgroup inside container. Select of proper memcg is a secondary goal here.
> >> Frankly speaking I do not see a big difference between memcg of current process,
> >> memcg of newly created child and memcg of its parent.
> >>
> >> As far as I understand, Roman chose the parent memcg because it was a special
> >> case of creating a new memory group. He temporally changed active memcg
> >> in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
> >> allocations.
> > 
> > My primary goal was to apply the memory pressure on memory cgroups with a lot
> > of (dying) children cgroups. On a multi-cpu machine a memory cgroup structure
> > is way larger than a page, so a cgroup which looks small can be really large
> > if we calculate the amount of memory taken by all children memcg internals.
> > 
> > Applying this pressure to another cgroup (e.g. the one which contains systemd)
> > doesn't help to reclaim any pages which are pinning the dying cgroups.
> > 
> > For other controllers (maybe blkcg aside, idk) it shouldn't matter, because
> > there is no such problem there.
> > 
> > For consistency reasons I'd suggest to charge all *large* allocations
> > (e.g. percpu) to the parent cgroup. Small allocations can be ignored.
> 
> I showed in [1] other large allocation:
> "
> number	bytes	$1*$2	sum	note	call_site
> of	alloc
> allocs
> ------------------------------------------------------------
> 1       14448   14448   14448   =       percpu_alloc_percpu:
> 1       8192    8192    22640   ++      (mem_cgroup_css_alloc+0x54)
> 49      128     6272    28912   ++      (__kernfs_new_node+0x4e)
> 49      96      4704    33616   ?       (simple_xattr_alloc+0x2c)
> 49      88      4312    37928   ++      (__kernfs_iattrs+0x56)
> 1       4096    4096    42024   ++      (cgroup_mkdir+0xc7)
> 1       3840    3840    45864   =       percpu_alloc_percpu:
> 4       512     2048    47912   +       (alloc_fair_sched_group+0x166)
> 4       512     2048    49960   +       (alloc_fair_sched_group+0x139)
> 1       2048    2048    52008   ++      (mem_cgroup_css_alloc+0x109)
> "
> [1] https://lore.kernel.org/all/1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org/
> =	already accounted
> ++	to be accounted first
> +	to be accounted a bit later
> 
> There is no problems with objects allocated in mem_cgroup_alloc(),
> they will be accounted to parent's memcg.
> However I do not understand how to handle other large objects?
> 
> We could move set_active_memcg(parent) call from mem_cgroup_css_alloc() 
> to cgroup_apply_control_enable() and handle allocation in all .css_alloc()
> 
> However I need to handle allocations called from cgroup_mkdir() too and
> badly understand how to do it properly.

I don't think there is a better alternative than just having several
set_active_memcg(parent);...set_active_memcg(old); places in the cgroup.c.

Nesting is fine here, so it shouldn't be a big issue.
