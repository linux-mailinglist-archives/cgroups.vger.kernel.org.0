Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEB6FC362
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEIKDx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjEIKDw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 06:03:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1572126;
        Tue,  9 May 2023 03:03:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB6B221B45;
        Tue,  9 May 2023 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683626629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVOcH3ojLkF2oleErumS69jiq2T/Qhx9NHw4f5gaQfM=;
        b=EkRevYyx8PlFZqTaDOGZUy0A3OlcDuXYp+8WnEwhteSXOC+jm4o+uVjFd3PqkV3+b9/ULI
        0fNxYIR1s/7M3CIJ0OYb6jixod9/IoCmGW47JhMnPPfc/6tkEpp0AwQZ+bpEwLtv8cNBQK
        PRSt9u7dk3pavlC5Dqdk0gMzT0d5s1w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98490139B3;
        Tue,  9 May 2023 10:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ibwyJIUaWmTgeAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 09 May 2023 10:03:49 +0000
Date:   Tue, 9 May 2023 12:03:48 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [RFC PATCH] cgroup: Return error when attempting to migrate a
 zombie process
Message-ID: <cetfatnt2cy2pmcskg243ebau36au2vy6fi6mu7hpgg3e7kjp4@gg7l5zoix4xt>
References: <20230503125359.14789-1-mkoutny@suse.com>
 <ZFVTRdP6eK1soMVR@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kajz4hm6ew66s2tm"
Content-Disposition: inline
In-Reply-To: <ZFVTRdP6eK1soMVR@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kajz4hm6ew66s2tm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 09:04:37AM -1000, Tejun Heo <tj@kernel.org> wrote:
> This seems racy to me. The liveness state can change between here and the
> PF_EXITING check in cgroup_migrate_add_task(), right?

You're right, threadgroup lock won't prevent that (as I got wrongly in
the patch):

  cgroup_procs_write_start                                =20
                                                     do_exit
                                                       exit_signals
                                                         cgroup_threadgroup=
_change_begin
                                                           tsk->flags |=3D =
PF_EXITING
                                                         cgroup_threadgroup=
_change_end
    percpu_down_write(&cgroup_threadgroup_rwsem)          =20
      ...                                                 =20
      atomic_read(&live)                                  =20
                                                       ...
                                                       atomic_dec_and_test(=
live)
      ...                                                 =20
      cgroup_migrate_add_task                             =20
      ...                                                 =20
    percpu_up_write(&cgroup_threadgroup_rwsem)


> Wouldn't it be better to just track how many tasks are tracked and
> return -ESRCH if none was migrated?

Thanks, such an integral sounds better, will see.

Michal

--kajz4hm6ew66s2tm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZFoagQAKCRAkDQmsBEOq
uV58AP0YJRo7aRKynt665xXOLH1SQSTX1MShDbDSZVr+4pBULgEAx887fE5n3Mar
tkkG4OI6a6Bof2v6liLPXWWg50Giigo=
=CdaX
-----END PGP SIGNATURE-----

--kajz4hm6ew66s2tm--
