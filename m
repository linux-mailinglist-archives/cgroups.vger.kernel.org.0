Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011B59C3BD
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiHVQHu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiHVQHt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 12:07:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C632DAC
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:07:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so14433089pjj.4
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gUVeYVstiPrcbddnMA7a91R1MVlm8VXe4cQjO+uITck=;
        b=qJU/J6milNR1oV5NO1gr1r9vhtxCS9d8ZKRW1oRrJmNJqHRx2lxTImH8vetGV6ilAh
         xUphI7Un4qyUSuEDND0A7UNpIdiG7vRWpyafS5+WDaQhQoAGAG+bLu1MvmhojfFqODDr
         E2t3KE+j4c9Q/2wqW9Adu8yQo2vKApYIwPjwoEFAVlrMSBiR+Iwkb5mq1xKM6v96mpv+
         50JdfOsjLfzxqZv7VnwabsQ0nGoiOw2s7iWe+FOic0ZSVUCpFyO7jFRxcGiKV62loMir
         cdsgS511CkPCukoKUkZNZhTCS8NPNZyo1mRO4Lk3b2TNTW9poBkTfUMYiZOcMyMOgoHn
         YziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gUVeYVstiPrcbddnMA7a91R1MVlm8VXe4cQjO+uITck=;
        b=PrsF+7E3eiNfEfOYJbeVL0pvMjDDCfYkom1wrrpTYQsQhSyt/MnwUaSbNT4AOlC0qV
         VB3YkNJ4DRhRViIY7++8DIzPNQgmJUmUVLl30ZY49q8hF3RTCiQXjMadPecAbIwwFwqy
         Cz9SpWFpsPHU9XDdBWeDW/ybbvg+vzosZeYMadRuRj4gG/sko6CUYAN5RNaKtPGuL8/T
         5PuWjSgr1EeP+OT88ny9tuNH6TL2uil2oAUDdlrYgv1WIsMrnmU3Rn5OV24q3ENDou7D
         zZd12Y7J0VWcuCrK440fNrDZ8sq2mQ+wyhBPch782vEt1dNJPObxKBaiE5IrEO3N3HTo
         xOBQ==
X-Gm-Message-State: ACgBeo3EU5x8iPXDWw/yc2SttmC+uxQHgILqhPRXylimmdJighskuErm
        K0MD1edadb9lPTqiU400Yn25mIW4fuiIjzG+0vB37Q==
X-Google-Smtp-Source: AA6agR5MHC/BTxgzO7qC6dLvR96E17Sxi3/i1RXs5BlWoSY9hIdl7PlVXMVRxG/WkibXxiXxoUC6q2ONfVMOvTLKYOs=
X-Received: by 2002:a17:90b:4d0f:b0:1f7:ae99:b39d with SMTP id
 mw15-20020a17090b4d0f00b001f7ae99b39dmr23982623pjb.237.1661184467070; Mon, 22
 Aug 2022 09:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com> <20220822001737.4120417-4-shakeelb@google.com>
 <YwNe3HBxzF+fWb2n@dhcp22.suse.cz> <CALvZod5YGVSTvsg25P6goqyGEY21eVnahsXcs2BGsp6OXxLwsg@mail.gmail.com>
 <YwOfP/6PtS8BxNhz@dhcp22.suse.cz>
In-Reply-To: <YwOfP/6PtS8BxNhz@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Aug 2022 09:07:36 -0700
Message-ID: <CALvZod5mgn6eUaCBV3bNJKA8k_sOAYs5QKyX7at+2OW_+5GNGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg: increase MEMCG_CHARGE_BATCH to 64
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 22, 2022 at 8:22 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 22-08-22 08:09:01, Shakeel Butt wrote:
> > On Mon, Aug 22, 2022 at 3:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > [...]
> > >
> > > > To evaluate the impact of this optimization, on a 72 CPUs machine, we
> > > > ran the following workload in a three level of cgroup hierarchy with top
> > > > level having min and low setup appropriately. More specifically
> > > > memory.min equal to size of netperf binary and memory.low double of
> > > > that.
> > >
> > > a similar feedback to the test case description as with other patches.
> >
> > What more info should I add to the description? Why did I set up min
> > and low or something else?
>
> I do see why you wanted to keep the test consistent over those three
> patches. I would just drop the reference to the protection configuration
> because it likely doesn't make much of an impact, does it? It is the
> multi cpu setup and false sharing that makes the real difference. Or am
> I wrong in assuming that?
>

No, you are correct. I will cleanup the commit message in the next version.
