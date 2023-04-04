Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330C6D6981
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjDDQxm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 12:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjDDQxb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 12:53:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A319AA;
        Tue,  4 Apr 2023 09:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F0872068B;
        Tue,  4 Apr 2023 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680627195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsMVP1Gx6bqzvFmi3XkM83yTiX2CMmFn0tLAqTXnpkI=;
        b=btRPMMcl2b2uFZz5YK+tZE32E88Ja+m/EkIvXmlf/VcbcyPt8UXBCI+1HfaQcy83X/zun0
        q8RT3lcBoIJDjqhQN0pXO17r2yZOR2oRKUkxYGi1adL3BezoX5ydpiXRqzkCA18uWnHeQF
        XP2lmbvyGFA9b3jQoIJi4gEXoZ7IQ7M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A9781391A;
        Tue,  4 Apr 2023 16:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dYFtFftVLGTlMAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Apr 2023 16:53:15 +0000
Date:   Tue, 4 Apr 2023 18:53:14 +0200
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
Subject: Re: [PATCH v3 8/8] memcg: do not modify rstat tree for zero updates
Message-ID: <20230404165314.swb7bide2mkjap3p@blackpad>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-9-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5h2bvm4dmip3h3q"
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-9-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--v5h2bvm4dmip3h3q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 07:18:01PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--v5h2bvm4dmip3h3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCxV9QAKCRAkDQmsBEOq
uYK9AP0WJYtFSeSrHica60KBnkpC0zuL6ZB9oq/HdqUH8N7N9gEAxT/BKJqjFEX1
f8Ij/Sc8okkrXt+NvEbGkgBVVJnCNAA=
=86rE
-----END PGP SIGNATURE-----

--v5h2bvm4dmip3h3q--
