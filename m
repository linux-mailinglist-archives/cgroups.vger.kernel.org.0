Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575067B9F01
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjJEOQu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjJEOPE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:15:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED969EE6;
        Thu,  5 Oct 2023 02:06:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D0D91F892;
        Thu,  5 Oct 2023 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696496791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5mDtqn4ke7EOccXi4sHIRDZaPhR32uiSgJHqJga3Hg=;
        b=Gb7qt86CRw4Q2hcmLffRyrjdC42UtFGR7X8XobT6nxzGeZd1VOa3nm/yNyp5QIqvIBoetq
        WouqBXaum/wzpjeQ7kyDLPtsvqQOVgrVLp6sUQ9Lkg0DaXIx5lOlQKwx2ZjFWmnT74HH46
        qlzfJnMjAXx/r9L0i3c+S+83QdscROA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22851139C2;
        Thu,  5 Oct 2023 09:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bbGdB5d8HmWVcgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Oct 2023 09:06:31 +0000
Date:   Thu, 5 Oct 2023 11:06:29 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
 <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
 <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
 <20231004183619.GB39112@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdqoo3w6fdlwt4bn"
Content-Disposition: inline
In-Reply-To: <20231004183619.GB39112@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--cdqoo3w6fdlwt4bn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:36:19PM -0400, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> Yes, it's because of node resolution which event counters generally
> don't have. Some of the refault events influence node-local reclaim
> decisions, see mm/vmscan.c::snapshot_refaults().
>=20
> There are a few other event counters in the stat array that people
> thought would be useful to have split out in
> /sys/devices/system/node/nodeN/vmstat to understand numa behavior
> better.
>=20
> It's a bit messy.
>=20
> Some events would be useful to move to 'stats' for the numa awareness,
> such as the allocator stats and reclaim activity.
>=20
> Some events would be useful to move to 'stats' for the numa awareness,
> but don't have the zone resolution required by them, such as
> kswapd/kcompactd wakeups.

Thanks for the enlightenment.

> Some events aren't numa specific, such as oom kills, drop_pagecache.

These are oddballs indeed. As with the normalization patchset these are
counted as PAGE_SIZE^W 1 error but they should rather be an infinite
error (to warrant a flush).

So my feedback to this series is:
- patch 1/2 -- creating two classes of units is consequence of unclarity
  between state and events (as in event=3D=CE=94state/=CE=94t) and resoluti=
on
  (global vs per-node), so the better approach would be to tidy this up,
- patch 2/2 -- it could use the single unit class that exists,=20
  it'll bound the error of printed numbers afterall (and can be changed
  later depending on how it affects internal consumers).

My 0.02=E2=82=AC,
Michal

--cdqoo3w6fdlwt4bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR58lAAKCRAGvrMr/1gc
jrLvAP91rXrkJJRIRNaOZGR9o6ggxOXbwA7LGaBGQc6FSZyomAD/VZ3zJwOcG0uw
rVioAhpVnfjLpk/ADrszcFpJ7FRPzQI=
=s1VT
-----END PGP SIGNATURE-----

--cdqoo3w6fdlwt4bn--
