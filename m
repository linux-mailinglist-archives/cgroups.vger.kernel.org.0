Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37E37BF5DE
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442775AbjJJIaD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442828AbjJJIaC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 04:30:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D34118;
        Tue, 10 Oct 2023 01:29:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 321C2211B7;
        Tue, 10 Oct 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696926594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I34eP0hTEKSiHThegKush8ZSUw/yfG8Vfvjh4U2aWG8=;
        b=guz3HE0nJA3IfpoRwIrKUU0xanK6v9bQIWzg8iaUtLYVml6CvGms5qPYhHRIwzJUec73ev
        hFImSbDpp0sHVMvS4Dj/NfZnNlewlRn44nzrBPbkQTlIg2EoOHswLPh+bQhtqAXGv3ewIr
        kCM1Fc8bxnUFLbLAIXB8S5rs6muzl5M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C47511348E;
        Tue, 10 Oct 2023 08:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fcQIL4ELJWUGXAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 10 Oct 2023 08:29:53 +0000
Date:   Tue, 10 Oct 2023 10:29:52 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex
 in task_cgroup_from_root()
Message-ID: <afdnpo3jz2ic2ampud7swd6so5carkilts2mkygcaw67vbw6yh@5b5mncf7qyet>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-2-laoar.shao@gmail.com>
 <sdw6rnzbvmktajcxb4svj2kzvttftae2i5nd2lnlxnm3llub37@2q2rlubjzb5a>
 <CALOAHbC4_0990_HD4=mg8gfU51juk8fs07zYrr6VL9fPOuLOng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pntlv7oxdpgdn37p"
Content-Disposition: inline
In-Reply-To: <CALOAHbC4_0990_HD4=mg8gfU51juk8fs07zYrr6VL9fPOuLOng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--pntlv7oxdpgdn37p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yafang.

On Tue, Oct 10, 2023 at 11:58:14AM +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> current_cgns_cgroup_from_root() doesn't hold the cgroup_mutext as
> well. Could this potentially lead to issues, such as triggering the
> BUG_ON() in __cset_cgroup_from_root(), if the root has already been
> destroyed?

current_cgns_cgroup_from_root() is a tricky one, see also
https://lore.kernel.org/r/20230502133847.14570-3-mkoutny@suse.com/

I argued there with RCU read lock but when I look at it now, it may not be
sufficient for the cgroup returned from current_cgns_cgroup_from_root().

The 2nd half still applies, umount synchronization is ensured via VFS
layer, so the cgroup_root nor its cgroup won't go away in the
only caller cgroup_show_path().


> Would it be beneficial to introduce a dedicated root_list_lock
> specifically for this purpose? This approach could potentially reduce
> the need for the broader cgroup_mutex in other scenarios.

It may be a convenience lock but v2 (cgrp_dfl_root could make do just
fine without it).

I'm keeping this dicussuion to illustrate the difficulties of adding the
BPF support for cgroup v1. That is a benefit I see ;-)

Michal


--pntlv7oxdpgdn37p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSULfgAKCRAGvrMr/1gc
jsVqAQCrQRuss+LGKV09QeQElsako/KCmgfC7FO4t4lUlAxIOgEA8eNoIlxjsXF6
C85X7yNyLaKZbY8xHTmF2J/J4rNPswU=
=44OO
-----END PGP SIGNATURE-----

--pntlv7oxdpgdn37p--
