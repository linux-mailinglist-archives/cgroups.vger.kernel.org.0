Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DA68C2FE
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBFQTm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 11:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjBFQT0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 11:19:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF52F7BB;
        Mon,  6 Feb 2023 08:19:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0F3E1FDC4;
        Mon,  6 Feb 2023 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675700324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDZV3mvNGQ6bQlUZNt+pm2+TOpLBe+J478jwvr5iYPs=;
        b=hQO7lfu/O7FHy0nrH+ZhkVayWc951N8vQUFqsqBQVt4PbLGzLrGPHE0FDkfgw6DtmqrQPF
        qa2n3gEEry2sT6DZB/Rg+HdMe6NO7pTxDB6Xavt7nlAC7Uxskyt7xQPfC/06rlzBMBlBxC
        3x3/WqSPCBN2XPQ1ctlHBSeoxXMyGEg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93FF5138E7;
        Mon,  6 Feb 2023 16:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ubUoI2Qo4WP5BwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 16:18:44 +0000
Date:   Mon, 6 Feb 2023 17:18:43 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <20230206161843.GD21332@blackbody.suse.cz>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 10:30:40AM -0800, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > b) Only count cgroup swap events when they are actually due to a
> >    cgroup's own limit. Exclude failures that are due to physical swap
> >    shortage or other system-level conditions (like !THP_SWAP). Also
> >    count them at the level where the limit is configured, which may be
> >    above the local cgroup that holds the page-to-be-swapped.
> >
> >    This is in line with how memory.swap.high, memory.high and
> >    memory.max events are counted.
> >
> >    However, it's a change in documented behavior.
>=20
> This option makes sense to me, but I can't speak to the change of
> documented behavior. However, looking at the code, it seems like if we do=
 this
> the "max" & "fail" counters become effectively the same. "fail" would
> not provide much value then.
>=20
> I wonder if it makes sense to have both, and clarify that "fail" -
> "max" would be non-limit based failures (e.g. ran out of swap space),
> or would this cause confusion as to whether those non-limit failures
> were transient (THP fallback) or eventual?

I somewhat second this.

Perhaps, could the patch (and arguments) be split in two:
1) count .max events on respective limit's level (other limits consistency),
2) redefine (remove?) memory.swap.fail events?

Michal

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+EoYQAKCRAkDQmsBEOq
uXuJAQCRA9+UXkEzfVoUWjltXKLdc9vqvH0D5zne/GZdvubZBwEAoxc1UQlw1YcL
8fUMQsShXoCJhwMdfV5kVkrsg1du8ww=
=agtq
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
