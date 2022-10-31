Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAD613782
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaNLq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiJaNLp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 09:11:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818AFD27;
        Mon, 31 Oct 2022 06:11:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E271622C6F;
        Mon, 31 Oct 2022 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667221901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKEWeuaqEd6vlqq7RTx8/3afjyq+Dr1cAWsD5nEX5GU=;
        b=MnEqUWgYzBToTXLZKf9RPYtbnqf4atIaTUw4xzKjI8Fe9YOOTbZMdSkdVkAJBKlsE/7zME
        R4YV6pswN0Rd6TYiyR8lgFEF8/yiqHcH7SK3vSkyUsfdcLyCd3Be1270B37jQSP5rd3hAx
        xF/pUYcxzWPtBCUJAPTj0fQrCtR+2j0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEA713AAD;
        Mon, 31 Oct 2022 13:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZJkgLY3JX2NPVAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 31 Oct 2022 13:11:41 +0000
Date:   Mon, 31 Oct 2022 14:11:40 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
Message-ID: <20221031131140.GC27841@blackbody.suse.cz>
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
 <20221027080558.GA23269@blackbody.suse.cz>
 <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

> 1) If calls 'css_set_update_populated' , the cset is either getting the
> first task or losing the last. There is a need to update the populated
> state of the cset only when 'css_set_populated' returns false.
> In other words, the last has been deleted from from_cset and the first
> hasn't been added to to_cset yet.

I've likely misread the condition previously. I see how this works now
(update happens after "from_cset" but before "to_cset" migration).

> 3) In order to update the populated state of to_cset the same way
> from_cset does, 'css_set_update_populated' is also invoked during the
> process of moving a task to to_cset.

As I think more about this in the context of vertical migrations
(ancestor<->descendant, such as during controller dis- or enablement),
I'm afraid the inverted order would lead to "spurious" emptiness
notifications in ancestors (in the case a there is just a single task
that migrates parent->child, parent/cgroup.populated would generate and
event that'd be nullified by the subsequent population of the child).

So I'm not sure the change is worth it.

Michal

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY1/JiQAKCRAkDQmsBEOq
uTWXAP4+msA6mEv17VE0bvXPosCxQHytBdxI4BLiZcaE9m59ggD/SDf7epi6xoIP
Ik6LZC+YlTL+GCTFIOhxdlJNT2RyAQE=
=SfdS
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
