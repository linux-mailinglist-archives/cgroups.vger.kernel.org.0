Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920A6D7612
	for <lists+cgroups@lfdr.de>; Wed,  5 Apr 2023 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjDEIAw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjDEIAv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 04:00:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1230E2;
        Wed,  5 Apr 2023 01:00:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0B2320600;
        Wed,  5 Apr 2023 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680681648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NF83qlVzxv5rP31TK87fQBjgypo+iPk8Tgc/ff/LzS0=;
        b=nWYAwbTopJSeJ+HfSY6AkXfF6hH7nbJMp50CUAQdErLnNegkaTgEgfo0Xtcp3Y0Zy6IYqu
        XsFYsercb9dhTAcnh9CiJLDMkcLllZsaGQ8D5uWxucNnpWOTOwS2i2ciWfvyLP63x+kb7Z
        f8bb2+A7sVt9W5n2EwOktFXUdweSbwk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D4013A10;
        Wed,  5 Apr 2023 08:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ai37H7AqLWQjMwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Apr 2023 08:00:48 +0000
Date:   Wed, 5 Apr 2023 10:00:47 +0200
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
Subject: Re: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <20230405080047.5omnatjbwz46f3y5@blackpad>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-7-yosryahmed@google.com>
 <20230404165305.ffs7uscqpndnfytn@blackpad>
 <CAJD7tkb-0rXL9V2TX-Ax-3OkwJPYx_GaOT4D=VCA60riit+dOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkpos56pi67t66c5"
Content-Disposition: inline
In-Reply-To: <CAJD7tkb-0rXL9V2TX-Ax-3OkwJPYx_GaOT4D=VCA60riit+dOw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--xkpos56pi67t66c5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 11:09:02AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> IIUC there are multiple places where we can sleep in this path, we can
> sleep waiting for a page to be read from disk, we can sleep during
> allocating the page to read into, and IIUC the allocations on the
> fault path can even run into reclaim, going into the vmscan code. So
> there are precedents, but I am not sure if that's enough argument.

I expect it'd depend on the proportion of the slow/fast paths.
OK, let's see how it turns out in wider population.

Thanks,
Michal

--xkpos56pi67t66c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZC0qqwAKCRAkDQmsBEOq
uQd1AP9da0usdZXtaqKldZWC3hNIo/w+tYQarhExM3TWXX+KGQEAvck6zPYNvKdu
uhY4KtMQkxSOomI7xDc/A08Ae98OjA8=
=ErRC
-----END PGP SIGNATURE-----

--xkpos56pi67t66c5--
