Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07D137A04
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2020 00:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgAJXQh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 18:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:42764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgAJXQh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 Jan 2020 18:16:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69E5FAC66;
        Fri, 10 Jan 2020 23:16:34 +0000 (UTC)
Date:   Sat, 11 Jan 2020 00:16:24 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        security@debian.org, Security Officers <security@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        james.hsu@mediatek.com, linger.lee@mediatek.com,
        Tom Cherry <tomcherry@google.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20200110231624.GA6557@blackbook>
References: <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190607170952.GE30727@blackbody.suse.cz>
 <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
 <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Suren.

On Fri, Jan 10, 2020 at 01:47:19PM -0800, Suren Baghdasaryan <surenb@google=
=2Ecom> wrote:
> > On Fri, Jun 07, 2019 at 07:09:53PM +0200, Michal Koutn=FD wrote:
> > > Wouldn't it make more sense to call
> > >       css_set_move_task(tsk, cset, NULL, false);
> > > in cgroup_release instead of cgroup_exit then?
> > >
> > > css_set_move_task triggers the cgroup emptiness notification so if we
> > > list group leaders with running siblings as members of the cgroup (IMO
> > > correct), is it consistent to deliver the (un)populated event
> > > that early?
> > > By moving to cgroup_release we would also make this notification
> > > analogous to SIGCHLD delivery.
> >
> > So, the current behavior is mostly historical and I don't think this
> > is a better behavior.  That said, I'm not sure about the cost benefit
> > ratio of changing the behavior at this point given how long the code
> > has been this way.  Another aspect is that it'd expose zombie tasks
> > and possibly migrations of them to each controller.
>=20
> Sorry for reviving an old discussion
Since you reply to my remark, I have to share that I found myself wrong
later wrt the emptiness notifications. Moving the task in cgroup_exit
doesn't matter if thread group contains other live tasks, the unpopulated
notification will be raised when the last task of thread group calls
group_exit, i.e. it is similar to SIGHLD.

Now to your issue.

> but I got a bug report from a customer about Android=20
What kernel version is that? Can be it considered equal to the current
Linux?

> In my testing I was able to reproduce the failure in
> which case rmdir() fails with EBUSY from cgroup_destroy_locked()
> because cgroup_is_populated() returns true.
That'd mean that not all tasks in the cgroup did exit() (cgroup_exit()),
i.e. they're still running. Can you see them in cgroup.threads/tasks?

> cgroup_is_populated() depends on cgrp->nr_populated_xxx counters which
> IIUC will not be updated until cgroup_update_populated() is called
> from cgroup_exit() and that might get delayed...
Why do you think it's delayed?

> So from user space's point of view the cgroup is empty and can be
> removed but rmdir() fails to do so.
As Tejun says, cgroup with only dead _tasks_ should be removable (and if
I'm not mistaken it is in the current kernel). Unless you do individual
threads migration when a thread would be separated from its (dead)
leader. Does your case include such migrations?

Michal

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4ZBb8ACgkQia1+riC5
qSglKA/7BJoYDX9r50pa/XZfZI2JNZttiGfKqjgPyFCavP/qX63tAz1OmZU2eEOZ
yIELdeSzucbiv72mTWdwXRiM+NZ8Rzae1ggDS7KXpRdIaUqeb9JYc/ncfB7WWL9a
uMNO0JhT+C8VXDit8DgXI4Fm3eGKzEygmipYP3V3/2+f+QukUOVQzvbW/QVulckw
00GC3ooZ9/FqOdMYnrQ6kDlcGhutk7L7KOvbXA2sEl7sP4uFJ+DdqwyEoJnCkEBT
JR1cAyQeBYTO61QHNxrJPst7HFtFf0oMXAgtwa+nJvWWY8ks31OvDWyPwqPSD6dt
sgF1trGbROo3yemzvYYJDNwZPIThCyPdufsng8kgNtVLRCIO8zzI0FVgQIBGAan4
L32hi3lg0iBYmW3juqaMr5/w+GfPEcGjXiReiW5mN095QxnVfV2VH+YtnGBjjVEO
P4+SmXsvhVRflPAiKpMPy6u8MWJpB7ueL8JjaIRkmmdRsvnbMWMYCqujWJGWXhf/
2D/uvVP5U2qqWObz6BZ0ZvKZV4nVkwRJYmPPA0nV2KaDxj9dFFY/x90iqrxU9efp
jgr2RIqcMVRTcmLbHwz+WQNC5nm5Sv8cK9RhfLAmAr8BbXmsLZi9asgy/gWMl1iI
XbLCsgytbfye9oYrd8lublcLvN9+bc1wbAbNUbz+CfIFLhODAwg=
=2gY/
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
