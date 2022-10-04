Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD845F4974
	for <lists+cgroups@lfdr.de>; Tue,  4 Oct 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJDSuC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 14:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJDSt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 14:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345418B1E;
        Tue,  4 Oct 2022 11:49:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DECF41F94D;
        Tue,  4 Oct 2022 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664909392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UNyI7lLYkq9NR142HxaTAJjkImjeZgGlN6hwkAxwMk=;
        b=YC+buOEk9Zc2GcPD5jOtQJWPyzrKsJH/cz+0BQYO7BGtB1JGjVdxR6XHWP8ftATaQo6OHd
        JhKwLPZDIsyhSrLJtXujRVkh75AJvF0yYrrOIUe5aqbh0nmobhYxqufLH/vGO+WlHkP25y
        +2oHfraB4VDBb7/iDgFznOCT3jB2vMU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E721139EF;
        Tue,  4 Oct 2022 18:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kn6PJVCAPGM4XwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Oct 2022 18:49:52 +0000
Date:   Tue, 4 Oct 2022 20:49:51 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YzyAT/lfyKhOnOpy@blackbook>
References: <20221004151748.293388-1-longman@redhat.com>
 <20221004151748.293388-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2x28QV160etDw6kh"
Content-Disposition: inline
In-Reply-To: <20221004151748.293388-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--2x28QV160etDw6kh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Oct 04, 2022 at 11:17:48AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> To protect against destruction of blkg, a percpu reference is gotten
> when putting into the lockless list and put back when removed.

Just to conclude my previous remark about the loop, let me try
explaining it more precisely:

blkcg->lhead via blkg_iostat_set holds reference to blkcg_gq=20
   (taken in in blk_cgroup_bio_start)

blkcg_gq holds reference to its blkcg_gq->blkcg=20
   (taken in blkg_create)

The cycle has two edges, the latter is broken in __blkg_release but
that's a release callback of the involved blkcg_gq->refcnt, so it won't
be called.

The first edges is broken in blkcg_rstat_flush and that's more promising.
The current code does the final flushes -- in css_release_work_fn.
The problem is that it's the release callback of blkcg->css, i.e. it's
also referenced on the cycle, therefore this final flush won't happen
before cycle is broken.

Fortunately, any other caller of cgroup_rstat_flush comes to the rescue
-- the blkcg_rstat_flush on the stuck blkcg would decompose lhead list
and the reference cycle is broken.

In summary, I think this adds the reference cycle but its survival time
is limited to the soonest cgroup_rstat_flush call, which should not
cause practical troubles.

HTH,
Michal

--2x28QV160etDw6kh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYzyATQAKCRAkDQmsBEOq
uR6ZAQDgLur6eHNw+8NVHuBo39WYPgLu3bNOK4TNdtKfpKl3mQEAxvyDr/yKx2iZ
Duqml+a289o/PZPQLt5fTmUskNjKYAI=
=xQFZ
-----END PGP SIGNATURE-----

--2x28QV160etDw6kh--
