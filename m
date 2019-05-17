Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D8216C6
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfEQKM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 06:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfEQKM6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 06:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78DB83001A62;
        Fri, 17 May 2019 10:12:57 +0000 (UTC)
Received: from antique-laptop (unknown [10.43.2.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BE578373;
        Fri, 17 May 2019 10:12:54 +0000 (UTC)
Date:   Fri, 17 May 2019 12:12:51 +0200
From:   Pavel Hrdina <phrdina@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Jiri Olsa <jolsa@redhat.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] cgroup gets release after long time
Message-ID: <20190517101222.GF1981@antique-laptop>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
 <20190516171427.GA8058@castle.DHCP.thefacebook.com>
 <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 17 May 2019 10:12:57 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 10:25:50AM -0700, Alexei Starovoitov wrote:
> On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > > hi,
> > > > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > > > not being released at the time when the cgroup is removed and
> > > > > are still visible in 'bpftool prog' list afterwards.
> > > >
> > > > Hi Jiri!
> > > >
> > > > Can you, please, try the patch from
> > > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d=
342bf6721e148e2 ?
> > > >
> > > > It should solve the problem, and I'm about to post it upstream.
> > >
> > > Perfect, I'll give it a try with full libvirt setup as well.
> > >
> > > Can we have this somehow detectable from user-space so libvirt can
> > > decide when to use BPF or not?  I would like to avoid using BPF with
> > > libvirt if this issue is not fixed and we cannot simply workaround it
> > > as systemd automatically removes cgroups for us.
> >
> > Hm, I don't think there is a good way to detect it from userspace.
> > At least I have no good ideas. Alexei? Daniel?
> >
> > If you're interested in a particular stable version, we can probably
> > treat it as a "fix", and backport.
>=20
> right.
> also user space workaround is trivial.
> Just detach before rmdir.

Well yes, it's trivial but not if you are using machined from systemd.
Once libvirt kills QEMU process systemd automatically removes the
cgroup so we don't have any chance to remove the BPF program.

Would it be too ugly to put something into
'/sys/kernel/cgroup/features'?

Pavel

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlzeiSMACgkQUi1kczAH
4YwxjxAA2NmLZIjbAiTsE+D4p8WbDUps9sldDKMKZI9sqeoffL779fLYxKsRnWSg
U0W5T85hNPsFwbRDLYwWzBoOqD+HuspY/MrhUzH1SagvZyYkJyJ0GxM+JvfgMFfS
HRQE7179vLFGx0OP0c4od2l7FUGPS1XVHoLc6gskehErkMPJog5I+OmqF9DPBlAB
6Qk6K4kTeH88jIRuHQmAEzOpOZrjjeaQ+ugih4eTCRmeB/uFLzwJfHzmY4SyWUnz
fEXf6GNd6dyFrCr4dWUF0wTFrV8hK3MynHBWQFVykZczD25n2B8E0PoGxZExCaBp
c3pImWFCfspu/15ajqP1nsSxggdGdP4PnzW9sR+eG3igL+EaltTJDUI8A/hPeOcw
BQUY24MSDZaxJlB8Kzx81/pbWRGoIjvYk1lwkZFTXTGfOSPdu21VjW7mNRBqAsH9
WfPHS5UHZ5hLZfqqCYER/xUWT/Ea4BTcoFmFkUhCYFjwcWtvCaT6XikEBTr2skVv
6FHXNB1vLykknJuc+hXlur7cabcMCXmr+PrGslvpEF00yn4IosbGoHwpmxcOLUMc
/7LbN7nQdkCBNQI6ka2/oXG/ph1xNVsBD26/+XUuwdqzgvGMOZVVToXV4W/UjczO
Ij6qj1tRImuC0jupYc+w0RwTtWu9D8Vs6V0Fp7BmOm4PGXOAqlE=
=1uOM
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
