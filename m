Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA368C234
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBFPvN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 10:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBFPvN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 10:51:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C156589;
        Mon,  6 Feb 2023 07:51:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFA826061D;
        Mon,  6 Feb 2023 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675698670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fhVqQ68veOG9L/p1SZuHOGXVu/+YnsgNDr8L++Nf6Y=;
        b=hasfkwf5qLMSjdjBN6tNl9erNVm4U6hoHsFNNv8OenccPiydH09u+yHslUPouNtKnn2j4N
        IRgHQtzLbkOt8iKWYtUOv6bo1JcUIFxWHwPmp2gSgcxRDuF2Ctx5P6pQwAe+dzYWZqeVsp
        54yNNtbDWOGQDl97k5EHhRinkwPr6Gw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D1F7138E7;
        Mon,  6 Feb 2023 15:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R8GOIe4h4WPrdwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 15:51:10 +0000
Date:   Mon, 6 Feb 2023 16:51:09 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Merge individual nohz_full features
 into a common housekeeping flag
Message-ID: <20230206155107.GA31453@blackbody.suse.cz>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20230203232409.163847-2-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Frederic.

On Sat, Feb 04, 2023 at 12:24:08AM +0100, Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> The individual isolation features turned on by nohz_full were initially
> split in order for each of them to be tunable through cpusets. However
> plans have changed in favour of an interface (be it cpusets or sysctl)
> grouping all these features to be turned on/off altogether.
> Then should the need ever arise, the interface can still be expanded
> to handle the individual isolation features.
>=20
> Therefore the current isolation split between tick/timer/workqueue/rcu/
> kthreads/misc doesn't make sense anymore.

Why it doesn't make sense? I think it's a useful annotation of
respective operations wrt CPU isolation.

The grouping you did into HK_TYPE_KERNEL_NOISE (or even coarser) should
IMO be done at the place where it'll be exposed into the favored
interface (like it's with nohz_full=3D).

Thanks,
Michal

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+Eh4QAKCRAkDQmsBEOq
uY4SAQCzuyUGyy1DTu07dJpsvqnTWqj22goDeqZvTqIu0AP03gEAyBFBBPOZ8x2z
1AxH3gDttpfyCcnalCsgb2sHDcUf+gA=
=pZsI
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
