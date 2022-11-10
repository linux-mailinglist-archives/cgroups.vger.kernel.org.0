Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55C2624551
	for <lists+cgroups@lfdr.de>; Thu, 10 Nov 2022 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiKJPP0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Nov 2022 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiKJPPZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Nov 2022 10:15:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819712615
        for <cgroups@vger.kernel.org>; Thu, 10 Nov 2022 07:15:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7408521B34;
        Thu, 10 Nov 2022 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668093323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKymvBvNUc8tSCUQvAi1PjPsqmEYDlbDheSS2WGM6TE=;
        b=gUJwt0jof4XdlEV8c5oNAwU7p6Z4rKIk1smBOSJqHG7koAWfNIf/A173AOq+zxW7NIUUZv
        vOmPFyi3vfoq5zU5Sy6qaAT8ukiEbdlLRmd8BFf7U5/XU/BFL4bpftu40v5izx8TXFs0id
        ooSzWIy74jATH1hJ2frezuXNvGy44fQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D1CA13B58;
        Thu, 10 Nov 2022 15:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BhduFYsVbWP6PwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 10 Nov 2022 15:15:23 +0000
Date:   Thu, 10 Nov 2022 16:15:22 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Sergey Dolgov <palza00@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: problem with remove cgroup in function cgroup_addrm_files
Message-ID: <20221110151522.GB10562@blackbody.suse.cz>
References: <CADn0Px_+-z5-cjJ6t6fO86=oq9Se-uLDA1nJ0OUSxwf+zHJgWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <CADn0Px_+-z5-cjJ6t6fO86=oq9Se-uLDA1nJ0OUSxwf+zHJgWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Mon, Nov 07, 2022 at 12:50:04PM +0600, Sergey Dolgov <palza00@gmail.com> wrote:
> we faced problem in removing cgroup in cgroup_addrm_files in kernel 5.4

Do you have a reproducer for this issue? Ideally, with a current kernel?



> crash> struct cgroup_subsys.cfts 0xffff88fc910d9f80
>   cfts = {
>     next = 0x703,
>     prev = 0x0
>   },

The cgroup_subsys pointed in css->ss doesn't look like a valid
cgroup_subsys, cfts.next looks like a rubbish.

>  from (!css->ss) to (!(css->ss or css == css->cgroup->self)) it will
> be resolve problem

This doesn't seem correct to me. The condition in this place should
capture whether css represents a true subsys state or just a cgroup.
You made it effectively always false, regardless of css->ss is valid or
not. (Maybe there's a typo in your posting and the "fix" was making the
condition always true but that still doesn't seem correct to me, it's
just masking the garbled css->ss.)

> loaded Tainted: G           OE     5.4.0-73-generic #82~18.04.1-Ubuntu

`(O)`  externally-built ("out-of-tree") module was loaded

My bets are off.

HTH,
Michal

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY20VhgAKCRAkDQmsBEOq
uQ2IAQDSlyu5enLN9jLXDkH7Dtke8PPrLhE5nVjo6rrcpmlhQQD/QKJ3rDxmsCcK
zJ8aumroXcoYId9hWISTWsa4q7FX6AI=
=JZjC
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
