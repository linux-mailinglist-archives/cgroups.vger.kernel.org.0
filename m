Return-Path: <cgroups+bounces-4371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A56958314
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE144286503
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE21898F2;
	Tue, 20 Aug 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="LNUcxZh7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC03E47B
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147045; cv=none; b=IjuNZ240GDyNgt1c4HTFZ4HlqgSAM5sUddaKNc3kLjsMiDkbYsJmiKF0gp3pC2uhCu/Tal/k/D8HspvivqzetvONwI9RGXjLvqiVlQ8C+Xn6PHhI4tLMt1Ym0sXMOaGdtTx+LgxkIBLzhBP5ZWc58m2ADne2dM/pDFvVEqnqNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147045; c=relaxed/simple;
	bh=UXN6Hz41fsT5CwoupTSUwp6fKqMOLT7VeoPg8p0GPK8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgNvnllOv3QuLKFPhVHwJw+6BJ/D9yTecoilOZw1kxwxZgOcuCWMy/71Yl7hZDYwdAQgpBgzy9j/ZX58X4E/kyaCUksTe20MaVIvj+tXznUZdgHxK2l+nT3BiisRwVvWpk3O90vYWEsPKtqC2CT3yFAvHNbWb4R+bqNkbB703tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=LNUcxZh7; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1724147041; x=1724406241;
	bh=UXN6Hz41fsT5CwoupTSUwp6fKqMOLT7VeoPg8p0GPK8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LNUcxZh7VjzfmogmZP9wTdIpKPwWaKpGxoRtGTXeDbaDr3xejBfXdaAEnpQKkOIud
	 BCxF01p5/sdcq8hmwjv/86qRDR7BAPVosEqVdfTXxpiuE/bEFcWdVee380cY2O9tuI
	 R0jzEnIsy1Jm63PR3QnUPOXvMP4P+T3RASDiATkirSc1U7JQqsSCvQCOOP9/FFwQD2
	 GcjGhprIhO1Vu02MpB5P6hRzjYATsD6OwQryiWQwTBWy4D/RsjFuOpe2xpANfzGr4B
	 SsbYwQd0h07lLODDhwSdhwRqiWwwte7zkePgIk0nSsjQptKszgjKBUIGTcJqeQftql
	 zRzfK+XFuhkMQ==
Date: Tue, 20 Aug 2024 09:43:54 +0000
To: Yosry Ahmed <yosryahmed@google.com>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/2] selftests: test_zswap: add test for hierarchical zswap.writeback
Message-ID: <9e39ed273b5e25e3d2f33c5a2b8e3131efbfcedc.camel@yhndnzj.com>
In-Reply-To: <CAJD7tkYRiA7113ehpXoiafJtk8Z+j6nV_bQWK0xoX3KaK6=wcQ@mail.gmail.com>
References: <20240816144344.18135-1-me@yhndnzj.com> <20240816144344.18135-2-me@yhndnzj.com> <CAJD7tkYRiA7113ehpXoiafJtk8Z+j6nV_bQWK0xoX3KaK6=wcQ@mail.gmail.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 822ab96bf117f3804cbe182c28e1d2c5b8ec1278
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-19 at 12:19 -0700, Yosry Ahmed wrote:
> On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
> >=20
> > Ensure that zswap.writeback check goes up the cgroup tree.
>=20
> Too concise :) Perhaps a little bit of description of what you are
> doing would be helpful.

The patch has been merged into mm-unstable tree. Do I need to
send a v3 to resolve the comments?

