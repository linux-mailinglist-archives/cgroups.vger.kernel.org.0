Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1AA67E7D6
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 15:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjA0OME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 09:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjA0OLk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 09:11:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEA113C0;
        Fri, 27 Jan 2023 06:11:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B04182004A;
        Fri, 27 Jan 2023 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674828698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mSncck0uCNO0XEG+dAMJPtpF70wyeN5+vS8xanKFqy0=;
        b=C1YoRptlDUvtsZPxFNqni7kpmNoA5+rRt8/CIEw/LMiA/d9XXDsAxWTxbwAVOmi07VCulg
        IipcUh7HGReprrPS0A3KwTN54ZPuwyAR9p56cSkttQ5A0UAnWgx2XnXBeLOO3PpGMWzzFu
        +EaUCvzEhrzzuBA9tz3O87ZIe5AbYoU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ECC1138E3;
        Fri, 27 Jan 2023 14:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yltBFprb02MQOwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 27 Jan 2023 14:11:38 +0000
Date:   Fri, 27 Jan 2023 15:11:37 +0100
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
Message-ID: <20230127141136.GG3527@blackbody.suse.cz>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
 <20230127130134.GA15846@blackbody.suse.cz>
 <a96e6b5c-b538-f7e7-d603-cabb29137de7@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <a96e6b5c-b538-f7e7-d603-cabb29137de7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 01:31:54PM +0000, Tvrtko Ursulin <tvrtko.ursulin@li=
nux.intel.com> wrote:
> I think you missed the finish_suspend_scanning() part:
>=20
> 	if (root_drmcs.suspended_period_us)
> 		cancel_delayed_work_sync(&root_drmcs.scan_work);
>=20
> So if scanning was in progress migration will wait until it finishes.

Indeed, I've missed that. Thank you!

> Not claiming I did not miss something because I was totally new with cgro=
up
> internals when I started working on this. So it is definitely useful to h=
ave
> more eyes looking.

The custom with (especially v2, especially horizontal) migrations
is that they're treated leniently to avoid performance costs.

I'm afraid waiting for scan in can_attach() can propagate globally (via
cgroup_update_dfl_csses() and cgroup_attach_lock()) sometimes.

OTOH, unless I misunderstood, you need to cover explicit (not task but
resource, when sending client FD around) migration anyway?
(I.e. my suggestion would be to mutualy exclude scanning and explicit
migration but not scanning and task migration in order to avoid possible
global propagation.)

Thanks,
Michal

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY9PblAAKCRAkDQmsBEOq
ucw5AQC5ZB3HI12pF2NT0El6kZyt7tb80DxhDnscyavv+b0IdQEAiK5mjOqXAtP+
SYfNfDKskxKUJ4WdJnbrY4PbeeQlLwk=
=Rwoe
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
