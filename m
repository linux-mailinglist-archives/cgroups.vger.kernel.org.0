Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8C7BE354
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjJIOpJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjJIOpI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 10:45:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C0BA;
        Mon,  9 Oct 2023 07:45:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E0C11F381;
        Mon,  9 Oct 2023 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696862704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk8QgHdLYwW112OLr4BrQ25Nu7+xYY3ibDsMkcwEE2Y=;
        b=Z5rREdVCpt/IKiVMcLC/xJB43aJqwyezdpM5S9RfrAz3pfSBrbRMNybIKzT1v0Nt2/PCT6
        VOnPAyigCN8ijwLQPeui7HFTz7YSRCXGNv4479JInOO1lE4H7WpKo7MPT1IPTk+d6JhKeX
        gzMrGFjT5wA1KSkFmNzoG4KPEFNgdnQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDFE213905;
        Mon,  9 Oct 2023 14:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KP8wOe8RJGWbGAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 09 Oct 2023 14:45:03 +0000
Date:   Mon, 9 Oct 2023 16:45:02 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex
 in task_cgroup_from_root()
Message-ID: <sdw6rnzbvmktajcxb4svj2kzvttftae2i5nd2lnlxnm3llub37@2q2rlubjzb5a>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6q2ja7pwinum5jiy"
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6q2ja7pwinum5jiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 07, 2023 at 02:02:57PM +0000, Yafang Shao <laoar.shao@gmail.com> wrote:
> The task cannot modify cgroups if we have already acquired the
> css_set_lock, thus eliminating the need to hold the cgroup_mutex. Following
> this change, task_cgroup_from_root() can be employed in non-sleepable contexts.

IIRC, cset_cgroup_from_root() needs cgroup_mutex to make sure the `root`
doesn't disappear under hands (synchronization with
cgroup_destroy_root().
However, as I look at it now, cgroup_mutex won't synchronize against
cgroup_kill_sb(), it may worked by accident(?) nowadays (i.e. callers
pinned the root implicitly in another way).

Still, it'd be good to have an annotation that ensures, the root is around
when using it. (RCU read lock might be fine but you'd need
cgroup_get_live() if passing it out of the RCU read section.)

Basically, the code must be made safe against cgroup v1 unmounts.


Michal

--6q2ja7pwinum5jiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSQR7AAKCRAGvrMr/1gc
jrnzAP91+lw53+BV5UqsWRIeykgAj45ncQP5Jyov7YDvSrMKbAD/W/q25ZMcohjE
m/z+7ie7DKP0nuVf8EefZIeFcmQgKQc=
=ibtO
-----END PGP SIGNATURE-----

--6q2ja7pwinum5jiy--
