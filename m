Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00E775E8D
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjHIMLR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHIMLQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 08:11:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899271FD4;
        Wed,  9 Aug 2023 05:11:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4517B1F390;
        Wed,  9 Aug 2023 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691583074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bFw/WJBWsVmnC3JIQOGCnya92pXr+LvPFTesg/9s1Q=;
        b=ub7DH9nJ6UoqBcoyE6iSeIUyE0clsVVe5kr8cLreCRs3+yOwc6WU+42omEKVGcb/gvgfPj
        oVqhy3fAHZCWwoR+tdZRHfU3fYjPFnVc3wKvCw4PhA4i7plNsvJhMFx5UZ7fOrghG9i54O
        d09dv4DUMpoBrW3WSb1ipEZMLrYeBpE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 109B1133B5;
        Wed,  9 Aug 2023 12:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zlguA2KC02RmZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 09 Aug 2023 12:11:14 +0000
Date:   Wed, 9 Aug 2023 14:11:12 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH -next v2] block: remove init_mutex and open-code
 blk_iolatency_try_init
Message-ID: <6dcshmol4oz4hpsm42s3ocfdg7rtykkx2vjg6fd6zdvmkbmg7w@4liecv2rxqqk>
References: <20230809112928.2009183-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vz25knwjnl4pua2b"
Content-Disposition: inline
In-Reply-To: <20230809112928.2009183-1-lilingfeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--vz25knwjnl4pua2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 07:29:28PM +0800, Li Lingfeng <lilingfeng@huaweiclo=
ud.com> wrote:
>  1 file changed, 10 insertions(+), 24 deletions(-)

I like this bottom line.

> @@ -861,7 +838,16 @@ static ssize_t iolatency_set_limit(struct kernfs_ope=
n_file *of, char *buf,
> =20
>  	blkg_conf_init(&ctx, buf);
> =20
> -	ret =3D blk_iolatency_try_init(&ctx);
> +	ret =3D blkg_conf_open_bdev(&ctx);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
> +	 * confuse iolat_rq_qos() test. Make the test and init atomic.
> +	 */

Perhaps add here
	lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);

because without that the last sentence of the comment misses the
context.

> +	if (!iolat_rq_qos(ctx.bdev->bd_queue))
> +		ret =3D blk_iolatency_init(ctx.bdev->bd_disk);
>  	if (ret)
>  		goto out;

Thanks,
Michal

--vz25knwjnl4pua2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNOCXgAKCRAGvrMr/1gc
jqQ5AP97ZVTbopQGteWUqwgmcSpEJ6DaXzMfGJ8JRsEFEncwPQD/d9YGR41xRPtq
9ifkSdCa+JcV+2WAW25bjYGN6+hovwc=
=8mdk
-----END PGP SIGNATURE-----

--vz25knwjnl4pua2b--
