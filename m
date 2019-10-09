Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB3D12E1
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfJIPgg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 11:36:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730503AbfJIPgg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 9 Oct 2019 11:36:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA13FAD49;
        Wed,  9 Oct 2019 15:36:33 +0000 (UTC)
Date:   Wed, 9 Oct 2019 17:36:29 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, clm@fb.com, dennisz@fb.com,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        newella@fb.com, lizefan@huawei.com, axboe@kernel.dk,
        Paolo Valente <paolo.valente@linaro.org>,
        Rik van Riel <riel@surriel.com>, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20191009153629.GA5400@blackbody.suse.cz>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <20191003145106.GC6678@blackbody.suse.cz>
 <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 09:45:52AM -0700, Tejun Heo <tj@kernel.org> wrote:
> [...] but the qos file gets weird because the content of the file is
> more resource control policies than device properties.
I see two facets on this -- the semantics of the QoS controls and
storing controller parameters generally.

Because I'm not fully convinced using the root cgroup for the latter is
a good idea and I don't have a better one (what about
/sys/kernel/cgroup/?), I'd like to question the former to potentially
postpone finding the place for its parameters :-)


On Wed, Aug 28, 2019 at 03:05:58PM -0700, Tejun Heo <tj@kernel.org> wrote:
> [...]
> Please see the top comment in blk-iocost.c and documentation for
> more details.
I admit I did't grasp the explanations in the cgroup-v2.rst, perhaps
some of the explanations from blk-iocost.c would be useful there as
well.

IIUC, the controls are supposed to be abstracted and generic to express
high-level ideas and be independent of particular details.
Here a bunch of parameters is introduced whose tuning may become a
complex optimization task.

What is the metric that is the QoS controller striving to guarantee?
How does it differ from the io.latency policy?


> [...]=20
> + * 2-2. Vrate Adjustment
> + * [...] When this delay becomes noticeable, it's a clear
> + * indication that the device is saturated and we lower the vrate.  This
> + * saturation signal is fairly conservative as it only triggers when both
> + * hardware and software queues are filled up, and is used as the default
> + * busy signal.
(The following paragraph is based only on na=EFve understanding of the
block layer.) So the device's vrate is lowered, causing its vtime
growing slower, i.e.  postponing issuing an IO later for all cgroups
accessing the device. But what's the purpose of this? If the queues fill
up, wouldn't be all naturally pushed back by the longer queue time
anyway? And wouldn't slowing down the device's vtime just cause queueing
elsewhere?

Thanks,
Michal

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2d/nUACgkQia1+riC5
qSgceA//QDkptfj5otDY4KHhLNVykDf/CbJN9RXtXKVybJ+GMFUF0hZqur090XJ/
OIy+rmh6WXf6HEislGKoc9UvRxko+6jxteR1ROd9b9S4tzQib1vJ8i2euw61uO8U
PLhkmGGU7vXvMwdI07vrmfI7XnrCH7cC1gAVkZ25m7NPwDGTq55h0h9FZDhcyJWL
PI66dmr5yJnfV6W+A/JmlzUV0s7D2h9KFiPm1wxtxQaCacsN5A54OyqMvgJ+W1WM
5+udGwMol41ukl9VeHQEhrsx0gRFwIzP6P/zS4tGiFmxyPEGkH6o+nXSUKdOAm6I
91Z7bCI6dFVZHAA4BXzpEpMQAQADk654H3OPhxxKrb9jtPMm+SoC7Ch87bbb0uc3
8WfjMl4DNaEroncGCFEI/i5YfA/8hh9yRktC0SZ3KKDMm/Ne4P0PPtK25JTjRynM
2T030Z2RGSs0EjBw4e/6mhsb4NpuQczoQ4bMKxFDj13gX2myWwxKuBz5BBfi8npl
u/z6RDT1DVekTBHGE3tycDdwzFFZ7iXLgjJMQpQK+nyZIk3/dHqrSF0QDhz6dST4
rLUbzAzhATbDMGIswWvl57/CloudeL9oSev6HFCNGnhL4yMp2ue0RkGG1vTaNLgy
3VKYlosU7zWHM8sSj+3/dxLVZAaHT85veMWUjdv9l8x8jAD/snc=
=JD5Q
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
