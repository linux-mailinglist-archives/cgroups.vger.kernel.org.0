Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BC678033
	for <lists+cgroups@lfdr.de>; Mon, 23 Jan 2023 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjAWPnH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 10:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjAWPnF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 10:43:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45725592;
        Mon, 23 Jan 2023 07:42:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78F42339C7;
        Mon, 23 Jan 2023 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674488561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55apZeYnu6RO07C6lWHKMqZeQ9QD+dZi2oV45IYgqR8=;
        b=NwZHaPnSdW0sTqWIpW2Ep2zUuQal9AFNwBLp9xUmbUjAfDGelZ/xsCQDuUGJM72HmTIzWD
        OVGHfd0I8eI2RL5CanevYwNgICrTG+L9yMtGcFVikSQMyfesIE/B6sHkF1jegMTYHs7TtI
        KIBufBqOPxkvvdIyiJwOXwaUEQXgNhs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 236FB1357F;
        Mon, 23 Jan 2023 15:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gh6oB/GqzmNMXgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 23 Jan 2023 15:42:41 +0000
Date:   Mon, 23 Jan 2023 16:42:39 +0100
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
Message-ID: <20230123154239.GA24348@blackbody.suse.cz>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Tvrtko.

Interesting work.

On Thu, Jan 12, 2023 at 04:55:57PM +0000, Tvrtko Ursulin <tvrtko.ursulin@li=
nux.intel.com> wrote:
> Because of the heterogenous hardware and driver DRM capabilities, soft li=
mits
> are implemented as a loose co-operative (bi-directional) interface betwee=
n the
> controller and DRM core.

IIUC, this periodic scanning, calculating and applying could be partly
implemented with userspace utilities. (As you write, these limits are
best effort only, so it sounds to me such a total implementation is
unnecessary.)

I think a better approach would be to avoid the async querying and
instead require implementing explicit foo_charge_time(client, dur) API
(similar to how other controllers achieve this).
Your argument is the heterogenity of devices -- does it mean there are
devices/drivers that can't implement such a synchronous charging?=20

> DRM core provides an API to query per process GPU utilization and 2nd API=
 to
> receive notification from the cgroup controller when the group enters or =
exits
> the over budget condition.

The return value of foo_charge_time() would substitute such a
notification synchronously. (By extension all clients in an affected
cgroup could be notified to achieve some broader actions.)

> Individual DRM drivers which implement the interface are expected to act =
on this
> in the best-effort manner only. There are no guarantees that the soft lim=
its
> will be respected.

Back to original concern -- must all code reside in the kernel when it's
essentially advisory resource control?

>  * DRM core is required to track all DRM clients belonging to processes s=
o it
>    can answer when asked how much GPU time is a process using.
>  [...]
>  * Individual drivers need to implement two similar hooks, but which work=
 for
>    a single DRM client. Over budget callback and GPU utilisation query.

This information is eventually aggregated for each process in a cgroup.
(And the action is carried on a single client, not a process.)
The per-process tracking seems like an additional indirection.
Could be the clients associated directly with DRM cgroup? [1]


Regards,
Michal

[1] I understand the sending a fd of a client is a regular operation, so
    I'm not sure how cross-cg migrations would have to be handled in any
    case.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY86q5AAKCRAkDQmsBEOq
ueEGAQDI5fZQTAIasuzhXqvhso/sSZM6kjJABNN/jGexID1/AgEA7ESyKCV82koM
JsjtlGG3kRl/Y0LhTvA4J7akVFgGdQo=
=vAYz
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
