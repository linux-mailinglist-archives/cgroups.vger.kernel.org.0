Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4D583288
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiG0S4d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiG0S4A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 14:56:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403053D26;
        Wed, 27 Jul 2022 10:56:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b22so178835plz.9;
        Wed, 27 Jul 2022 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=FNJqWOgunTysXo2x6MYgmJbijH0daSpLu5NGEZRQviE=;
        b=A/u3Wjgc6Pq6XfpcsLe9ZPc/0GNdFxt8A6JJ8VmjPhGMKdLSNN0EOiS3dWtui4azMj
         jn+/Al0U4PLfPbF/zMf5d86WrI52ysytboMjjFBBeB648qMEb8Aqz+lZbCbQyc57iKpo
         oKudOAu9TkIAt9p86u7HAMxUvTwWdKk1L1IUsue7nMeXmd15oOllnyTw3zhykckM7Y+U
         FIJSVm1SxY6FrxyjbHs06eOwTeYNwwU5vX0hJdD170g4TLSKUb2BEfS6OdC0gHLwKLNE
         qnf4v73uF3y43EfbJUa8wb/VLBO59ynVFHOdiixIpZXo/amlH+T+In2IblGizPkTzNh+
         MXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=FNJqWOgunTysXo2x6MYgmJbijH0daSpLu5NGEZRQviE=;
        b=Px/LucuhAfcFZE3AAu2h8J9FCVRnJ+LQmq4zVSURZ/G6W9daOTWO8tlqPKozW7clHg
         nSWDzpVqbAW6iS2ztDiaG2JpcN6NHGmCB+J0gwl4D8TqCTBCVck5+cy9OtxaTDCmv7LO
         z/jfrefipCphBgFe76TnRGIjxKx4GAAOuCkRXZiLdSfEddaTHO3hYe3ij1NrGDxUceSr
         ZSbRAnDbRwkzxA56RMxnpydLb4qXBcRFA89c0/vKiL2HWHNamN4RJmML13CbFK6ro4E+
         VT2TevF7ejOftXpTko2QOwNS3Ds9vyWNzb6NkrlNV4cE3BEmB4sThC7Gw/yeTFgaAH7v
         oz5Q==
X-Gm-Message-State: AJIora9SmmgU5LJ2HqRCB4bMgU23Pok0AtiRvwaQeEtinT0q21DoOXcQ
        BNuT7QqfqeitjQFyLW26WLk=
X-Google-Smtp-Source: AGRyM1vtw0uIJ2M7Ps/ai2eBKkXMxcto+mK+opMvLe2CBHf2/mbesFYUsC65FJyktEAbZTHaPPV2sQ==
X-Received: by 2002:a17:903:2281:b0:16d:614a:63a0 with SMTP id b1-20020a170903228100b0016d614a63a0mr18846955plh.140.1658944561122;
        Wed, 27 Jul 2022 10:56:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016d01c133e1sm6882006plk.248.2022.07.27.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:55:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 07:55:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup/for-5.20] cgroup: remove "no" prefixed mount
 options options
Message-ID: <YuF8LrDcd9tpYLnX@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <20220726143246.GA23794@blackbody.suse.cz>
 <YuBIACfZDk72yjI3@slm.duckdns.org>
 <YuB5ICv3bXsy5Xuh@slm.duckdns.org>
 <YuB9QXapVUy1t8TZ@slm.duckdns.org>
 <20220727092715.GA1569@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727092715.GA1569@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 27, 2022 at 11:27:15AM +0200, Michal Koutný wrote:
> On Tue, Jul 26, 2022 at 01:48:17PM -1000, Tejun Heo <tj@kernel.org> wrote:
> Thanks.
> 
> > While a bit confusing, given that there is a way to turn off the options,
> > there's no reason to have the explicit "no" prefixed options. Let's remove
> > them.
> 
> This is sensible...
> 
> >  Documentation/admin-guide/cgroup-v2.rst |    8 ++++----
> >  kernel/cgroup/cgroup.c                  |   24 ++++--------------------
> >  2 files changed, 8 insertions(+), 24 deletions(-)
> 
> ...and cleaner.

Alright, applied to cgroup/for-5.20.

Thanks.

-- 
tejun
