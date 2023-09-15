Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD457A2421
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 19:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjIORBz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjIORBj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 13:01:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FCF2126;
        Fri, 15 Sep 2023 10:01:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BBEC1FD79;
        Fri, 15 Sep 2023 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694797290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3dIzvlBxdfOKjCtJrhlIGa8SoPY/rHAEBMPc40WOHY=;
        b=ItWumZaKbB6MhyTFNvPvoRKIfR1BnhsSzAtHBbxB5AYaIPuuDtGocpcWkIRDqMRURhLaD1
        +dhWbASomi6ckyQwLTVQG26DQtMUWyB6LfE6IMAICGBkwWu6uiY5PIzteBQ83UBqRIkmNb
        BqnhHDqtx6ubU+pv5iOW75r1MvwugWg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D5A413251;
        Fri, 15 Sep 2023 17:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DD4bDuqNBGUkRQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 15 Sep 2023 17:01:30 +0000
Date:   Fri, 15 Sep 2023 19:01:28 +0200
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
Message-ID: <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
 <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bwbu34nvlbqq3rqp"
Content-Disposition: inline
In-Reply-To: <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--bwbu34nvlbqq3rqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Sep 12, 2023 at 11:30:32AM +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> With the above changes, I think it can meet most use cases with BPF on cgroup1.
> What do you think ?

I think the presented use case of LSM hooks is better served by the
default hierarchy (see also [1]).
Relying on a chosen subsys v1 hierarchy is not systematic. And extending
ancestry checking on named v1 hierarchies seems backwards given
the existence of the default hierarchy.


Michal

[1] https://docs.kernel.org/admin-guide/cgroup-v2.html#delegation-containment

--bwbu34nvlbqq3rqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZQSN5gAKCRAGvrMr/1gc
jqoaAQDSlFTLyvMU3pnG272pXuMMF5KmhsnId0TP0peVan9QcAEAw2Zhpgzlxa7y
db4CtFmbfl/wQ7HfdVDyaYQ/I92Zowo=
=lHHe
-----END PGP SIGNATURE-----

--bwbu34nvlbqq3rqp--
