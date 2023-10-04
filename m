Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5F7B8ABA
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjJDSi1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbjJDSi1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:38:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CEDFB
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 11:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F364921845;
        Wed,  4 Oct 2023 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696444699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVIBnFcJesPFXhG7kE7mKAteaRmG3NScmIEsxJW8Shw=;
        b=LflQ8PGjXNKnI78orJoRnOYgdpCSjIDDxw+h6562IXPFO3lsBZBeIeDT3/QEUYT+ZUZir5
        E5EWgngCOyMKqBeGLGG38MNif166cAYqrHnQowmYQW9wKaPuG9owdZqYyodLMRBU6zzw1m
        kNdbBiqFOOt9AyphB8iMWMMa87pC7r0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E02AC139F9;
        Wed,  4 Oct 2023 18:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id esvaNRuxHWUIeAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 Oct 2023 18:38:19 +0000
Date:   Wed, 4 Oct 2023 20:38:18 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Felip Moll <lipixx@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: VSZ from cgroup interfaces
Message-ID: <ruokbytamh5n456ufqteijolzper3jhhhitjtwrhrguz3svkf2@ddszugmaypvz>
References: <CAOv3p80vCV1_FeynQ_sZhzYbif_-4k4odZHex9NbhzuZ204gLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qw5qaxfng5owkh4"
Content-Disposition: inline
In-Reply-To: <CAOv3p80vCV1_FeynQ_sZhzYbif_-4k4odZHex9NbhzuZ204gLg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6qw5qaxfng5owkh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Felip.

On Mon, Oct 02, 2023 at 10:59:34AM +0200, Felip Moll <lipixx@gmail.com> wrote:
> Does cgroups account for virtual memory? Is it too expensive to
> account for it? I cannot find it by reading the kernel but I might be
> wrong.

Virtual memory is a per-process resource (if you consider it a resource
at all and if I understood what you mean by vsz). It is not well defined
what would it mean if you summed up VSZ of all processes in a cgroup
(vsz of one process is not exclusive to another process's vsz). So my
answer is that doesn't make sense to account VSZ via cgroups.

HTH,
Michal


--6qw5qaxfng5owkh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZR2xGAAKCRAGvrMr/1gc
jkCXAQDKEOLbGHG2hjCmokHRlhWwzSvabWG/rR8O7xGAcrLcOwEAy5mE5cj0czX+
CfoVAu8eW1BcVRorY2aGEBh3pHf2IQ8=
=i/nT
-----END PGP SIGNATURE-----

--6qw5qaxfng5owkh4--
