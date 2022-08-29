Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A95A4CFD
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiH2NGj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH2NGV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 09:06:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A4562A9B;
        Mon, 29 Aug 2022 06:00:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2D3222DDF;
        Mon, 29 Aug 2022 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661777998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSRqVVn5SCoLVeckWTZ5Gj/nBtXDD5MTT0sRUoTFBiw=;
        b=UqKZNoswzkT4opbT0CFX0E2k4fxB6asNd34TQMJiKraxmyY5Oy62NiBcyrPldyXJ7KDJHR
        7Wzx8mJy2LXH7P8HqiXtIjspI2kHyviaLuibhQeNTELPHHnPMRqkdbRM750kNErG6GV8Br
        EgX2s0bkY6Ph0Hv59W0uEeHHnYScYaw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9836D133A6;
        Mon, 29 Aug 2022 12:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8skyJE64DGPAQwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 29 Aug 2022 12:59:58 +0000
Date:   Mon, 29 Aug 2022 14:59:57 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for
 ancestors
Message-ID: <20220829125957.GB3579@blackbody.suse.cz>
References: <20220826165238.30915-1-mkoutny@suse.com>
 <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 10:41:37AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> I understand that currently cgroup_iter is the only user of this, but
> for future use cases, is it safe to assume that cgrp will always be
> inside ns? Would it be safer to do something like:

I preferred the simpler root_cgrp comparison to avoid pointer
arithmetics in cgroup_is_descendant. But I also made the assumption of
cgrp in ns.

Thanks, I'll likely adjust cgroup_path_ns to make it more robust for
an external cgrp.


I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
cgroup iterator, exposes it via bpffs and than a process B in a narrowed
cgroup ns (which excludes the origin cgroup) wants to traverse the
iterator, should it fail straight ahead (regardless of iter order)?
The alternative would be to allow self-dereference but prohibit any
iterator moves (regardless of order).


Thanks,
Michal

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYwy4SQAKCRAkDQmsBEOq
uZX4AQDqrzGBoULhzyvm8GveGTXVJYAupuXli8zU2n5T8KXI1wEA/d5JS9XKNwTR
qMIafR6at0V6U72iM2jn2OX84ZgiKgk=
=auEQ
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
