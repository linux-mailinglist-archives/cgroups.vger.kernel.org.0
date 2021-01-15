Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3382C2F77F8
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAOLvw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 06:51:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:48252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbhAOLvv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Jan 2021 06:51:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610711465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSrrwVVDuNBTwhNUys2eeIr+jYSEnX846ZDOze4F/Rc=;
        b=HWNLrfNPOalhS8svmVe4ZSZ/q0oY8x0nbXl0nhvwnhT/Jz8cppve72e6k7LhegCrSIcV9u
        /Mwz1SzLP5K6Am6CBfvCtlX2w9eMj46xOw2Ydfe/ZMKQ6SwXkv5XyAHt4Nz8ULGZSMGNbE
        8ugZZ0tww/KnkIenODnULjwSSlSRzJo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2F72AE05;
        Fri, 15 Jan 2021 11:51:04 +0000 (UTC)
Date:   Fri, 15 Jan 2021 12:51:03 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        viro@zeniv.linux.org.uk, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH v3] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
Message-ID: <YAGBpwc+mG9fphkN@blackbook>
References: <20210115093717.79474-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LRTQWv5FIzkk1CnV"
Content-Disposition: inline
In-Reply-To: <20210115093717.79474-1-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--LRTQWv5FIzkk1CnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 05:37:17PM +0800, Chen Zhou <chenzhou10@huawei.com>=
 wrote:
> [...]
>  kernel/cgroup/cgroup-v1.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--LRTQWv5FIzkk1CnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmABgaMACgkQia1+riC5
qSgENQ//THZ0aN/jvVhGYM3k13t0jW/DWcpVSCaxQtWDesCT6o5KydDvmd/8b6O/
H+DeSBxPh1owPaYINJ1SfuRWNuaW3iXb40Lvpd/2COgIFg8cq4u/dHsbSLsE/xJh
qeKH3/rDoufm1XYqMEm98mjg2SRVKMTudRMA/TVvXyCO3y8lRyxHxmsxXPV+lf+I
+GcUlY/dWS4588b2cQDVL6n6SNk3ufu0fG+4SHWkw459K6MQvH42G30FsGOC7f75
r9lOPzOExYQSuE8nzC7aypsrBOPKuRvSSVayHndZsofFcZB7HCY1huCcEIUlOD8h
RT1Ndn7ehmJYE4Md5RoBYkTwGY4zGFkStCVZ4W6+GSWqISzFgmMtw8Orn51Pwsyx
wq0Ttc5sHPtnEJS7FvNhudC+wlMc7LftFfXqPodVg4JbjqPT1TpxELxk1ffEjEJy
//u6rC/GKSCPKCKS/E5lMDQVBPGLKl2swkcoE3lzMhY195V4y0Qd24nyEzzYAtP1
u83jxespxWdU96c3BrKIUYB4M54p+p3nbfw0wUytQCUE+fTCXdPtA/uzUIZfv+Su
M/Iafwifbdb7pufCFe19N/SxhDY34mD7Fc+ebno5nuCy3AIs2taVLa4knHDM6fOo
3n0GslcnwvQinaPYUToSjurm1kGwwMDv3T4f9pRpRGxyHEKnuLc=
=EyUt
-----END PGP SIGNATURE-----

--LRTQWv5FIzkk1CnV--
