Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB056C80AB
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjCXPDz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCXPDy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 11:03:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883AE055;
        Fri, 24 Mar 2023 08:03:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 891C81FEF6;
        Fri, 24 Mar 2023 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679670232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rfr8g5aJSVUWobCiA6CGIV3Ux30dV0HPukLuzQZq+hk=;
        b=UwCiahyMAVG4lGGaeiI26S5FSNGq7lKd3cTtrlRbhbaTyWMfUVFS0L7PWKD2QauBv0p/I8
        lB/cCsq1Be+SXtxVBk7V/yeSH2c5VS/0qOq4zqdmw2BI187JynDfaVlhM67l2q+WGdYnHh
        tbQhI2CEZSj5XRY2mooGLZOyrHgWw5k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55DCC138ED;
        Fri, 24 Mar 2023 15:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 838HFNi7HWS3XwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 15:03:52 +0000
Date:   Fri, 24 Mar 2023 16:03:50 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Florian Schmidt <flosch@nutanix.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
Message-ID: <20230324150350.fu7itbqqvtjmyf3s@blackpad>
References: <20230322142525.162469-1-flosch@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="giw5phpov7yliruv"
Content-Disposition: inline
In-Reply-To: <20230322142525.162469-1-flosch@nutanix.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--giw5phpov7yliruv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Mar 22, 2023 at 02:25:25PM +0000, Florian Schmidt <flosch@nutanix.c=
om> wrote:
> cgroups v1 has a unique way of setting up memory pressure notifications:
=2E..
> There are several ways around this issue, but adding a dummy read
> handler seems like the least invasive to me. I'd be interested to hear:
> (a) do you think there is a less invasive way? Alternatively, we could
>     add a flag in cftype in include/linux/cgroup-defs.h, but that seems
>     more invasive for what is a legacy interface.

You can (as privileged user) modify file perms in userspace first (e.g.
chmod o+r memory.pressure_level) and then it can used by non-privileged
users. (Or do LSM prevent you from that too?)

> (b) would you be interested to take this patch, or is it too niche a fix
>     for a legacy subsystem?

I'd rather not extend this "unique way" with additionally unique dummy
helpers.

My 0.02 =E2=82=AC,
Michal

--giw5phpov7yliruv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB271AAKCRAkDQmsBEOq
uaftAP9jAb8MRvyOlJlzSiA/74Dm588NNIhwB30zeAvi2Gy2DQD8Du97muUPss8S
XDdnabKXH1krN1zbPtFwqMvvCx5e6wI=
=7Q79
-----END PGP SIGNATURE-----

--giw5phpov7yliruv--
