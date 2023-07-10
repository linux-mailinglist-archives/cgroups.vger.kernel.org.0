Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6474D940
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGJOo6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJOo5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 10:44:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543DC3;
        Mon, 10 Jul 2023 07:44:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38B7721AE8;
        Mon, 10 Jul 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689000295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2dSDCIryhoqYz8ZS1bBqRNqc86fubisnGZKJq77QBlA=;
        b=ZOh9PSn4qAb49Y/vRW4RvILvHVqDNm8r7BSRKjNFgqVMKsAHnK+MLjUCMjalAB1ujYKCXP
        VH9Y13+ev6/vDr7W357nCLvnoVwnsFHEaGMUZGMQZXiDaIpzdjn2cZa1YiBoRWsDx1qnAW
        cfgvONSAD46IH0pcuEFK25CaUCcA8C8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0743A13A05;
        Mon, 10 Jul 2023 14:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mijkAGcZrGSrSgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Jul 2023 14:44:55 +0000
Date:   Mon, 10 Jul 2023 16:44:53 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Expensive memory.stat + cpu.stat reads
Message-ID: <gbqumqkxixvvrbbqh55rw6thgfa67tw2kkcuauc4xj5t6pnivd@3yfkokngo43w>
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b77s5ccberk4hrjr"
Content-Disposition: inline
In-Reply-To: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--b77s5ccberk4hrjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> As you might've noticed from the output, splitting the loop into two
> makes the code run 10x faster.

That is curious.

> We're running Linux v6.1 (the output is from v6.1.25) with no patches
> that touch the cgroup or mm subsystems, so you can assume vanilla
> kernel.

Have you watched for this on older kernels too?

> I am happy to try out patches or to do some tracing to help understand
> this better.

I see in your reproducer you tried swapping order of controllers
flushed.=20
Have you also tried flushing same controller twice (in the inner loop)?
(Despite the expectation is that it shouldn't be different from half the
scenario where ran two loops.)

Thanks,
Michal

--b77s5ccberk4hrjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZKwZYwAKCRAGvrMr/1gc
jkiaAP0cMXwbvKMrd3UFe9bkgPZXxl1WeME+caCgKNQqMZaS1AD/eGWbOeKD5V7A
KBibSziS+oGtgU+Wg7XvKGBFaasJZA4=
=jPdL
-----END PGP SIGNATURE-----

--b77s5ccberk4hrjr--
