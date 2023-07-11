Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE74174ED5B
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 13:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGKLw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGKLw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 07:52:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0210FC;
        Tue, 11 Jul 2023 04:52:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F82821D09;
        Tue, 11 Jul 2023 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689076371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4te5JwumvF8/GIgkO+TJ0V5B1TkpxMPkr04XN6p1A28=;
        b=VZJbzOP9afXhZN7G+sPdUEroSa0FtkyX6R848TJmsI6bwBCCzelW/44TukY+ylg/n2eRgQ
        +aKbEHzo+IgUHChuHawdB5oSk1EA0paU+2ES+ZtylsWY50PVEZLah94VKtl3TuGfOKWumd
        65r259bjXC3jaokWPET6XBTaeGYyy9E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 736A71390F;
        Tue, 11 Jul 2023 11:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9hgZG5NCrWRrKgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Jul 2023 11:52:51 +0000
Date:   Tue, 11 Jul 2023 13:52:50 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Waiman Long <longman@redhat.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Message-ID: <tebnrmbl6ouz567vlalojcynk25siwwom7et7yn2vvi6zyv6nv@jj3r5o3kl52j>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
 <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
 <30b1f809-a11b-efe8-289c-04a801f20207@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rpxvczwrelgzbfqd"
Content-Disposition: inline
In-Reply-To: <30b1f809-a11b-efe8-289c-04a801f20207@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rpxvczwrelgzbfqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:52:02AM +0800, Miaohe Lin <linmiaohe@huawei.com>=
 wrote:
> commit 2bdfd2825c9662463371e6691b1a794e97fa36b4
> Author: Waiman Long <longman@redhat.com>
> Date:   Wed Feb 2 22:31:03 2022 -0500
>=20
>     cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning

Aha, thanks for the pointer.

I've also found a paragraph in [1]:
> In addition, the -rt patchset turns spinlocks into a sleeping locks so
> that the corresponding critical sections can be preempted, which also
> means that these sleeplockified spinlocks (but not other sleeping
> locks!) may be acquire within -rt-Linux-kernel RCU read-side critical
> sections.

That suggests (together with practical use) that dicussed spinlocks
should be fine in RCU read section. And the possible reason is deeper in
generate_sched_domains() that do kmalloc(..., GFP_KERNEL).

Alas update_cpumask_hier() still calls generate_sched_domains(), OTOH,
update_parent_subparts_cpumask() doesn't seem so.

The idea to not relieve rcu_read_lock() in update_cpumask() iteration
(instead of the technically unneeded refcnt bump) would have to be
verified with CONFIG_PROVE_RCU && CONFIG_LOCKDEP. WDYT?

Michal

[1] https://www.kernel.org/doc/html/latest/RCU/Design/Requirements/Requirem=
ents.html?highlight=3Drcu+read+section#specialization

--rpxvczwrelgzbfqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZK1CkAAKCRAGvrMr/1gc
jslQAP9hbBzspCiXduaN1xbeQyV+ZnUhEAOznzhyLOo8+dDxRgEA3FXd5SDDuVMJ
87l6UFwCe1ThIrCymWRsgFxk2a+AJws=
=Xt4s
-----END PGP SIGNATURE-----

--rpxvczwrelgzbfqd--
