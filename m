Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794EF68D75C
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 13:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBGM7F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 07:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjBGM7E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 07:59:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653D1B56D;
        Tue,  7 Feb 2023 04:59:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E96738DC1;
        Tue,  7 Feb 2023 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675774742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QoTLoXlIMxSw37JX85ExzUtBnHWAzOyLQ2c0uIpTLM=;
        b=IgskfTMKEaO1jmC/N1nUWksgS2w7L8hHtYNz/l/0AgYHAEeL8SvjUTb1X8N2aT+oc21fQK
        uVxDNfqkoggQQalEcTuNbwT7BnJg3edJ2qvl5KTiMunxb80wXQkiLAlWEaNbjCA56AE9lC
        dWFgdQMn5ORKYrhQw9DZoNFkuARlRtw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCE7513467;
        Tue,  7 Feb 2023 12:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMA0LRVL4mMdZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 07 Feb 2023 12:59:01 +0000
Date:   Tue, 7 Feb 2023 13:59:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Merge individual nohz_full features
 into a common housekeeping flag
Message-ID: <20230207125900.GA24523@blackbody.suse.cz>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-2-frederic@kernel.org>
 <20230206155107.GA31453@blackbody.suse.cz>
 <Y+I61dp5qPkWK4s2@lothringen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <Y+I61dp5qPkWK4s2@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2023 at 12:49:41PM +0100, Frederic Weisbecker <frederic@kernel.org> wrote:
> But what do we need these annotations for? The only outcome I've ever
> seen with these is that it confuses everyone.

Take that as a note of a lone actor then who found it useful documenting
relations between various parts of the code.

> This way I can add the support for each part smoothly.

Yeah, that makes sense.

> For example first patch moves HK_TYPE_TIMER to HK_TYPE_KERNEL_NOISE
> and unbound timers are supported by cpuset.kernel_noise, second patch
> moves HK_TYPE_WQ to HK_TYPE_KERNEL_NOISE and unbound workqueues are
> supported by cpuset.kernel_noise, etc until all of them turned by
> nohz_full= are supported...

So does this mean you'll re-introduce the finer grained HK_* flags
again?

The idea (not only mine?) is that this would extend
cpuset.cpus.partition that only allows HK_TYPE_DOMAIN analogy. The
mapping to individual flags may not be exposed to users. The graduality
could be achieved by adding more flags under user_exposed_term.

Just to be on the same page -- that's how I understand it, the original
HK_* resolution turned out impractical for users and that's why the
direction is towards some loose combinations representing user
intentions. Is that right?


Cheers,
Michal

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHQEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+JLBQAKCRAkDQmsBEOq
udOKAPdJq+O7uJgDbO4QNyCO7NcKnOeMid700809Y9NpPfptAP94KF/OZau1bPKP
nGKv3/uKXc7NKO/TqZ2HmKeGpdNzDg==
=vDYK
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
