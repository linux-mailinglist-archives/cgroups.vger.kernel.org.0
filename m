Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A42499C
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEUIAQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 04:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUIAP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 May 2019 04:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE03B308620F;
        Tue, 21 May 2019 08:00:09 +0000 (UTC)
Received: from antique-laptop (ovpn-200-37.brq.redhat.com [10.40.200.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71929646CE;
        Tue, 21 May 2019 08:00:06 +0000 (UTC)
Date:   Tue, 21 May 2019 10:00:03 +0200
From:   Pavel Hrdina <phrdina@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] cgroup gets release after long time
Message-ID: <20190521080003.GA9932@antique-laptop>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
 <20190516171427.GA8058@castle.DHCP.thefacebook.com>
 <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
 <20190517101222.GF1981@antique-laptop>
 <20190518005606.GA3431@tower.DHCP.thefacebook.com>
 <20190520084126.GM1981@antique-laptop>
 <20190520191135.GB24204@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190520191135.GB24204@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 21 May 2019 08:00:15 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 07:11:39PM +0000, Roman Gushchin wrote:
> On Mon, May 20, 2019 at 10:41:26AM +0200, Pavel Hrdina wrote:
> > On Sat, May 18, 2019 at 12:56:12AM +0000, Roman Gushchin wrote:
> > > On Fri, May 17, 2019 at 12:12:51PM +0200, Pavel Hrdina wrote:
> > > > On Thu, May 16, 2019 at 10:25:50AM -0700, Alexei Starovoitov wrote:
> > > > > On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wro=
te:
> > > > > >
> > > > > > On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > > > > > > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrot=
e:
> > > > > > > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > > > > > > hi,
> > > > > > > > > Pavel reported an issue with bpf programs (attached to cg=
roup)
> > > > > > > > > not being released at the time when the cgroup is removed=
 and
> > > > > > > > > are still visible in 'bpftool prog' list afterwards.
> > > > > > > >
> > > > > > > > Hi Jiri!
> > > > > > > >
> > > > > > > > Can you, please, try the patch from
> > > > > > > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1af=
a6c4872d342bf6721e148e2 ?
> > > > > > > >
> > > > > > > > It should solve the problem, and I'm about to post it upstr=
eam.
> > > > > > >
> > > > > > > Perfect, I'll give it a try with full libvirt setup as well.
> > > > > > >
> > > > > > > Can we have this somehow detectable from user-space so libvir=
t can
> > > > > > > decide when to use BPF or not?  I would like to avoid using B=
PF with
> > > > > > > libvirt if this issue is not fixed and we cannot simply worka=
round it
> > > > > > > as systemd automatically removes cgroups for us.
> > > > > >
> > > > > > Hm, I don't think there is a good way to detect it from userspa=
ce.
> > > > > > At least I have no good ideas. Alexei? Daniel?
> > > > > >
> > > > > > If you're interested in a particular stable version, we can pro=
bably
> > > > > > treat it as a "fix", and backport.
> > > > >=20
> > > > > right.
> > > > > also user space workaround is trivial.
> > > > > Just detach before rmdir.
> > > >=20
> > > > Well yes, it's trivial but not if you are using machined from syste=
md.
> > > > Once libvirt kills QEMU process systemd automatically removes the
> > > > cgroup so we don't have any chance to remove the BPF program.
> > > >=20
> > > > Would it be too ugly to put something into
> > > > '/sys/kernel/cgroup/features'?
> > >=20
> > > I thought about it, but it seems that /sys/kernel/cgroup/features is =
also
> > > relatively new. So if we're not going to backport it (I mean auto-det=
aching),
> > > than we can simple look at the kernel version, right?
> >=20
> > If you think only about upstream then the version check is in most cases
> > good enough, but usually that's not the case and patches are backported
> > to downstream distributions as well.
> >=20
> > Yes, that file was introduced in kernel 4.15 so there are some
> > limitations where the fix would be introspectable.
> >=20
> > > If we're going to backport it, the question is which stable version w=
e're
> > > looking at.
> > >=20
> > > In general, I don't see any reasons why cgroup/features can't be used.
> >=20
> > Perfect, in that case I would prefer if we could export it in
> > cgroup/features as it will be easier for user-space to figure out
> > whether it's safe to relay on proper cleanup behavior or not and
> > it will make downstream distributions life easier.
>=20
> Hello, Pavel!
>=20
> Tejun noticed that cgroup features are supposed to match cgroupfs mount o=
ptions,
> so it can't be used here. And this >=3D 4.15 limitation is also a signifi=
cant
> constraint.

Hi Roman,

That's unfortunate, I guess I will have to do the version check.

Thanks for the info.

Pavel

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlzjsAMACgkQUi1kczAH
4Yz+zA//aFF0Y0HPU9du0EUPp6EClAlDUc9qJ37sh1GID2cgsT/FdsFSey2AhqSV
KJT3DDWwIcHHxefWgHLvjMN0Yc/P41byuu1kA9Hthp+TJ47Y9a5EnmJctbftCm6T
xgEMBWIheX8nG1uYiXHPAlvm9nc1L4SUpJYxtRPBEcy9mEL8FhSPBpoazMbwyEz8
r3x2vrJ08xGgVvYfJhIWpn2PNAi6SmBBbx+8EaddpeKU71Ck0xd9pSC60h3sHMhy
oX81gn0ICfDhGZqeMovVmZ4BPedNutYTmUzJYUvNeRtfXOBHOql6yGcwTKWMIuhI
yd3Hbt3qnKb4n0zUuFxZWmIdsLfrbkE+F8dFrMXIqpYe/HFP9x5LfYZTjnLdOBfG
PIKGnaDfhTIH38jLEBewBlUDcD+s/P7CQ4Skc5lenGoQPBnqqrIduRYcKgYAyKy5
m9+l9uI9mqoZ+H/QiySV9+ZIimk6L1IK/Wkjkdwrq3pHSTIZaDMNF0zvSgcy3p4h
DKD2qpQHXwBvrMC/6WIAzNw48s8epghLwWiMtJsdytK+C4JYyQIluxy/xcACVGA0
ibr1ICyGFRvDv6Slvs43sx+6KISUyyrSG4XAPJO8JSEkSflqkxcBSpJrCm2qP6WE
hxoKHDzmmrQecyJVLbDplCM5p+0mYAJ1wpqNmMMQx8A41i+wSa8=
=KPfi
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
