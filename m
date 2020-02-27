Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813B31718CC
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgB0Nfv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 08:35:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgB0Nfv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 Feb 2020 08:35:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07DEBACF2;
        Thu, 27 Feb 2020 13:35:48 +0000 (UTC)
Date:   Thu, 27 Feb 2020 14:35:44 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200227133544.GA20690@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200221171256.GB23476@blackbody.suse.cz>
 <20200221185839.GB70967@cmpxchg.org>
 <20200225133720.GA6709@blackbody.suse.cz>
 <20200225150304.GA10257@cmpxchg.org>
 <20200226132237.GA16746@blackbody.suse.cz>
 <20200226150548.GD10257@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20200226150548.GD10257@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

TL;DR I see merit in the recursive propagation if it's requested
explicitly (i.e. retaining meaining of 0). The protection/weight
semantics should be refined.

On Wed, Feb 26, 2020 at 10:05:48AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> They still ultimately translate to real resources. The concrete value
> depends on what the parent's weight translates to, and it depends on
> sibling configurations and their current consumption. (All of this is
> already true for memory protection as well, btw). But eventually, a
> weight specification translates to actual time on a CPU, bandwidth on
> an IO device etc.
>=20
> > - sum of sibling weights is meaningless (and independent from parent
> >   weight)
>=20
> Technically true for overcommitted memory.low values as well.
Yes, but for overcommited only. For pure weights it doesn't matter if
you set 1:10, 10:100 or 100:1000, however, for the protection it has
this behavior only when approaching infinity and as the sum compares to
parent's value, the protection behaves differently.

[If there had to be to some pure memory weights, those would for
instance express relative affinity of group's pages to physical memory.]

> I don't see a fundamental difference between them. And that in turn
> makes it hard for me to accept that hierarchical inheritance rules
> should be different.
I'll try coming up with some better examples for the difference that I
perceive.

> "Wrong" isn't the right term. Is it what you wanted to express in your
> configuration?
I want to express absolute amount of memory (ideally representing
workingset size) under protection.

IIUC, you want to express general relative priorities of B vs C when
some outer metric has to be maintained given you reach both limits of
memory and IO.

> You are talking about a mathematical truth on a per-controller
> basis. What I'm saying is that I don't see how this is useful for real
> workloads, their relative priorities, and the performance expectations
> users have from these priorities.
=20
> With a priority inversion like this, there is no actual performance
> isolation or containerization going on here - which is the whole point
> of cgroups and resource control.
I acknowledge that by pressing too much along one dimension (memory) you
induce expansion in other dimension (IO) and that may become noticable in
siblings (expansion over saturation [1]). But that's expected when only
weights are in use. If you wanted to hide the effect of workload B to C,
B would need real limit.

[I beg to disagree that containerization is whole point of cgroups, it's
large part of it, hence the isolation needn't be necessarily
bi-directional.]

> My objection is to opting out of protection against cousins (thus
> overriding parental resource assignment), not against siblings.
Just to sync up the terminology - I'm calling this protection against
uncles (the composition/structure under them is irrelevant).
And the limitation comes from grandparent or higher (or global).

=2E..and the overriden parental resource assignment is the expansion on
non-memory dimension (IO/CPU).

> Correct, but you can change the tree to this:
>=20
>      A.low=3D10G
>      `- A1.low=3D10G
>         `- B.low=3D0G
>         `- C.low=3D0G
>      `- D.low=3D0G
>=20
> to express
>=20
> A1 > D
>  B =3D C
That sort of works (if I give up the scapegoat). Although I have trouble
that I have to copy the value from A to A1, I could have done that with
previous hierarchy and simply set B.low=3DC.low=3D10G.

> That is, I would like to see an argument for this setup:
>=20
>      A			=09
>      `- B		io.weight=3D200          memory.low=3D10G
>         `- D		io.weight=3D100 (e.g.)   memory.low=3D10G
>         `- E		io.weight=3D100 (e.g.)   memory.low=3D0
>      `- C		io.weight=3D50           memory.low=3D5G
>=20
> Where E has no memory protection against C, but E has IO priority over
> C. That's the configuration that cannot be expressed with a recursive
> memory.low, but since it involves priority inversions it's not useful
> to actually isolate and containerize workloads.
But there can be no cousin (uncle) or more precisely it's the global
rest that we don't mind to affect.

> > I'd say that protected memory is a disposable resource in contrast with
> > CPU/IO. If you don't have latter, you don't progress; if you lack the
> > former, you are refaulting but can make progress. Even more, you should
> > be able to give up memory.min.
>=20
> Eh, I'm not buying that. You cannot run without memory either. If
> somebody reclaims a page between you faulting it in and you resuming
> to userspace, there is no forward progress.
I made a hasty argument (misinterpretting the constant outer reclaim
pressure). So that wasn't the fundamental difference.

The second part -- memory.min is subject to equal calculation as
memory.low. Do you find the scape goat preventing OOM in grand-parent
(or higher) subtree also a misfeature/artifact?

Thanks,
Michal

[1] Here I'm taking your/Tejun's assumption that in the stressful
situations it always boils down to IO, although I don't have any
quantitative arguments for that.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl5XxaoACgkQia1+riC5
qSjXEQ//TtmVFOz0YQtWrE6vuUDuj2qcbjpq+VB45p3A20Bei67TizG13W6pTaEn
qcib274NCR0DUuErWqn8jB6R6UuUgwQCTiJpRLs2Dr/ehrR8evKri8YrBxCoT31p
3+PDtyM3CkPk1BtCx6rqVe81jyDBXyYH2pyolBcegzGI9L9WYDFQFtVjO3fboYoQ
afmZpFH6J1aQ9aaCZK7fAZ1adE3PuEd1IuWC2T7KYMfpc0Mmb++SGoC/OXqdrY/Y
dPMOiBN6D+h8u3J4fPj896Qz3Ag4Gyj9CdAe7uSlMfZ79++6jjNJa8jR9ZFLXNOz
IJnhKI5gdBfy/7khsOmdSMqFHPi3Uy0kxeJ+VDYsxaphJrDu+6AYAW7L7nv5DOoK
AJYKc2Iri2LOU+KJA+pa24J7R+zUVpb1nHMJ2d6+6YrbG/DpAof/Zroqert4eB+I
p5kpWYw+08tiptqLXzwbtTSWsYgZe+iPL/mNfDoPxjQbycG4PiMu2SjeVcbZKrrB
8oJ6csaPyREUB69F6ADv+1kUIbFlYkTNrtEw4DhR7POJaeGr+Hl7FZElz/v0oP5T
zSaW2RgZYtk6/zxIvYoPbKjg3ZOh7c5QkUIVJEfPlDP7Ecppw57StIoV/a0FElQW
S36n+nYaL+mAZVcCAUnt60A5crbRwVnk5xfhChK1dnAiiLCHYdI=
=KqDG
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
