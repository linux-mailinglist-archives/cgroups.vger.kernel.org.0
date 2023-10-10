Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083F7C01A2
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjJJQbZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJJQbY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 12:31:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688997
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 09:31:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BE8C215D5;
        Tue, 10 Oct 2023 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696955480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Q1U1CHyXGVO2PbSA3d0dUiTq95KBSuvwcgYtdrhTwA=;
        b=pT+Yy06v+X0puT9a7QKxnhYs2UQQT7k1V5iXUDUdxzAWQUoOomos5Gb3ija4MX23icxbJP
        FIl8YmMgXB1RckjFIzFjezEFeFxIlJPcZ5uTMouum7ssWtzqI03kIkAJI2qfdd8rqnspHg
        /UbFAdgDA3LzvqKBpNETrUIh0l266l0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1A21358F;
        Tue, 10 Oct 2023 16:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ocd+CVh8JWWPNwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 10 Oct 2023 16:31:20 +0000
Date:   Tue, 10 Oct 2023 18:31:18 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zcajmngpzzh7f7m4"
Content-Disposition: inline
In-Reply-To: <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--zcajmngpzzh7f7m4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 11:37:19AM -0700, "T.J. Mercier" <tjmercier@google.=
com> wrote:
> I suppose it's also possible there is PID reuse by the same app,
> causing the cgroup to become repopulated at the same time as a kill,
> but that seems extremely unlikely. Plus, at the point where these
> kills are occurring we shouldn't normally be simultaneously launching
> new processes for the app. Similarly if a process forks right before
> it is killed, maybe it doesn't show up in cgroup.procs until after
> we've observed it to be empty?

Something like this:

							kill (before)
cgroup_fork
cgroup_can_fork .. begin(threadgroup_rwsem)
tasklist_lock
fatal_signal_pending -> cgroup_cancel_fork		kill (mid)
tasklist_unlock
							seq_start,
							seq_next...

cgroup_post_fork  .. end(threadgroup_rwsem)	=09
							kill (after)

Only the third option `kill (after)` means the child would end up on the
css_set list. But that would mean the reader squeezed before
cgroup_post_fork() would still see the parent.
(I.e. I don't see the kill/fork race could skew the listed procs.)

(But it reminds me another pathological case of "group leader
 separation" where:
- there is a multithreaded process,
- threadgroup leader exits,
- threadgroup is migrated from A to B (write to cgroup.procs)
  - but leader stays in A (because it has PF_EXITING),
- A will still show it in cgroup.procs,
- B will not include it in cgroup.procs despite it hosts some threads of
  the threadgroup (effectively populated).
It's been some time, I didn't check if it's still possible nowadays.)

BTW is there any fundamental reason the apps cannot use the
notifications via cgroup.events as recommended by Tejun?

Thanks,
Michal

--zcajmngpzzh7f7m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSV8VAAKCRAGvrMr/1gc
jsWdAQDPj0t4X2+v7sZxp1Sa0s6sT3E6sfs9Ls5aUrDY9r7CJAD4pMa5kWFEEeur
T5hm4LGVm29UfXT7guB4/p+AXytjBA==
=lLLj
-----END PGP SIGNATURE-----

--zcajmngpzzh7f7m4--
