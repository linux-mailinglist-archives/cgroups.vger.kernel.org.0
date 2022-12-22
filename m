Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E765423B
	for <lists+cgroups@lfdr.de>; Thu, 22 Dec 2022 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiLVN7B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Dec 2022 08:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLVN7A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Dec 2022 08:59:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EC1C413;
        Thu, 22 Dec 2022 05:58:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D683E7679C;
        Thu, 22 Dec 2022 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671717537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fKATc+B04yPGuwVoMjN+880psfHG481KAwJvLG9IAuY=;
        b=WBq6ASIWKvgNfUiotGOXishHrXz1OaT2uQNWZx8kpWVUeCyV4sC+9XgZFcx3hg0MIFTKEE
        FNnScyG76pkyCA01ofhDM+9a43A/HvwDIbpjwQDoV5rxUo9JtKhJwoEky3vMyPimd2ZCzg
        a1pscpFiO+riwT3DwA6cEVpiLPIz1/g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A84B8138FD;
        Thu, 22 Dec 2022 13:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XPInKKFipGMtPgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 22 Dec 2022 13:58:57 +0000
Date:   Thu, 22 Dec 2022 14:58:55 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: don't make all constants unsigned long long
Message-ID: <20221222135855.GC20830@blackbody.suse.cz>
References: <20221220201819.1497577-1-ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20221220201819.1497577-1-ydroneaud@opteya.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2022 at 09:18:19PM +0100, Yann Droneaud <ydroneaud@opteya.com> wrote:
> +enum {
>  	/* switch iff the conditions are met for longer than this */
>  	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
> +};

This looks gratuitous.

What about indivudial #defines with typed literals instead of the "lazy
splitting"?

Regards,
Michal

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY6RingAKCRAkDQmsBEOq
uVPgAP4y2ImrULaeHe+Vpcp/aQaKYMrV7D3Q1d9z39OiU0CmwQD+PBJ70cOphLPH
5zWBwTr/hS3qRiIJ7Feh9YL4sjTrig8=
=ZT8m
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
