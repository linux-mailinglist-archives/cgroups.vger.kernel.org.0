Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57CB6C8317
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCXROo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCXROe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 13:14:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C95B9D;
        Fri, 24 Mar 2023 10:14:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DCFA1FF94;
        Fri, 24 Mar 2023 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679678053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=porIllnFw2p86E2ijRdzEbR8T3FBX2CIBdas6/Gd6LM=;
        b=jNC/qpMiWtn8ZgQtU4A5VS7jMHFB68+eObtzqVIN51ypAMW/Ky4K3757kbkbewPI+S4o0/
        9wP6YVvSr/W/oORA3ewkTTignhMg2px7JA36e5FimP8QjD85IoHibcNR2Z7Ztuxr5A9Dyc
        CB5+QL8FBM5fxNh5CZY/p5MsWHl3hYg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEF14138ED;
        Fri, 24 Mar 2023 17:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u2xkOWTaHWSDJQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 17:14:12 +0000
Date:   Fri, 24 Mar 2023 18:14:11 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Cai Xinchen <caixinchen1@huawei.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, longman@redhat.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yosryahmed@google.com, mpenttil@redhat.com
Subject: Re: [PATCH 0/1] Fix vmstat_percpu incorrect subtraction after
 reparent
Message-ID: <20230324171411.t2romq3ydphoonu2@blackpad>
References: <20230320030648.50663-1-caixinchen1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ps5la3sopyo7hm5"
Content-Disposition: inline
In-Reply-To: <20230320030648.50663-1-caixinchen1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--7ps5la3sopyo7hm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 03:06:47AM +0000, Cai Xinchen <caixinchen1@huawei.c=
om> wrote:
> There are two problems left:
>=20
>      root
>      /  \
>     A    B
>    / \    \
>   C   E    D
>=20
> 1. In some case of reparent, some page cache may be used by other memcg
> D but it charges to the parent memcg A of dying memcg E. D is getting
> away with using the page for free while A is taxed.

Note that A is (effectively) taxed even before E is removed due to
hierarchical nature of charging. Then what you describe transforms into
"well-known" problem of shared charging (with not well-known solution
:-/).

HTH,
Michal

--7ps5la3sopyo7hm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB3aYQAKCRAkDQmsBEOq
uULUAQCHRvKpQPSDHUkOEFl2uZo3E7GeJT8AUOQoAsdb9Scv3wEA6jAYPC9q+nvp
FbwIeniHgYs6j4F0z5/Y/u/CsVBLuQw=
=CvmU
-----END PGP SIGNATURE-----

--7ps5la3sopyo7hm5--
