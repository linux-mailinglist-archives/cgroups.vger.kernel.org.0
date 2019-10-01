Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81BC3773
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 16:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJAOb1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 10:31:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389035AbfJAOb0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 1 Oct 2019 10:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19501B03E;
        Tue,  1 Oct 2019 14:31:25 +0000 (UTC)
Date:   Tue, 1 Oct 2019 16:31:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com, daniel@ffwll.ch,
        y2kenny@gmail.com, tj@kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RFC v4 02/16] cgroup: Introduce cgroup for drm subsystem
Message-ID: <20191001143106.GA4749@blackbody.suse.cz>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-3-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20190829060533.32315-3-Kenny.Ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Thu, Aug 29, 2019 at 02:05:19AM -0400, Kenny Ho <Kenny.Ho@amd.com> wrote:
> +struct cgroup_subsys drm_cgrp_subsys = {
> +	.css_alloc	= drmcg_css_alloc,
> +	.css_free	= drmcg_css_free,
> +	.early_init	= false,
> +	.legacy_cftypes	= files,
Do you really want to expose the DRM controller on v1 hierarchies (where
threads of one process can be in different cgroups, or children cgroups
compete with their parents)?

> +	.dfl_cftypes	= files,
> +};

Just asking,
Michal

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2TYykACgkQia1+riC5
qSiNOhAAj+V8JbkviYhAkKfW2XIQz6L02LM+3vfiRHzZZJhcqdSs+4WB6xhmjKme
aG0SzH8NOiWzLpq+XPq4iW4G6v7QNjQcniUtb0kBiGvFfWpczCaFs9K0hyeUKCu0
2Xn/VIVvMqkPWDgirANCa/Dgsc5JMpsGY5A+E44aiPyqO/6UrQSDYXmvqu7132yx
L/4UtNJpH2SFnGJ7l0n1Gspe8W50WkKEscmLh3jlWcPFqUNY3JpdZ6rJ+LniGVck
xdEGSGbGnoZmfkg+lCLTnVU8p8fPUHh6Z8ZRoUey9d63+XCNvNqpWLfTp72kgIRr
48XrUaUKu49DO081Qehg4hLFb6uayHfoXMDHR/URLStF3AdPF3XZ/pStA3A0owp8
HztqK6hn/BfZuDSMZ5Vvtfqkqqjq68EmMdZ0TI4Ab/9dY5RMthv8ADVbKE58vC8K
KF4jbEKJFUGNWUpSVuX2BJOE9rTOk64MqSUmJs2KDKTZnwLeuOlHoUYUH1YLHxsj
6SEZZ6+3hiHMGQYAFz6bxSvzF/abDe/O9tW/MnOQT3VkxHBSWnMyC3j0KRlgUJ/j
HnWawWW4SPRkhykkzBxpp2Qs4YY29JqiExVfmFxQlt46MgnqH4V9DteH0H7EI0MY
eUvqey3L9y3hBv1B8Z9XjOix4HwxFpK4HZH8SrQArcyeThtNnuE=
=je6w
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
