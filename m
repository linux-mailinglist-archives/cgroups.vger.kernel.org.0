Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6868C220
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBFPrr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 10:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBFPro (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 10:47:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7C86B8;
        Mon,  6 Feb 2023 07:47:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2328260608;
        Mon,  6 Feb 2023 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675698432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6gmdUnhXsh7F4Q5zhkhB8x3HI32ubbjTYXnnm6617s=;
        b=TKoEbDH2jSv0bb1xA/TIpfuqrEK9SpggArYwLP+ikxpLtL5CRk3bD7ngMACkIw0VedzTtP
        cJMtJkSSFdtOM70Cyy0ORW/pbsaM1Te6hbLfpqXfwCqAkGBvPHtq04YGwSBHN9GHhJcaIK
        LhSybdGzki92Wxjlz6kPfmaPVDSeXp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5924138E7;
        Mon,  6 Feb 2023 15:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cGJcM/8g4WOadQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 15:47:11 +0000
Date:   Mon, 6 Feb 2023 16:47:10 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <20230206154710.GC21332@blackbody.suse.cz>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-3-frederic@kernel.org>
 <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Feb 03, 2023 at 10:53:46PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> CPUs in an isolated cpuset partition is similar to HK_TYPE_DOMAIN CPUs as
> load balancing is disabled. I can add an API to access the cpumask and add
> to this API. However, that list is dynamic as it can be changed at run ti=
me.
> Will that be a problem?

I can see a problem already -- as a CPU can be dynamically switched to
"isolated" mode so should all dependent operations support that (switch)
too, i.e. the CPUs local PCP caches would have to be drained when the
CPU enters isolation.

> Or should that be used separately?

It'd be nice to have both (cpuset and cmdline flags) eventually unified.

Alas, it only leads me conservatively to:

#ifndef CONFIG_CPUSETS
// the proposed implementaion
else
static inline bool cpu_is_isolated(int cpu) {
	return true;
}
#endif

My 0.02=E2=82=AC,
Michal


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+Eg/AAKCRAkDQmsBEOq
uez7AQDvZKyGoF72K2smV4hq3/IPwBfNLn2t+ww7L0b8II8ihgD+L95xmOMksNcs
blBIR3kqNeUmmECFUeYuPOGLfWIGygc=
=chfl
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
