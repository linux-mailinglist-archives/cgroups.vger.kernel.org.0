Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57135F3255
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJCPIl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJCPIk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 11:08:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325481BEBE;
        Mon,  3 Oct 2022 08:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D54AA21982;
        Mon,  3 Oct 2022 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664809717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aytUdXlGSVAVAW293DkhDivkGR0N7fkvULdwZOjcsOA=;
        b=n/FrNF6zgz6jZFmZnlJOWIbrGzQYXL6yM0mJ/jc+QIH1ww+yX9V1b8JfTsKpXG0QyYRZmf
        gIWbP1pq/MTUlu8K1wfZh8MsW1LfrK7LvQVeKNgMVX51MimhtIJL5YlF+de/kXp+5BF+0J
        Pnl3KLp1HBlbjwAkHetW094SQIHonQM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A974C13522;
        Mon,  3 Oct 2022 15:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O/oGKPX6OmN5dgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Oct 2022 15:08:37 +0000
Date:   Mon, 3 Oct 2022 17:08:36 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] memcg: calling reclaim_high(GFP_KERNEL) in GFP_NOFS
 context deadlocks
Message-ID: <Yzr69M9MtNYIKPBx@blackbook>
References: <20220929215440.1967887-1-david@fromorbit.com>
 <20220929222006.GI3600936@dread.disaster.area>
 <YzbesGeUkX3qwqj8@blackbook>
 <20220930220834.GK3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OOHJpowuF7rqPJPU"
Content-Disposition: inline
In-Reply-To: <20220930220834.GK3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--OOHJpowuF7rqPJPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 01, 2022 at 08:08:34AM +1000, Dave Chinner <david@fromorbit.com> wrote:
> You might be right in that c9afe31ec443 exposed the issue, but it's
> not the root cause. I think c9afe31ec443 just a case of a
> new caller of mem_cgroup_handle_over_high() stepping on the landmine
> left by b3ff92916af3 adding an unconditional GFP_KERNEL direct
> reclaim deep in the guts of the memcg code.

It's specific of the memory.high induced reclaim that it happens out of
sensitive paths (as was with exit to usermode or workqueue), so there'd
be no explicit flags to pass through, hence the unconditional
GFP_KERNEL.

> So what's the real root cause of the issue - the commit that stepped
> on the landmine, or the commit that placed the landmine?

My preference here is slighty on the newer commit but feel free to
reference both.

> Either way, if anyone backports b3ff92916af3 or has a kernel with
> b3ff92916af3 and not c9afe31ec443, they still need to know
> about the landmine in b3ff92916af3....

To be on the same page -- having just b3ff92916af3 won't lead to the
described cycle when FS code reclaims without GFP_NOFS? (IOW, how would
the fix look like fix without c9afe31ec443?)

Thanks,
Michal

--OOHJpowuF7rqPJPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYzr68gAKCRAkDQmsBEOq
uShAAP4nCUb/8BBe0G5NPxDTfRtDkhqnQSLtUqP1SheQihbQ8AEA08BzlyOuRTWH
DwghMoqgqag9V2P98YpcCDpA2R/KvwA=
=/1mZ
-----END PGP SIGNATURE-----

--OOHJpowuF7rqPJPU--
