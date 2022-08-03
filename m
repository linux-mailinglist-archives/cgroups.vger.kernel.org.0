Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA245891F7
	for <lists+cgroups@lfdr.de>; Wed,  3 Aug 2022 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiHCR6r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Aug 2022 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiHCR6c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Aug 2022 13:58:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2D5A178;
        Wed,  3 Aug 2022 10:58:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i71so10252837pge.9;
        Wed, 03 Aug 2022 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0F2KsgjThkMHJsCvW8q0mHWxfELmkopPA/c2rKsFWiQ=;
        b=irnvtNDIhFfQ5STKu/5oLxnXV9W5JZmn1EV32OigTb/j1H7T4y30vulOjAKaAlbI5P
         Cm8ZuZ0CLfsw55nypOyeR4PB2evi7h7MSyRZlw2hdAK/MSdj19G7f7D4dwdj5BHqiD6U
         x6EU71FTrPaqJBTtm5+s7omP3SqaHD8Fpnd3cQtNbMfSN/TnOC96P4qwRn+GINwaSJB5
         1usP0fEwBYFkR34DhK/fe6Yjff1IrmHA9CfJsgmjttZGEL1V+Ka/S6h/WISxaAyhpUwN
         g7av/flBcnUgkS5cXSDC/nKHPXOaaKUPksJkwn9uYjVcMhLDXTI+ghaJNfe1Ajwb74hh
         JXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0F2KsgjThkMHJsCvW8q0mHWxfELmkopPA/c2rKsFWiQ=;
        b=tkIN4AGQdUUsGkRwuxZfZxxt8mM61kYs/8zS5QMfKnXbO+o+pT9Fo40CtEtaWK9VXV
         uzFjWbFo2Axw1ZVhrpjDKk32LvW4yfkBv2pSks/edkOLy17WJSgN4v6lw6q6HEL6cdwL
         y4IJneTj3aNGz9SgCR2CtCEVAkcLsUuxk90/YUtUNWRIynYtsiLbHbbEBVfPDGokZp3W
         v2WUbO4C070PBTLtxeiWkjlnW0NeN7cvUB0Mmf5AIm/Ib8MxDtUpeUVdnCYnfyfg3j7V
         WwCbfv12OeWFHUG63uCbF2yY7F4RbZakiJoDZzF0e9kuSG0RaPx/GEUrbYLrQFADcZ47
         PX5g==
X-Gm-Message-State: AJIora9I1MC7z4fKj8RJsDvIFiHAYxKIslGyyCoKccWdVk04BUYQhsmi
        gJkV+LFr7E3xLWChXvzJe/Q=
X-Google-Smtp-Source: AGRyM1tCpII40sPNaHdhKgqmNluFYhaR17/ZC6haTluSNFmmikP70DA5/RnueUxwV0Ye25rWMiBpLA==
X-Received: by 2002:a65:5207:0:b0:3fb:c00f:f6e4 with SMTP id o7-20020a655207000000b003fbc00ff6e4mr22436056pgp.415.1659549509177;
        Wed, 03 Aug 2022 10:58:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:83dc])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b005251c6fbd0csm13344644pfb.29.2022.08.03.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:58:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 Aug 2022 07:58:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org>
 <YuAqWprKd6NsWs7C@slm.duckdns.org>
 <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Aug 03, 2022 at 08:17:22PM +0800, Chengming Zhou wrote:
> > Assuming the above isn't wrong, if we can figure out how we can re-enable
> > it, which is more difficult as the counters need to be resynchronized with
> > the current state, that'd be ideal. Then, we can just allow each cgroup to
> > enable / disable PSI reporting dynamically as they see fit.
> 
> This method is more fine-grained but more difficult like you said above.
> I think it may meet most needs to disable PSI stats in intermediate cgroups?

So, I'm not necessarily against implementing something easier but we at
least wanna get the interface right, so that if we decide to do the full
thing later we can easily expand on the existing interface. ie. let's please
not be too hacky. I don't think it'd be that difficult to implement
per-cgroup disable-only operation that we can later expand to allow
re-enabling, right?

Thanks.

-- 
tejun
