Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01760A645D
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfICIw7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 04:52:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbfICIw7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Sep 2019 04:52:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AF34B807;
        Tue,  3 Sep 2019 08:52:57 +0000 (UTC)
Date:   Tue, 3 Sep 2019 10:52:48 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v14 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190903085248.GB8756@blackbody.suse.cz>
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
 <20190822132811.31294-2-patrick.bellasi@arm.com>
 <CAJuCfpGWtrg02LNE3PJZag9-LLVT=by2v+9x_tm1PyoXwZ8DqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <CAJuCfpGWtrg02LNE3PJZag9-LLVT=by2v+9x_tm1PyoXwZ8DqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 04:02:57PM -0700, Suren Baghdasaryan <surenb@google=
=2Ecom> wrote:
> > +static inline void cpu_uclamp_print(struct seq_file *sf,
> > +                                   enum uclamp_id clamp_id)
> > [...]
> > +       rcu_read_lock();
> > +       tg =3D css_tg(seq_css(sf));
> > +       util_clamp =3D tg->uclamp_req[clamp_id].value;
> > +       rcu_read_unlock();
> > +
> > +       if (util_clamp =3D=3D SCHED_CAPACITY_SCALE) {
> > +               seq_puts(sf, "max\n");
> > +               return;
> > +       }
> > +
> > +       percent =3D tg->uclamp_pct[clamp_id];
>=20
> You are taking RCU lock when accessing tg->uclamp_req but not when
> accessing tg->uclamp_pct.
Good point.

> Is that intentional? Can tg be destroyed under you?
Actually, the rcu_read{,un}lock should be unnecessary in the context of
the kernfs file op handler -- the tg/css won't go away as long as its
kernfs file is being worked with.


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl1uKdYACgkQia1+riC5
qSjfnQ/7BeUT18FFFi99Yyw3HCELlyDCFeWq85E5tsiLPEIlUV0DWFe5st1TugIz
RUQBMlHdM4UsgbRX8J//envlsT6aFD4ZMNp9LdYAK/PUMo8b68B63vsBBNLVfCNm
ayv6/oowRNcbo4c3NQ2V5eiIt/X8V4JWQHRr4IpM+U6DwmWBQ9hpsKH7yXlcHYQv
px/as6LKBxDtpURI4SUTm8sva7roOi1uixZ25BwPurRDisZlY990IGClMtOsW3S8
Ik59LppHO1YHee5B+ifFdPvmqvv3QdJVOjQBL050MdLPS6advmVSvmt/GRSr1MAa
kj7c8reeTo1jlHO9YmT2qqt+vsxfYMJxudnujXnQ5FZI60ibhSbLclDiEsc8028r
HpNJFNFkTZiURjJd39wJr3zSuXoFafIkc24s4QYDywHoSajloMc9xrqUTv3z+pdW
fhSdekB+3paS04Hesmnr4rV6a6Uo6hYatSEADG3XFbIv5TEBLOXK6bYv/KMKLj8X
98U43Ude0YmGi/B3HH6UYJFbXqrU5kBhlD/3S/RwF/NBhwPJM8bSZmzVJhWvXVDw
0DAcrfxiexS7Pp4kG2BFXlUGyTkN+2DRi+3ymiSW4y2+5DuYDvStFBw7Ud7eQZzN
YkkBGQzTAmUzb0wpHOHhQ3diiq914WViZpwSuxVZ7FNaJgdGe3s=
=B4jM
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
