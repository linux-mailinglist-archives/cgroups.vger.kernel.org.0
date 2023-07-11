Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179DA74EC87
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGKLVo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGKLVo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 07:21:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58239E7A;
        Tue, 11 Jul 2023 04:21:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0920A1FE81;
        Tue, 11 Jul 2023 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689074501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vowglESr1KoOEcY4XXmA0mTe20uS/zqvChy0ToqbJlw=;
        b=GwL+qkZnIy2QFgfpjgTPLJlEV//u+2813Bb38189aR7Zm2/gNFOmWRZ8RAhRnJyIYzbwNI
        t72sniEI3ZdmVcZtwEBOnhAZhIJXBLes2THAO86pREcYVEDzLzTMFDk4/pbpK2S19BzEBe
        xEkiN2Fos24yBO10UsreHSv79mJOKQM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB7FA1390F;
        Tue, 11 Jul 2023 11:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5PGMNEQ7rWRIGQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Jul 2023 11:21:40 +0000
Date:   Tue, 11 Jul 2023 13:21:39 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
Message-ID: <cwqcmeqxglkd32crmc7fw57hhrrihtqnkle5ympniuthkg6j6w@fmyd7jxvffhi>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
 <ue4duahv6scnn64zgduuhiyq2gh33w7x5ftdffw3uqcn4ahyd2@txxtxf2fkzp2>
 <7d3323ab-f796-6846-ab08-5d48734595e1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fhkx5cds4otewh5u"
Content-Disposition: inline
In-Reply-To: <7d3323ab-f796-6846-ab08-5d48734595e1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fhkx5cds4otewh5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:58:48AM +0800, Miaohe Lin <linmiaohe@huawei.com>=
 wrote:
> +/* It builds upon cgroup_addrm_files()'s. */
>  static void cgroup_rm_cftypes_locked(struct cftype *cfts)
>  {
>         lockdep_assert_held(&cgroup_mutex);
>=20

I meant adding the reasoning to the commit message -- swallowing errors
on removal is fine because cgroup_addrm_files() won't fail at removal.
It's a minor remark for the future readers ;-)

Michal

--fhkx5cds4otewh5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZK07QQAKCRAGvrMr/1gc
jq21AQCWPqVs+XV9Vu8QeN38R34dWAgvPGj9y4EfFgTQDIWk4QEAqcd+aEHRGC2i
onMUJSBPVSf3GqVIjpW7MNZ5aAaKPAE=
=GCjq
-----END PGP SIGNATURE-----

--fhkx5cds4otewh5u--
