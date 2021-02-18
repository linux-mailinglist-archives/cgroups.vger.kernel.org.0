Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6331ECDA
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhBRRGg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 12:06:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:52952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhBRPqC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 10:46:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613663113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kndRiznQhLZKdWjvHBON40ykfoLHDXlmWt2IkZM5PBU=;
        b=c/Ju6GZd7mODmFOw0RU+s3Te8Rj6FISqx3vLAeSpNv+lm8vJob7on1EyKZCeD86O5KSxzW
        B5wEAEdwPrXvyqEfYIg2Wgaug4Q3XAByoUNxJ7AZsk+bfOKK8GorHWXhGXQMDv5p9QMlNK
        JsjZGrpqYhvgKCMZjE/nCTSfaAkF2lY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52075ADDB;
        Thu, 18 Feb 2021 15:45:13 +0000 (UTC)
Date:   Thu, 18 Feb 2021 16:45:11 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 4/8] cgroup: rstat: support cgroup1
Message-ID: <YC6Lh8BRfMA2Ppdk@blackbook>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-5-hannes@cmpxchg.org>
 <20210217174232.GA19239@blackbody.suse.cz>
 <YC2CKyaeF2bqvpMk@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xS+is/W892RytHV4"
Content-Disposition: inline
In-Reply-To: <YC2CKyaeF2bqvpMk@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--xS+is/W892RytHV4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2021 at 03:52:59PM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> It's possible, but I don't think worth the trouble.
You're right. I gave it a deeper look and what would be saved on data,
would be paid in code complexity.

> In this case, we're talking about a relatively small data structure
> and the overhead is per mountpoint.
IIUC, it is per each mountpoint's number of cgroups. But I still accept
the argument above. Furthermore, this can be changed later.

> The default root group has statically preallocated percpu data before
> and after this patch. See cgroup.c:
I stand corrected, the comment is still valid.

Therefore,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--xS+is/W892RytHV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAui4cACgkQia1+riC5
qSiJ4w/8DUxQueOw6E/q3wd6I9lRyh4brtboIOu0xAz+2INf5BsbykFQJEEIoAA+
nsM+ICp+et0ABUMFGA34a3+vX0dOb2IkF84foWIIqnR683/gjF+tiQJrmbZBztBP
R5MnPRKG/R2JtJer/q4SFDGtBblFUr78Y56k7mO2lbXCeHvkAJLMit6VfQZAmS6R
BWbTTWJQov5DWTA0gtfWM5vXIe0sFkiJKz2oi6xHiKBIuUrISGGrpMzlxOP0abpU
Gm1/IVaspHWJ0LB6XFjU0KnjpW1WJVQKEmg5pecEL5M5V01Bc0sA+s2F/XDq/beZ
8MUdVgw+le4omSkvi3rjpX5Pk006SEJfOYpB+/m9fRA23yC1zYLLPvoimHHGS7Ir
QMLkVfozsOWqMpTSdWO9eKIFFt1FL7S4kaR5cWxI4gbvJDR89t9Q6do16+jP4FGM
mWb47ipEwi/52Ib6YxYosV9MIqpSpfa6bQYkCHdj4mRoot+HwfWthOnV3PKUaGzT
XWJVh9UWac6rydWCi5j0L865dZrDMeGT8xYmOx1Dm7AfrDyNXpJGoTb+n4rn+nw9
lGETsYGzcIhRDU2vILI5MaROqjfn2ZU1bIKQRUCmhpYqF5Fa3Ejglzdy2MM/hfd3
SIx50o61u3w6k10SzaS3mjPu6ROBhtLTXhU2e+pmfY84qJLRdW0=
=H1Nj
-----END PGP SIGNATURE-----

--xS+is/W892RytHV4--
