Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97847B9F9B
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjJEOZ4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJEOYM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:24:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEB8A7D
        for <cgroups@vger.kernel.org>; Thu,  5 Oct 2023 01:35:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E77C1F74D;
        Thu,  5 Oct 2023 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696494919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M724WXv33Uc1wz4phQmuEdysQ357lwXIlbLevkMfpBo=;
        b=uBI8wnNFohCCP2B0acvCAowQYgdGfXiLo6s56LDpN1qgMNnCxim/4gZbvbqfycHruYjbom
        N5TP/okN1OANHQY2Bp9j+M8ymC/wAi5MWaOWP4S6BZLGExZauiGTZsG++n9Ptxe7N4Zeyo
        IKJkl5FTO2VTwgeh4QPXFVbIyE/dUgU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CA4E13438;
        Thu,  5 Oct 2023 08:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MOctBkd1HmVoYAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Oct 2023 08:35:19 +0000
Date:   Thu, 5 Oct 2023 10:35:17 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Felip Moll <lipixx@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: VSZ from cgroup interfaces
Message-ID: <ozgj2cg254fmse73rb2sv2pmexz3rx7r3yekztjnr7swpsxqtp@5zn7jdhhovc7>
References: <CAOv3p80vCV1_FeynQ_sZhzYbif_-4k4odZHex9NbhzuZ204gLg@mail.gmail.com>
 <ruokbytamh5n456ufqteijolzper3jhhhitjtwrhrguz3svkf2@ddszugmaypvz>
 <CAOv3p83SCJEEK2Obh4s=-WPoqAuktYeAQxPF8E-c2QJD7pwtdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7sg54ruurvxfbxb6"
Content-Disposition: inline
In-Reply-To: <CAOv3p83SCJEEK2Obh4s=-WPoqAuktYeAQxPF8E-c2QJD7pwtdQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--7sg54ruurvxfbxb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 09:52:28PM +0200, Felip Moll <lipixx@gmail.com> wrote:
> Well, I understand it is a per-process resource as any other field you
> can check in /sys/fs/cgroup/../memory.stat.

Those fields are machine (owned) resources consumed by processes (e.g.
(anon) pages (but this file has a mixture of types of values)).

> Can you develop on why you say vsz of one process is not exclusive to
> another's vsz?

One process can have a vaddrs in range say 1G..2G, that is 1G vsz (and
can be much less of rss).
Another process can have very same (nominal) range, 1G vsz again. That
is 2G of vsz in total but nothing needs to be actually consumed (for
backing pages, whose number can further vary depending on possible
sharing).

> Technically, the sum of all VSZ would give an estimation of how much
> memory a set of processes might try to use. I think that's the same
> idea of VSZ for a single process but just for a set of processes.
> This could be useful to detect memleaks on a program before they
> happen when you see a huge VSZ.

Ah, now I see where you're coming from. That could be a new field in
memory.stat.

Regards,
Michal

--7sg54ruurvxfbxb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR51RAAKCRAGvrMr/1gc
jp2tAQD05Xhg5cBM35Er0iYwZqshe9G5SJKJhG5hjHyLla2LBgD+J0AalOXpb6Qn
EVm+pM2nb1kzLZIRVkiB+c3P7m008Qc=
=MPjK
-----END PGP SIGNATURE-----

--7sg54ruurvxfbxb6--
