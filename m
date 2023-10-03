Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982817B70BA
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJCSWz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjJCSWz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 14:22:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373183;
        Tue,  3 Oct 2023 11:22:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13BB021850;
        Tue,  3 Oct 2023 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696357370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=snq5RhSGYHBHi8BPd1bP7iYx3B/gYWxBD5InsOqzHAc=;
        b=FbmB+coq881p/BKfyHH0tppRCI9xdBQvqZTf6VUI5qSAATOdlfsaAvPJZvUso32TKwph7M
        zMw+zZX3DdgxU0FUsYow8ISINzOevV5RYZH+ZdchhBSev1UEGLWUMhekrjeCe47dQXSEQq
        XsqsCZVz6N23A8SAD6BJ6RUAkt4yRIs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D95A7139F9;
        Tue,  3 Oct 2023 18:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bMxMNPlbHGWvOwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 03 Oct 2023 18:22:49 +0000
Date:   Tue, 3 Oct 2023 20:22:48 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memcg: normalize the value passed into
 memcg_rstat_updated()
Message-ID: <qejogc2nxbcekhujsh56zlyqssgxolf7vboxwyr7dk7zjznhzy@yt7bqkxefjyp>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xld3q657sg75bexy"
Content-Disposition: inline
In-Reply-To: <20230922175741.635002-3-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--xld3q657sg75bexy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 05:57:40PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> memcg_rstat_updated() uses the value of the state update to keep track
> of the magnitude of pending updates, so that we only do a stats flush
> when it's worth the work. Most values passed into memcg_rstat_updated()
> are in pages, however, a few of them are actually in bytes or KBs.
>=20
> To put this into perspective, a 512 byte slab allocation today would
> look the same as allocating 512 pages. This may result in premature
> flushes, which means unnecessary work and latency.
>=20
> Normalize all the state values passed into memcg_rstat_updated() to
> pages.

I've dreamed about such normalization since error estimates were
introduced :-)

(As touched in the previous patch) it makes me wonder whether it makes
sense to add up state and event counters (apples and oranges).

Shouldn't with this approach events: a) have a separate counter, b)
wight with zero and rely on time-based flushing only?

Thanks,
Michal

--xld3q657sg75bexy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZRxb9AAKCRAGvrMr/1gc
jo8EAQCHso22KOo01FrMO5y8vuJbtEnROzr9y7VGM8DBcnx6QwD6AmbPbTKOMvE4
9AN5W+sZ+Ge4/lZ/E+DTn6TCAA+2KQc=
=UQA2
-----END PGP SIGNATURE-----

--xld3q657sg75bexy--
