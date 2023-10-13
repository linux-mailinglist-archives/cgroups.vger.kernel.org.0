Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F327C891C
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjJMPu1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMPu0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 11:50:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF4BB;
        Fri, 13 Oct 2023 08:50:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD141FDA3;
        Fri, 13 Oct 2023 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697212222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7RHgYxxzJ/pOaovwvv6HlOwhHh2FXPWvC+R+XRmWbc=;
        b=rdx60rFehK2i6+arc2yuiZqIq756SIqcqRE5cIrCX+EWupt5oxfx2pNoElAE/FjEWbUFcK
        CF4xNdSKbYbUsSdq56KIy8rGrsflEgwHE3c5aZvzNfl6jcNpND9eFAUJ470HmKmXGPUzBF
        OKwmcXz+bdiR/zPShFexlDrS5E1zIMc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06C37138EF;
        Fri, 13 Oct 2023 15:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hhfdAD5nKWXKWAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 Oct 2023 15:50:22 +0000
Date:   Fri, 13 Oct 2023 17:50:20 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Message-ID: <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
References: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tesk6d4tqdsww4u2"
Content-Disposition: inline
In-Reply-To: <20230905133243.91107-1-longman@redhat.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.70
X-Spamd-Result: default: False [-5.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tesk6d4tqdsww4u2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

(I know this is heading for 6.7. Still I wanted to have a look at this
after it stabilized somehow to understand the new concept better but I
still have some questions below.)

On Tue, Sep 05, 2023 at 09:32:36AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Both scheduling and isolated partitions can be formed as a remote
> partition. A local partition can be created under a remote partition.
> A remote partition, however, cannot be formed under a local partition
> for now.
>=20
>=20
> With this patch series, we allow the creation of remote partition
> far from the root. The container management tool can manage the
> "cpuset.cpus.exclusive" file without impacting the other cpuset
> files that are managed by other middlewares. Of course, invalid
> "cpuset.cpus.exclusive" values will be rejected.

I take the example with a nested cgroup `cont` to which I want to
dedicate two CPUs (0 and 1).
IIUC, I can do this both with a chain of local root partitions or as a
single remote partion.


[chain]
  root
  |                           \
  mid1a                        mid1b
   cpuset.cpus=3D0-1              cpuset.cpus=3D2-15
   cpuset.cpus.partition=3Droot  =20
  |
  mid2
   cpuset.cpus=3D0-1
   cpuset.cpus.partition=3Droot
  |
  cont
   cpuset.cpus=3D0-1
   cpuset.cpus.partition=3Droot


[remote]
  root
  |                           \
  mid1a                        mid1b
   cpuset.cpus.exclusive=3D0-1    cpuset.cpus=3D2-15
  |
  mid2
   cpuset.cpus.exclusive=3D0-1
  |
  cont
   cpuset.cpus.exclusive=3D0-1
   cpuset.cpus.partition=3Droot

In the former case I must configure cpuset.cpus and
cpuset.cpus.partition along the whole path and in the second case
cpuset.cpus.exclusive still along the whole path and root at the bottom
only.

What is the difference between the two configs above?
(Or can you please give an example where the remote partitions are
better illustrated?)

<snip>
> Modern container orchestration tools like Kubernetes use the cgroup
> hierarchy to manage different containers. And it is relying on other
> middleware like systemd to help managing it. If a container needs to
> use isolated CPUs, it is hard to get those with the local partitions
> as it will require the administrative parent cgroup to be a partition
> root too which tool like systemd may not be ready to manage.

Such tools ready aren't ready to manage cpuset.cpus.exclusive, are they?
IOW tools need to distinguish exclusive and "shared" CPUs which is equal
to distinguishing root and member partitions.

Thanks,
Michal



--tesk6d4tqdsww4u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSlnOgAKCRAGvrMr/1gc
jlo1AP4xYSAUf4DNG5nuDm9LyX+YsGRZ3bq7u4QtsOcCrbBDcQEAxQyx0Jkugln1
c2iV+v7jMcqrtN8iFmXXCc/E1ZE49Qs=
=9/XE
-----END PGP SIGNATURE-----

--tesk6d4tqdsww4u2--
