Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F36A21CC
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjBXSvh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 13:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBXSvg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 13:51:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CCF6A7A6;
        Fri, 24 Feb 2023 10:51:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17F1A6084F;
        Fri, 24 Feb 2023 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677264693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXQvhEuj9SoWq4xHpYapHJn0TS7BQOaz7ZvYAaP4S+A=;
        b=dEYBd4cfzxjGTUmflHKaPPcrCa5DIXUW5PXOlZp25Ohjug6EGBHiNxCC4c2PxqyS/2Ey4z
        mhwRMO46LgnpEdxuUAGUYrz8/3/ZV12IG2ECnZBLqPvbjZV4TozoHBZaimvafQ/+J2k4U7
        SSFL+6vupQbD8c5MFDRjWifxKXfR0+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5DEE13246;
        Fri, 24 Feb 2023 18:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V8z9LjQH+WOvdAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Feb 2023 18:51:32 +0000
Date:   Fri, 24 Feb 2023 19:51:26 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
Subject: Re: [PATCH] blk-iocost: initialize rqos before accessing it
Message-ID: <20230224185126.bxkreilofbp2t4on@blackpad>
References: <20230224160714.172884-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6m3yodbwxciinozt"
Content-Disposition: inline
In-Reply-To: <20230224160714.172884-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6m3yodbwxciinozt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 08:07:14AM -0800, Breno Leitao <leitao@debian.org> =
wrote:
> ---
>  block/blk-iocost.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Well done.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


[...]
> 	blk_iocost_init (include/asm-generic/qspinlock.h:128
> 			 include/linux/spinlock.h:203
> 			 include/linux/spinlock_api_smp.h:158
> 			 include/linux/spinlock.h:400
> 			 block/blk-iocost.c:2884)
> 	ioc_qos_write (block/blk-iocost.c:3198)
> 	? kretprobe_perf_func (kernel/trace/trace_kprobe.c:1566)
> 	? kernfs_fop_write_iter (include/linux/slab.h:584 fs/kernfs/file.c:311)
> 	? __kmem_cache_alloc_node (mm/slab.h:? mm/slub.c:3452 mm/slub.c:3491)
> 	? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:46
> 			   arch/x86/include/asm/uaccess_64.h:52
> 			   lib/iov_iter.c:183 lib/iov_iter.c:628)
> 	? kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1693)
> 	cgroup_file_write (kernel/cgroup/cgroup.c:4061)
> 	kernfs_fop_write_iter (fs/kernfs/file.c:334)
> 	vfs_write (include/linux/fs.h:1849 fs/read_write.c:491
> 		   fs/read_write.c:584)
> 	ksys_write (fs/read_write.c:637)
> 	do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

BTW, out of curiosity what tool did you use to list stack with line
numbers?

Thanks,
Michal

--6m3yodbwxciinozt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY/kHFAAKCRAkDQmsBEOq
uZA8APwKEgRDcDxvVYqITHL+eSPHCCTuTseSO6af4mz3xtDDPAD9F5C04O0o8i2A
Cy6l5UzdFQQ+hamXG1WXrD52wGyWbQI=
=Ko1G
-----END PGP SIGNATURE-----

--6m3yodbwxciinozt--
