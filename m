Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111597B7095
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjJCSLJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJCSLI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 14:11:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B083;
        Tue,  3 Oct 2023 11:11:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96A882188F;
        Tue,  3 Oct 2023 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696356664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYYOS2Rb4Gft46HT9a3Ew+hqjRkAXefJxlOoM/tdWIY=;
        b=HjXqxe8/wntTzrvTsNfrdAnyH44mpAxBB6GfxJpG+O5R+e4+dnQHgqK9G5JCIrOIEjL3NE
        T23x25vBLUDKeflfuTNYE0yyZKiN856A+VVR4uA/Gw1qrQopSUditko2I6uEw7eWU4tcMN
        NGDPRRnyZbYrxIO2LKxocUmkG14coDI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DEFB139F9;
        Tue,  3 Oct 2023 18:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lc4wGjhZHGVCNwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 03 Oct 2023 18:11:04 +0000
Date:   Tue, 3 Oct 2023 20:11:03 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3qdsoh2u6z4zu32"
Content-Disposition: inline
In-Reply-To: <20230922175741.635002-2-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--i3qdsoh2u6z4zu32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 05:57:39PM +0000, Yosry Ahmed <yosryahmed@google.com> wrote:
> memcg_page_state_unit() is currently used to identify the unit of a
> memcg state item so that all stats in memory.stat are in bytes. However,
> it lies about the units of WORKINGSET_* stats. These stats actually
> represent pages, but we present them to userspace as a scalar number of
> events. In retrospect, maybe those stats should have been memcg "events"
> rather than memcg "state".

Why isn't it possible to move WORKINGSET_* stats under the events now?
(Instead of using internal and external units.)

Thanks,
Michal

--i3qdsoh2u6z4zu32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZRxZNQAKCRAGvrMr/1gc
jgo0AQDb9lpy0zerQzFtiZH/g19b+bqmEZBBe46qnjohE+hXYgD/WBCdV4mnuxTI
vnNNETrx33ndymulCkeglLV+sj3sYwc=
=mr+D
-----END PGP SIGNATURE-----

--i3qdsoh2u6z4zu32--
