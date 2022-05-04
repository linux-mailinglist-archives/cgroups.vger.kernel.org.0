Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C0519EFF
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbiEDMOc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349236AbiEDMOb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 08:14:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D718359;
        Wed,  4 May 2022 05:10:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 225CE1F745;
        Wed,  4 May 2022 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651666254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbtrdowooXgC4Dq4I7PP0O0e6k1pK88440d13xBhK68=;
        b=gvyorl1e9bnZvu9SbWDa+u1KYleZB6uYGpnI0dQX9V+DB6u4vxbQu5qltnYvmQiei1rLaI
        TqiXg4X62CL/MZ4++gP+Oz/1JpJPP9PTjUOlGcSOfSxUrVHSQIqjBIGQ3yGsIhE2RWpvOv
        bVYG1gSmsZ0Q0ATa/1Ic7LH6FnCUC5M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9C35131BD;
        Wed,  4 May 2022 12:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eFpTKE1tcmKnUwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 May 2022 12:10:53 +0000
Date:   Wed, 4 May 2022 14:10:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, daniel@ffwll.ch,
        hridya@google.com, christian.koenig@amd.com, jstultz@google.com,
        tkjos@android.com, cmllamas@google.com, surenb@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] gpu: rfc: Proposal for a GPU cgroup controller
Message-ID: <20220504121052.GA24172@blackbody.suse.cz>
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-2-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502231944.3891435-2-tjmercier@google.com>
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

On Mon, May 02, 2022 at 11:19:35PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> [...]
> +	The device name string is set by a device driver when it registers with the
> +	GPU cgroup controller to participate in resource accounting. 

Are these names available anywhere else for the user? (I.e. would
drivers add respective sysfs attributes or similar?)


> +     Non-unique names will be rejected at the point of registration.

This doesn't seem relevant to the cgroupfs user, does it?
I think it should be mentioned at the respective API.

HTH,
Michal

