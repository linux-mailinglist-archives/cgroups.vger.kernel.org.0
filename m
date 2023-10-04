Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994A7B8A25
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbjJDScr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244249AbjJDScq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:32:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2DA6;
        Wed,  4 Oct 2023 11:32:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4D771F45A;
        Wed,  4 Oct 2023 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696444360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4VXNBgch7cHxmFAAfzZ4yk5G9bBv4IijY2ezEVg1sI=;
        b=q/nTqZ7HNJl0vlRvhOtwEPvLtgxtFocf5ftD56dKVl0FPuULOQaHC14ugXq6VkQ/dD1SpJ
        XxPViUE9If05/xUd6xRLKOJ3xpJ0nNQ8JkqyhiNe9A3TuQ72DIqatVz75ZWCdVixXdLl76
        ZZURgLF1RgVTYYjoT1TQZBB+/EO2tyo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6ECD139F9;
        Wed,  4 Oct 2023 18:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpfVK8ivHWV/dQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 Oct 2023 18:32:40 +0000
Date:   Wed, 4 Oct 2023 20:32:39 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 0/5] mm: improve performance of accounted kernel
 memory allocations
Message-ID: <n3x64d2wk7qr42tvcmqisbbrntppcwe6omv6li67ui6rz6umyk@wativjrwvh5g>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrhdawqlfcfif6oj"
Content-Disposition: inline
In-Reply-To: <20230929180056.1122002-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--xrhdawqlfcfif6oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 11:00:50AM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> This patchset improves the performance of accounted kernel memory allocations
> by ~30% as measured by a micro-benchmark [1]. The benchmark is very
> straightforward: 1M of 64 bytes-large kmalloc() allocations.

Nice.
Have you tried how these +34% compose with -34% reported way back [1]
when file lock accounting was added (because your benchmark and lock1
sound quite similar)?
(BTW Is that your motivation (too)?)

Thanks,
Michal

[1]  https://lore.kernel.org/r/20210907150757.GE17617@xsang-OptiPlex-9020/

--xrhdawqlfcfif6oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR2vxQAKCRAGvrMr/1gc
jrolAQCd8T26iT1xL/GtSHTC7BZH+GIQ5QrCf0gJt5shxk7K2wEAu4q5L5+nO7Hz
BDRacJqGpEoX/IwT3UmgeM1mIClLHwo=
=SuM6
-----END PGP SIGNATURE-----

--xrhdawqlfcfif6oj--
