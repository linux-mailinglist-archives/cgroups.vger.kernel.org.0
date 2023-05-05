Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3879E6F87A2
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEERdG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjEERdF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 13:33:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603171A4B5;
        Fri,  5 May 2023 10:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F271F1FE20;
        Fri,  5 May 2023 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683307962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=08FuX13wN9U4YYw2axhJqWpBUnoUcHOE2BMKcuHHIII=;
        b=dSvKo4grqGLt7OmzVg7CvER57EhkmRq43a6GttLWDA5VsTzGOjkr03cZx88FUETDQfnQKQ
        +6cC/JbCvornmP+fW+kmIflQXd0nBQ67ryVRD/tVNdVe9L3/bISJGQv+7ggjZLE7hzD8fN
        UuFbRmICbHw5Y0K1bER7vze628L+ysM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCB1413513;
        Fri,  5 May 2023 17:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tiArLbk9VWSnRAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 05 May 2023 17:32:41 +0000
Date:   Fri, 5 May 2023 19:32:40 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in
 cgroup_show_path
Message-ID: <ta7bilcvc7lzt5tvs44y5wxqt6i3gdmvzwcr5h2vxhjhshmivk@3mecui76fxvy>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
 <ZFUktg4Yxa30jRBX@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rylaem3izw3vqdtr"
Content-Disposition: inline
In-Reply-To: <ZFUktg4Yxa30jRBX@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rylaem3izw3vqdtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 05:45:58AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > There are three relevant nodes for each cgroupfs entry:
> >=20
> >         R ... cgroup hierarchy root
> >         M ... mount root
> >         C ... reader's cgroup NS root
> >=20
> > mountinfo is supposed to show path from C to M.
>=20
> At least for cgroup2, the path from C to M isn't gonna change once NS is
> established, right?

Right. Although, the argument about M (when C above M or when C and M in
different subtrees) implicitly relies on the namespace_sem.

> Nothing can be moved or renamed while the NS root is there. If so,
> can't we just cache the formatted path and return the same thing
> without any locking?

Here I find the caching complexity not worth it for v2 only (also C is
in the eye of the beholder) -- because then css_set_lock can be dropped
=66rom cgroup_show_path with simpler reasoning.

(Sadly, the bigger benefit would be on hybrid setups multiplied by the
number of v1 hierarchies listed.)

(OTOH, the caching argument and weights for it may be different for
/proc/$pid/cgroup.)

> The proposed changes seem a bit too brittle to me.

OK, I'll look into separate cgroup_show_path and cgroup1_show_path
approach.

Thanks,
Michal

--rylaem3izw3vqdtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZFU9swAKCRAkDQmsBEOq
uSoLAQD754ptzc5v4SJdwNDmNSnDSByFIjlKbnAxKHci/pO4ywD+MIDAb1A+syAS
I2WGGvHWDmD2tCQtQb85PVVcokfqkQ0=
=uY1H
-----END PGP SIGNATURE-----

--rylaem3izw3vqdtr--
