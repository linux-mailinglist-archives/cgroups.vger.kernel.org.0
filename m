Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4141EC1D2A
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2019 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfI3I31 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Sep 2019 04:29:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3I31 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Sep 2019 04:29:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so10168078wrw.8;
        Mon, 30 Sep 2019 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=cMSmKksRpZvm7DjI+W2FPVfuQhvxd33fHRo5ksvWmP4=;
        b=dRuBx2TC1uq36DDhogFse6nwMfAp/ucimdeY6k5ppTn2Xho+z3y/ZjUdHhQcPoazXo
         cUl5M2Tc2K6mKaKlg+SBDvdy7Oi3X7/ikExmnGLRT8sGsNOpxOiEHe6QK7uPo/VY0CXK
         CVzAd7AnOL8C+caYQYuaodnOP3e54tWdY5iqQe/Cyb8kAEKxKQs1s1QktwlZCCLiO/VU
         u/RomifRoQXgVF/ZB3ahSgGkC3anJWf1MWewAskf6e5kleYuhEMhhAW5MmC81Er9o0Et
         N8BH6XxrP3+LHJxEPhEDwii7muqWvRD/et3s8ml3IWlUZYc7iWKvuRtsKTfBeoTgGStr
         Gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=cMSmKksRpZvm7DjI+W2FPVfuQhvxd33fHRo5ksvWmP4=;
        b=GvrvsqXd6V1kWtjWAu/+XmDmeFHLaYYsaBeLKimkmaSJEIDanSG0rvFFJEGs+zJlyX
         6pFAOnOYkc3YSvL/7GhskG3jcyPwi3Fbi75nyA2JTA7ycYt/UDSA6OenfHMDuNbAhxWH
         dfTigWD2rXTcC/1ArGfAoOpjD3P8mWS2UkvwPiBQ5MA/vbp9eVdJORy+LPrM0oZqJmAN
         nAwh/lrhDJZTdk8Sm+vHz9OCTnbl2oNxOvE/P+5+8W3/TzZQgw768xG5fiMnl212DdOa
         54/5W+eRuCCDEoZWE6qGoPMS17gUcn3oZXFwwRNJXQ/lYgABwe5kv8uvdLMeaj2EKrJ0
         2EnQ==
X-Gm-Message-State: APjAAAVoFbPLykxTnSLw+2FI2XrHUYu7FQcL/35AbYq8TuOUeTiw4Ltu
        +QXwIU1Bh7AkrhYRIyQiYiyK5TgazyU=
X-Google-Smtp-Source: APXvYqyZ9iDjEf3KowUYVVpJfrrm4nEuNL4dXCEkaHoQiBx06KMBAOT3CFzmWVL00VRsReoL86FrKw==
X-Received: by 2002:adf:e348:: with SMTP id n8mr11126221wrj.299.1569832162487;
        Mon, 30 Sep 2019 01:29:22 -0700 (PDT)
Received: from [192.168.43.187] ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id a7sm25567078wra.43.2019.09.30.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 01:29:21 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
References: <cover.1560510935.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RESEND RFC PATCH 0/2] Fix misuse of blk_rq_stats in
 blk-iolatency
Message-ID: <276a02f3-3b1a-0580-54fb-497f85103ae3@gmail.com>
Date:   Mon, 30 Sep 2019 11:29:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1560510935.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vpDpuljOak4VUjubg0p6HLJIDCCP6aiBm"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vpDpuljOak4VUjubg0p6HLJIDCCP6aiBm
Content-Type: multipart/mixed; boundary="iwCQfC1143W97Fjrsn5ILXvfBDPud4pYO";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, josef@toxicpanda.com, Tejun Heo
 <tj@kernel.org>, cgroups@vger.kernel.org
Message-ID: <276a02f3-3b1a-0580-54fb-497f85103ae3@gmail.com>
Subject: Re: [RESEND RFC PATCH 0/2] Fix misuse of blk_rq_stats in
 blk-iolatency
References: <cover.1560510935.git.asml.silence@gmail.com>
In-Reply-To: <cover.1560510935.git.asml.silence@gmail.com>

--iwCQfC1143W97Fjrsn5ILXvfBDPud4pYO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I claim, that there is a bug, that hopefully doesn't show itself apart
from a minor disabled optimisation. It's _too_ easy to misuse, and if
somebody try to reuse, this could lead to quite interesting issues.

Could somebody at last take a look?
Thanks

On 25/07/2019 00:35, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> There are implicit assumptions about struct blk_rq_stats, which make
> it's very easy to misuse. The first patch fixes consequences, and the
> second employs type-system to prevent recurrences.
>=20
> Acked-by: Josef Bacik <josef@toxicpanda.com>
>=20
> Pavel Begunkov (2):
>   blk-iolatency: Fix zero mean in previous stats
>   blk-stats: Introduce explicit stat staging buffers
>=20
>  block/blk-iolatency.c     | 60 ++++++++++++++++++++++++++++++---------=

>  block/blk-stat.c          | 48 +++++++++++++++++++++++--------
>  block/blk-stat.h          |  9 ++++--
>  include/linux/blk_types.h |  6 ++++
>  4 files changed, 94 insertions(+), 29 deletions(-)
>=20

--=20
Yours sincerely,
Pavel Begunkov


--iwCQfC1143W97Fjrsn5ILXvfBDPud4pYO--

--vpDpuljOak4VUjubg0p6HLJIDCCP6aiBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2RvOEACgkQWt5b1Glr
+6UKiBAAgW2BL4yvqLYVizbAQnkdFQG/KreGrf5vyKZhcv2UHjoMvO2EUQzpwX2v
FMaHbFAx5tOnjeoWmwXjYuAJLAnu3qT1+tGtVUFxWcDbyTnrnqAEMB9dItDr2Ga5
K6smdf9rZhnFufPiJfJ0dFqBlfqJ1YhY3L5PG8as5/9Um9B/JCCb0Hjft5yoG2Gs
lsVh+RFzw8hHSptJOru/Fz6oKVDiMloqRSCWhiS7hXquMUhcPusAJLzGPhQ8Kv7o
W8bZOcs99Ijp8Ye5xlgLtohBtpN1C/+ZFMHVxv4UH+JrPvwFzLDCD/mCfGLWTbUK
N8ypzi5AW4KmlBAbzUs8HjQk7FvswcazyWRRm9bg4JWEE1TLgUMrrWmUsHxLlnDO
knNWMjD9+PO7BrYtQm6OUX4+0Jz9wUtYBGSZF7IXLCutJ9/NloHRTFIQWXnp2NX8
WWhB1x590ljZ1REULO1312qztHOQyEOgI9vGV1jlMMQPp5RzRAHeJyC2Ay0JSt43
RZBkbjkG5tcSZ/atpzi/LhXW4PIN3IBvto9F1WYpf465ISjFhmHfEk7K+Tcfa+S1
QfHO3/t2dmFEH/2vm2/foff0av4HedV3gtulofAjpH7c4SVFWJGRjGDewrsap/C2
zMKGPSyJnh8D+boNOMkiLV8qI0juyFQD7MTybazl6u8vHqVssVQ=
=CxFQ
-----END PGP SIGNATURE-----

--vpDpuljOak4VUjubg0p6HLJIDCCP6aiBm--
