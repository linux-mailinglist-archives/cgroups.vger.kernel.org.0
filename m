Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2761BAEAE7
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbfIJMzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 08:55:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730525AbfIJMzX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Sep 2019 08:55:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2174B8EF;
        Tue, 10 Sep 2019 12:55:20 +0000 (UTC)
Date:   Tue, 10 Sep 2019 14:55:14 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, clm@fb.com, dennisz@fb.com, newella@fb.com,
        lizefan@huawei.com, axboe@kernel.dk, josef@toxicpanda.com,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20190910125513.GA6399@blackbody.suse.cz>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20190828220600.2527417-9-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Aug 28, 2019 at 03:05:58PM -0700, Tejun Heo <tj@kernel.org> wrote:
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> [...]
> +static struct cftype ioc_files[] = {
> +		.name = "weight",
> [...]
This adds the generic io.weight attribute. How will this compose with
the weight from IO schedulers? (AFAIK, only BFQ allows proportional
control as of now. +CC Paolo.)

I see this attributes are effectively per-cgroup per-device. Apparently,
one device should have only one weight across hierarchy. Would it make
sense to have io.bfq.weight and io.cost.weight with disjunctive devices?

(Alas, I have no idea how to make the users of io.weight happy, when
proportionality control mechanism seems orthogonal to the weight.
(Vector weights?))


> +		.name = "cost.qos",
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> [...]
> +		.name = "cost.model",
> +		.flags = CFTYPE_ONLY_ON_ROOT,
I'm concerned that these aren't true cgroup attributes. The root cgroup
would act as container for global configuration options. Wouldn't these
values better fit as (configurable) attributes of the respective
devices?

Secondly, how is CFTYPE_ONLY_ON_ROOT supposed to be presented in cgroup
namespaces?

Thanks,
Michal

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl13nSUACgkQia1+riC5
qShK8w//Q7gh2wjcYmn/uuKlxF40/MhRa8LwT9aDjZp3gEiRmMQbHUHpx3Td5aAl
nPOQEp/W2sucYziohHPIokkeXIx+RwJliOEYfOCP+47ZOtWpeBXe6bTfmeRe87Ak
xSZ6M3ibr2Y4mNLdcvjSzSeh1T0qAha9B5DBEuK7C4xqK45DKSekLjVmd9jd71cE
CoYm56fVYZpDcYAHdTW7kjMie85QTLbiEY0WsuC563fxAoHDBZCDReIEtuAeMMog
lgOgBquPb6OCObzkE9CYMSroWMCRPkq2F9BTnk85fnpXkeQeE1cP8FbFt8CXGSh2
wsaz3dP8z7TAkUHRGySQiqaxsWDKRh/6KBk8Lv/wxffF3nSGLXuHC8tKcQIWHP45
y+e6utaK47XA7JDZcXObloE200Vpko5MhYM6vKsUYNDQ8BQjew/+xs5aYdU7yO/z
RtstUYBwgH6WWufm7D4yezdWGaJCZCuqtd46hy9vz8sJpm7iuJFbQdIQRD9z4kSf
NieSVJLSO3p6QJVYOdbtN1xzEEz1Qm8UJaHcgyjaUckKVjnkB7UWe/U5wj7D+b5R
sI0i0ACF6fdMsM0UnVArg4usmuFcwhO7NkngLrY85c6UTP75At+FhmTRJA3ZaIXI
l3T8OtIYNXt3+PBYIGwcPHLDa+HbPOToKpeP6ePE1r9ZzSV8bzI=
=VCDP
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
