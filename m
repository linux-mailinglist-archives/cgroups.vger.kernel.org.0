Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343D0778994
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHKJR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 05:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKJR0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 05:17:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5AE68;
        Fri, 11 Aug 2023 02:17:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7516721881;
        Fri, 11 Aug 2023 09:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691745444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YZepTMAv/Au26R8+gI+UkHj/wQbzQF2/pHToHgZrjg=;
        b=SMJPFU2WEyswb6twc8sKVxaTwcMcOCA2fafyXmHrwYXp0JCAKjQQPGzX4UJD8RpLDrEIJ6
        LVt6756QWGxgmfp7oFpUSyY12/CQzA0MtZbbVBJPFURfiXMGti1Vi0lBQlAxUbmqPh5Eb7
        bNoOLvx6Qgk0RX22PkWdZJu72KiIEVY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 457A8138E2;
        Fri, 11 Aug 2023 09:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h6FEEKT81WSRFwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 11 Aug 2023 09:17:24 +0000
Date:   Fri, 11 Aug 2023 11:17:23 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Message-ID: <fwzsn3wyqpthfkegnlq7obl3uy6hhodobvcswena2z42ndzmzp@izv4k6wy6opt>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
 <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
 <dtobag743cbzb3rxzldu36wszqtnbayz2grpyj2cctptfybtt3@66ico6n2clrr>
 <60dbff4b-d823-5dc9-ff8e-36648ddf7207@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6koa3vpku6zfzfmx"
Content-Disposition: inline
In-Reply-To: <60dbff4b-d823-5dc9-ff8e-36648ddf7207@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6koa3vpku6zfzfmx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 04:53:44PM +0800, Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> Yes, it'm implemented in the upper layer that rq_qos_add() and
> blkcg_activate_policy() should be atmoic, and currently there is no
> comments for that.

The check (iolat_rq_qos()) and use (activating the policy) should be the
atomic pair.

> Perhaps it's better to add some comments like following in rq_qos_add()
> instead?

Honestly, I find the current variant (v3) good as it is -- closest to
the pair of the operations.

(But it's merely a comment so =C2=AF\_(=E3=83=84)_/=C2=AF)

Michal

--6koa3vpku6zfzfmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNX8oAAKCRAGvrMr/1gc
jh2HAQDn5ssFKhK4z/OdWTcfgO8LfZnvmBz3+V8z54G2a+DN+QEAlsCwIo1klPtg
YTfZCKcGYeRkwlEtUpWCOjTchuJkIAo=
=CKR8
-----END PGP SIGNATURE-----

--6koa3vpku6zfzfmx--
