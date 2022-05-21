Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502152F728
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 02:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiEUAzx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 20:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiEUAzw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 20:55:52 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD664EB;
        Fri, 20 May 2022 17:55:48 -0700 (PDT)
Date:   Fri, 20 May 2022 17:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653094547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1Ic3mvDcYYQoaAM4Rtpe+PbHlC8Anf6qFpf3CmzxYQ=;
        b=Jjxd1bc+QrIggNSu2l7tf8IPCa1bRlt3WS5aeT268REna6NQ17GRbKKQPSyDhaVU5KuBra
        TcOl+XDU3h6qALxunUSdmvjO3JqONsYr0wgZotdDpYjyoB3jKE9sAAx62c5K+PT/Tn3lA6
        rbtlUnfktOIkoI+kh59UVVpEItAQx0I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
Message-ID: <Yog4jCygrYPtPXg5@carbon>
References: <Ynv7+VG+T2y9rpdk@carbon>
 <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
 <20220519165325.GA2434@blackbody.suse.cz>
 <740dfcb1-5c5f-6a40-0f71-65f277f976d6@openvz.org>
 <d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 20, 2022 at 11:16:32PM +0300, Vasily Averin wrote:
> On 5/20/22 10:24, Vasily Averin wrote:
> > On 5/19/22 19:53, Michal Koutný wrote:
> >> On Fri, May 13, 2022 at 06:52:12PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> >>> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
> >>> largest memory allocation in this scenario and is epecially important
> >>> for small VMs with 1-2 CPUs.
> >>
> >> What do you mean by this argument?
> >>
> >> (On bigger irons, the percpu components becomes dominant, e.g. struct
> >> cgroup_rstat_cpu.)
> > 
> > Michal, Shakeel,
> > thank you very much for your feedback, it helps me understand how to improve
> > the methodology of my accounting analyze.
> > I considered the general case and looked for places of maximum memory allocations.
> > Now I think it would be better to split all called allocations into:
> > - common part, called for any cgroup type (i.e. cgroup_mkdir and cgroup_create),
> > - per-cgroup parts,
> > and focus on 2 corner cases: for single CPU VMs and for "big irons".
> > It helps to clarify which allocations are accounting-important and which ones
> > can be safely ignored.
> > 
> > So right now I'm going to redo the calculations and hope it doesn't take long.
> 
> common part: 	~11Kb	+  318 bytes percpu
> memcg: 		~17Kb	+ 4692 bytes percpu
> cpu:		~2.5Kb	+ 1036 bytes percpu
> cpuset:		~3Kb	+   12 bytes percpu
> blkcg:		~3Kb	+   12 bytes percpu
> pid:		~1.5Kb	+   12 bytes percpu		
> perf:		 ~320b	+   60 bytes percpu
> -------------------------------------------
> total:		~38Kb	+ 6142 bytes percpu
> currently accounted:	  4668 bytes percpu
> 
> Results:
> a) I'll add accounting for cgroup_rstat_cpu and psi_group_cpu,
> they are called in common part and consumes 288 bytes percpu.
> b) It makes sense to add accounting for simple_xattr(), as Michal recommend,
>  especially because it can grow over 4kb
> c) it looks like the rest of the allocations can be ignored
> 
> Details are below
> ('=' -- already accounted, '+' -- to be accounted, '~' -- see KERNFS, '?' -- perhaps later )
> 
> common part:
> 16  ~   352     5632    5632    KERNFS (*)
> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
> 1       192     192     10504   (__d_alloc+0x29)
> 2       72      144     10648   (avc_alloc_node+0x27)
> 2       64      128     10776   (percpu_ref_init+0x6a)
> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
> 
> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
> 2       12      24      312     call_site=percpu_ref_init+0x23
> 1       6       6       318     call_site=__percpu_counter_init+0x22

I'm curios, how do you generate these data?
Just an idea: it could be a nice tool, placed somewhere in tools/cgroup/...

Thanks!
