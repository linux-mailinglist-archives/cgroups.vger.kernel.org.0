Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148C5599C6
	for <lists+cgroups@lfdr.de>; Fri, 24 Jun 2022 14:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiFXMnV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jun 2022 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiFXMnU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jun 2022 08:43:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0956140F0;
        Fri, 24 Jun 2022 05:43:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CBF7D21A5C;
        Fri, 24 Jun 2022 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656074597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbkT57a8V0dJcSqQrodxix/sir4fcRh67YaToWJTvHE=;
        b=ewI827+xmnQCyHqvi4SVwM8YXQrqPa90AuyZGpIe+rcogw9aqIprFe4iT597bsxYtmTnLS
        lVxPFb+CFLEQ9X3VNbp8J6uEM9ImjVdqKEa2F62aHcwBq4D7y+CiH0OcFpgi7ODhP0jixN
        fBsgE0c7lgpa9TwQZQzFyjALrQp1LWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A821313ACA;
        Fri, 24 Jun 2022 12:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e84SKGWxtWJ7awAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Jun 2022 12:43:17 +0000
Date:   Fri, 24 Jun 2022 14:43:16 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH] cpuset: Allow setscheduler regardless of manipulated
 task
Message-ID: <20220624124316.GH16004@blackbody.suse.cz>
References: <20220623124944.2753-1-mkoutny@suse.com>
 <ab4bcd51-83c5-ae21-ddf6-607a31a7d6ac@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <ab4bcd51-83c5-ae21-ddf6-607a31a7d6ac@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 02:44:33PM -0400, Waiman Long <longman@redhat.com> wrote:
> That could be an issue.

The way how I understand here is that the privileged process isn't part
of contrained workload (if it were then, it can modify cpuset itself)
like debugging or tracing a code within a container entered by the
admin. The bypass could not be used to setscheduler (via migration) of
an arbitrary process.

> What do you mean by nothing effectively changes?

It's a freshly created child (after cpuset_css_online()), so it inherits
parent's attributes, so the migration from the parent to this child
doesn't affect CPU affinity etc.

> Since the check is done on a taskset level, if only one of the tasks in the
> taskset fails, the whole taskset fails. Maybe we should consider an option
> for task based migration. So all the tasks that can be migrated will be
> migrated and the rests will be left behind in the original cpuset.

Hm, I haven't thought about that. That might be in theory possible for
threaded controllers (like cpuset) but I imagine it'd a bit messy, in
particular for these implicit migrations upon controller enablement.

Thanks,
Michal

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYrWxYgAKCRAkDQmsBEOq
uSK7AQDxSD0tP0e4c1MlmPs3gy70GRGHcWnbPa9H+VtXGrwCtgEA3seoFthswxlF
BlkMXOCW5rIUwjXRGQ/9u+FKiUXulg8=
=Q3D5
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
