Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EB791AA5
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjIDP3V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjIDP3V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 11:29:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84516199;
        Mon,  4 Sep 2023 08:29:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45CBB1F74D;
        Mon,  4 Sep 2023 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693841356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJLufghybCMa24PDpvfycL/ikAXyEs0VewOCLgkv2eg=;
        b=j299Sc/TsT+nZFscMydQEj2Gnb7vTxcXBX03rHpI6p62mNFZ0JNS37/wHT+lxSh8I4HRio
        T7WshfgDW2/PHpCAFYArzL5GQ/X6MIYbfmkqyng04a5RByI7GD2aQt+OrG4IbPK7KD9Wl4
        qrNllUW9brGOnw5F/f9Q580XqOYnNUk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D10013585;
        Mon,  4 Sep 2023 15:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CCljAsz39WTNTgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 04 Sep 2023 15:29:16 +0000
Date:   Mon, 4 Sep 2023 17:29:14 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes
 help unified flushes
Message-ID: <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
 <ZPXupwjewuLgksAI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syrk2v4vngqj4sdi"
Content-Disposition: inline
In-Reply-To: <ZPXupwjewuLgksAI@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--syrk2v4vngqj4sdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Sep 04, 2023 at 04:50:15PM +0200, Michal Hocko <mhocko@suse.com> wrote:
> I have hard time to follow why we really want/need this. Does this cause
> any observable changes to the behavior?

Behavior change depends on how much userspace triggers the root memcg
flush, from nothing to effectively offloading flushing to userspace tasks.
(Theory^^^)

It keeps stats_flush_threshold up to date representing global error
estimate so that error-tolerant readers may save their time and it keeps
the reasoning about the stats_flush_threshold effect simple.

Michal

--syrk2v4vngqj4sdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPX3wwAKCRAGvrMr/1gc
jrH9AQDraTQKzMHznCeTIWsFz0m6SziVQ0WMnHb90hQ5OGjzQQD/dPHTWpaxgO+S
ff5xBhybWn1PrJqNeXXnqzuYpF1d/gA=
=ACcJ
-----END PGP SIGNATURE-----

--syrk2v4vngqj4sdi--
