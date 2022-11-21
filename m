Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE7F632C53
	for <lists+cgroups@lfdr.de>; Mon, 21 Nov 2022 19:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKUSur (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Nov 2022 13:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiKUSuq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Nov 2022 13:50:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A445C67E9;
        Mon, 21 Nov 2022 10:50:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB5D31F8B5;
        Mon, 21 Nov 2022 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669056643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOkPtxy1B+aPiwWUMn6zq0m1QzdZL/48YTvASqRGnL4=;
        b=eWMES88FsBzrH40LiK+qYy1lxRyYmEbH8g8dpl52Ug6pzifOHVL20SZLjKE2E6+eGQlmQq
        0SPeOxmtxbUghhnfMAFejUqhU2tnuReqkc/p/TwqTbR1ON2k0YK3Fv2aPRmcUvuLGo6Egc
        3ToqnD7s5N+41BcgKlBBW/cdlMD2+vs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C01F01377F;
        Mon, 21 Nov 2022 18:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vtqHLYPIe2N0KwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 21 Nov 2022 18:50:43 +0000
Date:   Mon, 21 Nov 2022 19:50:42 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] cgroup/cpuset: Optimize cpuset_attach() on v2
Message-ID: <20221121185042.GA15225@blackbody.suse.cz>
References: <20221112221939.1272764-1-longman@redhat.com>
 <20221112221939.1272764-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20221112221939.1272764-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 12, 2022 at 05:19:39PM -0500, Waiman Long <longman@redhat.com> wrote:
> +	/*
> +	 * In the default hierarchy, enabling cpuset in the child cgroups
> +	 * will trigger a number of cpuset_attach() calls with no change
> +	 * in effective cpus and mems. In that case, we can optimize out
> +	 * by skipping the task iteration and update.
> +	 */
> +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
> +	    !cpus_updated && !mems_updated) {

I'm just wondering -- why is this limited to the default hierarchy only?
IOW why can't v1 skip too (when favorable constness between cpusets).

Thanks,
Michal

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY3vIfwAKCRAkDQmsBEOq
ueSvAQCyC6t+4Kgc9Ku5M0Twd+wYTQLyFcMCodNhZGs2DG56GQEA96Cg26FgHBCF
4fx2Ow2jpg02roncB1d72afOmf7dwwc=
=Py+0
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
