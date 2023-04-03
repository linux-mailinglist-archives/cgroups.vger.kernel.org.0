Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586566D4BEC
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjDCPa3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDCPaZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 11:30:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27671BFD;
        Mon,  3 Apr 2023 08:30:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4100521E7E;
        Mon,  3 Apr 2023 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680535823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDwpYF4u/WbyyCSZ3xRLaLaKTiwTm4Y0OH0oxOZVABk=;
        b=l9MyysTeT5JhkZxjgLyTDnDn9swdOLi94eW+7mcQeIg2+njQJlaolClaSoA7hl0F7WrExj
        qJyGBmD+AmUjjrpfgx5KA4CUDB+4tJXxnQdZfYEARqoeezCLGSzAcI33I7rE4th2sVQErr
        bsCKR2DhASdb81S0vQ47j+J7mTEVT3c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A22C1331A;
        Mon,  3 Apr 2023 15:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0VkcAQ/xKmQHPgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Apr 2023 15:30:23 +0000
Date:   Mon, 3 Apr 2023 17:30:21 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: Fix io statistics for cgroup v1
Message-ID: <20230403153021.z4smxxnxbgdcgcey@blackpad>
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyxomnpk7u4ms5xp"
Content-Disposition: inline
In-Reply-To: <20230401094708.77631-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--zyxomnpk7u4ms5xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han <hanjinke.666@bytedance=
=2Ecom> wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
>=20
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1,

There is also blkio.bfq.{io_serviced,io_service_bytes} couple, so it's
not the only. Or do you mean stable in terms of used IO scheduler?

> and these statistics are done in the blk-throttle code. But the
> current code only counts the bios that are actually throttled. When
> the user does not add the throttle limit,

=2E.. "or the limit doesn't kick in"

> the io stats for cgroup v1 has nothing.


> I fix it according to the statistical method of v2, and made it count
> all ios accurately.

s/all ios/all bios and split ios/=20

(IIUC you fix two things)

> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")

Good catch.

Does it also undo the performance gain from that commit? (Or rather,
have you observed effect of your patch on v2-only performance?)

> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> ---
>  block/blk-cgroup.c   | 6 ++++--
>  block/blk-throttle.c | 6 ------
>  block/blk-throttle.h | 9 +++++++++
>  3 files changed, 13 insertions(+), 8 deletions(-)

The code looks correct.

Thanks,
Michal

--zyxomnpk7u4ms5xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCrxCQAKCRAkDQmsBEOq
uYrdAQDQZdcEO4tDtRmV1dkrKTvOziHQuJI0oy2suFYm6RIM5QEAhZBPPLwgfokP
zz+x15hzo4Ce/VUdKwWOjbjwsq0/9w0=
=32so
-----END PGP SIGNATURE-----

--zyxomnpk7u4ms5xp--
