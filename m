Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1B4668A3
	for <lists+cgroups@lfdr.de>; Thu,  2 Dec 2021 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbhLBQxr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Dec 2021 11:53:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359727AbhLBQxp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Dec 2021 11:53:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 260BC2170C;
        Thu,  2 Dec 2021 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638463822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B5c8jd312OU++3RBvwTLKAqm2dX4TEtVdTF/pGzwaMU=;
        b=ERGiyyAjqJwCriXlkkBwKYNIVm5nfhXbZQtznCFpuRSgkuGGnHiW5+L7iun6EDRILZDXKl
        S6w6GzOZ3iXyerJDBxg7VVTuB21DKsMPdfSLTc1lhoRKCVVI/yFR6l+H3sG7VPtUDQc22P
        tR8LEGsLjs1s2jm2wC47VF3t+1D6UWU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0630A13E9E;
        Thu,  2 Dec 2021 16:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JObvAE75qGE3JQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 02 Dec 2021 16:50:22 +0000
Date:   Thu, 2 Dec 2021 17:50:20 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     cgel.zte@gmail.com
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, deng.changcheng@zte.com.cn
Subject: Re: [PATCH v2] block: Use div64_ul instead of do_div
Message-ID: <20211202165020.GC16798@blackbody.suse.cz>
References: <20211117010358.158313-1-deng.changcheng@zte.com.cn>
 <20211118034033.163550-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20211118034033.163550-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Nov 18, 2021 at 03:40:33AM +0000, cgel.zte@gmail.com wrote:
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Just feedback to the bot or to you -- the same do_div() is in the same
function for writes too. I think the processing shouldn't stop at the
first occurence.

Michal


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTiq06H1IhXbF2mqzsiXqxkP0JkRwUCYaj5PgAKCRAiXqxkP0Jk
RyzZAQCz0MBVSF0oVpol11+mBLRmq7R1xgXflAx9rH3/Ge9yJwD/eURdhzAfYNm4
ZPElCRbhAn62Wi1zRHKFeFh8Ca4WBgI=
=ydev
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
