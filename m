Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3258B469F70
	for <lists+cgroups@lfdr.de>; Mon,  6 Dec 2021 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355941AbhLFPs0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Dec 2021 10:48:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42622 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379377AbhLFPqe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Dec 2021 10:46:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5881FD34;
        Mon,  6 Dec 2021 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638805382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/uP9SPjURf9HFURwZMv6YyO0EUqdpWSbn3GJwO2TAZ4=;
        b=p5M6xJcqWuVRb4DSC/shUnJyVMqkf+k8ZzasFRPZ4LknAfvc7Y7pxwNEkZephU/942yefd
        nOhV7p+RIKZgSgUy4fq2jCfeMQLIowYlJJM671UkrMWA2766khdos+rzvf07QaUN+gDV2v
        0+NiPoHbSInzwYmQv1XNF58sjzdGuYI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7090C13C4C;
        Mon,  6 Dec 2021 15:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Aei+GoYvrmEaXQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Dec 2021 15:43:02 +0000
Date:   Mon, 6 Dec 2021 16:43:01 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <20211206154301.GD45344@blackbody.suse.cz>
References: <20211202130440.1943847-1-yukuai3@huawei.com>
 <20211202130440.1943847-3-yukuai3@huawei.com>
 <20211202144818.GB16798@blackbody.suse.cz>
 <95825098-a532-a0e4-9ed0-0b5f2a0e5f04@huawei.com>
 <20211203102739.GB64349@blackbody.suse.cz>
 <c8a16fe9-4ad2-682d-0d34-1049dc217d62@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <c8a16fe9-4ad2-682d-0d34-1049dc217d62@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 04, 2021 at 04:03:53PM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
> I was thinking that if there are active blkgs, holding queue_lock will
> ensure blkcg won't be freed.

My take is that the function traverses the whole blkcg tree (from global
root) and nothing prevents concurrent blkcg_css_free() in a possibly
unrelated branch (or queue).

> By the way, does spin_lock can guarantee this since it disables preempt
> like what rcu_read_lock() does?

Yes (but don't quoRTe me on that :-).

(It even isn't issue with a non-preemptible kernel neither but the code
IMO should be generic to allow for different configs -- or as I
mentioned initially, make a comment why the tree traversal is not
affected by concurrent frees.)

Thanks,
Michal

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTiq06H1IhXbF2mqzsiXqxkP0JkRwUCYa4vgQAKCRAiXqxkP0Jk
R37hAPkBlhUea4e+RY45MvG7rbiOlzMuuNw1T7b6FsVs+XbTUwEA6TPNgcddtJl4
zeg0w3Fvz/XJjRDhQv9Oa1fyXlv04wQ=
=Hf9G
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
