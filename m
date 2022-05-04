Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03C519F47
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbiEDM3h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbiEDM3h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 08:29:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFF13E38;
        Wed,  4 May 2022 05:26:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90E2E1F38D;
        Wed,  4 May 2022 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651667160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doyRZ/aPo6CAu2aRJZdJIbiD5u5Ey0uZjhyvfP1Ctxg=;
        b=N2vaxZGJ2unb+3IDJGpPKSzFqAbVU0whcBJYvGepz19nZuYUtUZV1YeQwH/896HEErAkZE
        Y6ajefODov6DJ/roi62apFVoZZ+Qv0Mkw7J15GK+8M7slaceWBctJQU5sdF7elqYx4+hbf
        sd773fem46TOty3AXl7mg/7SEvNr6/U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F161131BD;
        Wed,  4 May 2022 12:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Ld7DthwcmIuWwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 May 2022 12:26:00 +0000
Date:   Wed, 4 May 2022 14:25:58 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, daniel@ffwll.ch,
        hridya@google.com, christian.koenig@amd.com, jstultz@google.com,
        tkjos@android.com, cmllamas@google.com, surenb@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 2/6] cgroup: gpu: Add a cgroup controller for
 allocator attribution of GPU memory
Message-ID: <20220504122558.GB24172@blackbody.suse.cz>
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-3-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502231944.3891435-3-tjmercier@google.com>
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

Hello.

On Mon, May 02, 2022 at 11:19:36PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> This patch adds APIs to:
> -allow a device to register for memory accounting using the GPU cgroup
> controller.
> -charge and uncharge allocated memory to a cgroup.

Is this API for separately built consumers?
The respective functions should be exported (EXPORT_SYMBOL_GPL) if I
haven't missed anything.

> +#ifdef CONFIG_CGROUP_GPU
> + /* The GPU cgroup controller data structure */
> +struct gpucg {
> +	struct cgroup_subsys_state css;
> +
> +	/* list of all resource pools that belong to this cgroup */
> +	struct list_head rpools;
> +};
> +
> +/* A named entity representing bucket of tracked memory. */
> +struct gpucg_bucket {
> +	/* list of various resource pools in various cgroups that the bucket is part of */
> +	struct list_head rpools;
> +
> +	/* list of all buckets registered for GPU cgroup accounting */
> +	struct list_head bucket_node;
> +
> +	/* string to be used as identifier for accounting and limit setting */
> +	const char *name;
> +};

Do these struct have to be defined "publicly"?
I.e. the driver code could just work with gpucg and gpucg_bucket
pointers.

> +int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *name)

...and the registration function would return a pointer to newly
(internally) allocated gpucg_bucket.

Regards,
Michal
