Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395E6D4E4C
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjDCQrl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjDCQrk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 12:47:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB1EC;
        Mon,  3 Apr 2023 09:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32BF821C7A;
        Mon,  3 Apr 2023 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680540458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VH+9LfYj7MbhreJ3Szg7MbF/2ha5Mr1B2SE9ELvDJ0M=;
        b=kJzshujXHzyGF/fo1Q6O+NTAfxbHv0w+eS/aHfJzJJpZLWjta2sh/QjUpKpd7xOVZOUqAG
        foWWC1LD1MDZKWlD/2bjPg3adOFbAoTMyJ+y0SS4NM3u17g5KEaAwxlrTcHkXdWZ9eC3Ay
        +vjsofb4QjlQvBe/hTWTGhpKpwLxZus=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 071C913416;
        Mon,  3 Apr 2023 16:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CVnSACoDK2RLaQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Apr 2023 16:47:38 +0000
Date:   Mon, 3 Apr 2023 18:47:36 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach
 operation per cpuset
Message-ID: <20230403164736.lpjdpzxxnjlpxrqv@blackpad>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmhryddp6pf4i2i3"
Content-Disposition: inline
In-Reply-To: <20230331145045.2251683-4-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kmhryddp6pf4i2i3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2023 at 10:50:45AM -0400, Waiman Long <longman@redhat.com> wrote:
> The current cpuset code uses the global cpuset_attach_old_cs variable
> to store the old cpuset value between consecutive cpuset_can_attach()
> and cpuset_attach() calls. Since a caller of cpuset_can_attach() may
> not need to hold the global cgroup_threadgroup_rwsem, parallel cpuset
> attach operations are possible.

Do I understand correctly this consequence of the cpuset_attach_task()
on the clone path?
In that particular case (with CLONE_INTO_CGROUP) cgroup_mutex is taken,
so the access the the old_cs variable should still be synchronized with
regular migrations that are also under cgroup_mutex.


> When there are concurrent cpuset attach operations in progress,
> cpuset_attach() may fetch the wrong value from cpuset_attach_old_cs
> causing incorrect result.  To avoid this problem while still allowing
> certain level of parallelism, drop cpuset_attach_old_cs and use a
> per-cpuset attach_old_cs value. Also restrict to at most one active
> attach operation per cpuset to avoid corrupting the value of the
> per-cpuset attach_old_cs value.

Secondly, semantically wouldn't a `void *ss_priv[CGROUP_SUBSYS_COUNT]`
in struct cgroup_taskset make it simpler wrt the exclusivity guarantees?

Thirdly, if my initial assumptino is right -- I'd suggest ordering this
before the patch `cgroup/cpuset: Make cpuset_fork() handle
CLONE_INTO_CGROUP properly` to spare backporters possible troubles if
this is would be a fixup to that.


Thanks,
Michal

--kmhryddp6pf4i2i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCsDJQAKCRAkDQmsBEOq
uS1zAP9TeBgc6NireljK5S1YDI/FdwDZFOk2ok2qCHerVad9/AD/bvO7HggZe7lO
MYuH4JuHJxwswQfaPVy7pxI4M5JDtgc=
=cc04
-----END PGP SIGNATURE-----

--kmhryddp6pf4i2i3--
