Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7D7A4C7F
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjIRPez (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjIRPei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 11:34:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B37CEB;
        Mon, 18 Sep 2023 08:32:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 055681FF60;
        Mon, 18 Sep 2023 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695048313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m+c5MwjrU6e+eqnpeyq/gfs4XPJ67C6Tq+An5QkBSWg=;
        b=kpFMGaQSztQjUayzxgZpeMJevfzfaEbLDhJIiP1PMhvnA91PRgsjzMiZ3kQcYtUXTvhnWA
        NHNmK/Z3DHTHlj4QDK3W9B20H5pHeiB4qVBcm1ml22z85HS7EDcI3KyRUI4zgc7U2yG6hD
        Lrrhgr8yHCn6WiZPyA+sj71HWSNahy0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B69D01358A;
        Mon, 18 Sep 2023 14:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZzuK3hiCGUUQgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 18 Sep 2023 14:45:12 +0000
Date:   Mon, 18 Sep 2023 16:45:11 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable
 task_under_cgroup_hierarchy() on cgroup1
Message-ID: <ysajseo5a5dashpz4dtkdpthtdww4m6wpgtgpakbtlbqoy7cvg@53fx3pou6hrl>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <20230903142800.3870-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uoq6y5kmp3pqpxzu"
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--uoq6y5kmp3pqpxzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 02:27:56PM +0000, Yafang Shao <laoar.shao@gmail.com=
> wrote:
>  static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>  					       struct cgroup *ancestor)
>  {
>  	struct css_set *cset =3D task_css_set(task);
> +	struct cgroup *cgrp;
> +	bool ret =3D false;
> +	int ssid;
> +
> +	if (ancestor->root =3D=3D &cgrp_dfl_root)
> +		return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +
> +	for (ssid =3D 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {

This loop were better an iteration over cset->cgrp_links to handle any
v1 hierarchy (under css_set_lock :-/).

> +		if (!ancestor->subsys[ssid])
> +			continue;
> =20
> -	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +		cgrp =3D task_css(task, ssid)->cgroup;

Does this pass on a lockdep-enabled kernel?

See conditions in task_css_set_check(), it seems at least RCU read lock
would be needed (if not going through cgrp_links mentioned above).

HTH,
Michal

--uoq6y5kmp3pqpxzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZQhidQAKCRAGvrMr/1gc
jstqAQCEYHUIebapzJQGj+eNhDHfhcCyW19Sdpyn2oF07i7N+wD/QQufiDWkuqHZ
1Mzzg+E3EsbzUxHd+erYEhkctnPTtw4=
=JT1H
-----END PGP SIGNATURE-----

--uoq6y5kmp3pqpxzu--
