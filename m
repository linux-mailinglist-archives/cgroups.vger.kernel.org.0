Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F867E102
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 11:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjA0KEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 05:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjA0KEn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 05:04:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B713DEA;
        Fri, 27 Jan 2023 02:04:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0D7E201D2;
        Fri, 27 Jan 2023 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674813870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2Yj6ff8IbmYEbxojhB+2vw+NfQJD3sa9mrK8gYDrlU=;
        b=oSpjoRiphsPb9FjCgcMhy4VMAxtwPO7mmwnC1JnlR3dGohGzYh9aJWGao+j9UryNeC7RbJ
        Q4Z9uPAqEzLwsc6JPhlq/lTGl9xZ1KiDkNWdbyrhh8DlJ2boPQYc6NV25oxAH15r7EcWn6
        D3mX/jmvrHxA40e5tWuM6ITw4MR6uEA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2ADB138E3;
        Fri, 27 Jan 2023 10:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DBZ7Jq2h02NsLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 27 Jan 2023 10:04:29 +0000
Date:   Fri, 27 Jan 2023 11:04:28 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>, Intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC v3 00/12] DRM scheduling cgroup controller
Message-ID: <20230127100428.GA3527@blackbody.suse.cz>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230123154239.GA24348@blackbody.suse.cz>
 <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
 <20230126130050.GA22442@blackbody.suse.cz>
 <Y9KyiCPYj2Mzym3Z@slm.duckdns.org>
 <b8a0872c-fe86-b174-ca3b-0fc04a98e224@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <b8a0872c-fe86-b174-ca3b-0fc04a98e224@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2023 at 05:57:24PM +0000, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> So even if the RFC shows just a simple i915 implementation, the controller
> itself shouldn't prevent a smarter approach (via exposed ABI).

scan/query + over budget notification is IMO limited in guarantees.

> [...]
> Yes agreed, and to re-stress out, the ABI as proposed does not preclude
> changing from scanning to charging or whatever. The idea was for it to be
> compatible in concept with the CPU controller and also avoid baking in the
> controlling method to individual drivers.
> [...]

But I submit to your point of rather not exposing this via cgroup API
for possible future refinements.

> Secondly, doing this in userspace would require the ability to get some sort
> of an atomic snapshot of the whole tree hierarchy to account for changes in
> layout of the tree and task migrations. Or some retry logic with some added
> ABI fields to enable it.

Note, that the proposed implementation is succeptible to miscount due to
concurrent tree modifications and task migrations too (scanning may not
converge under frequent cgroup layout modifications, and migrating tasks
may be summed 0 or >1 times). While in-kernel implementation may assure
the snapshot view, it'd come at cost. (Read: since the mechanism isn't
precise anyway, I don't suggest a fully synchronized scanning.)

Regards,
Michal

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY9OhlwAKCRAkDQmsBEOq
ufYHAQCnD9btPT6J56fYnI1rsJHumK+TajFM5kqwWR6eIphScQD+NCFpWhvbh6n2
F2dtfltgBBeFK/0OaFCJuhoi7uIPUQA=
=ZjfL
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
