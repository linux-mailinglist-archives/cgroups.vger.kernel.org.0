Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739ED11008C
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCOqH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 09:46:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfLCOqH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Dec 2019 09:46:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7067BB3E5;
        Tue,  3 Dec 2019 14:46:05 +0000 (UTC)
Date:   Tue, 3 Dec 2019 15:46:02 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
Message-ID: <20191203144602.GB20677@blackbody.suse.cz>
References: <20191127124446.1542764-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20191127124446.1542764-1-gscrivan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Nov 27, 2019 at 01:44:46PM +0100, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.events
Just out of curiosity (perhaps addressed to Mike), does this naming
account for the potential future split between reservations and
allocations charges?


> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> [...]
> -	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
> +	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
> +				     &counter)) {
>  		ret = -ENOMEM;
> +		cgroup_file_notify(&h_cg->events_file);
> +	}
Two notes to this:

1) Is that on purpose that the events_file (and hence notifications) are
shared across various huge page sizes?

2) Note that page_counter_try_charge checks hierarchically all counters
(not just the current h_cg's) and the limit may also be hit in an
ancestor (the third argument). I.e. the notification should be triggered
in the cgroup that actually crossed the limit.

Furthermore, the hierarchical and local events. I suggest looking at
memcg_memory_event for comparison.

If I take one step back. Is there a consumer for these events? I can see
the reasoning is the analogy with memcg's limits and events [1] but
wouldn't be a mere .stats file enough?


Michal

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3mdSUACgkQia1+riC5
qSi4FQ/6AmVXKsiXrPTZi6eddz5knKiEFqvat7K7GDIWWdrMURm4f2VOLDR97pZy
7QX7yxlMNwNYEZg9kr+YWsinLS3vu+uFUNrlDe5qQKeOLD7Cas+xpPljmpTCb1CG
NGMS4ZvadRs/crx25rRBpr5jeuCgQ1E3Wz9rI02vjSlKigQBNWj08dwqzl+jIbXy
TR+jj8FYVOllU68ysdETRPDzLg7Hk4WOsEk8hxcH3yyl4kiZ6+d6bNSvUAYi7Dbb
3ijzQ3wXGYjT1pSvq5j9Gcv1JkBP06y/oxuVyog1shRyR6I5YPOQtEjasFPvlt22
TfFtpXtqOjlkeQP1Hx7jJ2Yr20KOAJTstitsN7QvOQFG+FSO4037B6mBfvRYHfTu
3ju1PP+ZiOBaC9j1u/I+mB93sydbihzB7ifP1J8N+0KU1HV8sa9LJukBb9Ul8NY5
9mGpj3ppnJZpaMO3RqShOO8G98Nu/lhUy/z9RcA/AXW0lMGHWoYKW4LsSFHB0ZkP
GhmjKiGrzX0H0h145FcHOZAuc5XOYQv1bvNZx6+8bF6GuYXrhKHiffbZZyU6qtp8
K1oQWFwod7kmN5h1LyZ06zafCe3kklwoohS7JzoLn/d0fV4egp8N0EntytNzjYxt
DbHKGhxuvb1Sd+YiisVS2xAu0NQynqYF9QCtcGSSwbtqKG9452Y=
=lIVH
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
