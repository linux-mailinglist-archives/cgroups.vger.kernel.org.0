Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C298C51BE00
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354942AbiEELcv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiEELcu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 07:32:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7C4CD46;
        Thu,  5 May 2022 04:29:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7A93218EF;
        Thu,  5 May 2022 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651750149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QztzfHPTmSF8udy99M+oiNjmEJKR+vOVp0C/C48CDH0=;
        b=fVa9/jQVA7FxoB2Yvgew58chqzIPQcGNV6v5gZHvfXRqjnza7FHT+mNpST0Y3E8/sgE4i4
        kOBTu5dWEezH/1d+DmxP/Q9zc4M+fSwEPDDv3OezauwSF7Lr1avS55OVFjZ3eSNxM2MBzB
        K9wQFZaM4ALSnkcoClgDJbFqZmtQnQY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EAE713B11;
        Thu,  5 May 2022 11:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ykO6IQW1c2LcZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 May 2022 11:29:09 +0000
Date:   Thu, 5 May 2022 13:29:08 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] gpu: rfc: Proposal for a GPU cgroup controller
Message-ID: <20220505112908.GC10890@blackbody.suse.cz>
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-2-tjmercier@google.com>
 <20220504121052.GA24172@blackbody.suse.cz>
 <CABdmKX2nbXLrngK8XRFCBCP=Zz-AMgKviiUdpWvEiYc-jOqang@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2nbXLrngK8XRFCBCP=Zz-AMgKviiUdpWvEiYc-jOqang@mail.gmail.com>
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

On Wed, May 04, 2022 at 10:16:50AM -0700, "T.J. Mercier" <tjmercier@google.com> wrote:
> However the only names that would result from this series are the
> names of the dma-buf heaps, with "-heap" appended. So they are
> predictable from the /dev/dma_heap/* names, and only the system and
> cma heaps currently exist upstream.

It's not so important with the read-only stats currently posted (a
crafted sysfs file with these names would be an overlikill)...

> 
> For other future uses of this controller I thought we were headed in
> the direction of "standardized" names which would be
> predefined/hardcoded and documented, so these names wouldn't really
> need to be made available to a user at runtime.
> https://lore.kernel.org/lkml/CABdmKX3gTAohaOwkNccGrQyXN9tzT-oEVibO5ZPF+eP+Vq=AOg@mail.gmail.com/

(Ah, I see.)

...but if writers (limits) are envisioned, the keys should represent
something that the user can derive/construct from available info -- e.g.
the documentation.

OK, so I understand current form just presents some statistics.

Michal
