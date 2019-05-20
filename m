Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F222F1C
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfETIlc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 May 2019 04:41:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbfETIlb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 20 May 2019 04:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0C9680F6D;
        Mon, 20 May 2019 08:41:30 +0000 (UTC)
Received: from antique-laptop (unknown [10.43.2.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78AB05D719;
        Mon, 20 May 2019 08:41:28 +0000 (UTC)
Date:   Mon, 20 May 2019 10:41:26 +0200
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
Message-ID: <20190520084126.GM1981@antique-laptop>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
 <20190516171427.GA8058@castle.DHCP.thefacebook.com>
 <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
 <20190517101222.GF1981@antique-laptop>
 <20190518005606.GA3431@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aSnC4ZPPfhCvD8sN"
Content-Disposition: inline
In-Reply-To: <20190518005606.GA3431@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 20 May 2019 08:41:31 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--aSnC4ZPPfhCvD8sN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2019 at 12:56:12AM +0000, Roman Gushchin wrote:
> On Fri, May 17, 2019 at 12:12:51PM +0200, Pavel Hrdina wrote:
> > On Thu, May 16, 2019 at 10:25:50AM -0700, Alexei Starovoitov wrote:
> > > On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > > > > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > > > > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > > > > hi,
> > > > > > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > > > > > not being released at the time when the cgroup is removed and
> > > > > > > are still visible in 'bpftool prog' list afterwards.
> > > > > >
> > > > > > Hi Jiri!
> > > > > >
> > > > > > Can you, please, try the patch from
> > > > > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4=
872d342bf6721e148e2 ?
> > > > > >
> > > > > > It should solve the problem, and I'm about to post it upstream.
> > > > >
> > > > > Perfect, I'll give it a try with full libvirt setup as well.
> > > > >
> > > > > Can we have this somehow detectable from user-space so libvirt can
> > > > > decide when to use BPF or not?  I would like to avoid using BPF w=
ith
> > > > > libvirt if this issue is not fixed and we cannot simply workaroun=
d it
> > > > > as systemd automatically removes cgroups for us.
> > > >
> > > > Hm, I don't think there is a good way to detect it from userspace.
> > > > At least I have no good ideas. Alexei? Daniel?
> > > >
> > > > If you're interested in a particular stable version, we can probably
> > > > treat it as a "fix", and backport.
> > >=20
> > > right.
> > > also user space workaround is trivial.
> > > Just detach before rmdir.
> >=20
> > Well yes, it's trivial but not if you are using machined from systemd.
> > Once libvirt kills QEMU process systemd automatically removes the
> > cgroup so we don't have any chance to remove the BPF program.
> >=20
> > Would it be too ugly to put something into
> > '/sys/kernel/cgroup/features'?
>=20
> I thought about it, but it seems that /sys/kernel/cgroup/features is also
> relatively new. So if we're not going to backport it (I mean auto-detachi=
ng),
> than we can simple look at the kernel version, right?

If you think only about upstream then the version check is in most cases
good enough, but usually that's not the case and patches are backported
to downstream distributions as well.

Yes, that file was introduced in kernel 4.15 so there are some
limitations where the fix would be introspectable.

> If we're going to backport it, the question is which stable version we're
> looking at.
>=20
> In general, I don't see any reasons why cgroup/features can't be used.

Perfect, in that case I would prefer if we could export it in
cgroup/features as it will be easier for user-space to figure out
whether it's safe to relay on proper cleanup behavior or not and
it will make downstream distributions life easier.

I'll try the patch today with libvirt setup.

Thanks,

Pavel

--aSnC4ZPPfhCvD8sN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlziaDYACgkQUi1kczAH
4YxAEw/9EWvy197LzBUmBX/ITZSf79Lsi/vTYmcMdc9fixgKbyP/gFomg1l9qXYA
Hy9HXqA43AZ+1OsSkakaevhGcR1me3E9PnWptI/5kLwtIG2Zy4R3ulaodrkjwQTg
zdm0t2NfBRcMx1t95bDWZd5wRwi1PYdGcrpGlV1nUgX8gQApvE71siSy07LYPPuD
nPlE5MWbOvYmvG1qfvIduN4AQZJpaWu29hpgWaNs2Ldc9ILjy0dj5xZEkyfiBaRl
uguMJZNMAF367ltO8JssGmruPrunxlHJcDxxjPAKtjcnPNl85IIwFvcYHG8xIQfL
YMGm0cEL3HYpe4I6V6J0SiMOLQQs0CPqoFbmT9nWotct9kBB9s+7NbyKqsbxoVoH
T/BnWhTCHhbWGBbr9hCVg+YYaNiFUK6RGxAJV6Hb/5Bn5IA2n5H8IulFvbjYnPWQ
dAH84IbS6oPdiAF3pW4jmWrVcqjgHSjBwvPhFq3o+Nj+HnZ6B/rZJL9gV/zsFby/
QCvfu8VKE9N2rQWBUBUlneqvk0ZpMS3OPdtyvZFnpn1B4y4knsiEyJeha2eJljOx
w5sQKv7XqOGJ/klNKvQfgJoiZ8HxQQGrPzKLwwlIQZnWcpQNir9Bc7OkYaOcb1yk
N7+YM5Z79qwbEDBCY6YG48H1vL63LifcU+ZJBzc92YaTA4VFlZY=
=iSUx
-----END PGP SIGNATURE-----

--aSnC4ZPPfhCvD8sN--
