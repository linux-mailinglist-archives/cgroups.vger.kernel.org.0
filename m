Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239F2735D09
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFSRaw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjFSRav (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 13:30:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3A198;
        Mon, 19 Jun 2023 10:30:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 231BA1F88D;
        Mon, 19 Jun 2023 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687195846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQFY7fZePp2Fj2uiaSid1me/iXz0lajB7QFNjTT4+ls=;
        b=pQDFDQhHXe7phJt2fLX6ATZgBbeZhDTeziVy/2jZ2ixsWgmpbNLBNi7nbpYLDA8l/FFmcP
        TF2KLLk5U5yCq8QR0WdQC1HSOfTQDoivDzVuA9P7h1z4nK7a78h/gLR2/pNN2LoyLBKUhc
        /iogDsjyLttIrG2Z6PpDRYlw0dAv8hs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B21F139C2;
        Mon, 19 Jun 2023 17:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kPYLIcWQkGQbdwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 19 Jun 2023 17:30:45 +0000
Date:   Mon, 19 Jun 2023 19:30:44 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Eric Dumazet <edumazet@google.com>, Tejun Heo <tj@kernel.org>,
        Christian Warloe <cwarloe@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Jason Xing <kernelxing@tencent.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem
 isolation
Message-ID: <4p22vtjrpu4obmbjivgpe635gbpjmhsfisnxghgsson2g6yy5r@ovawhchw7maq>
References: <20230609082712.34889-1-wuyun.abel@bytedance.com>
 <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
 <b879d810-132b-38ab-c13d-30fabdc8954a@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmi7m3lyy75eha77"
Content-Disposition: inline
In-Reply-To: <b879d810-132b-38ab-c13d-30fabdc8954a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--gmi7m3lyy75eha77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 02:46:32PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
> Memory protection (memory.{min,low}) helps the important jobs less
> affected by memstalls. But once low priority jobs use lots of kernel
> memory like sockmem, the protection might become much less efficient.

What would happen if you applied memory.{min,low} to the important jobs
and memory.{max,high} to the low prio ones?

Thanks,
Michal

--gmi7m3lyy75eha77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJCQwgAKCRAGvrMr/1gc
jlfqAP4n8Ka+X+iVeFLtQT/sbo8Dudkos2fyhrkWo0/AJG9aogD9GEihJOOgAxk9
aCoZ0Kwdy6zyeUy+7PVrsCAOIKJHJQc=
=1Q4d
-----END PGP SIGNATURE-----

--gmi7m3lyy75eha77--
