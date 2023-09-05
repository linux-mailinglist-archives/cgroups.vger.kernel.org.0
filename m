Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BCA7927FE
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbjIEQWL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbjIEQMF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 12:12:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122765B4;
        Tue,  5 Sep 2023 09:08:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF6ED1FED4;
        Tue,  5 Sep 2023 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693930025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7DpwVTdzkO9zvTaC0Nmsn1euztwCXxmkNCfH0qy/6k=;
        b=JuwiWsstsUx/RiXnQTVhHoohB5z8AqUuTYPwJqVfD3uJUgTGfqPeVba5V5NEEDW0ewNbK9
        2wvuBRryGXfUBvhrEM36nhox84C+PqP2ReSDma8+WWvRf7DZGDThb4CHbjJ0OSiyUZiTSv
        eZEMTFKIhS+9vnd097bZdCl7RTDQRUE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A872913499;
        Tue,  5 Sep 2023 16:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lNQ7KClS92QWEQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 05 Sep 2023 16:07:05 +0000
Date:   Tue, 5 Sep 2023 18:07:04 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <r5rbfskjjhkp5pjlwi7xqluc5lxq7bxo44gmxwhihn62ea75wp@iljnpiqo5dcr>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
 <ZPXupwjewuLgksAI@dhcp22.suse.cz>
 <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
 <ZPX6luPGqypp68+L@dhcp22.suse.cz>
 <hrpw2bjsrs3pzxympb7cz4nohyeztnxkmdtzbzlfdba6ugkken@dhcdbbbrv4fn>
 <CAJD7tkaHVtMiMYFocNiABuyhPcqt77gei0UeaDq4J7V-=tMFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6stuxi5kzfaubddj"
Content-Disposition: inline
In-Reply-To: <CAJD7tkaHVtMiMYFocNiABuyhPcqt77gei0UeaDq4J7V-=tMFYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6stuxi5kzfaubddj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2023 at 08:54:46AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> How would that create a userspace visible behavior that a dependency
> can be formed on?

A userspace process reading out root memory.stat more frequently than
in-kernel periodic flusher.

> Users expecting reclaim to be faster right after reading root stats?

Yes, that is what I had in mind.

> I would guess that would be too flaky to cause a behavior that people
> can depend on tbh.

I agree it's a weird dependency. As I wrote, nothing that would be hard
to take away.


Michal

--6stuxi5kzfaubddj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPdSJgAKCRAGvrMr/1gc
jvq0AP4lfNlWmGAFoLBq4DgbaLXZ/uCv05XZGxsrYdHcWo+uwAD8DGnuohLoPyYb
uBX+a5AsCXJZEgbqY1PGUk/edfszRAk=
=PUkx
-----END PGP SIGNATURE-----

--6stuxi5kzfaubddj--
