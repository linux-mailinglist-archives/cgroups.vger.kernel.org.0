Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6152AF22
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiERAYt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 20:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiERAYs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 20:24:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D127143;
        Tue, 17 May 2022 17:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C1BB81D9D;
        Wed, 18 May 2022 00:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E5DC385B8;
        Wed, 18 May 2022 00:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652833484;
        bh=IqdtSbJNm+VCuGfNAw8HzsuQPLkmpT4BhAuMLtG+vDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vhDZhQ93mCmb4YxS1mh5DEHHIcUSZbxx4FRPaLVghQFUuACIEem5vS0qa46A1JKZi
         a14rGVLnWHkOEKmkq1nnAYQENCzmQKAD9lqyHEfMWXg14bN0oFYkUAJ9VmLHZsK/zL
         mNWuy+13jtxf2UCabEYHHbwSU7jhlcDty3FRiM1w=
Date:   Tue, 17 May 2022 17:24:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        void@manifault.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, shakeelb@google.com,
        tj@kernel.org, Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 4/4] selftests: memcg: Remove protection from top level
 memcg
Message-Id: <20220517172443.3e524a8319c693ab24c5f22e@linux-foundation.org>
In-Reply-To: <Yn6qrHHS935ppX98@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
        <20220513171811.730-1-mkoutny@suse.com>
        <20220513171811.730-5-mkoutny@suse.com>
        <Yn6qrHHS935ppX98@carbon>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 13 May 2022 11:59:56 -0700 Roman Gushchin <roman.gushchin@linux.dev=
> wrote:

> On Fri, May 13, 2022 at 07:18:11PM +0200, Michal Koutny wrote:
> > The reclaim is triggered by memory limit in a subtree, therefore the
> > testcase does not need configured protection against external reclaim.
> >=20
> > Also, correct/deduplicate respective comments
> >=20
> > Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
> > ---
> >  tools/testing/selftests/cgroup/test_memcontrol.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/t=
esting/selftests/cgroup/test_memcontrol.c
> > index 9ffacf024bbd..9d370aafd799 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
> > =20
> >  /*
> >   * First, this test creates the following hierarchy:
> > - * A       memory.min =3D 50M,  memory.max =3D 200M
> > + * A       memory.min =3D 0,    memory.max =3D 200M
> >   * A/B     memory.min =3D 50M,  memory.current =3D 50M
> >   * A/B/C   memory.min =3D 75M,  memory.current =3D 50M
> >   * A/B/D   memory.min =3D 25M,  memory.current =3D 50M
> > @@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
> >   * Usages are pagecache, but the test keeps a running
> >   * process in every leaf cgroup.
> >   * Then it creates A/G and creates a significant
> > - * memory pressure in it.
> > + * memory pressure in A.
> >   *
> >   * A/B    memory.current ~=3D 50M
> >   * A/B/C  memory.current ~=3D 29M
> > @@ -335,8 +335,6 @@ static int test_memcg_min(const char *root)
> >  			      (void *)(long)fd);
> >  	}
> > =20
> > -	if (cg_write(parent[0], "memory.min", "50M"))
> > -		goto cleanup;
> >  	if (cg_write(parent[1], "memory.min", "50M"))
> >  		goto cleanup;
> >  	if (cg_write(children[0], "memory.min", "75M"))
> > @@ -404,8 +402,8 @@ static int test_memcg_min(const char *root)
> > =20
> >  /*
> >   * First, this test creates the following hierarchy:
> > - * A       memory.low =3D 50M,  memory.max =3D 200M
> > - * A/B     memory.low =3D 50M,  memory.current =3D 50M
> > + * A       memory.low =3D 0,    memory.max =3D 200M
> > + * A/B     memory.low =3D 50M,  memory.current =3D ...
>=20
> Can you, please, just remove "memory.current =3D ...", it's not
> because obvious what "..." means here.
>=20

You mean this?

--- a/tools/testing/selftests/cgroup/test_memcontrol.c~selftests-memcg-remo=
ve-protection-from-top-level-memcg-fix
+++ a/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -403,15 +403,14 @@ cleanup:
 /*
  * First, this test creates the following hierarchy:
  * A       memory.low =3D 0,    memory.max =3D 200M
- * A/B     memory.low =3D 50M,  memory.current =3D ...
+ * A/B     memory.low =3D 50M
  * A/B/C   memory.low =3D 75M,  memory.current =3D 50M
  * A/B/D   memory.low =3D 25M,  memory.current =3D 50M
  * A/B/E   memory.low =3D 0,    memory.current =3D 50M
  * A/B/F   memory.low =3D 500M, memory.current =3D 0
  *
  * Usages are pagecache.
- * Then it creates A/G an creates a significant
- * memory pressure in it.
+ * Then it creates A/G and creates significant memory pressure in it.
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~=3D 50M
_

(includes gratuitous comment cleanup)

I assume your comment in
https://lkml.kernel.org/r/Yn6pBPq+lAXm9NG8@carbon can be addressed in a
later patch.

I'm not sure what to amke of https://lkml.kernel.org/r/Yn6pWPodGPlz+D8G@car=
bon

Do we feel this series needs more work before merging it up?

