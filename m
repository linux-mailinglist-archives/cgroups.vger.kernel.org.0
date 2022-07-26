Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D76B581556
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiGZOcu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiGZOct (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 10:32:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2532C;
        Tue, 26 Jul 2022 07:32:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A215D37EFB;
        Tue, 26 Jul 2022 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658845967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsmx+z/oBusYDzp7fU39ROvdgKcbPo4y7ckSVswOWzk=;
        b=HxBBAsWtFVAyfycssrnjYDTMniIYsSROXdSpEs3X/jBvj9faRaiOA75LODa8RZ9dziGpIj
        Zvi1yqZfuf6AIi+GvxTE+Qrtprr3yURaJWVDd30dBiKOPQcdG6tAx+VVeXe4my2RGo4N6f
        sKxTTspWLeEzTjxEM90jJfWI8vR8nK8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77A6813322;
        Tue, 26 Jul 2022 14:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nxI5HA/732JgPwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 26 Jul 2022 14:32:47 +0000
Date:   Tue, 26 Jul 2022 16:32:46 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-5.20] cgroup: Add "no" prefixed mount
 options
Message-ID: <20220726143246.GA23794@blackbody.suse.cz>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <YtDvU4jRPSsarcNp@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 06:38:43PM -1000, Tejun Heo <tj@kernel.org> wrote:
> We allow modifying these mount options via remount. Let's add "no" prefixed
> variants so that they can be turned off too.

They can be turned off:

> // on v5.19-rc?
> :~ # grep cg /proc/mounts
> cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
> :~ # mount -t cgroup2 cgroup2 /sys/fs/cgroup/ -oremount
> :~ # grep cg /proc/mounts
> cgroup2 /sys/fs/cgroup cgroup2 rw,relatime 0 0

The mount(2) says about remounting:
> The  mountflags  and  data  arguments should match the values used in
> the original mount() call, except for those parameters that are being
> deliberately changed.

Or is this a provision for the fsconfig(2) API?

> +	fsparam_flag("memory_nolocalevents",	Opt_memory_nolocalevents),
> +	fsparam_flag("memory_norecursiveprot",	Opt_memory_norecursiveprot),

These are not 'no' prefixes of the option :-)

I.e. it seem more consistent to prefix whole boolean option name (in
accordance with other FS options but I know limited subset of them).
In the end, this should be handled generically for boolean options in
the VFS and not via custom options.

Also, this allows both
	'nsdelegate,nonsdelegate'
and
	'nonsdelegate,nsdelegate'
(nsdelegate is just an example) where the 'no' always overrides being a
hidden implementation detail.

I find this patch a bit weird.


Thanks,
Michal

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYt/7CwAKCRAkDQmsBEOq
uV3mAQCItCNZ+qgk+YsiePoYjqY2EogjCLrFfuM3E5vqQkJKuAD/Zz/xId+puHZe
b3vUeGdCg/W5RERU4NX0miYjHXAv6gA=
=F2ZO
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
