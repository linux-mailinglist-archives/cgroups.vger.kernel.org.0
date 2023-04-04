Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB56D5B83
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjDDJIJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 05:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjDDJH6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 05:07:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34001211B;
        Tue,  4 Apr 2023 02:07:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD1F0204A6;
        Tue,  4 Apr 2023 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680599258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rp1byrR7s3fkY4PjvvNsxVQi+oUszqEO+iMKVPDKdIk=;
        b=vN5Ed2ujeDnWAjclyPn/8Eom7F+TJM78c7KtgnToFgnIAyfD/Aqnrk2NbDUMKyifUwUr3n
        1Z0YS0qvLrdWg5nhZro2NuiBBACFME+zaWDHYJj5dEu53In+Z1Nw3swHJXTXv6oHw5ffoW
        rhiePGvP9y7/aefjEMuTGxZqtjWmjIc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5BCA1391A;
        Tue,  4 Apr 2023 09:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 62d7J9roK2TfLAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Apr 2023 09:07:38 +0000
Date:   Tue, 4 Apr 2023 11:07:37 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach
 operation per cpuset
Message-ID: <20230404090737.3g3uxga52bojgdu5@blackpad>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-4-longman@redhat.com>
 <20230403164736.lpjdpzxxnjlpxrqv@blackpad>
 <24b67530-62ce-4f9c-7b74-d41d2ccc710e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilogas4aec7si4wz"
Content-Disposition: inline
In-Reply-To: <24b67530-62ce-4f9c-7b74-d41d2ccc710e@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ilogas4aec7si4wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Mon, Apr 03, 2023 at 01:41:33PM -0400, Waiman Long <longman@redhat.com> wrote:
> This patch is actually not related to the CLONE_INTO_GROUP problem in patch
> 1. It is a generic problem when multiple users are moving threads into
> cgroup.threads of the same or different cpusets simultaneously.

I meant this:
	__cgroup_procs_write
	  cgroup_kn_lock_live
	    mutex_lock(&cgroup_mutex)

and (more succintly)
	cgroup_update_dfl_csses
	  lockdep_assert_held(&cgroup_mutex)

Even the threaded migrations should be synchronized here.
Can you please explain in more detail what's the problematic case?

> I don't believe this patch has a dependency on patch 1.

(I meant the opposite, patch 1 would depend in this 3/3. But maybe this
one isn't need.)

Michal

--ilogas4aec7si4wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCvoyAAKCRAkDQmsBEOq
uWSoAP41lQ11CXnVKE2G4jMF7tULituGE65Jni9yu8QGOPvQEAD/cthzkgC2745v
rrgDBOyUhh+6zjNzCq6nigOTN7j16w8=
=z1SR
-----END PGP SIGNATURE-----

--ilogas4aec7si4wz--
