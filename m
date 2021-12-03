Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC884674BF
	for <lists+cgroups@lfdr.de>; Fri,  3 Dec 2021 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbhLCKbG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Dec 2021 05:31:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhLCKbF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Dec 2021 05:31:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8E38212C6;
        Fri,  3 Dec 2021 10:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638527260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DvmP4cB/KNSRMgh4UcYVFP3x4fPHzjzEcFBhVdgCru0=;
        b=MhFZ5ke24T5q0Sb3wHgjIeX2G1ZCb5g6d41PhS8Trge8RFGVLrwzMO/HycD4Jd2kNRV7bz
        LrhPHTIzUonH7t8N+MMz6ch2dmM1oBJQagD7Ep3UpZ4/paqZtZNwk4JwzY92h8umG1HitZ
        tMhsu1WaLNQpPDIgIacn1YgtL6q7hC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B86D713CF5;
        Fri,  3 Dec 2021 10:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vRFZLBzxqWFoDwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 03 Dec 2021 10:27:40 +0000
Date:   Fri, 3 Dec 2021 11:27:39 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <20211203102739.GB64349@blackbody.suse.cz>
References: <20211202130440.1943847-1-yukuai3@huawei.com>
 <20211202130440.1943847-3-yukuai3@huawei.com>
 <20211202144818.GB16798@blackbody.suse.cz>
 <95825098-a532-a0e4-9ed0-0b5f2a0e5f04@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <95825098-a532-a0e4-9ed0-0b5f2a0e5f04@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 03, 2021 at 03:50:01PM +0800, "yukuai (C)" <yukuai3@huawei.com>=
 wrote:
> blkg_destroy() is protected by the queue_lock=EF=BC=8Cso I think queue_lo=
ck can
> protect such concurrent scenario.

blkg_destroy() is not as destroying :-) as actual free, you should
synchronize against (the queue_lock ensures this for
pd_free_fn=3Dthrotl_pd_free but you may still trip on blkcg after
blkcg_css_free()).

[Actually, I think you should see a warning in your situation if you
enable CONFIG_PROVE_RCU.]

HTH,
Michal

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTiq06H1IhXbF2mqzsiXqxkP0JkRwUCYanxCgAKCRAiXqxkP0Jk
R3lBAP4oljvRynKApFVPUyqI5k6NuqpWC4Yv1Ll3PdCiKrZkiwEAtozR8aRyinFF
NPyhhAKCpdU+IAXi7JXzqU982GQDEAs=
=YebJ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
