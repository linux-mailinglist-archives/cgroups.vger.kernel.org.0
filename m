Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F826C82F9
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjCXRLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjCXRLa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 13:11:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6C21942;
        Fri, 24 Mar 2023 10:11:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AB011FF94;
        Fri, 24 Mar 2023 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679677876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWmn6S5YIs367DkBrcliyowrdz09FT4jicvN67WVd1Q=;
        b=Eku5Ernzy7mmNguDiowGGaJXYc7ZQ2vU1KA46inl7ZfH1RKMVqbk8gnL3KMsKyAYqEMkRf
        2Om7zsa2zVwanBak0bzaUtO90jxztxVY5c1O9xoFBMa4ej1q6pdLlSZYzj4RAjiYcBxMmD
        v7hqcgJV90Eh9vjW41I6rIxVrngWD6Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0157138ED;
        Fri, 24 Mar 2023 17:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HW2INbPZHWQwJAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 17:11:15 +0000
Date:   Fri, 24 Mar 2023 18:11:14 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Cai Xinchen <caixinchen1@huawei.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, longman@redhat.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yosryahmed@google.com, mpenttil@redhat.com
Subject: Re: [PATCH 1/1] mm: memcontrol: fix vmstats_percpu state incorrect
 subtraction after reparent
Message-ID: <20230324171114.32oru5sdubfsfvgi@blackpad>
References: <20230320030648.50663-1-caixinchen1@huawei.com>
 <20230320030648.50663-2-caixinchen1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdhfeu2yhc5s3ooc"
Content-Disposition: inline
In-Reply-To: <20230320030648.50663-2-caixinchen1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--zdhfeu2yhc5s3ooc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Mar 20, 2023 at 03:06:48AM +0000, Cai Xinchen <caixinchen1@huawei.com> wrote:
> When memcg C is offllined, its pages are reparented to memcg P,
> so far P->vmstats (hierarchical) have those pages, and
> P->vmstats_percpu (non-hierarchical) don't. When those pages get
> uncharged, P->vmstats (hierachical) decreases, which is correct,
> but P->vmstats_percpu (non-hierarchical) also decreases, which
> is wrong, as those stats were never added to P->vmstats_percpu to
> begin with.

I was wondering why ->vmstats_percpu matters (in the end all is summed
in ->vmstats) -- do you mean this is a cgroup v1 only issue? As only
that exposes the non-hieararchical stats.

Thanks,
Michal

--zdhfeu2yhc5s3ooc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB3ZsAAKCRAkDQmsBEOq
ubgvAP0S0+i6gFMj+uLkO7p+vwL0oN12X2x0vhGGOkGva271GAD/RP/Nz+EJ6cb5
hc9lBjB3CbP+EKpYGdVof3rKoyv4Wws=
=uY3T
-----END PGP SIGNATURE-----

--zdhfeu2yhc5s3ooc--
