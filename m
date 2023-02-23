Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFF6A0BCC
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 15:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjBWOU5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 09:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjBWOU4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 09:20:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65F2A15A;
        Thu, 23 Feb 2023 06:20:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA45B1FD92;
        Thu, 23 Feb 2023 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677162054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kav8FmN/Pj89hSxrGp53cgOm8Q4RadxShRyIj0aVt2M=;
        b=KCM/GkDJ5CtrBapJmm08Wf0Llp3zhiGYXKrM4uUOajtjgJm1kj8pXs2eksaizhJIHaIvux
        giEr4JnWA2DcaeQVK7kAsTR0tU68shsJhTBm4/Q/OyvKGeQp1CKXopYhQCk/ovC0IJ/keI
        QnKHkQpZqz8LzK3EIVQZqqymtg9rcKQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6519D13928;
        Thu, 23 Feb 2023 14:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YQxiF0Z292NNFgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 23 Feb 2023 14:20:54 +0000
Date:   Thu, 23 Feb 2023 15:20:53 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Matthew Chae <matthew.chae@axis.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@axis.com,
        christopher.wong@axis.com, Muchun Song <muchun.song@linux.dev>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <20230223142053.ejpygn4asiks7uue@blackpad>
References: <20230221143421.10385-1-matthew.chae@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q22yp5mylqojoxly"
Content-Disposition: inline
In-Reply-To: <20230221143421.10385-1-matthew.chae@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--q22yp5mylqojoxly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Matthew.

On Tue, Feb 21, 2023 at 03:34:20PM +0100, Matthew Chae <matthew.chae@axis.com> wrote:
> The kernel currently doesn't provide any method to show the overall
> system's peak memory usage recorded. Instead, only each slice's peak
> memory usage recorded except for cgroup root is shown through each
> memory.peak.

The memory.peak value is useful as a calibration insight when you want to
configure memcg limit.
But there is no global (memcg) limit on memory. So what would be this
(not clearly) defined value good for? Or better then userspace sampling
of chosen available metric?

Thanks,
Michal

--q22yp5mylqojoxly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY/d2QgAKCRAkDQmsBEOq
uZKPAP0XDln51ca97Q7J1pGYE4mYyE5HiobHbhWmbtWeDr85qwD9GTceOFjkX9Xb
q33nFRFD1ixImjgy/z6X9cnP0dK/WQ4=
=3ruE
-----END PGP SIGNATURE-----

--q22yp5mylqojoxly--
