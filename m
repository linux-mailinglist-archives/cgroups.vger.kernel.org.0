Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A868F488
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBHRaM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 12:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjBHRaA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 12:30:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D284697;
        Wed,  8 Feb 2023 09:29:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B79B11FF10;
        Wed,  8 Feb 2023 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675877397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNT7NX0+hT2aQtpy7b1M6dknJlluQx/yb2v06LJSz4M=;
        b=sQ8cUC9PcQvWDu0lRxPN9duoXTBMmUEOh6UcpBdECsy0vXbOypH3BJoor9HNZmolDykWdc
        TMP7tWJSYqYNS076G5wDJvHdCGx8YwFfi5J8FOVd7mm/GafpEkYcKAs/yGrkAIHWJCoKyF
        OwspVtVsMA3fItc7ZI47R3eOL+bU9kg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A58213425;
        Wed,  8 Feb 2023 17:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m+g0HBXc42NlcgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Feb 2023 17:29:57 +0000
Date:   Wed, 8 Feb 2023 18:29:56 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <20230208172956.GF24523@blackbody.suse.cz>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20230208161654.99556-3-ryncsn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 12:16:54AM +0800, Kairui Song <ryncsn@gmail.com> wrote:
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Kairui Song <ryncsn@gmail.com>

Typo?

> -static inline struct psi_group *task_psi_group(struct task_struct *task)
> +static inline struct psi_group *psi_iter_first(struct task_struct *task, void **iter)
>  {
>  #ifdef CONFIG_CGROUPS
> -	if (static_branch_likely(&psi_cgroups_enabled))
> -		return cgroup_psi(task_dfl_cgroup(task));
> +	if (static_branch_likely(&psi_cgroups_enabled)) {
> +		struct cgroup *cgroup = task_dfl_cgroup(task);
> +
> +		*iter = cgroup_parent(cgroup);

This seems to skip a cgroup level -- maybe that's the observed
performance gain?

> +		return cgroup_psi(cgroup);
> +	}
>  #endif
>  	return &psi_system;
>  }

Michal

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+PcEQAKCRAkDQmsBEOq
ucIeAQDi16jPR5cqfDFK6ypdLlSSoGcqc6FSu2lcsoDjuvDlnwD/ZU7UkoG2cu4M
KNiNToxChBDynyJlkRovlFTYnxMSMwg=
=Cy+H
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
