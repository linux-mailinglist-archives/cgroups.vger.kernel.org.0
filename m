Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E746459B5
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGMSX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 07:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGMSV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 07:18:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF537223
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 04:18:20 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31C081FDBC;
        Wed,  7 Dec 2022 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670415499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsWcyBnHXfZzUpbqAQNm8GZOpQrDrOtkcxsdqceJnRU=;
        b=G2DeFspat7QSz2ZZ9Uz6dCgSiUH8CiIXIzc1F8JeFQxFgLL52BnuU+bdqmfIJ2/b+ZFUGM
        oxa9NtCDWISy7o0XuYtMG8XyoDAtNCTgsL/l9lAYtMlN7FQD5wHdoP9K3W1YRY8P0+J4Kh
        RDcN/EN307hE3diHYMhw2eWy75PplOg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 14BA0136B4;
        Wed,  7 Dec 2022 12:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /EkdAouEkGOeRwAAGKfGzw
        (envelope-from <mhocko@suse.com>); Wed, 07 Dec 2022 12:18:19 +0000
Date:   Wed, 7 Dec 2022 13:18:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: memcontrol: speedup memory cgroup resize
Message-ID: <Y5CEisw3waf2n3Gh@dhcp22.suse.cz>
References: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
 <CALvZod7_1oq1D73EKJHG1zQpeUp+QTPHmMRsL3Ka0f6XUfO4Eg@mail.gmail.com>
 <Y48aaCkgonOlMwNu@dhcp22.suse.cz>
 <cf7f485c3e7f4238b509d9dbbd084a2f@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7f485c3e7f4238b509d9dbbd084a2f@baidu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 07-12-22 02:31:13, Li,Rongqing wrote:
> 
> 
> > -----Original Message-----
> > From: Michal Hocko <mhocko@suse.com>
> > Sent: Tuesday, December 6, 2022 6:33 PM
> > To: Shakeel Butt <shakeelb@google.com>
> > Cc: Li,Rongqing <lirongqing@baidu.com>; linux-mm@kvack.org;
> > cgroups@vger.kernel.org; hannes@cmpxchg.org; roman.gushchin@linux.dev;
> > songmuchun@bytedance.com; akpm@linux-foundation.org
> > Subject: Re: [PATCH] mm: memcontrol: speedup memory cgroup resize
> > 
> > On Mon 05-12-22 08:32:41, Shakeel Butt wrote:
> > > On Mon, Dec 5, 2022 at 3:49 AM <lirongqing@baidu.com> wrote:
> > > >
> > > > From: Li RongQing <lirongqing@baidu.com>
> > > >
> > > > when resize memory cgroup, avoid to free memory cgroup page one by
> > > > one, and try to free needed number pages once
> > > >
> > >
> > > It's not really one by one but SWAP_CLUSTER_MAX. Also can you share
> > > some experiment results on how much this patch is improving setting
> > > limits?
> > 
> 
> If try to resize a cgroup to reclaim 50 Gb memory, and this cgroup has
> lots of children cgroups who are reading files and alloc memory, this
> patch can speed 2 or more times.

Do you have any more specific numbers including a perf profile to see
where the additional time is spent? I find 2 times speed up rather hard
to believe. The memory reclaim itself should be more CPU heavy than
additional function calls doing the same in batches.

Also is this an example of a realistic usecase?

> > Besides a clear performance gain you should also think about a potential over
> > reclaim when the limit is reduced by a lot (there might be parallel reclaimers
> > competing with the limit resize).
> > 
> 
> to avoid over claim,  how about to try to free half memory once?

We should really focus on why would a larger batch result in a
noticeably better performance.
-- 
Michal Hocko
SUSE Labs
