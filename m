Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4367E5FC
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjA0NBo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 08:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjA0NBl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 08:01:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D8B749;
        Fri, 27 Jan 2023 05:01:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8941921EB1;
        Fri, 27 Jan 2023 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674824496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwqwimypfYhckyzFeaCO359/Wbd8QLK/UU3i+F4YZ9M=;
        b=kxTr+5nGawv5c+31CyMgEt3X4+S1+4evQh+J1Dg58MqKbnjUH9unrBer5bNpBAJ7R6Wd77
        VD8rwA1obRyuqw3M5hAh8MdMuDbuxNMJ6FF6ifulfEzRrlWc+ZEF0jMeIKKA5K1fu2uvGE
        9d0zsWLGDEgFESRukKgMT7/bh9bYObU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40B751336F;
        Fri, 27 Jan 2023 13:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hDftDjDL02PZEwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 27 Jan 2023 13:01:36 +0000
Date:   Fri, 27 Jan 2023 14:01:34 +0100
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
Subject: Re: [RFC 10/12] cgroup/drm: Introduce weight based drm cgroup control
Message-ID: <20230127130134.GA15846@blackbody.suse.cz>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 04:56:07PM +0000, Tvrtko Ursulin <tvrtko.ursulin@li=
nux.intel.com> wrote:
> +static int drmcs_can_attach(struct cgroup_taskset *tset)
> +{
> +	int ret;
> +
> +	/*
> +	 * As processes are getting moved between groups we need to ensure
> +	 * both that the old group does not see a sudden downward jump in the
> +	 * GPU utilisation, and that the new group does not see a sudden jump
> +	 * up with all the GPU time clients belonging to the migrated process
> +	 * have accumulated.
> +	 *
> +	 * To achieve that we suspend the scanner until the migration is
> +	 * completed where the resume at the end ensures both groups start
> +	 * observing GPU utilisation from a reset state.
> +	 */
> +
> +	ret =3D mutex_lock_interruptible(&drmcg_mutex);
> +	if (ret)
> +		return ret;
> +	start_suspend_scanning();
> +	mutex_unlock(&drmcg_mutex);
> +
> +	finish_suspend_scanning();

Here's scanning suspension, communicated via=20

	root_drmcs.scanning_suspended =3D true;
	root_drmcs.suspended_period_us =3D root_drmcs.period_us;
	root_drmcs.period_us =3D 0;

but I don't see those used in scan_worker() and the scanning traversal
can apparently run concurrently with a task migration.

> [...]
> +static bool
> +__start_scanning(struct drm_cgroup_state *root, unsigned int period_us)
> [...]
> +	css_for_each_descendant_post(node, &root->css) {
> [...]
> +		active =3D drmcs_get_active_time_us(drmcs);
> +		if (period_us && active > drmcs->prev_active_us)
> +			drmcs->active_us +=3D active - drmcs->prev_active_us;
> +		drmcs->prev_active_us =3D active;

drmcs_get_active_time_us() could count a task's contribution here,
the task would migrate to a different drmcs,
and it'd be counted 2nd time.



--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY9PLLAAKCRAkDQmsBEOq
uR23AQDwt1E9t+jVuVU7H8uzqQ4NU955UNFhUY+uPnN1iQs1hwD+InLBJmA61dva
zuO/RFocXhzfrqMboDPUdkJFDknEYAw=
=+pK0
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
