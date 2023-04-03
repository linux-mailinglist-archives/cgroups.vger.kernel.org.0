Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947B06D4E76
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjDCQza (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjDCQz2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 12:55:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F617172C;
        Mon,  3 Apr 2023 09:55:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D74C121F41;
        Mon,  3 Apr 2023 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680540924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjHTDLKnu47Af8/RYRI8Ep8eWiGDBHSZDf7lS1gT7w8=;
        b=CEfOfG3UaWRbtseNKY9DpsYv+24G2DErlSrzrBLWXwn7D9NOSFcy7jOqZsSWAfOKQNB9vC
        w0OKgbKTVzYTREfxDKWgjtGaNzyYHCFpfTVzLWYiCgrnFjS4xOKNhnoFEkauyNHAIded4E
        9b1BuHPOi+OUq7CGt3aCyfpOT1O7Hcs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5DD01331A;
        Mon,  3 Apr 2023 16:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fxKEJ/wEK2RbbQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Apr 2023 16:55:24 +0000
Date:   Mon, 3 Apr 2023 18:55:23 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Message-ID: <20230403165523.aphsec2epqi72k27@blackpad>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hqjzbb4yslshnocc"
Content-Disposition: inline
In-Reply-To: <20230331145045.2251683-2-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--hqjzbb4yslshnocc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 10:50:43AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> By default, the clone(2) syscall spawn a child process into the same
> cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
> introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
> into cgroups"), the child will be spawned into a different cgroup which
> is somewhat similar to writing the child's tid into "cgroup.threads".
>=20
> The current cpuset_fork() method does not properly handle the
> CLONE_INTO_CGROUP case where the cpuset of the child may be different
> from that of its parent.  Update the cpuset_fork() method to treat the
> CLONE_INTO_CGROUP case similar to cpuset_attach().

Should .can_fork=3Dcpuset_can_fork in analogy to cpuset_can_attach be also
devised? (Sorry if I missed that in the previous discussion.)

>=20
> Since the newly cloned task has not been running yet, its actual
> memory usage isn't known. So it is not necessary to make change to mm
> in cpuset_fork().
>=20
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks,
Michal

--hqjzbb4yslshnocc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCsE9gAKCRAkDQmsBEOq
uXNEAP4yZWUDQPS5MdBJKxg7KPFXijvx7boOQCgxkNjZYray+wD+JXdFvFEi1rKM
oOJu9alNdUlt9cXh0vK+1QGgfk7KggQ=
=9fk7
-----END PGP SIGNATURE-----

--hqjzbb4yslshnocc--
