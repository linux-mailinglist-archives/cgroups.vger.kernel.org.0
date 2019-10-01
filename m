Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4CC376D
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbfJAOaw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 10:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJAOaw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 1 Oct 2019 10:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F151AE3A;
        Tue,  1 Oct 2019 14:30:51 +0000 (UTC)
Date:   Tue, 1 Oct 2019 16:30:47 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com, daniel@ffwll.ch,
        y2kenny@gmail.com, tj@kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RFC v4 11/16] drm, cgroup: Add per cgroup bw measure and
 control
Message-ID: <20191001143046.GA4311@blackbody.suse.cz>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-12-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20190829060533.32315-12-Kenny.Ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Thu, Aug 29, 2019 at 02:05:28AM -0400, Kenny Ho <Kenny.Ho@amd.com> wrote:
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1256,6 +1257,12 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
> [...]
> +		move_delay /= 2000; /* check every half period in ms*/
> [...]
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> [...]
> @@ -382,6 +548,25 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
> [...]
> +			if (rc || val < 2000) {
This just caught my eye and it may be simply caused by RFC-ness of the
series but I'd suggest turning this into a constant with descriptive
name.

My 2 cents,
Michal

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2TYxYACgkQia1+riC5
qSiZeg//bj2A/ClcMhpwuE0J8gvyfDQynY9eDJlRse6YteLmIg1WwJdh0j8IJDJX
BC0/pMubCU/sbHw5rscCCgQ9ecft1517aCah6uOvJo3LeLS0LrYDRuu++3T60MLQ
DTLJxuMHyAjJSdthOfeRxoHupvHh7/XxfcZxJ20PPu/G3v5f0vvIrfj8eADD19J/
jRyqyF14ytWvYkfnofwIuX9EuKesjGFMPTp6kpDq24PqzNwZma68/456oReb1TRF
t6u3vBFOdieLwhjt0FYY9ZL/6DlHnYou9nElamjm1igLOLCVp0dvIHDLrWYO2WY3
uJg5jq1Dgs0kGNZVY9L5JdB/K+hoVuhN975CiNqF9zz8h9HRNmeSeQwPi+0MgSJj
m430HsChdstWsCh28n1LOnIprYdR+oGngXyJrnWaevjvxUMQS0Ia+6qkbxmtq3tG
0M8PeanLOnbV+9oELF7fxfN1L4FDGDdQ7kT5cTX2ZCMHQU5fZSGcpNr8s9yysRT4
McBDchQJ/3O9E+8yDNt70v3OssutbhHNOal9RP1Y31p4zDxxS2bt3mRIZwqfBH2A
30oui6xyYsatphBiRfonOXaQYDsyrki3phwGogCchm3EbjeW3/TWgxOWlipAtefr
GsMF0wZubmtd3966lx/fnR2j9yEnTQ+jjUiuIdlGXwsXHneSztU=
=Yn1L
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
