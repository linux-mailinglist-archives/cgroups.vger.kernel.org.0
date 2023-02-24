Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4B6A2258
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 20:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBXT3Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXT3Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 14:29:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD0688D7;
        Fri, 24 Feb 2023 11:29:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB2963ECA0;
        Fri, 24 Feb 2023 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677266961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnAMd8q05Oc+Az6aeyniIup+x2AJU5/PdX1pnOCHdJs=;
        b=cU2tCFgRPQYdnsnpsRf1Poa8TL/3C6O/oI0EPZZp19/BGEaSu17O+F+NHq4lp5ZzRzaTFk
        l9v2ieikO/5p3NfDdJjrp5yebQEsFutRZScsHqlaF6k22o+0Y2ViWpvl58eZRdowV/Lk7f
        0aW3Ztv9IcFZWs9dVMz+WqQOZ93Du6A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3057313246;
        Fri, 24 Feb 2023 19:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vxKVChEQ+WNPBgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Feb 2023 19:29:21 +0000
Date:   Fri, 24 Feb 2023 20:29:19 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH v12 6/8] sched/fair: Add sched group latency support
Message-ID: <20230224192919.d4fcde3dwh7betvm@blackpad>
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ach44qdpkbnxkdxs"
Content-Disposition: inline
In-Reply-To: <20230224093454.956298-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ach44qdpkbnxkdxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vincent.

On Fri, Feb 24, 2023 at 10:34:52AM +0100, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> +  cpu.latency.nice
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	The nice value is in the range [-20, 19].
> +
> +	This interface file allows reading and setting latency using the
> +	same values used by sched_setattr(2). The latency_nice of a group is
> +	used to limit the impact of the latency_nice of a task outside the
> +	group.

IIUC, the latency priority is taken into account when deciding between
entitites at the same level (as in pick_next_entity() or
check_preempt_wake()/find_matchig_se()).

So this group attribute is relevant in context of siblings (i.e. like
cpu.weight ~ bandwidth priority)?

I'm thus confused when it's referred to as a limit (in vertical sense).
You somewhat imply that in [1]:

> Regarding the behavior, the rule remains the same that a sched_entity
> attached to a cgroup will not get more (latency in this case) than
> what has been set for the group entity.

But I don't see where such a constraint would be implemented in the
code. (My cursory understanding above tends to horizontal comparisons.)

Could you please hint me which is right?

Thanks,
Michal

[1] https://lore.kernel.org/r/CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com/


--ach44qdpkbnxkdxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY/kQDQAKCRAkDQmsBEOq
ub3oAQDEfOX2TRBsjRsSXpo+vOEyZrjXeyDhQLhjWFuVBg+ULAD5ATvSCYRMEgA2
2bDHVH5lA4uSr/kcxYKHNEp+qw6K5w8=
=bajD
-----END PGP SIGNATURE-----

--ach44qdpkbnxkdxs--
