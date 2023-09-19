Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8D7A6073
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjISLA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjISLAZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 07:00:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF4F1;
        Tue, 19 Sep 2023 04:00:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F47B2296D;
        Tue, 19 Sep 2023 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695121217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUW8+lJZM7K/XgtkgyMNw3L0b83uwQqlZMHcQJDzIAc=;
        b=RL/WIN6uROihO8XYV/Rp8U4wVyp11s2T+EP8TBn6cVrqrApsc7WL1JTnAbNytc6oe6ZYID
        jsyLxdp3PAXEQ3J0vw/dXVOL+5la0I1iAr4XLFMiEQxQ1eiZS/20BMnBFPjrCbo+fQ+yqb
        MfImqgqcXiOhnW4rbFh2GFp39D/PP+I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3323513458;
        Tue, 19 Sep 2023 11:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lO6XC0F/CWU+XQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 19 Sep 2023 11:00:17 +0000
Date:   Tue, 19 Sep 2023 13:00:15 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Luiz Capitulino <luizcap@amazon.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        lcapitulino@gmail.com
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <7zv7lqkondaacjhmc7oscyqzwugguxvjw2yhdhkv4axhhkts7a@upoxgl3qpunt>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <29bdb453-c6e3-a047-1f27-e9656da92301@amazon.com>
 <ZQiNIWQe7spOwjil@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fq5yevqc27dto7fu"
Content-Disposition: inline
In-Reply-To: <ZQiNIWQe7spOwjil@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fq5yevqc27dto7fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 18, 2023 at 07:47:13AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Michal raised some valid concerns. I don't really mind that it's not great
> on the edges tho. Michal, what do you think?

I'd have a few suggestions:
- reset to have_dynmods value instead of false in cgroup_destroy_root()
  (to the benefing of the users of this option, not the common default
  users) or not touch the value in cgroup_destroy_root() at all
- s/CONFIG_FAVOR_DYNMODS/CONFIG_CGROUP_FAVOR_DYNMODS/ in commit message

Those should be minor tweaks,
Michal

--fq5yevqc27dto7fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZQl/PQAKCRAGvrMr/1gc
jrkrAP0Tym353enXva+j6+YL+Gm0V3UvU+Jj6RKzfoMExDArZwEAwZ8CC+0DQZW1
1VW13GrliCR0DXybstlYxSDVzLFvcAk=
=OD1D
-----END PGP SIGNATURE-----

--fq5yevqc27dto7fu--
