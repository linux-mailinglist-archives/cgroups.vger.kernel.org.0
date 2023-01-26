Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E605867CB8D
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAZNBL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 08:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjAZNBB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 08:01:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462416537C;
        Thu, 26 Jan 2023 05:00:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE0DA1FF71;
        Thu, 26 Jan 2023 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674738051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jq01Sm8SBYrwuIbnTiDzZaS12Esjwjw+h71W4eebOX4=;
        b=K75+0LENCpiZZU3kMZnJrFUA4+44SN8LdEABzSCpIz22gmVv/HwH2lzrsYI5x0JZViHUUM
        wcy9eFyPF6rgsuViC3kbxwVm3DKMR3TWH902j64biJlGce/pyBzsBvmeyUGi3xeJTep5cp
        bSwZ++MfqmGC/D1s41XTt2GdZhZENIA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A04C1139B3;
        Thu, 26 Jan 2023 13:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAQ8JoN50mNkUwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 26 Jan 2023 13:00:51 +0000
Date:   Thu, 26 Jan 2023 14:00:50 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC v3 00/12] DRM scheduling cgroup controller
Message-ID: <20230126130050.GA22442@blackbody.suse.cz>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230123154239.GA24348@blackbody.suse.cz>
 <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2023 at 06:11:35PM +0000, Tvrtko Ursulin <tvrtko.ursulin@li=
nux.intel.com> wrote:
> I don't immediately see how you envisage the half-userspace implementation
> would look like in terms of what functionality/new APIs would be provided=
 by
> the kernel?

Output:
	drm.stat (with consumed time(s))

Input:
	drm.throttle (alternatives)
	- a) writing 0,1 (in rough analogy to your proposed
	     notifications)
	- b) writing duration (in loose analogy to memory.reclaim)
	     - for how long GPU work should be backed off

An userspace agent sitting between these two and it'd do the measurement
and calculation depending on given policies (weighting, throttling) and
apply respective controls.

(In resemblance of e.g. https://denji.github.io/cpulimit/)

> Problem there is to find a suitable point to charge at. If for a moment we
> limit the discussion to i915, out of the box we could having charging
> happening at several thousand times per second to effectively never. This=
 is
> to illustrate the GPU context execution dynamics which range from many sm=
all
> packets of work to multi-minute, or longer. For the latter to be accounted
> for we'd still need some periodic scanning, which would then perhaps go p=
er
> driver. For the former we'd have thousands of needless updates per second.
>=20
> Hence my thinking was to pay both the cost of accounting and collecting t=
he
> usage data once per actionable event, where the latter is controlled by s=
ome
> reasonable scanning period/frequency.
>=20
> In addition to that, a few DRM drivers already support GPU usage querying
> via fdinfo, so that being externally triggered, it is next to trivial to
> wire all those DRM drivers into such common DRM cgroup controller framewo=
rk.
> All that every driver needs to implement on top is the "over budget"
> callback.

I'd also like show comparison with CPU accounting and controller.
There is tick-based (~sampling) measurement of various components of CPU
time (task_group_account_field()). But the actual schedulling (weights)
or throttling is based on precise accounting (update_curr()).

So, if the goal is to have precise and guaranteed limits, it shouldn't
(cannot) be based on sampling. OTOH, if it must be sampling based due to
variability of the device landscape, it could be advisory mechanism with
the userspace component.

My 0.02=E2=82=AC,
Michal

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY9J5fQAKCRAkDQmsBEOq
uUg3AP4+ZWvuZ3xdlWSXFPWS/n5dpEobQswSJpRzulYDa0Y2kQEAvVvMx/X7B0zi
wV+jzd0bW0zXWpasGE5L8GxBJMNyRwA=
=pO2C
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
