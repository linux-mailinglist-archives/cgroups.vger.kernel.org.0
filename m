Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DB719F0A
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjFAOGl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjFAOGQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 10:06:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE15186;
        Thu,  1 Jun 2023 07:06:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7611FDAA;
        Thu,  1 Jun 2023 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685628374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbkSDAdLFYbIoAWZ1gJrOqgEs1hVPjHXyEexOto9I8A=;
        b=OFsvcR3IGJWU1vkTU/YzDEmg+rz0dQ0ZG9ZHI6OHkHIOVx7Xf3LBlZfdmKjzKSniYjH/nv
        HoQW+BjkC+fQM0nDOmL/QuexEcBaGYInAuL48PWP50HUeA2Mwr0rZdnWK3zxuaBoT7ek5y
        nZNMrc3/WyIFOS4ILCyjAcg5YLe/zBs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FBA013441;
        Thu,  1 Jun 2023 14:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MxelDtaleGRBQQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 01 Jun 2023 14:06:14 +0000
Date:   Thu, 1 Jun 2023 16:06:12 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unused macro for_each_e_css()
Message-ID: <rzd6vcpcrxngnfannzzse5iidxsoioxscudsvxnapcrfzhf2lq@dr4yc725m457>
References: <20230527093353.153078-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7atkutyhfmrtddtv"
Content-Disposition: inline
In-Reply-To: <20230527093353.153078-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--7atkutyhfmrtddtv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 05:33:53PM +0800, Miaohe Lin <linmiaohe@huawei.com>=
 wrote:
> for_each_e_css() is unused now. Remove it.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--7atkutyhfmrtddtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZHil0gAKCRAkDQmsBEOq
uQEPAP9GalywFNelOaF6eV8FMJ2HWO0EOdep8H7YyRYil61QegEAtXf9VuTbZxYH
4tIj6a7SeAsQ0tiMcSTlXFSGaRwmPgU=
=b4BE
-----END PGP SIGNATURE-----

--7atkutyhfmrtddtv--
