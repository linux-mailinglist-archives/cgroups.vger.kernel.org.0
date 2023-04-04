Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF06D6977
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDDQxV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjDDQxP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 12:53:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1594C18;
        Tue,  4 Apr 2023 09:53:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA1C52068A;
        Tue,  4 Apr 2023 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680627180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J++lSR0qBN+0TGvxu6lzekTohutLNFEkeNAdPcqtrMc=;
        b=qOluMdxPHhvtFQLCFpQe1/5GzQwfB/aZnibvtGxy2cJj/GyfWJ5wH4U5vkOgOM4tLtt1Nu
        Zvy2ZDtEOpyTBqcaT3xmplxiRScoHOSM7b0DIGYzfo+dy8TIFtXcIJ/kmtMwDURxu6+1hO
        2swLdLqT2gFMWpUe1QczgdY8wOiZM5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B2071391A;
        Tue,  4 Apr 2023 16:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MatdFexVLGTJMAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Apr 2023 16:53:00 +0000
Date:   Tue, 4 Apr 2023 18:52:58 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 4/8] memcg: replace stats_flush_lock with an atomic
Message-ID: <20230404165258.ie6ttxobbmgn62hs@blackpad>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pchdddtux2qbf53z"
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-5-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--pchdddtux2qbf53z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Mar 30, 2023 at 07:17:57PM +0000, Yosry Ahmed <yosryahmed@google.com> wrote:
>  static void __mem_cgroup_flush_stats(void)
>  {
> -	unsigned long flag;
> -
> -	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> +	/*
> +	 * We always flush the entire tree, so concurrent flushers can just
> +	 * skip. This avoids a thundering herd problem on the rstat global lock
> +	 * from memcg flushers (e.g. reclaim, refault, etc).
> +	 */
> +	if (atomic_read(&stats_flush_ongoing) ||
> +	    atomic_xchg(&stats_flush_ongoing, 1))
>  		return;

I'm curious about why this instead of

	if (atomic_xchg(&stats_flush_ongoing, 1))
		return;

Is that some microarchitectural cleverness?

Thanks,
Michal

--pchdddtux2qbf53z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCxV6AAKCRAkDQmsBEOq
ucctAP0QF3CXk51W8Pmcc0e8ZfVGikqKVH42APSyMXgCLEw4twD/ajlglQ+6Jt7N
Lf+TNXVTCA0s8f9NI8huIwxn6NR+XQc=
=Q0r7
-----END PGP SIGNATURE-----

--pchdddtux2qbf53z--
