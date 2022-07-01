Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72256293A
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 04:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiGACms (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiGACmq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 22:42:46 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24564D40;
        Thu, 30 Jun 2022 19:42:45 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656643363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMVELDaA6mcFkDFllRvcL5kIjjxBxBLDIIVIdn97dz4=;
        b=ScqzngmdlUq8J5Kb06lReoG/MwkkI6G9TVrCHdbC9i++IBDL2+fN7P+gZPFs/0Aa3bwAEV
        9JXjkrAUBwXK9420gleAL8BwrOwUBFv/kCkXYGmdNCcrCntT4HZ4jvss0snDNRQiPEl8Nt
        sPZblsUlzi7M3IVALotR9AO/mF5Db1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Tejun Heo <tj@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Message-ID: <Yr5fHHeB9WXnIMC+@castle>
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
 <YrpO9CUDt8hpUprr@castle>
 <17916824-ba97-68ba-8166-9402d5f4440c@openvz.org>
 <20220628091648.GA12249@blackbody.suse.cz>
 <YrrIWe/nn5hoVyu9@mtj.duckdns.org>
 <525a3eea-8431-64ad-e464-5503f3297722@openvz.org>
 <YrynRcW4/B2nl/kK@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrynRcW4/B2nl/kK@mtj.duckdns.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 30, 2022 at 04:25:57AM +0900, Tejun Heo wrote:
> On Wed, Jun 29, 2022 at 09:13:02AM +0300, Vasily Averin wrote:
> > I experimented on fedora36 node with LXC and centos stream 9 container.
> > and I did not noticed any critical systemd troubles with original -EAGAIN.
> > When cgroup's limit is reached systemd cannot start new services, 
> > for example lxc-attach generates following output:
> > 
> > [root@fc34-vvs ~]# lxc-attach c9s
> > lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 Resource temporarily unavailable - Failed to create leaf cgroup ".lxc"
> > lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 Resource temporarily unavailable - Failed to attach to cgroup fd 11
> > lxc-attach: c9s: attach.c: lxc_attach: 1679 Resource temporarily unavailable - Failed to attach cgroup
> > lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
> > lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container
> > 
> > I did not found any loop in userspace caused by EAGAIN.
> > Messages looks unclear, however situation with the patched kernel is not much better:
> > 
> > [root@fc34-vvs ~]# lxc-attach c9s
> > lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 No space left on device - Failed to create leaf cgroup ".lxc"
> > lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 No space left on device - Failed to attach to cgroup fd 11
> > lxc-attach: c9s: attach.c: lxc_attach: 1679 No space left on device - Failed to attach cgroup
> > lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
> > lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container
> 
> I'd say "resource temporarily unavailable" is better fitting than "no
> space left on device"

+1

Thanks!
