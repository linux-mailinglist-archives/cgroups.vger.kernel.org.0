Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85351BE64
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355943AbiEELyD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiEELyB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 07:54:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8521A8;
        Thu,  5 May 2022 04:50:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4AA91F8D2;
        Thu,  5 May 2022 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651751416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFH/x2L4G69sbr6PPcrJ24GF6EKzycaRm+AGvFywOyg=;
        b=Hi7oi4+HvgHIFy7zdrmmaaXxpCzxgIsU/9DIcQEQIsZBrzEnC99VBYyTdl9tCC5Clj0fNo
        S4wfHAcq5GS0FxgqjHIneVl1e76wHk0FgPIrmw1/VLSR1LTsnu6LUe2oRBxPFHVVShOMzR
        bOw8YBZW592ZS2VzcJD/HrayK6QgMM8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6974213A65;
        Thu,  5 May 2022 11:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lOXYGPi5c2IDbwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 May 2022 11:50:16 +0000
Date:   Thu, 5 May 2022 13:50:15 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 2/6] cgroup: gpu: Add a cgroup controller for
 allocator attribution of GPU memory
Message-ID: <20220505115015.GD10890@blackbody.suse.cz>
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-3-tjmercier@google.com>
 <20220504122558.GB24172@blackbody.suse.cz>
 <CABdmKX2DJy0i3XAP7xTduZ8KFVKtgto24w714YJNUb_=pfYiKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2DJy0i3XAP7xTduZ8KFVKtgto24w714YJNUb_=pfYiKw@mail.gmail.com>
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

On Wed, May 04, 2022 at 10:19:20AM -0700, "T.J. Mercier" <tjmercier@google.com> wrote:
> Should I export these now for this series?

Hehe, _I_ don't know.
Depends on the likelihood this lands in and is built upon.

> No, except maybe the gpucg_bucket name which I can add an accessor
> function for. Won't this mean depending on LTO for potential inlining
> of the functions currently implemented in the header?

Yes.  Also depends how much inlining here would be performance relevant.
I suggested this with an OS vendor hat on, i.e. the less such ABI, the
simpler.

> I'm happy to make this change, but I wonder why some parts of the
> kernel take this approach and others do not.

I think there is no convention (see also
Documentation/process/stable-api-nonsense.rst ;-)).

Regards,
Michal
