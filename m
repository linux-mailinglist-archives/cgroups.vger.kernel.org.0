Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3874DA23
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 17:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGJPqQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGJPqQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 11:46:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22325B1;
        Mon, 10 Jul 2023 08:46:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD4AE21B06;
        Mon, 10 Jul 2023 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689003973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Csf/O53K061Tg2O8DUcAmJ7TXCxHkY96GEDUe2hk864=;
        b=RZe3jCqnQgAh5tdMl3sCRcNfotwRAgzSOz2BVkOFs9k4b/FZP5ITr5hQIt91PoxufhAG42
        wL7ZJbjnQQfjKSEkclDuqxso6t318xk/U9jWnV3Zats3gJ5tZfrLx7AZpvzdZ6tO1ZsfOo
        Zj+zO02nA6M0SGiuqFSULOcz9ZbN/7c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC1861361C;
        Mon, 10 Jul 2023 15:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QZ0NKcUnrGTmagAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Jul 2023 15:46:13 +0000
Date:   Mon, 10 Jul 2023 17:46:12 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
Message-ID: <ue4duahv6scnn64zgduuhiyq2gh33w7x5ftdffw3uqcn4ahyd2@txxtxf2fkzp2>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kyoxkof3brdp3vbp"
Content-Disposition: inline
In-Reply-To: <20230701073856.2095425-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kyoxkof3brdp3vbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, Jul 01, 2023 at 03:38:56PM +0800, Miaohe Lin <linmiaohe@huawei.com>=
 wrote:
> The return value of cgroup_rm_cftypes_locked() is always 0. So remove
> it to simplify the code. No functional change intended.

I'd add a comment that it builds upon cgroup_addrm_files()'s:
> For removals, this function never fails.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--kyoxkof3brdp3vbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZKwnwgAKCRAGvrMr/1gc
jnYVAPwMLLOEYIeph0SWge4e4A3F5ye6RxReGFqVGXVEK09OngD+J+R/PCIA08hT
CiKosuzZJmwkLRKsTW4SlJ9cUwbSNQU=
=VAXP
-----END PGP SIGNATURE-----

--kyoxkof3brdp3vbp--
