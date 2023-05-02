Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE236F4948
	for <lists+cgroups@lfdr.de>; Tue,  2 May 2023 19:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjEBRpC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 May 2023 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjEBRpC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 May 2023 13:45:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7496C3;
        Tue,  2 May 2023 10:45:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24EAF1F88D;
        Tue,  2 May 2023 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683049499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgLp4vIr0EtQova6tp/E9AbDg/ZxYjK50xAdJLTkr8o=;
        b=W66VaMlPsdg7qRR+/IjaOJTeNwxv1vMoKD8HyGhhnW4wrsOVBZ487iYDyvOIPhdoHgH9Hm
        8RB2Cnn2eU6iapC8fKjJM4AUsjeeKvGJWyD8qQ5HLDlKart23CaVomHZ5j28XszssBqbW6
        DD6fZk6sFljHjHnzkpoQX/rZy+PMziA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E79C134FB;
        Tue,  2 May 2023 17:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4o2SAhtMUWS6ZgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 17:44:59 +0000
Date:   Tue, 2 May 2023 19:44:57 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Michael Honaker <mchonaker@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: cgroup: Clarification around usage_in_bytes and its relation to
 the page counter
Message-ID: <p37th7kmkn3njp6nuu22qi5vnse3mdhlqen4wlk3ps26bdaujd@prgdu3vtm47y>
References: <CAAKLMZ1fM1d4Drw0D2AkEwAG9iFOyT9qboy1REWtwS6Q00BA6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32lmaltfn23dhzgl"
Content-Disposition: inline
In-Reply-To: <CAAKLMZ1fM1d4Drw0D2AkEwAG9iFOyT9qboy1REWtwS6Q00BA6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--32lmaltfn23dhzgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Michael.

On Wed, Apr 12, 2023 at 09:22:07PM -0400, Michael Honaker <mchonaker@gmail.com> wrote:
> I have been trying to get an accurate measurement of memory usage of a
> non-root cgroup, specifically a Kubernetes container,

Beware that containers are more or less based on sharing resources,
shared accounting is difficult and hence _accurate_ measurement may not
be available or the numbers need some amount of interpretation.

> and noticed some inconsistencies when comparing the value of
> `memory.usage_in_bytes` with the information in `memory.stat`. After
> further investigation of the cgroup docs
> (/admin-guide/cgroups/memory.rst#usage_in_bytes) and an old LMKL
> thread ("real meaning of memory.usage_in_bytes"),

[OT: I suggest you move to cgroup v2, the entities are IMO better named
and it's also more futureproof ;-)]

> I came to the understanding that `usage_in_bytes` actually shows the
> value of the resource counter which is an overestimation due to the
> counter being split into per-cpu chunks for caching,

I didn't read the thread but it's true that per-cpu batching may result
in an error (both signs in theory). Since around v5.13 the
implementation changed and error should be better:
O(nr_cpus * nr_cgroups(subtree) * MEMCG_CHARGE_BATCH) -> O(nr_cpus * MEMCG_CHARGE_BATCH).

> and that the real usage can be calculated from RSS+Cache gathered from
> `memory.stat`.  I've created cadvisor issue #3286
> (https://github.com/google/cadvisor/issues/3286) which goes into
> greater detail on my investigation with examples.

The difference that you spot there is not caused (merely) by the per-cpu
optimization.
What you see as the difference is mainly kernel memory (e.g. dentries,
inodes, task_struct,...) -- RSS+Cache would only show memory that
userspace is directly responsible for but not the kernel structures
(whose size depends on kernel implementation afterall).

(On v2, you could see breakdown of the kernel memory usage besides
others in memory.stat.)

> Is the above understanding still correct with the new page counters?
> If so, could any memory allocations be reflected in `usage_in_bytes`
> but not in `stat` for child cgroups? I want to ensure I'm not
> missing anything by only monitoring the `stat` file.

I hope the abve sheds some light on these questions.

Michal

--32lmaltfn23dhzgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZFFMFgAKCRAkDQmsBEOq
uW7sAP93XpdrwS/ZlcnjTUBXiArOSqPj3IhP2i88OpLg4ZvXwgEAn+XPgGGv+hWQ
wWxCTQjSrPbSD9acugPheEOKr/razQM=
=s6ba
-----END PGP SIGNATURE-----

--32lmaltfn23dhzgl--
