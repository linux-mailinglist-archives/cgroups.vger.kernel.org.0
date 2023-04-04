Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479116D5BB5
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjDDJUI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjDDJUG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 05:20:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039EA19BF;
        Tue,  4 Apr 2023 02:19:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 339F7204BB;
        Tue,  4 Apr 2023 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680599995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i67LZvndle0FXns2qvwNfT1XOL/ofgh7nRXwodyjXPs=;
        b=Oh3tIDquq5GAp/daRsZLPe8+keWjgn/xo26/bDtxYuh/NyIXC8eUV2ajlDvD5PdX6e3Bxc
        LeWQwHKJ2/4tDCgTl+My4ZLnXLjN4po1o8GhZWAhU+UW6Yq397WVXZdN3DwwLA3IcuWvqN
        CCHm9q+hpAiowzhA58WooTHxjRuiAGo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB5451391A;
        Tue,  4 Apr 2023 09:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/cuK7rrK2Q+NQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Apr 2023 09:19:54 +0000
Date:   Tue, 4 Apr 2023 11:19:53 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Message-ID: <20230404091953.tcu3zg7npstk3ztc@blackpad>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
 <20230403165523.aphsec2epqi72k27@blackpad>
 <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t44yctniyorb4iao"
Content-Disposition: inline
In-Reply-To: <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--t44yctniyorb4iao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 01:18:42PM -0400, Waiman Long <longman@redhat.com> wrote:
> 1) PF_NO_SETAFFINITY flag - which won't be set in the case of fork() as it
> is for kthread only.
> 2) DL bandwidth - Juri has a cpuset outstanding to modify the way this check
> is being done. I want to wait until it is settled before tackling this, if
> necessary.

BTW what about CLONE_INTO_CGROUP where the target cpuset has empty
effective cpuset?

> 3) security_task_setscheduler() - the CLONE_INTO_CGROUP code has already
> checked that, we don't need to duplicate the check.

Not sure what this refers to.

> So we don't need a can_fork() check for now.

Anyway, good breakdown. Could you please add it to the commit message
too?

Regards,
Michal

--t44yctniyorb4iao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCvrtQAKCRAkDQmsBEOq
uXeGAQCpgXtPsXDXcfOTHX/nDug4IiTdeZK6ER7w5mOHPkUAxgD/cum39WzeVSGZ
V0835/NthpeochRAaHAX/FNgF63xlAw=
=b803
-----END PGP SIGNATURE-----

--t44yctniyorb4iao--
