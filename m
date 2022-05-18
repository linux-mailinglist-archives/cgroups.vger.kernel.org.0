Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A352AF67
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiERAwi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 20:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiERAwh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 20:52:37 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5153E23;
        Tue, 17 May 2022 17:52:34 -0700 (PDT)
Date:   Tue, 17 May 2022 17:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652835152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1o3oJN5gQQTieH2g5nQdeNUsC++N3DE8B+0iuF60aw4=;
        b=GewWqVjHhWuzqety2mXdbrWLrO/2oTjNznANQxyCkgxP+e0u82igfbs4pzNk60tmlj1tYB
        BlmTPiX2hXmz4bXqK+HQh8R74tV+IczWEnsR7jCoVrqBTpmbRGGdqnG2cWlqtXsyrIz6Sh
        JMQY/aTeFX58HSFvXL1xAE3A9SQntrI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        void@manifault.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, shakeelb@google.com,
        tj@kernel.org, Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 4/4] selftests: memcg: Remove protection from top level
 memcg
Message-ID: <YoRDSfv6xK/R+n+R@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-5-mkoutny@suse.com>
 <Yn6qrHHS935ppX98@carbon>
 <20220517172443.3e524a8319c693ab24c5f22e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517172443.3e524a8319c693ab24c5f22e@linux-foundation.org>
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

On Tue, May 17, 2022 at 05:24:43PM -0700, Andrew Morton wrote:
> On Fri, 13 May 2022 11:59:56 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > On Fri, May 13, 2022 at 07:18:11PM +0200, Michal Koutny wrote:
> > > The reclaim is triggered by memory limit in a subtree, therefore the
> > > testcase does not need configured protection against external reclaim.
> > > 
> > > Also, correct/deduplicate respective comments
> > > 
> > > Signed-off-by: Michal Koutný <mkoutny@suse.com>
> > > ---
> > >  tools/testing/selftests/cgroup/test_memcontrol.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > index 9ffacf024bbd..9d370aafd799 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
> > >  
> > >  /*
> > >   * First, this test creates the following hierarchy:
> > > - * A       memory.min = 50M,  memory.max = 200M
> > > + * A       memory.min = 0,    memory.max = 200M
> > >   * A/B     memory.min = 50M,  memory.current = 50M
> > >   * A/B/C   memory.min = 75M,  memory.current = 50M
> > >   * A/B/D   memory.min = 25M,  memory.current = 50M
> > > @@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
> > >   * Usages are pagecache, but the test keeps a running
> > >   * process in every leaf cgroup.
> > >   * Then it creates A/G and creates a significant
> > > - * memory pressure in it.
> > > + * memory pressure in A.
> > >   *
> > >   * A/B    memory.current ~= 50M
> > >   * A/B/C  memory.current ~= 29M
> > > @@ -335,8 +335,6 @@ static int test_memcg_min(const char *root)
> > >  			      (void *)(long)fd);
> > >  	}
> > >  
> > > -	if (cg_write(parent[0], "memory.min", "50M"))
> > > -		goto cleanup;
> > >  	if (cg_write(parent[1], "memory.min", "50M"))
> > >  		goto cleanup;
> > >  	if (cg_write(children[0], "memory.min", "75M"))
> > > @@ -404,8 +402,8 @@ static int test_memcg_min(const char *root)
> > >  
> > >  /*
> > >   * First, this test creates the following hierarchy:
> > > - * A       memory.low = 50M,  memory.max = 200M
> > > - * A/B     memory.low = 50M,  memory.current = 50M
> > > + * A       memory.low = 0,    memory.max = 200M
> > > + * A/B     memory.low = 50M,  memory.current = ...
> > 
> > Can you, please, just remove "memory.current = ...", it's not
> > because obvious what "..." means here.
> > 
> 
> You mean this?
> 
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c~selftests-memcg-remove-protection-from-top-level-memcg-fix
> +++ a/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -403,15 +403,14 @@ cleanup:
>  /*
>   * First, this test creates the following hierarchy:
>   * A       memory.low = 0,    memory.max = 200M
> - * A/B     memory.low = 50M,  memory.current = ...
> + * A/B     memory.low = 50M
>   * A/B/C   memory.low = 75M,  memory.current = 50M
>   * A/B/D   memory.low = 25M,  memory.current = 50M
>   * A/B/E   memory.low = 0,    memory.current = 50M
>   * A/B/F   memory.low = 500M, memory.current = 0
>   *
>   * Usages are pagecache.
> - * Then it creates A/G an creates a significant
> - * memory pressure in it.
> + * Then it creates A/G and creates significant memory pressure in it.
>   *
>   * Then it checks actual memory usages and expects that:
>   * A/B    memory.current ~= 50M
> _
> 
> (includes gratuitous comment cleanup)

Yes, thank you!

> 
> I assume your comment in
> https://lkml.kernel.org/r/Yn6pBPq+lAXm9NG8@carbon can be addressed in a
> later patch.
> 
> I'm not sure what to amke of https://lkml.kernel.org/r/Yn6pWPodGPlz+D8G@carbon
> 
> Do we feel this series needs more work before merging it up?
> 

Please, go ahead with it. If anything comes up, it can be addressed later.

Thanks!
