Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF0EC676
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2019 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKAQPz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Nov 2019 12:15:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbfKAQPy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 1 Nov 2019 12:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E53BB533;
        Fri,  1 Nov 2019 16:15:51 +0000 (UTC)
Date:   Fri, 1 Nov 2019 17:15:06 +0100
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
Message-ID: <20191101161506.GA28212@blackbody.suse.cz>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <20191003145106.GC6678@blackbody.suse.cz>
 <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
 <20191009153629.GA5400@blackbody.suse.cz>
 <20191014153643.GD18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20191014153643.GD18794@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

(I realize it's likely late for the remark but I'd like to bring it up
anyway.)

On Mon, Oct 14, 2019 at 08:36:43AM -0700, Tejun Heo <tj@kernel.org> wrote:
> We likely can talk on the subject
> for a really long time probalby because there's no clearly technically
> better choice here, so...
I agree with you that functionally the two options are equal and also
=66rom configuration POV they seem both sensible.

I checked where BFQ stores its per-device parameters and its under the
sysfs directory of given device's iosched directory. So from the user
perspective it'd be more consistent if all similar tunables resided
under that location.

(OTOH, I admit I'm not that familiar with block layer internals to
identify the overlap between IO scheduler and IO controller.)

> Yeah, it's kinda unfortunate that it requires this many parameters but
> at least my opinion is that that's reflecting the inherent
> complexities of the underlying devices and how workloads interact with
> them.
After I learnt about the existence of BFQ tunables, I'm no longer
concerned by the complexity of the parameter space.

Thanks for the explanations of QoS purpose.

> For QoS parameters, Andy is currently working on a method to determine
> the set of parametesr which are at the edge of total work cliff -
> ie. the point where tighetning QoS params further starts reducing the
> total amount of work the device can do significantly.
The QoS description in the Documentation/ describes the interpretation
of the individual parameters, however, this purpose and how it works was
not clear to be from that. I think the QoS policy would deserve similar
description in the Documentation/.

> Nothing can issue IOs indefinitely without some of them completing and
> the total amount of work a workload can do is conjoined with the
> completion latencies. [...]
I may reply to this point later. However, if that provably works, I'm
likely missing something in my understanding, so that'd be irrelevant.

Cheers,
Michal

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl28WgQACgkQia1+riC5
qShQKA/7BT64RM/e1xU73WG0TsdQ1By8FWwkm/pwmasQzFiWE2gbCKdVx7FOdoR7
m1cyKkl1tWef4uJGy788zwruYfliudpgN4juB0qDBMXfX+FIMOcIkbfbsXYf7qSy
S3iIUP5p0sidWswOeK/fEwXKDEDzmZGqxqHiRiLYyoXE1gGsf6wH2HCy+S5fOC8K
EEiCk3c4EzG2cX6gQa1nuhXIYhGASZXpVGwfyFi9O6cYZmzuEyj26k2YjnZsmWp9
i8uqcOrTOCYV36nP5YJyfKKhfx0UlpGKFk90z9LGagKEhbD2Ht3xgYugJJCrem4C
OS7tJWWWaycZ/uli5InGk5X/lGMp514FY1ARNyA0/HavLI5eqTDkvf2b2EP+yoRH
bwnPh/YeYyPjMQJ+ONfdV1iC5pGIYsGC20jOQz4QY9QRkjbKwMLLacYHoCSDIRxg
BLgwf35pxzXJfxQc8iEdoSz1Ii6yKOZGDN+5C4yUV/1qDSG4j4DvAfY+71oc34is
HvZBattBqurPSH8f4DMg9zB6KaU/JAWrg0m/sUxDXSbu3pit7R/L/PVP+Kljhsf5
vmQf6n3e4wcU93S7hCCLPA0CWMQLgn/PIgDBKUIJP6eP6CAV4NKkK7xY/ZjViduI
DlKBVs30QYjqG4xx5oZCyzmiA7Q96q3vMtzR6tevrTD6tSyf08g=
=0UBH
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
