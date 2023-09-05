Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD57927B4
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjIEQVy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbjIEOKQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 10:10:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68EED;
        Tue,  5 Sep 2023 07:10:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC5E721B46;
        Tue,  5 Sep 2023 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693923011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfXW8hhd1XlJUbKT2y+Z8z/xpNcq0SYP8MPtpS/4cLs=;
        b=GsWx/gC+utWM4y3FM5UmDf/N2Yi6LqI1Q+E9qdDmspRlfhrmUO1gLMTtaIHxDWpCFfk9mn
        WkMV+6NSQv+LHG1vE2yUVWJfqytQfDGh4nbNWuHnn7DYijpnglIxeGrjCJF9SBLXDBAuYj
        qqDr8WTCv+a0GQ8kG0G1vHstZ++C+vw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DC8013911;
        Tue,  5 Sep 2023 14:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ziSTJcM292Q1TgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 05 Sep 2023 14:10:11 +0000
Date:   Tue, 5 Sep 2023 16:10:10 +0200
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
Message-ID: <hrpw2bjsrs3pzxympb7cz4nohyeztnxkmdtzbzlfdba6ugkken@dhcdbbbrv4fn>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
 <ZPXupwjewuLgksAI@dhcp22.suse.cz>
 <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
 <ZPX6luPGqypp68+L@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xl6u4xlnnymxuii"
Content-Disposition: inline
In-Reply-To: <ZPX6luPGqypp68+L@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5xl6u4xlnnymxuii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 05:41:10PM +0200, Michal Hocko <mhocko@suse.com> wr=
ote:
> So it also creates an undocumented but userspace visible behavior.
> Something that userspace might start depending on, right?

Yes but -
- depending on undocumented behavior is a mistake,
- breaking the dependency would manifest (in the case I imagine) as a
  performance regression (and if there are some users, the future can
  allow them configuring periodic kernel flush to compensate for that).

Or do you suggest these effects should be documented (that would require
deeper analysis of the actual effect)?=20


Thanks,
Michal

--5xl6u4xlnnymxuii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPc2wAAKCRAGvrMr/1gc
jlxaAP46l8gRlfACegKealpEqf4LldUZ6wJpB4fTVFaOGIrwtgD8C5FMCJxGkTXl
1GdDHiGP3h6e0MohvE8iIjMLkW8eyQk=
=yjdi
-----END PGP SIGNATURE-----

--5xl6u4xlnnymxuii--
