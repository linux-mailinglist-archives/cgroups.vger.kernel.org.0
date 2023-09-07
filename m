Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2237979F4
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjIGR0G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbjIGRZ4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 13:25:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FE10FB;
        Thu,  7 Sep 2023 10:25:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7A341F8B0;
        Thu,  7 Sep 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694097665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/GWuQ82O0cqDWnLwHLamdkhZxjacO2j0BJIXilWXjc=;
        b=G8pcgQbRkAoNq1GD1BaIXvsUmciVqLKZ3+J18kyYCXaPXMgaX402fFxyOzzZx6Xl6D4t86
        mtFn0VpJdohH5CoNYW+E4K2M7VvAyKbz/BZEUjXCvJVeDURLzRTuxjrsZoohKBdPmwScJY
        5M00egnTaoz2lhQm/wCP5NCYQESf9mY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F6A138F9;
        Thu,  7 Sep 2023 14:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RTgBEwHh+WTSYwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 07 Sep 2023 14:41:05 +0000
Date:   Thu, 7 Sep 2023 16:41:04 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on
 cgroup1
Message-ID: <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpqfbqf66cnxpfb6"
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--lpqfbqf66cnxpfb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yafang.

On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@gmail.com> wrote:
> In our specific use case, we intend to use bpf_current_under_cgroup() to
> audit whether the current task resides within specific containers.

I wonder -- how does this work in practice?

If it's systemd hybrid setup, you can get the information from the
unified hierarchy which represents the container membership.

If it's a setup without the unified hierarchy, you have to pick one
hieararchy as a representation of the membership. Which one will it be?

> Subsequently, we can use this information to create distinct ACLs within
> our LSM BPF programs, enabling us to control specific operations performed
> by these tasks.

If one was serious about container-based ACLs, it'd be best to have a
dedicated and maintained hierarchy for this (I mean a named v1
hiearchy). But your implementation omits this, so this hints to me that
this scenario may already be better covered with querying the unified
hierarchy.

> Considering the widespread use of cgroup1 in container environments,
> coupled with the considerable time it will take to transition to cgroup2,
> implementing this change will significantly enhance the utility of BPF
> in container scenarios.

If a change like this is not accepted, will it make the transition
period shorter? (As written above, the unified hierarchy seems a better
fit for your use case.)

Thanks,
Michal

--lpqfbqf66cnxpfb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPng7wAKCRAGvrMr/1gc
juZAAQCCMKwWVeLjjokOs8ldESgvMuN/3xsmMmJaDv8ZAb2i4wD/VRDN7bDKUdMi
1L4tP03C2+tFBp0Y/7+DtsLxIGHuYQw=
=zosN
-----END PGP SIGNATURE-----

--lpqfbqf66cnxpfb6--
