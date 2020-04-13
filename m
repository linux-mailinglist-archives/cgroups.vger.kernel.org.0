Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A91A6AAD
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbgDMQ5g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732216AbgDMQ5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:57:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075EC0A3BDC;
        Mon, 13 Apr 2020 09:57:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so10842068wrt.7;
        Mon, 13 Apr 2020 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Xk2BsSDKDhxiXf1W9gwjsfp/DxSiKFq+bcaV0hQZsPk=;
        b=Ek6w3+2LwAgiEFDyJrzJ5+hBEeixOiDyTWppwlRHynKI7HKyY00VBh54AtmkM/tBT/
         HXgnDqaRJLaacub59m4ZAc8rIviUGL+EQAXy92qTwWo5CZ1vfpUeNZZX3/7Ide5puFIT
         Kg+AeTnkWlOwIFcQUYsUNJBC97RbveeDwLjyX18UgS+LAxOdjASYYAPjizDBWTIH22xy
         7a07z57tP6vAEbV8ngk8wuWHoAk6boUQQljYzOlGG/nbehfLgm0l0MTftg2tp45F1ECa
         vZCOtBbB/JbCFOrVcerRRIvoWd1SwAPF3IXGFk4hWVoh/d8+wEravjuDH/1xGD9lOvU7
         Z80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Xk2BsSDKDhxiXf1W9gwjsfp/DxSiKFq+bcaV0hQZsPk=;
        b=iAiGzkdhmhhel9FmT4nLQxL+oTsWZfpcICNezJkwc0EpiQS7KRjrwhsMOWeu7dkMmu
         wnDO6BBeD2dtqCuaSDlfgx16cd2A1/UCYQvRVG/whYw6XwZWurEeKXN1J7wQoImDe9KA
         mN72Wk6DFvuKDb/SFmE2CR9RjXkwd5dLidKmuT7zZLrcYpHW7Ch2z0gDUdlCVESLpS7H
         Yvv/kVEX805MtcD6i9Kt6TEJlkQ2J3ULwTXnJwSYpbvRTwACZRuYh8qyhsB4qRuS0IZj
         5xb18Y8t6qyibdnjVxB+uMh009WDjkFkug7ydPMRgF3CQHRGlHP7rEl0pN6/fWivW8Ao
         WqtA==
X-Gm-Message-State: AGi0PuaZZeVvDnAuC/Fxy9kPQxkyRIh2XmS9KoChRy5mVHExhWAnvP1O
        pCwbc9Q9dAnRJ0l+DcShYr2cC7eNwXU=
X-Google-Smtp-Source: APiQypISXbG9dV2fcRgzor6zakpBuK4UFfevcf7Gl4GEg01N/eKgMDCWdKixZp165gs6Dd+lmJyz5g==
X-Received: by 2002:adf:f750:: with SMTP id z16mr18108334wrp.115.1586797052925;
        Mon, 13 Apr 2020 09:57:32 -0700 (PDT)
Received: from [192.168.43.75] ([109.126.129.227])
        by smtp.gmail.com with ESMTPSA id d7sm15565513wrr.77.2020.04.13.09.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:57:32 -0700 (PDT)
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, ming.lei@redhat.com, bvanassche@acm.org
References: <20200413162758.97252-1-tj@kernel.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
Date:   Mon, 13 Apr 2020 19:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hFjuupwkWmuwpO9jhiJUUOPGSlwvofv9Q"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hFjuupwkWmuwpO9jhiJUUOPGSlwvofv9Q
Content-Type: multipart/mixed; boundary="naT5wF3ZYUQA1LjeTnwfcxF3ZNXqJImDO";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
 josef@toxicpanda.com, ming.lei@redhat.com, bvanassche@acm.org
Message-ID: <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
References: <20200413162758.97252-1-tj@kernel.org>
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>

--naT5wF3ZYUQA1LjeTnwfcxF3ZNXqJImDO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/04/2020 19:27, Tejun Heo wrote:
> Changes from v1[1]
>=20
> * Dropped 0002-block-add-request-io_data_len.patch and updated to use
>   rq->stats_sectors instead as suggested by Pavel Begunkov.

