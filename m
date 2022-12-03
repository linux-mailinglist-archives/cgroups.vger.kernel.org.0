Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25896413FB
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 04:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLCDXN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 22:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiLCDXM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 22:23:12 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 19:23:10 PST
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938560B64
        for <cgroups@vger.kernel.org>; Fri,  2 Dec 2022 19:23:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670037449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yB//b1EitRmLn+k+QyZlckrtyNyeyMWH9FzHsotPYVg=;
        b=ubL93lHJgSTgz+3zzH+QSRUgMV/lU7i9P2hA234RwUQaM5sly2K9vbBgeWb0vwoGJBxdx/
        glDZK10V70CZbf0v9q9CummWFes9OBw5TNB9xxhy8eM0hCnc5G10YopaPIL8WS7DzpnGzu
        9hsfB3qvJ5n8shNfCGlcwXzjKpvzL18=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221202223533.1785418-1-almasrymina@google.com>
Date:   Sat, 3 Dec 2022 11:17:10 +0800
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, Michal Hocko <mhocko@suse.com>,
        bagasdotme@gmail.com, cgroups@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC963F6F-75C3-4168-97B3-544C36C2600A@linux.dev>
References: <20221202223533.1785418-1-almasrymina@google.com>
To:     Mina Almasry <almasrymina@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Dec 3, 2022, at 06:35, Mina Almasry <almasrymina@google.com> wrote:
>=20
> The nodes=3D arg instructs the kernel to only scan the given nodes for
> proactive reclaim. For example use cases, consider a 2 tier memory =
system:
>=20
> nodes 0,1 -> top tier
> nodes 2,3 -> second tier
>=20
> $ echo "1m nodes=3D0" > memory.reclaim
>=20
> This instructs the kernel to attempt to reclaim 1m memory from node 0.
> Since node 0 is a top tier node, demotion will be attempted first. =
This
> is useful to direct proactive reclaim to specific nodes that are under
> pressure.
>=20
> $ echo "1m nodes=3D2,3" > memory.reclaim
>=20
> This instructs the kernel to attempt to reclaim 1m memory in the =
second tier,
> since this tier of memory has no demotion targets the memory will be
> reclaimed.
>=20
> $ echo "1m nodes=3D0,1" > memory.reclaim
>=20
> Instructs the kernel to reclaim memory from the top tier nodes, which =
can
> be desirable according to the userspace policy if there is pressure on
> the top tiers. Since these nodes have demotion targets, the kernel =
will
> attempt demotion first.
>=20
> Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim""), the proactive reclaim interface memory.reclaim does both
> reclaim and demotion. Reclaim and demotion incur different latency =
costs
> to the jobs in the cgroup. Demoted memory would still be addressable
> by the userspace at a higher latency, but reclaimed memory would need =
to
> incur a pagefault.
>=20
> The 'nodes' arg is useful to allow the userspace to control demotion
> and reclaim independently according to its policy: if the =
memory.reclaim
> is called on a node with demotion targets, it will attempt demotion =
first;
> if it is called on a node without demotion targets, it will only =
attempt
> reclaim.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.=
