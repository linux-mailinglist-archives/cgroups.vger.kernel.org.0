Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9827A4C28
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjIRP1V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIRP1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 11:27:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF012194;
        Mon, 18 Sep 2023 08:24:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8732B21D63;
        Mon, 18 Sep 2023 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695048261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSTcQ7jDh1oJ0HUjZfKQreOsvxKwNqv8dpWOPBspbQc=;
        b=rxuEiqQmfb5q4TyOSIo7ToLiHlF1KWiMSI0MfYi82xXO8+K7nZ6Stj8hVZxYYJVTDwRI5m
        zT/pPBrzax7yQDOVAdtSgMFN0gceHGtHWEcbz9HAWTURY2KKXhXLSC/J8LRaMkEcrq4nHF
        8CbXBak6z4YdSVLe5AArY7B5L5KdfFQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36B511358A;
        Mon, 18 Sep 2023 14:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w9aODEViCGWMQQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 18 Sep 2023 14:44:21 +0000
Date:   Mon, 18 Sep 2023 16:44:19 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on
 cgroup1
Message-ID: <nlprhofelq5pme7b7aawnaep3qxvzwq2gwgwxicrs6zakywttd@sdeji44v3xe2>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
 <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
 <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
 <CALOAHbCG6W+dxpcO-f=U5=9WD-sEqRoLuhFrYAps-p944=sVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nc6bgo5yugaggn6w"
Content-Disposition: inline
In-Reply-To: <CALOAHbCG6W+dxpcO-f=U5=9WD-sEqRoLuhFrYAps-p944=sVgw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--nc6bgo5yugaggn6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 17, 2023 at 03:19:06PM +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> The crucial issue at hand is not whether the LSM hooks are better
> suited for the cgroup default hierarchy. What truly matters is the
> effort and time required to migrate all cgroup1-based applications to
> cgroup2-based ones. While transitioning a single component from
> cgroup1-based to cgroup2-based is a straightforward task, the
> complexity arises when multiple interdependent components in a
> production environment necessitate this transition. In such cases, the
> work becomes significantly challenging.

systemd's hybrid mode is the approach helping such combined
environments. (I understand that it's not warranted with all container
runtimes but FYI.) On v1-only deployments BPF predicates couldn't be
used at all currently.

Transition is transitional but accompanying complexity in the code would
have to be kept much longer.

> Our objective is to enhance BPF support for controller-based
> scenarios, eliminating the need to concern ourselves with hierarchies,
> whether they involve cgroup1 or cgroup2.

I'm posting some notes on this to the 1st patch.

Regards,
Michal

--nc6bgo5yugaggn6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZQhiQQAKCRAGvrMr/1gc
jiUfAP9yYts+3IR9/rQIVX/bgExVZv4l8A2+9vrZKTYQRHIUlQD/ZMTuTcvuE/No
wfIpsCjbsISwSRehkoG+bfZtJcX7yww=
=IuU9
-----END PGP SIGNATURE-----

--nc6bgo5yugaggn6w--
