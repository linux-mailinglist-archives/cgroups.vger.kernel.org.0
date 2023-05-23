Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC170DF86
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjEWOlA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjEWOk6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 10:40:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE7FA;
        Tue, 23 May 2023 07:40:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11270229F9;
        Tue, 23 May 2023 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684852848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGlr9RSvSIRIegvdJA3tDbcOz/gxFk1P8G5vHNFFvdw=;
        b=Uxk2np0yuV6dsJAJsvbMA15zF96rjED8fP2akEhLxsmTpt+feyN2T/XT2pX2L8XeAZ4ZNd
        x/FzKx4vRGic0qaTq8sE2kEc12gKEby+NSQYZAjT9a/i9yg98rtiR1IHPVBAP/QqZKzzcp
        /LSS2uf6XfVEVLuRagQgPj5k0Vkwt7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA1DA13588;
        Tue, 23 May 2023 14:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tCdyNG/QbGRaawAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 23 May 2023 14:40:47 +0000
Date:   Tue, 23 May 2023 16:40:46 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, hannes@cmpxchg.org,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: cgroup: fix unexpected failure on
 test_memcg_low
Message-ID: <r5owzlvxbx22gqmw2cnmykvrzzhhw3hkoffk3f4wbvv7lmqzod@wbbmnt4a76cu>
References: <20230522095233.4246-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrfw5lltt6r2lzen"
Content-Disposition: inline
In-Reply-To: <20230522095233.4246-2-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qrfw5lltt6r2lzen
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 09:52:33AM +0000, Haifeng Xu <haifeng.xu@shopee.com=
> wrote:
> Since commit f079a020ba95 ("selftests: memcg: factor out common parts
> of memory.{low,min} tests"), the value used in second alloc_anon has
> changed from 148M to 170M. Because memory.low allows reclaiming page
> cache in child cgroups, so the memory.current is close to 30M instead
> of 50M. Therefore, adjust the expected value of parent cgroup.
>=20
> Fixes: f079a020ba95 ("selftests: memcg: factor out common parts of memory=
=2E{low,min} tests")
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Yes, the expected value should be complement of the allocation to the
limit when reclaim is allowed.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

FTR, the test_memcg_low fails after the fix still (6.3.1-2-default)
because of nonzero memory.events:low in the unprotected A/B/E group
(with memory_recursiveprot).
(That's another and long standing issues -- perhaps the reason why this
issue was hidden.)

Thanks,
Michal

--qrfw5lltt6r2lzen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZGzQbAAKCRAkDQmsBEOq
uZ7BAQCh/IzL0Y/nVUwN/zZJm3gzAUIYiiYkjKXr3IdIi/nEEAD8CrjZAUCERkWq
My0modfCN7u48OMYoc2a0660bD9tYww=
=er1S
-----END PGP SIGNATURE-----

--qrfw5lltt6r2lzen--
