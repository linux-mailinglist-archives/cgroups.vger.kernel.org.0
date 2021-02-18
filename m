Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41731ECD9
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBRRGD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 12:06:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:48220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhBRPjT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 10:39:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613662663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8xSuHg5FcxqaUiLy/07VNaVdH7jpOGpygmlG0tFCPA=;
        b=fk2s0A3B16v2RiDa7GjCZaWyaQgL9PvIP9RoEVXWSsjtARABYF/FSs6+DmzvHF8Wte5/ma
        LgmgEeJI8gl10ZEF4UgMh+/K9JVOtJWaT8bko36a0xvOQ25hWaXT1key0aC3pZEsD1l2vJ
        ZZGsq+kQ/RcYb5zQQAQvhTnMSTJWnpM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39715AD57;
        Thu, 18 Feb 2021 15:37:43 +0000 (UTC)
Date:   Thu, 18 Feb 2021 16:37:41 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 8/8] kselftests: cgroup: update kmem test for new
 vmstat implementation
Message-ID: <YC6JxXU9qJLKpfdQ@blackbook>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fHNhrTm/0V5/xRS3"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-9-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fHNhrTm/0V5/xRS3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 11:33:04AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--fHNhrTm/0V5/xRS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAuicUACgkQia1+riC5
qSiQLQ//c6i9TdMWD82nlSR/w1T8wAEzFaMzXDQxgqpXL/eOSYOvQoG0bruyPwWf
TotGZU/GtFSEYkHXHEnWb7ZO/7RK9EeQN9WS0XBg4w3CtU/Gv4TZLP+k3dZfoM+C
GTrO9N820v6ez66phHpKgwWhUIfg6iPaJ8uP7SCt/GTJb/4lOLuf47ddnomrWMwn
j3BcSZhzcZQtptN3diL0aoBmZJ+y0Mo/Xo7bx4omEIv91st9SE4f6hQwVBtZpfqG
DkLTJBVTJ3Vu2t0ADeao9vAru0Ylp5/SOb9qPYsSq+JGaornjg9MAmHRrzg2IKHo
35qJQTplQRqZtNRSMySXVTf7Ntz7D42xRPDw0yFjXA6J/NWtOw4yvnP/X0dTuArO
Yeu1+8vDFGyhEWU+UFPUFggvyr4HzbbH7WQxmmTKUqFILkkp+4KZwDjWkUXr+jzp
TSqAk34EkO1luhKQPMwcP1e2RUIfXbV32ZYiq0gT/si/KC22NG4IfKni5tuJHEAT
eHBvBRcpwypqxI1Y0258CFOCaFmfH1toJ0M3j4zlElUnNhYsqc1GD08ymaI/q7QF
UtLuo4ARokvUtm3eZROk1ACe69lnYk0Vu5cb76tfRci0gWmHAg8KqlV+cCpK7Km6
vT/s3Enga86z6iuOsSp+8NJxddhx2uH0O6EDQSa2CudGRPSXn74=
=SFWt
-----END PGP SIGNATURE-----

--fHNhrTm/0V5/xRS3--