> >=20
> > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > ---
> > =C2=A0tools/testing/selftests/cgroup/test_zswap.c | 69 ++++++++++++++--=
-
> > ----
> > =C2=A01 file changed, 48 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/cgroup/test_zswap.c
> > b/tools/testing/selftests/cgroup/test_zswap.c
> > index 190096017f80..7da6f9dc1066 100644
> > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > @@ -263,15 +263,13 @@ static int test_zswapin(const char *root)
> > =C2=A0static int attempt_writeback(const char *cgroup, void *arg)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long pagesize =3D sysconf(_S=
C_PAGESIZE);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *test_group =3D arg;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t memsize =3D MB(4);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[pagesize];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long zswap_usage;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool wb_enabled;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool wb_enabled =3D *(bool *) arg=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *mem;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wb_enabled =3D cg_read_long(test_=
group,
> > "memory.zswap.writeback");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem =3D (char *)malloc(memsi=
ze);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mem)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > @@ -288,12 +286,12 @@ static int attempt_writeback(const char
> > *cgroup, void *arg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&mem[i], buf, pagesize);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try and reclaim allocated=
 memory */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write_numeric(test_group, =
"memory.reclaim",
> > memsize)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write_numeric(cgroup, "mem=
ory.reclaim", memsize)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ksft_print_msg("Failed to reclaim all of the
> > requested memory\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswap_usage =3D cg_read_long(test=
_group,
> > "memory.zswap.current");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswap_usage =3D cg_read_long(cgro=
up, "memory.zswap.current");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* zswpin */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < memsiz=
e; i +=3D pagesize) {
> > @@ -303,7 +301,7 @@ static int attempt_writeback(const char
> > *cgroup, void *arg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write_numeric(test_group, =
"memory.zswap.max",
> > zswap_usage/2))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write_numeric(cgroup, "mem=
ory.zswap.max",
> > zswap_usage/2))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > @@ -312,7 +310,7 @@ static int attempt_writeback(const char
> > *cgroup, void *arg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If writeback is disa=
bled, memory reclaim will fail as
> > zswap is limited and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it can't writeback t=
o swap.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D cg_write_numeric(test_gro=
up, "memory.reclaim",
> > memsize);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D cg_write_numeric(cgroup, =
"memory.reclaim", memsize);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!wb_enabled)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;
> >=20
> > @@ -321,12 +319,38 @@ static int attempt_writeback(const char
> > *cgroup, void *arg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > =C2=A0}
> >=20
> > +static int test_zswap_writeback_one(const char *cgroup, bool wb)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long zswpwb_before, zswpwb_after;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_before =3D get_cg_wb_count=
(cgroup);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zswpwb_before !=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ksft_print_msg("zswpwb_before =3D %ld instead of
> > 0\n", zswpwb_before);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_run(cgroup, attempt_writeb=
ack, (void *) &wb))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Verify that zswap writeback oc=
curred only if writeback
> > was enabled */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_after =3D get_cg_wb_count(=
cgroup);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zswpwb_after < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wb !=3D !!zswpwb_after) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ksft_print_msg("zswpwb_after is %ld while wb is
> > %s",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_after, wb ? "enabled" :
> > "disabled");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > =C2=A0/* Test to verify the zswap writeback path */
> > =C2=A0static int test_zswap_writeback(const char *root, bool wb)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long zswpwb_before, zswpwb_after;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D KSFT_FAIL;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *test_group;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *test_group, *test_group_chi=
ld =3D NULL;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_group =3D cg_name(root,=
 "zswap_writeback_test");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_group)
> > @@ -336,29 +360,32 @@ static int test_zswap_writeback(const char
> > *root, bool wb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write(test_group, "me=
mory.zswap.writeback", wb ? "1"
> > : "0"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_before =3D get_cg_wb_count=
(test_group);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zswpwb_before !=3D 0) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ksft_print_msg("zswpwb_before =3D %ld instead of
> > 0\n", zswpwb_before);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_zswap_writeback_one(test=
_group, wb))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_run(test_group, attempt_wr=
iteback, (void *)
> > test_group))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write(test_group, "memory.=
zswap.max", "max"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out;
>=20
> Why is this needed? Isn't this the default value?

attempt_writeback() would modify it.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write(test_group, "cgroup.=
subtree_control",
> > "+memory"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Verify that zswap writeback oc=
curred only if writeback
> > was enabled */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_after =3D get_cg_wb_count(=
test_group);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zswpwb_after < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_group_child =3D cg_name(test=
_group,
> > "zswap_writeback_test_child");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_group_child)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_create(test_group_child))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out;
>=20
> I'd rather have all the hierarchy setup at the beginning of the test,
> before the actual test logic. I don't feel strongly about it though.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cg_write(test_group_child, "m=
emory.zswap.writeback",
> > "1"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>=20
> Is the idea here that we always hardcode the child's zswap.writeback
> to 1, and the parent's zswap.writeback changes from 0 to 1, and we
> check that the parent's value is what matters?
> I think we need a comment here.

Yes, indeed.

> TBH, I expected a separate test that checks different combinations of
> parent and child values (e.g. also verifies that if the parent is
> enabled but child is disabled, writeback is disabled).

That's (implicitly) covered by the test itself IIUC? The parent cgroup
here is in turn the child of root cgroup.

> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wb !=3D !!zswpwb_after) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ksft_print_msg("zswpwb_after is %ld while wb is
> > %s",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zswpwb_after, wb ? "enabled" :
> > "disabled");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_zswap_writeback_one(test=
_group_child, wb))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D KSFT_PASS;
> >=20
> > =C2=A0out:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_group_child) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cg_destroy(test_group_child);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 free(test_group_child);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cg_destroy(test_group);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(test_group);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > --
> > 2.46.0
> >=20
> >=20



