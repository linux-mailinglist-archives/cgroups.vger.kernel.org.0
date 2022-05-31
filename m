Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD0538BE1
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiEaHQy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiEaHQw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 03:16:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF84477C;
        Tue, 31 May 2022 00:16:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 309B51F8E6;
        Tue, 31 May 2022 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653981410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JRzXAFyBJ83o3cQYXfJAjgf/18XPkXFhsvvS1XfXo8=;
        b=LoroXGjQaGygCf+ii5RaT5Q6MKzPcDtkhbE5h0W3gOfcb/7CQvzVuGFV/fknsIsXESUz2X
        Eq5mSiyZmpaIS0fl79wzRLZ7o2tmFDJCW3MTNZONWSCfx9BQdH2fGTHP02Kcs+dcmpJE/S
        oCqKSXqNAAlLDjO78RW+1p4mEJh29eU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 080FB2C141;
        Tue, 31 May 2022 07:16:48 +0000 (UTC)
Date:   Tue, 31 May 2022 09:16:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v3 0/9] memcg: accounting for objects allocated by
 mkdir cgroup
Message-ID: <YpXA35F33hvrxNLf@dhcp22.suse.cz>
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
 <YpSwvii5etfnOYC9@dhcp22.suse.cz>
 <ef9f7516-853d-ffe4-9a7a-5e87556bdbbe@openvz.org>
 <YpTTL3Ys35kgYyAW@dhcp22.suse.cz>
 <3a1d8554-755f-7976-1e00-a0e7fb62c86e@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1d8554-755f-7976-1e00-a0e7fb62c86e@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 30-05-22 22:58:30, Vasily Averin wrote:
> On 5/30/22 17:22, Michal Hocko wrote:
> > On Mon 30-05-22 16:09:00, Vasily Averin wrote:
> >> On 5/30/22 14:55, Michal Hocko wrote:
> >>> On Mon 30-05-22 14:25:45, Vasily Averin wrote:
> >>>> Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
> >>>> 4cpu VM with Fedora and self-complied upstream kernel. The calculations
> >>>> are not precise, it depends on kernel config options, number of cpus,
> >>>> enabled controllers, ignores possible page allocations etc.
> >>>> However this is enough to clarify the general situation.
> >>>> All allocations are splited into:
> >>>> - common part, always called for each cgroup type
> >>>> - per-cgroup allocations
> >>>>
> >>>> In each group we consider 2 corner cases:
> >>>> - usual allocations, important for 1-2 CPU nodes/Vms
> >>>> - percpu allocations, important for 'big irons'
> >>>>
> >>>> common part: 	~11Kb	+  318 bytes percpu
> >>>> memcg: 		~17Kb	+ 4692 bytes percpu
> >>>> cpu:		~2.5Kb	+ 1036 bytes percpu
> >>>> cpuset:		~3Kb	+   12 bytes percpu
> >>>> blkcg:		~3Kb	+   12 bytes percpu
> >>>> pid:		~1.5Kb	+   12 bytes percpu		
> >>>> perf:		 ~320b	+   60 bytes percpu
> >>>> -------------------------------------------
> >>>> total:		~38Kb	+ 6142 bytes percpu
> >>>> currently accounted:	  4668 bytes percpu
> >>>>
> >>>> - it's important to account usual allocations called
> >>>> in common part, because almost all of cgroup-specific allocations
> >>>> are small. One exception here is memory cgroup, it allocates a few
> >>>> huge objects that should be accounted.
> >>>> - Percpu allocation called in common part, in memcg and cpu cgroups
> >>>> should be accounted, rest ones are small an can be ignored.
> >>>> - KERNFS objects are allocated both in common part and in most of
> >>>> cgroups 
> >>>>
> >>>> Details can be found here:
> >>>> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
> >>>>
> >>>> I checked other cgroups types was found that they all can be ignored.
> >>>> Additionally I found allocation of struct rt_rq called in cpu cgroup 
> >>>> if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
> >>>> percpu structure and should be accounted too.
> >>>
> >>> One thing that the changelog is missing is an explanation why do we need
> >>> to account those objects. Users are usually not empowered to create
> >>> cgroups arbitrarily. Or at least they shouldn't because we can expect
> >>> more problems to happen.
> >>>
> >>> Could you clarify this please?
> >>
> >> The problem is actual for OS-level containers: LXC or OpenVz.
> >> They are widely used for hosting and allow to run containers
> >> by untrusted end-users. Root inside such containers is able
> >> to create groups inside own container and consume host memory
> >> without its proper accounting.
> > 
> > Is the unaccounted memory really the biggest problem here?
> > IIRC having really huge cgroup trees can hurt quite some controllers.
> > E.g. how does the cpu controller deal with too many or too deep
> > hierarchies?
> 
> Could you please describe it in more details?
> Maybe it was passed me by, maybe I messed or forgot something,
> however I cannot remember any other practical cgroup-related issues.
> 
> Maybe deep hierarchies does not work well.
> however, I have not heard that the internal configuration of cgroup
> can affect the upper level too.

My first thought was any controller with a fixed math constrains like
cpu controller. But I have to admit that I haven't really checked
whether imprecision can accumulate and propagate outside of the
hierarchy.

Another concern I would have is a id space depletion. At least memory
controller depends on idr ids which have a space that is rather limited
#define MEM_CGROUP_ID_MAX       USHRT_MAX

Also the runtime overhead would increase with a large number of cgroups.
Take a global memory reclaim as an example. All the cgroups have to be
iterated. This will have an impact outside of the said hierarchy. One
could argue that limiting untrusted top level cgroups would be a certain
mitigation but I can imagine this could get very non trivial easily.

Anyway, let me just be explicit. I am not against these patches. In fact
I cannot really judge their overhead. But right now I am not really sure
they are going to help much against untrusted users.
-- 
Michal Hocko
SUSE Labs
