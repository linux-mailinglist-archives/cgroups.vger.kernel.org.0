Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7F120ECF
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfLPQHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 11:07:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:41792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLPQHJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Dec 2019 11:07:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6481BB1F6;
        Mon, 16 Dec 2019 16:07:07 +0000 (UTC)
Date:   Mon, 16 Dec 2019 17:07:04 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v5] mm: hugetlb controller for cgroups v2
Message-ID: <20191216160704.GE20677@blackbody.suse.cz>
References: <20191213102808.295966-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20191213102808.295966-1-gscrivan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guiseppe.

Thanks for incorporating the changes.

On Fri, Dec 13, 2019 at 11:28:08AM +0100, Giuseppe Scrivano <gscrivan@redha=
t.com> wrote:
> @@ -202,8 +234,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned l=
ong nr_pages,
>  	}
>  	rcu_read_unlock();
> =20
> -	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
> +	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
> +				     &counter)) {
>  		ret =3D -ENOMEM;
> +		hugetlb_event(h_cg, idx, HUGETLB_MAX);
Here should be something like

-		hugetlb_event(h_cg, idx, HUGETLB_MAX);
+		hugetlb_event(hugetlb_cgroup_from_counter(counter), idx, HUGETLB_MAX);

in order to have consistent behavior with memcg events (because
page_counter_try_charge may fail higher in the hierarchy than h_cg).

Michal

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl33q6EACgkQia1+riC5
qSgBhg/+PLDf13HE/4At7Gk2B08oBZYAbtwOALIdy+6a3p1sU16kfdw9xbnCX4aq
4j4t1U7qV+3FGTYM5NpGHKpS09FD0y0qnxOQ0jvouZorST2P7wBOBdkHVzMHqiVY
1UKVpsKNmLfgIxA8z5kUXEPVrBYxsr4rZxK01kZMZK4eGjLVsWJd/Bvtb9IlPssJ
nWbPR6U7tT7ze0E9DBLpEp7Ng2LFrb2bfv+aJ0oKzj0RKC2eD41KVQTqFdRQVTd2
3dj66Wmg8+N61447YSENdrWJQ4Wv9bTh1rMYgyqlCucZrkEZ2Znsz1fWYnWlIU9b
Ys6ZMFpapDhoXD8mxfbRXDgLROhLotFUVIjcISwZ+QOIFiohRjSqplQJ+mNH0bSR
MS2mlUwOHESgJA+hxzHpShirBEAwPsCRIEohDfNnwrvlr273gRcYQImbYPXA+Ics
U95bG+jm9Cv4Uq83UHvhzeUAW3NnTy1PfcPkjS39rZ0LAgp8EE1VJk7n6VyUcPQD
o4WxQWBPWwbnBbx5/TaWGniv2uutiuvfELW1lDVYbUmipcgHU/AdWb+csc+X9fUE
WqHkAN2r+AnlC7kxM0K09kUfdE2w7aIO1KgcMu0gBvxX8Wwi65TgSRpSc4N0jMEo
DwW2Vqh+14aljZ5YhAIEpcoRILX8S4PK7khFRwZzhnLDxue09ik=
=kOql
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
