Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0516C278
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2020 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgBYNh2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Feb 2020 08:37:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:40678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYNh2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 Feb 2020 08:37:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B551AD3C;
        Tue, 25 Feb 2020 13:37:26 +0000 (UTC)
Date:   Tue, 25 Feb 2020 14:37:20 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200225133720.GA6709@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200221171256.GB23476@blackbody.suse.cz>
 <20200221185839.GB70967@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20200221185839.GB70967@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Feb 21, 2020 at 01:58:39PM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> When you set task's and logger's memory.low to "max" or 10G or any
> bogus number like this, a limit reclaim in job treats this as origin
> protection and tries hard to avoid reclaiming anything in either of
> the two cgroups.
What do you mean by origin protection? (I'm starting to see some
misunderstanding here, c.f. my remark regarding the parent=3D=3Droot
condition in the other patch [1]).

> memory.events::low skyrockets even though no intended
> protection was violated, we'll have reclaim latencies (especially when
> there are a few dying cgroups accumluated in subtree).
Hopefully, I see where are you coming from. There would be no (false)
low notifications if the elow was calculated all they way top-down from
the real root. Would such calculation be the way to go?

> that job can't possibly *know* about the top-level host
> protection that lies beyond the delegation point and outside its own
> namespace,
Yes, I agree.

> and that it needs to propagate protection against rpm upgrades into
> its own leaf groups for each tasklet and component.
If a job wants to use concrete protection than it sets it, if it wants
to use protection from above, then it can express it with the infinity
(after changing the effective calculation I described above).

Now, you may argue that the infinity would be nonsensical if it's not a
subordinate job. Simplest approach would be likely to introduce the
special "inherit" value (such a literal name may be misleading as it
would be also "dont-care").

> Again, in practice we have found this to be totally unmanageable and
> routinely first forgot and then had trouble hacking the propagation
> into random jobs that create their own groups.
I've been bitten by this as well. However, the protection defaults to
off and I find it this matches the general rule that kernel provides the
mechanism and user(space) the policy.

> And when you add new hardware configurations, you cannot just make a
> top-level change in the host config, you have to update all the job
> specs of workloads running in the fleet.
(I acknowledge the current mechanism lacks an explicit way to express
the inherit/dont-care value.)


> My patch brings memory configuration in line with other cgroup2
> controllers.
Other controllers mostly provide the limit or weight controls, I'd say
protection semantics is specific only to the memory controller so
far [2]. I don't think (at least by now) it can be aligned as the weight
or limit semantics.

> I've made the case why it's not a supported usecase, and why it is a
> meaningless configuration in practice due to the way other controllers
> already behave.
I see how your reasoning works for limits (you set memory limit and you
need to control io/cpu too to maintain intended isolation). I'm confused
why having a scapegoat (or donor) sibling for protection should not be
supported or how it breaks protection for others if not combined with
io/cpu controllers. Feel free to point me to the message if I overlooked
it.

> I think at this point in the discussion, the only thing I can do is
> remind you=20
I think there is different perception on both sides because of unclear
definitions, so I seek to clarify that.

> that the behavior I'm introducing is gated behind a mount
> option that nobody is forced to enable if they insist on disagreeing
> against all evidence to the contrary.
Sure, but I think it's better to (try reaching|reach) a consensus than
to introduce split behavior (maintenance, debugging).

Thanks,
Michal

[1] https://lore.kernel.org/lkml/20200221171024.GA23476@blackbody.suse.cz/
[2] I admit I didn't look into io.latency that much and IIRC
    cpu.uclamp.{min,max} don't have the overcommit issue.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl5VIwwACgkQia1+riC5
qSg1Fw//bVszZ/T8JtDrhpquRDNMB5s1WtL4D0yBcZ3SV24IpMMW83Hm5sRww4z2
BSfu0H5HcHy0zMmgd5MjxT6SJdQNlpa6aCmw4R4m3DaTv4Ygt2y/EYWAB29jK3S8
5DmClF3VJjDOPaGYRb7bNrawq93rWjXS4DcbsPyRM+GAnX+7fJRP3q4dUKuABlxI
h/GH2QtwGD9iWWResAmBEM/8YWkMFEpowZENLTzDiDVbYeF/PP9dqbUAWt+mwHDC
Rk6SxE0TlUio0LxdYVOlBP+PFRp9fIhHPJCZgs6qJgyW/nJ2YVxiaNkF57I4zWt2
lgTC6fXn9faO51uTV3b7damLC77fKPc35K1xK7s4dlUGS9Tw1uX8xqN3uD9Iyjrk
AQFwjkaNNj+/7asLJo9HyYwO7wByfMcDqEnlMJmyjynb5Pav39I2irQqMQsBpoou
bWqbeB/53S1FMkasqGhfTYsXcdjLgUtv2ot/vU0g6HiCsyqXTUaOZhPw43oodCUa
TYRubNo7y3Wx8PGTYxpGLE1esXS17EST6hsqv/ilm8Ss8Lu/kk7YXxOuDnYRFaAV
mqPMvXd60X6kXdGDhHlr2E4uoGg98B0R+6mUak6PbQm5/qow1/0wo1G9FnneIETR
bQaz4lNRZeqN6rzoNjUM+GTaMRY+dVgbHKOfiMbXud5w5xluCP0=
=7BYP
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