rq->stats_sectors is set only when there is QUEUE_FLAG_STATS, see
blk_mq_start_request(). I don't see blk-iocost requiring it. Did I miss s=
omething?

>=20
> This patchset improves the following two iocost control behaviors.
>=20
> * iocost was failing to punish heavy shared IO generators (file metadat=
a, memory
>   reclaim) through use_delay mechanism - use_delay automatically decays=
 which
>   works well for iolatency but doesn't match how iocost behaves. This l=
ed to
>   e.g. memory bombs which generate a lot of swap IOs to use over their =
allotted
>   amount. This is fixed by adding non-decaying use_delay mechanism.
>=20
> * The same latency targets were being applied regardless of the IO size=
s. While
>   this works fine for loose targets, it gets in the way when trying to =
tigthen
>   them - a latency target adequate for a 4k IO is too short for a 1 meg=
 IO.
>   iocost now discounts the size portion of cost when testing whether a =
given IO
>   met or missed its latency target.
>=20
> While at it, it also makes minor changse to iocost_monitor.py.
>=20
> This patchset contains the following five patches.
>=20
>  0001-blk-iocost-switch-to-fixed-non-auto-decaying-use_del.patch
>  0002-blk-iocost-account-for-IO-size-when-testing-latencie.patch
>  0003-iocost_monitor-exit-successfully-if-interval-is-zero.patch
>  0004-iocost_monitor-drop-string-wrap-around-numbers-when-.patch
>=20
> and is also available in the following git branch.
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-del=
ay-latency-v2
>=20
> diffstat follows. Thanks.
>=20
>  block/Kconfig                  |    1=20
>  block/blk-cgroup.c             |    6 ++++
>  block/blk-iocost.c             |   56 +++++++++++++++++++++++++++++---=
---------
>  include/linux/blk-cgroup.h     |   43 ++++++++++++++++++++++++-------
>  tools/cgroup/iocost_monitor.py |   48 +++++++++++++++++++-------------=
---
>  5 files changed, 106 insertions(+), 48 deletions(-)
>=20
> --
> tejun
>=20
> [1] http://lkml.kernel.org/r/20200408201450.3959560-1-tj@kernel.org
>=20

--=20
Pavel Begunkov


--naT5wF3ZYUQA1LjeTnwfcxF3ZNXqJImDO--

--hFjuupwkWmuwpO9jhiJUUOPGSlwvofv9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl6Umb8ACgkQWt5b1Glr
+6UL3Q//cYxPSPCP602xbhfwteRZw+0SsyigabnibOPeoindiN7zG1pRZqRqVdBA
s0H7GfBW8f+DhVSPlgKYSYu4XQMwLRo1/adRJMeLtRvNh8b0CCdENXafKcMty5hK
y0r9/PeMV/xlYb+aRUYFVwwMfX/B35nPnJ0NydCZz6ZYRFgkFz/27YppfsZY1tyk
SBj+jWmBZgGmQoqoPwoCF8HN0KVb/8UIfx3be5b3KGAaB+pcYz26MJjKFufwap6r
31oNhC3GcXSR5GrlsJauwYB5641H3IdP+1a4jg6cvrGN0+h/THVB98JwgImmz6WJ
tWe6uiYXvDCrSdC9QNIJqIv3FiXaF/8pJMv4utJICPcB5xkq0cvz1yx+Zdca6o0b
ybD/7AAcXMOaWbKYxffji/jpChJM0kPdUhDNr79MLoNr7fUusoocxRmPwkWG+jBe
by8O/pGMsKOz3JXELwtWysQy0y/HqQSVYW8x58tdKXj0ACxSKwJqAgDzS5xdOJ1Y
qgauGp4Kx3SwvE0oqV0bC5TKXVxS0q1PCg1XTKicnT7QjQqXYYJdZLf2PkDlqmEE
Ug0P0dfH/ucNAXtv6lz/xfIgvfJnOtg+AHTBE1ol3gSRRbGccCVmrAxwYVcO+wFQ
fVayxegf7IY55PMAPMuNMVCovTih6+DgOgOnc3czO3Y0mi3MYzI=
=D3I7
-----END PGP SIGNATURE-----

--hFjuupwkWmuwpO9jhiJUUOPGSlwvofv9Q--
