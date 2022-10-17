Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F36016A8
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJQSwn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJQSwm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 14:52:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA972ED4
        for <cgroups@vger.kernel.org>; Mon, 17 Oct 2022 11:52:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DADA25BFCA;
        Mon, 17 Oct 2022 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666032759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uIg/vWRDzwcg+FnbrRQRZsB7kMPtfjh8GsB556SPdCE=;
        b=opkb3ve0AqetQ24+LxR7h4nCUtfSNEtlQ16c+8jm7TtbDpuPTQc24EklqJhdYisPgtwIq+
        1hzt/V+jP3veWOnLweikP1UqTd6OsekH8QTMgpz1dzxJPs/N0pS1xWl7zohBsLC0rWCfHI
        yVO3G4J3tCyfvLTwQY8zDhjJ1Sp9+wI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A118B13398;
        Mon, 17 Oct 2022 18:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AqNGJnekTWPhBgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 17 Oct 2022 18:52:39 +0000
Date:   Mon, 17 Oct 2022 20:52:38 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [RFC] memcg rstat flushing optimization
Message-ID: <20221017185238.GA7699@blackbody.suse.cz>
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Oct 04, 2022 at 06:17:40PM -0700, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> Sorry for the long email :)

(I'll get to other parts sometime in the future. Sorry for my latency :)

> We have recently ran into a hard lockup on a machine with hundreds of
> CPUs and thousands of memcgs during an rstat flush.
> [...]

I only respond with some remarks to this particular case.


> As you can imagine, with a sufficiently large number of
> memcgs and cpus, a call to mem_cgroup_flush_stats() might be slow, or
> in an extreme case like the one we ran into, cause a hard lockup
> (despite periodically flushing every 4 seconds).

Is this your modification from the upstream value of FLUSH_TIME (that's
every 2 s)?

In the mailthread, you also mention >10s for hard-lockups. That sounds
scary (even with the once per 4 seconds) since with large enough update
tree (and update activity) periodic flush couldn't keep up.
Also, it seems to be kind of bad feedback, the longer a (periodic) flush
takes, the lower is the frequency of them and the more updates may
accumulate. I.e. one spike in update activity can get the system into
a spiral of long flushes that won't recover once the activity doesn't
drop much more.=20

(2nd point should have been about some memcg_check_events() optimization
or THRESHOLDS_EVENTS_TARGET justifying delayed flush but I've found none to=
 be applicable.
Just noting that v2 fortunetly doesn't have the threshold
notifications.)

Regards,
Michal

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY02kdAAKCRAkDQmsBEOq
ucSYAQC1iiT2OoWMBWVeABnkerHapSlZb9R02QB2KaKYuq0IeQEAhZVf5gQ3FK2e
7yTBVL+HCfkrSeToyI19ckXOnIIGBwA=
=s/Rd
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
