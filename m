Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C212F619F
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 14:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhANNNr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 08:13:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbhANNNq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Jan 2021 08:13:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610629980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GF0WE0Qb6cVvTF2NflEBTiiInZOom4YMvYdVAC+0ETs=;
        b=ppy0OqvZZFsx46UyvH/Y+mY7fTQiwWlcKuhkEbbFcZdQZtFZ5RhA3BKOnX788tNIk9oJgv
        AXW70nFIyE03LmllPcvvqAkEoA+3QfjdaTKUed7321bX5vEMuaqx/GRyvuBHLsXMSm4bwu
        jcSogLSuNsqDLDDJoCVz4AdTFsc9MmI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1D0AB7A4;
        Thu, 14 Jan 2021 13:12:59 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:12:58 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
Message-ID: <YABDWvI2PWQpnv59@blackbook>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QyWpP+FhytSknTGW"
Content-Disposition: inline
In-Reply-To: <20201218061755.121205-1-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--QyWpP+FhytSknTGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chen.

On Fri, Dec 18, 2020 at 02:17:55PM +0800, Chen Zhou <chenzhou10@huawei.com> wrote:
> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
> all available controllers will be attached.
Not sure if I understand the situation -- have you observed a v1
controller attached to a hierarchy while specifying cgroup_no_v1= kernel
cmdline arg?

AFAICS, the disabled controllers are honored thanks to
check_cgroupfs_options().

Michal

--QyWpP+FhytSknTGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAAQ1UACgkQia1+riC5
qSjfmhAAjoBfZd9q9AjcZUbdDE79xfD2+0B+c03VStMia9Y4uEBWHMUAVLZMK9Vt
BoOCVFB6V2SdjkB1gV3gxPfShWHIt9iIz9GVqSuGgXBXtt0Lut8nuw/t/Z2mP4pw
rMHXKR9aOWNQU3dWKIttXMp7TZ2EMLJ/HW73Jth867zXZd8Wc+lYEDrfsbQT1WCI
fZHr/dJSUb9uEFo7Wr1IpNsR3owLNcZ+0POnPmeUjUleClrwe0C8CAp1ipTcVx+2
0tA5Yqy0uSHpbrRiuhI2lseHvwOdc7SG1oxRIBe/M4smN/P12GeN6YD6k0V3tRgc
1PZVpAjsBoHvJl+lVIKWN+X/Qpjh/GlSwHsufZeoKGtR6NAKNEcU39/yACRJBGBx
M3osYIRcuTT+D822Yq1Rn8wQ9juolImzwWaRAJzlIXNh4PZfJD3ywI0AoO6I69md
3aokm5YEycI76Y75TNxKbfkr51EmprqNNOgz71qslj2Y7robC7h0Mf4BvRCu/1ns
M2V0U4bZQy872sfoPu/k+13ki3Bc9cukowl31w7jrhvVAvuxo5FqgDZzNzRwGYRE
hzKNW0Ed6hX6RL1ZHvxsClHgyh49wgMEIbAJHblkmoIgFGQrBCHe03uoN+DN18ke
x0LQCS6h5y/WR7STRS1CHM1NPJPQvqpDu92GREfZCXNsVIgK3vc=
=l74T
-----END PGP SIGNATURE-----

--QyWpP+FhytSknTGW--
