Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1A6A44DE
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjB0Omm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 09:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjB0Oml (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 09:42:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AD20571;
        Mon, 27 Feb 2023 06:42:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 693EB1FD67;
        Mon, 27 Feb 2023 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677508958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BdizNH1AzSr0bKpBzNhArg9yFjow/CCwchYkew7eG8k=;
        b=pqUg/q6/MUBr1HnwOq2Z4zkg0ZwcBEX7c8zJkoNMfAMDc0o/YbFfh96lMqOWYqoEOxCR/n
        xhGpnCZTnjAKDQ+QzC6+DypAo39hvZx0yCFYWJluxJBpy3aoDSq97ScBF2XM4x137ishdq
        V9PWkJY+8PpVVO8KBzrfuCd9ivVQt7I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C474F13A43;
        Mon, 27 Feb 2023 14:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fOL0Ll3B/GNkEQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 27 Feb 2023 14:42:37 +0000
Date:   Mon, 27 Feb 2023 15:42:36 +0100
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
Message-ID: <20230227144236.z6zbgsaohlz6sl7o@blackpad>
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-7-vincent.guittot@linaro.org>
 <20230224192919.d4fcde3dwh7betvm@blackpad>
 <CAKfTPtBorwnjU2=nprBo7aAEjoz+7x5nRYUdajZc53cuVgHSBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k2vtvr4lfwegj6vr"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBorwnjU2=nprBo7aAEjoz+7x5nRYUdajZc53cuVgHSBw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--k2vtvr4lfwegj6vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 02:44:22PM +0100, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Regarding the current use of latency nice to set a latency offset, the
> problem doesn't appear because latency offset applies between entities
> at the same level as you mentioned above

Splendid, it turned out that way (latency nice analogous to bandwidth
nice).

> Does  my explanation above make sense to you ?

Yes, thank you.

Thus, I'd like to propose avoiding the use of "limit" in this context and
stress the horizontal scope. For example:

> +     This interface file allows reading and setting latency using the
> +     same values used by sched_setattr(2). The latency_nice of a group is
> +     used to limit the impact of the latency_nice of a task outside the
> +     group.

+     This interface file allows reading and setting latency using the
+     same values used by sched_setattr(2). The latency_nice of a group is
+     used to modify group members' latency with respect to sibling groups.

Regards,
Michal

--k2vtvr4lfwegj6vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY/zBWgAKCRAkDQmsBEOq
uRXXAP4nBfg1JWkFJlUphJU/HXYaqG7HKuwUDehUmhtQOcLnRQD/XqLftrr1aayr
WcfeRCiKVdubEZX6L35zYCrcNd3hBAM=
=FRsw
-----END PGP SIGNATURE-----

--k2vtvr4lfwegj6vr--
