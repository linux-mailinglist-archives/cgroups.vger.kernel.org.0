Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E77BDA3A
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjJILqv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbjJILqu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 07:46:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33794;
        Mon,  9 Oct 2023 04:46:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E60882186E;
        Mon,  9 Oct 2023 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696852007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53NCDgJD7fhJCAK9a7mAHncYEVrDFOYrilzVt/5h5vs=;
        b=uLXfJmcfvU6JBeZIdlIIbrGGkg5TEFznuCjLTbklmcTm8h80v6vvMyxTM5KIiGZcBujM3z
        FCBXwM6+suE6cCztgVBbr7rHtCOPkoYr+8l6WKpGMTblgkbr/XuQaoz9Vh8HZqBUH3N+Mt
        ExC7GEmGMgxNYvVQAj9gAI2QnMO0OpI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97C8913586;
        Mon,  9 Oct 2023 11:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HPsAJCfoI2UaLQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 09 Oct 2023 11:46:47 +0000
Date:   Mon, 9 Oct 2023 13:46:46 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
Message-ID: <kitlkwmcd45ng5nx442orpdwb55fajfiovupc72evx3coflssq@nomeuw22bwom>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyrm7snfd4lefojk"
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--uyrm7snfd4lefojk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Sat, Oct 07, 2023 at 02:02:56PM +0000, Yafang Shao <laoar.shao@gmail.com> wrote:
> Given the widespread use of cgroup1 in container environments, this change
> would be beneficial to many users.

This is an unverifiable claim (and benefit applies only to subset of
those users who would use cgroup1 and BPF). So please don't use it in
this form.

Thanks,
Michal


--uyrm7snfd4lefojk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSPoJAAKCRAGvrMr/1gc
jvjoAP41Hch4pFvO6QlXOwvMRcYXEo2K7rpkoqjxDDNw6ePMeQD+Ot17Rw4VBaIh
/gEiqjUka14wRenS4V9jUDlz5iKm/Aw=
=5TgT
-----END PGP SIGNATURE-----

--uyrm7snfd4lefojk--
