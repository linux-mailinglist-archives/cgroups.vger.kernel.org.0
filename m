Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97C522A2A
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 05:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiEKDGf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiEKDGe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 23:06:34 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC25542ED5;
        Tue, 10 May 2022 20:06:32 -0700 (PDT)
Date:   Tue, 10 May 2022 20:06:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652238390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9oPpCxajvjGUrmg0f6gckutPEOOPZaEku255Vyx78E=;
        b=ctkko5zKqXKRqBvkI7AzNbCPvjk+mTf48++bYM8Vcq12dt+8H2aFcWCV2RRm0dO0MO8OB8
        Ba3SyHMRE06mHqGuEi54JOaGxRgkuyMtv6h+EXp/ar9SvCbnAIfMlnyYueJ9jdGUKnfPKe
        s3kYwBI2w4ZRgaXnU6KOHUMVmTVg09M=
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
Message-ID: <YnsoMEuWjlpDcmt3@carbon>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 04, 2022 at 12:00:18PM +0300, Vasily Averin wrote:
> On 5/3/22 00:22, Michal Koutný wrote:
> > When struct mem_cgroup charging was introduced, there was a similar
> > discussion [1].
> 
> Thank you, I'm missed this patch, it was very interesting and useful.
> I would note though, that OpenVZ and LXC have another usecase:
> we have separate and independent systemd instances inside OS containers.
> So container's cgroups are created not in host's root memcg but 
> inside accountable container's root memcg.  
> 
> > I can see following aspects here:
> > 1) absolute size of kernfs_objects,
> > 2) practical difference between a) and b),
> > 3) consistency with memcg,
> > 4) v1 vs v2 behavior.
> ...
> > How do these reasonings align with your original intention of net
> > devices accounting? (Are the creators of net devices inside the
> > container?)
> 
> It is possible to create netdevice in one namespace/container 
> and then move them to another one, and this possibility is widely used.
> With my patch memory allocated by these devices will be not accounted
> to new memcg, however I do not think it is a problem.
> My patches protect the host mostly from misuse, when someone creates
> a huge number of nedevices inside a container.
> 
> >> Do you think it is incorrect and new kernfs node should be accounted
> >> to memcg of parent cgroup, as mem_cgroup_css_alloc()-> mem_cgroup_alloc() does?
> > 
> > I don't think either variant is incorrect. I'd very much prefer the
> > consistency with memcg behavior (variant a)) but as I've listed the
> > arguments above, it seems such a consistency can't be easily justified.
> 
> From my point of view it is most important to account allocated memory
> to any cgroup inside container. Select of proper memcg is a secondary goal here.
> Frankly speaking I do not see a big difference between memcg of current process,
> memcg of newly created child and memcg of its parent.
> 
> As far as I understand, Roman chose the parent memcg because it was a special
> case of creating a new memory group. He temporally changed active memcg
> in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
> allocations.

My primary goal was to apply the memory pressure on memory cgroups with a lot
of (dying) children cgroups. On a multi-cpu machine a memory cgroup structure
is way larger than a page, so a cgroup which looks small can be really large
if we calculate the amount of memory taken by all children memcg internals.

Applying this pressure to another cgroup (e.g. the one which contains systemd)
doesn't help to reclaim any pages which are pinning the dying cgroups.

For other controllers (maybe blkcg aside, idk) it shouldn't matter, because
there is no such problem there.

For consistency reasons I'd suggest to charge all *large* allocations
(e.g. percpu) to the parent cgroup. Small allocations can be ignored.

Thanks!
