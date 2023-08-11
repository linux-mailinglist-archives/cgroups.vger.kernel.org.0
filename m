Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984507788DD
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHKIXy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKIXy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 04:23:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B32723;
        Fri, 11 Aug 2023 01:23:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7247421877;
        Fri, 11 Aug 2023 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691742231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XAHLRJ91aICIGGOaaGit2Y6QwMl3ywOsiEqwUzwig6c=;
        b=hi4xqu/Xfb/lRFWXg7qi1rorGt75xQyV7YSBTBCzbp54A1sqfXGGQ0CMDnBSR1tjGbLqaA
        RF9GfgvYb7hKLzmRQrqQIk7arD6AZgAuIrpY6Z4doEpsGxRhamIyCz+HcYBMh2vcRIkNin
        q1NpSE1INhzEIH2Vp6IeCwfvg3d4aLo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D74713592;
        Fri, 11 Aug 2023 08:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jNAkDhfw1WSwfQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 11 Aug 2023 08:23:51 +0000
Date:   Fri, 11 Aug 2023 10:23:49 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Message-ID: <dtobag743cbzb3rxzldu36wszqtnbayz2grpyj2cctptfybtt3@66ico6n2clrr>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
 <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqhlkl5irnp4pmde"
Content-Disposition: inline
In-Reply-To: <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--zqhlkl5irnp4pmde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2023 at 09:44:55AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Now that this problem doesn't exist, I think it's ok just to remove this
> comment.

Why doesn't the problem exist now?
IIUC, it does but it's prevented thanks to outer synchronization via
rq_qos_mutex. Hence the comment clarifies why is the lockdep_assert
placed here.


Michal

--zqhlkl5irnp4pmde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNXwBgAKCRAGvrMr/1gc
jh/AAP9SvWJp6Nz9+hOawByX3LxRnZ9iMEwthx4HdWkkUFWzigEA5WqdymnqVleY
CwTyxjDyPdWnuMyLErCzkRgA/BTmYgo=
=qLjb
-----END PGP SIGNATURE-----

--zqhlkl5irnp4pmde--
