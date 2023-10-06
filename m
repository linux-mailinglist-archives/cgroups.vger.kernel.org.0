Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178677BBD63
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjJFQ6v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjJFQ6u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 12:58:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30FFC
        for <cgroups@vger.kernel.org>; Fri,  6 Oct 2023 09:58:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6323211BC;
        Fri,  6 Oct 2023 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696611527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oi+MO38jNHJr8nQ6AS3FcO7/HgSSBEQS+pVLwQ+xGbA=;
        b=VqIP0oVLqJwwxP+Be/0NPDzoDJCGxmL7ZIphkX6YhvI70CnbOx5Uj6Rvc+52lGaPPwTPvF
        P8aGqTm1fPvVTYEiJisGFDKnLHKbfb0/Y1a/P7WsCNO+lrWtCtke9v1ndMCD584dzzHZ/Z
        LizLl2fyp27j4Hd835tCwUFQWqZWlsw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C539313586;
        Fri,  6 Oct 2023 16:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8FBZL8c8IGWTKgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 06 Oct 2023 16:58:47 +0000
Date:   Fri, 6 Oct 2023 18:58:46 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmsakqa3aklp5mzd"
Content-Disposition: inline
In-Reply-To: <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rmsakqa3aklp5mzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello T.J.

A curious case.

I was staring at the code and any ways occurring to me would imply
css_set_lock doesn't work.

OTOH, I can bring the reproducer to rmdir()=-EBUSY on my machine
(6.4.12-1-default) [1].

I notice that there are 2*nr_cpus parallel readers of cgroup.procs.
And a single thread's testimony is enough to consider cgroup empty.
Could it be that despite the 200ms delay, some of the threads see the
cgroup empty _yet_?
(I didn't do own tracing but by reducing the delay, I could reduce the
time before EBUSY was hit, otherwise it took several minutes (on top of
desktop background).)


On Tue, Oct 03, 2023 at 11:01:46AM -0700, "T.J. Mercier" <tjmercier@google.com> wrote:
...
> > The trace events look like this when the problem occurs. I'm guessing
> > the rmdir is attempted in that window between signal_deliver and
> > cgroup_notify_populated = 0.

But rmdir() happens after empty cgroup.procs was spotted, right?
(That's why it is curious.)

> > However on Android we retry the rmdir for 2 seconds after cgroup.procs
> > is empty and we're still occasionally hitting the failure. On my
> > primary phone with 3 days of uptime I see a handful of cases, but the
> > problem is orders of magnitude worse on Samsung's device.

Would there also be short-lived members of cgroups and reading
cgroup.procs under load?


Thanks,
Michal

[1] FTR, a hunk to run it without sudo on a modern desktop:
-static const std::filesystem::path CG_A_PATH = "/sys/fs/cgroup/A";
-static const std::filesystem::path CG_B_PATH = "/sys/fs/cgroup/B";
+static const std::filesystem::path CG_A_PATH = "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/a";
+static const std::filesystem::path CG_B_PATH = "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/b";


--rmsakqa3aklp5mzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSA8xAAKCRAGvrMr/1gc
jh9RAQDAWBkyO1/2rF2C2BVyymsfN1T9WwhwvA8ES1Lp0AQnhAD/VI3PKGLdGSna
H17Y7lOG72616Ah31gCZAfFkNff0sAw=
=SKzT
-----END PGP SIGNATURE-----

--rmsakqa3aklp5mzd--
