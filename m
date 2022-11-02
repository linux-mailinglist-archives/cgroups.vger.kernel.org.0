Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FB616BD8
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 19:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKBSTH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBSTG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 14:19:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179A2F00D
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 11:19:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6DE4222E6;
        Wed,  2 Nov 2022 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667413143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8OXey/PxRAn40mqSgN2tC64eUdoFvOstMSQHeo4Byg=;
        b=YpQdvG5XC6BH3CVi3lhlrFgAyQFPaf9DawEAPC38cwS/fmsTb31DiHYc3Nzse7GX5N79jf
        Qby8opGz8mAJvAIyC3cDAMgYOXsoaTfymYMQiXXeB4Z6/WT5f+UyDAVrdgjEsZXkNBhneu
        JAKZ4sK/0vVXuJwmxTbgUcXiycm9agA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B15139D3;
        Wed,  2 Nov 2022 18:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 712YIJe0YmN0VwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 02 Nov 2022 18:19:03 +0000
Date:   Wed, 2 Nov 2022 19:19:02 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Message-ID: <20221102181902.GA25267@blackbody.suse.cz>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
 <Y2FPSqOaQGnISvXu@slm.duckdns.org>
 <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Nov 01, 2022 at 05:03:25PM +0000, "Accardi, Kristen C" <kristen.c.a=
ccardi@intel.com> wrote:
> So to be clear, if I have this:
>=20
> /sys/fs/cgroup/misc.capacity
> some_res 10
>=20
> and this:
> /sys/fs/cgroup/test
>=20
> test.current will never be allowed to exceed 10.

If the capacity was initially larger than 10 and charges inside test
succeeded and then some event caused shrinking of the resource (without
synchronously preempting distributed units), then test.misc.current can
exceed the current capacity.

See the condition in misc_cg_current_show()
    if (READ_ONCE(misc_res_capacity[i]) || usage)

What the shrinking and preemption means is up to the implementation of
the particular miscresource.

IOW sum of 1st level children's .current may overrun capacity,
semantics is not defined by the misc controller (but it'd reject new
charges in such a situation).

(That's just for completeness. I understood from the rest that you
rather want to disable capacity checking.)

HTH,
Michal

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY2K0lAAKCRAkDQmsBEOq
ucMuAP9zkS5oP28Z2jHwng5UJQbSYQw4i/ls6fpyjRE4w3i5QgEA2vCtWWVForhC
EsFfz+2XCx5xTNicqVq9QroOFxGgIgw=
=Uxqg
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
