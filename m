Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A740C65E936
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 11:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjAEKpu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 05:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAEKpU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 05:45:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147CB3D9D8;
        Thu,  5 Jan 2023 02:45:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12EDC33B5B;
        Thu,  5 Jan 2023 10:45:10 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C65FC138DF;
        Thu,  5 Jan 2023 10:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cmPILjWqtmNLGgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Jan 2023 10:45:09 +0000
Date:   Thu, 5 Jan 2023 11:45:08 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
Message-ID: <20230105104241.GA16920@blackbody.suse.cz>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
 <20230104151241.GA13268@blackbody.suse.cz>
 <4b559d1d-31e4-6049-4548-451bf7afb4f4@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <4b559d1d-31e4-6049-4548-451bf7afb4f4@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.20
X-Spamd-Result: default: False [-2.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         RCPT_COUNT_SEVEN(0.00)[10];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2023 at 09:43:02AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> This is based only on code review, currently the only negative effects
> is that root blkg from blk-throtl won't call pd_online_fn().

Good, that's a NOP and there are no other uses of pd_online_fn.

I wonder are the separate pd_init_fn and pd_online_fn callbacks
necessary today?
(IOW your fixup is a good catch and looks correct to me; I'd suggest
more of a clean up. Shall I look into that?)

> No, this is not true, before blkcg_activate_policy() is called,
> blkg_create() won't see this policy, hence pd_init_fn/pd_online_fn won't
> be called from blkg_create().

Thanks, I missed the q->blkcg_pols bit.

Michal

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY7aqMgAKCRAkDQmsBEOq
udG/AP443o4fnN2JypjVdH6EZJPRY/O5O0N3ywlBupWqtBkSeQD8DIJhUF+tVjlL
zXTyjDqKPgE2Ri3wEWklUqmarfiGJg4=
=7FAl
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
