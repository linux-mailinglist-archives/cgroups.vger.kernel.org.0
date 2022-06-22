Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6579D555254
	for <lists+cgroups@lfdr.de>; Wed, 22 Jun 2022 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFVR02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377042AbiFVR0Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 13:26:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211B28E05;
        Wed, 22 Jun 2022 10:26:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0EF1F92F;
        Wed, 22 Jun 2022 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655918782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jml0n4rcqjuj+OPSJZyRw7ItN6cmTrfRr6AuCXrU/lE=;
        b=vNbktpf1xKsoPuXRFhRhomPfTR6dR5KLyWvi9TFcnR+ZqXyNArdoJuXxTgbYme3q8UadJH
        XKlk6G10CYi/ZJCtdhvOwXdtgJDAVAV0aB+qpx8o39KbwaMH4vjcH/zIBlR0OxMdF2R3Il
        4x7uE3VXXiNbg7wXwktEv49H5kyWf0Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7121213A5D;
        Wed, 22 Jun 2022 17:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GhLIGr5Qs2JrKgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 22 Jun 2022 17:26:22 +0000
Date:   Wed, 22 Jun 2022 19:26:21 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next v5 4/8] blk-throttle: fix io hung due to config
 updates
Message-ID: <20220622172621.GA28246@blackbody.suse.cz>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20220528064330.3471000-5-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Apologies for taking so long before answering.)

On Sat, May 28, 2022 at 02:43:26PM +0800, Yu Kuai <yukuai3@huawei.com> wrot=
e:
> Some simple test:
> 1)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 2048" > blkio.throttle.write_bps_device
> {
>         sleep 2
>         echo "8:0 1024" > blkio.throttle.write_bps_device
> } &
> dd if=3D/dev/zero of=3D/dev/sda bs=3D8k count=3D1 oflag=3Ddirect
>=20
> 2)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 1024" > blkio.throttle.write_bps_device
> {
>         sleep 4
>         echo "8:0 2048" > blkio.throttle.write_bps_device
> } &
> dd if=3D/dev/zero of=3D/dev/sda bs=3D8k count=3D1 oflag=3Ddirect
>=20
> test results: io finish time
> 	before this patch	with this patch
> 1)	10s			6s
> 2)	8s			6s

I agree these are consistent and correct times.

And the new implementation won't make it worse (in terms of delaying a
bio) than configuring minimal limits from the beginning, AFACT.

> @@ -801,7 +836,8 @@ static bool tg_with_in_iops_limit(struct throtl_grp *=
tg, struct bio *bio,
> =20
>  	/* Round up to the next throttle slice, wait time must be nonzero */
>  	jiffy_elapsed_rnd =3D roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
> -	io_allowed =3D calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
> +	io_allowed =3D calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
> +		     tg->io_skipped[rw];
>  	if (tg->io_disp[rw] + 1 <=3D io_allowed) {
>  		if (wait)
>  			*wait =3D 0;
> @@ -838,7 +874,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp *t=
g, struct bio *bio,
>  		jiffy_elapsed_rnd =3D tg->td->throtl_slice;
> =20
>  	jiffy_elapsed_rnd =3D roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
> -	bytes_allowed =3D calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> +	bytes_allowed =3D calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd)=
 +
> +			tg->bytes_skipped[rw];
>  	if (tg->bytes_disp[rw] + bio_size <=3D bytes_allowed) {
>  		if (wait)
>  			*wait =3D 0;
>

Here we may allow to dispatch a bio above current slice's
calculate_bytes_allowed() if bytes_skipped is already >0.

bytes_disp + bio_size <=3D calculate_bytes_allowed() + bytes_skipped

Then on the next update

> [shuffle]
> +static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
> +{
> +	unsigned long jiffy_elapsed =3D jiffies - tg->slice_start[rw];
> +	u64 bps_limit =3D tg_bps_limit(tg, rw);
> +	u32 iops_limit =3D tg_iops_limit(tg, rw);
> +
> +	if (bps_limit !=3D U64_MAX)
> +		tg->bytes_skipped[rw] +=3D
> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> +			tg->bytes_disp[rw];
> +	if (iops_limit !=3D UINT_MAX)
> +		tg->io_skipped[rw] +=3D
> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> +			tg->io_disp[rw];
> +}

the difference(s) here could be negative. bytes_skipped should be
reduced to account for the additionally dispatched bio.
This is all unsigned so negative numbers underflow, however, we add them
again to the unsigned, so thanks to modular arithmetics the result is
correctly updated bytes_skipped.

Maybe add a comment about this (unsigned) intention?

(But can this happen? The discussed bio would have to outrun another bio
(the one which defined the current slice_end) but since blk-throttle
uses queues (FIFO) everywhere this shouldn't really happen. But it's
good to know this works as intended.)

This patch can have
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYrNQpAAKCRAkDQmsBEOq
uZ3BAQCL8oobgb+B0o8EQKGsxtLcjkKWGAXteGs1+CHNsFrUGAD/V+B+r/Bv3hQR
A5tMH+4VD4tzI0yNIrKNYH5LIKu2ZgU=
=HsKx
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
