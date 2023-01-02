Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73E265B4D1
	for <lists+cgroups@lfdr.de>; Mon,  2 Jan 2023 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjABQKQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Jan 2023 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjABQJu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Jan 2023 11:09:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F7B1C3;
        Mon,  2 Jan 2023 08:09:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D17AE5C4B4;
        Mon,  2 Jan 2023 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672675787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TXMFafqZSk+G4FHe0dFtLpO4ewGe6qnJ+N0wbs8SPY=;
        b=QTi3UzxN6Jw/VzGJjLhZQdsQ+UBM7B4GAP4tthZfQGXeYmVgc6UTwe+BvVvpUaumfvoFOC
        pDu4+IXoLkjUUez0lGE1mlsK48eJaXenqfirr60jtzJzW9r835sNXpqfDa7As9HZ2CZPx1
        9zOUopaIcFyvLCNDzjWv/+lTgbqQR0o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0E4B139C8;
        Mon,  2 Jan 2023 16:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p/lUJssBs2MKfQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 02 Jan 2023 16:09:47 +0000
Date:   Mon, 2 Jan 2023 17:09:46 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 2/2] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <20230102160946.GD16704@blackbody.suse.cz>
References: <20221220182745.1903540-1-roman.gushchin@linux.dev>
 <20221220182745.1903540-3-roman.gushchin@linux.dev>
 <20221222135044.GB20830@blackbody.suse.cz>
 <Y6SEHTkHSNYQmv5k@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <Y6SEHTkHSNYQmv5k@P9FQF9L96D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Dec 22, 2022 at 08:21:49AM -0800, Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> Do you have any numbers to share?

The numbers are in bko#216038, let me explain them here a bit.
I used the will-it-scale benchmark that repeatedly locks/unlocks a file
and runs in parallel.

The final numbers were:
  sample			metric	 	  =CE=B4	 =CE=B4_cg
  no accounting implemented	32307750	  0 %	 =C2=AD
  accounting in cg		2.49577e+07	-23 %	 0 %
  accounting in cg + cache	2.51642e+07 	-22 %	+1 %

Hence my result was only 1% improvement.

(But it was a very simple try, not delving into any of the CPU cache
statistics.)

Question: Were your measurements multi-threaded?

> 1) some people periodically complain that accounted allocations are slow
>    in comparison to non-accounted and slower than they were with page-bas=
ed
>    accounting,

My result above would not likely satisfy those complainers I know about.
But if your additional changes are better the additional code complexity
may be justified in the end.


> Btw, I'm working on a patch 3 for this series, which in early tests brings
> additional ~25% improvement in my benchmark, hopefully will post it soon =
as
> a part of v1.

Please send it with more details about your benchmark to put the numbers
into context.


Michal

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY7MByAAKCRAkDQmsBEOq
uUG/AQC11XKCM/wWsjYXa9wOcZSD924NsT+jZ2ZVsvw96HBebAD9EYkrKAMMTTlE
Zk65EirkknPYoU5zwvfnv8zzrOvGWgk=
=ihb/
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
