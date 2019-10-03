Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A5CA09E
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2019 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJCOvM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Oct 2019 10:51:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:42266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729373AbfJCOvM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 3 Oct 2019 10:51:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFCF6B186;
        Thu,  3 Oct 2019 14:51:09 +0000 (UTC)
Date:   Thu, 3 Oct 2019 16:51:06 +0200
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
Message-ID: <20191003145106.GC6678@blackbody.suse.cz>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi (and apology for relatively late reply).

On Tue, Sep 10, 2019 at 09:08:55AM -0700, Tejun Heo <tj@kernel.org> wrote:
> I can implement the switching if so.
I see the "conflict" is solved by the switching.

> Initially, I put them under block device sysfs but it was too clumsy
> with different config file formats and all.
Do you have any more details on that? In the end, it all boils down to a
daemon/setup utility writing into the control files and it can use
whatever config files it decides, can't it?

> I think it's better to have global controller configs at the root
> cgroup.
I agree with the "global controller" configs, however, does it also hold
for "global controller per-device" configs? They seem closer to the
device than the controller. Potentially, the parameters could be used by
some other consumers in the future. (I'm not opposing the current form,
I just want to explore the space before an API is fixed.)


> Not at all.  These are system-wide configs.  cgroup namespaces
> shouldn't have anything which aren't in non-root cgroups.
Thanks, I understand the cgroup namespaces are not meant to be
transparent to their members.

Michal

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2WCtEACgkQia1+riC5
qSjb7A/+Iu+DwJIFVlA9ZTOkLBRLqBGA/Pca0wmt9zzvp+FOD10oV0eIcqC1rAt6
RkQuosEn/7JRJ9Kk0XD/Add4ztMKQsYQMrvVTQwefwpbCudSzQ5Fc170yyo86qed
6h40X+Y3l0NWQP5KKCNVtmboVaj7uiesPAOOzCyAgMfjvswg46vP1VxESys5DIhG
r0WNGE6jUBrgbpYghS/lcP4DpLNVCpOqYYRiSEht+l17linh8CF/eTpeTE6idO7S
3Aox0WMDSZ0ckuCmzFBJdR1WFh6mhd6Ij5eavtHasYsuJ/bjeDactxOua1mdpCGn
fIpN8gAny7BFNYVmPKKtFxKaImbc4tpFu0FB+JdZeWNEKSwhY19URZk/JdTEN6c9
u9jodAZXbCJ3jnj0M/2gAYMqR2hoW6bHYSQMj1mUy7TlWjxtKWzVdyZlNRejCp+9
hUes/fZy2di3u93OF9czgtKEKBbgb6Q/xdHHr7mcSE+OzxKZiKKFpzM8ZYTZ70T3
uYDo10yEJYFarwvW6JTHJYftMP5x7NQpJpFrMHEQWfOp+Vb2DwCcNtVEt9HL4OMQ
uDCG2p6LA6MUAW1NB7n8OkI9VXk88gSG7C0r/LSinq5NXaQ0ztw+sz9wk3XOFCjq
W4rQqKvckE/ME0N8IJCZbJUebVjhvGxFpgMgs123gDBVulQzl6U=
=cftV
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
