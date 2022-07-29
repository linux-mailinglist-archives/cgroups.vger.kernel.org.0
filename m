Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D65856E6
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiG2WmR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiG2WmP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 18:42:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8358AED8;
        Fri, 29 Jul 2022 15:42:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCC9335079;
        Fri, 29 Jul 2022 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659134531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rD+aoO58/UXvvvt/aND0JlhDHBAo4vbm4X2nBeuMrk=;
        b=nbv4TSFz/AnJ67K2qEUp0Et7jSzrGj8ODP/vQ+wQ5NbNs4GVIu4Lic3m9pVH14mB7IAxPw
        38W7rHxJ+F4RbBLqFG1hS1HjDT6b+uI46lCtzHEHYaMDAlDCS1Yd3ZVU+mq1C96HfSj08e
        2PxnIbPcmNaWI+rlSU4gbKxre7POMmQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92CFE13A1B;
        Fri, 29 Jul 2022 22:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mIGaIkNi5GJJfwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 29 Jul 2022 22:42:11 +0000
Date:   Sat, 30 Jul 2022 00:42:09 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH v2 cgroup/for-5.20] cgroup: Replace
 cgroup->ancestor_ids[] with ->ancestors[]
Message-ID: <YuRiQc35guAWcbjt@blackbook>
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
 <YuRJ7uzKY5/fokH5@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRJ7uzKY5/fokH5@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 29, 2022 at 10:58:22AM -1000, Tejun Heo <tj@kernel.org> wrote:
> @@ -520,8 +520,8 @@ struct cgroup_root {
>  	/* The root cgroup.  Root is destroyed on its release. */
>  	struct cgroup cgrp;
>  
> -	/* for cgrp->ancestor_ids[0] */
> -	u64 cgrp_ancestor_id_storage;
> +	/* for cgrp->ancestors[0] */
> +	u64 cgrp_ancestor_storage;

Just noticed, this member is (and was AFAICS) superfluous.


Michal
