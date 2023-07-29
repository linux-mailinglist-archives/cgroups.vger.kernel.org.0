Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5B767F3A
	for <lists+cgroups@lfdr.de>; Sat, 29 Jul 2023 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjG2Mrz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jul 2023 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2Mrz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jul 2023 08:47:55 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD706E6A;
        Sat, 29 Jul 2023 05:47:53 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2A8141C0A94; Sat, 29 Jul 2023 14:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1690634872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAsNUQf+00oUuts2a7jrozlCZl17QKNd69lxBxURL3g=;
        b=YnoqXcg30UY3MdSapkyH4rKRfmwItAMk6U74tP90L8di9bpTuUvR+jkWhqxdB2I7RIHOy5
        mR6SxYFrOmWaY2DdCamfRajqHtno/aufJelCtXKvOF5UfLS4TthIpDWJWR0gQT4LtQVJwM
        MMzRIAcVkPw2y5cposyyuIyaGkkZ2nk=
Date:   Sat, 29 Jul 2023 14:47:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v3 11/28] x85/sgx: Return the number of EPC pages that
 were successfully reclaimed
Message-ID: <ZMUKd7KY6Kquubjf@duo.ucw.cz>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-12-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R7yJGefVtKAYCwSn"
Content-Disposition: inline
In-Reply-To: <20230712230202.47929-12-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--R7yJGefVtKAYCwSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sean Christopherson <sean.j.christopherson@intel.com>
>=20
> Return the number of reclaimed pages from sgx_reclaim_pages(), the EPC
> cgroup will use the result to track the success rate of its reclaim
> calls, e.g. to escalate to a more forceful reclaiming mode if
> necessary.

Subject says x85. While some would love to see support of Linux on
Intel 8085, I guess it should be x86.

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--R7yJGefVtKAYCwSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMUKdwAKCRAw5/Bqldv6
8hyIAKC6e4rHUDwLQThZHsYgsxUnrEcKQQCfXT0HVDxSw+VWX7v8QzRcoZQ5q/I=
=C2G9
-----END PGP SIGNATURE-----

--R7yJGefVtKAYCwSn--
