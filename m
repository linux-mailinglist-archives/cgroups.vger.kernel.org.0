Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1C52DCB5
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 20:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbiESSZ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiESSZZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 14:25:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66FED724
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 11:25:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so4137860wmb.0
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX4W+bGFQtjopHaRz1grkqNNRwJqfo8+CP9Ln5Qv0BI=;
        b=i4PyrMtkcgGixTlkUSsQqhbDDpwMivPfCTE3sFBvx33wKc5ZVPhd4MJiuGlinz3o0a
         JJ/0W5wMh06DoDbheCitqY2+PNpKrFWysvgo/4GE7X7EHEocqxttah93EoHfiWvG3IsF
         MvVcgCGHcdM6gickuEP/50CG5SmyjJg4mJlXy01hvPHg/sI5OMr2fDIt6sicDaxMRE5p
         QKOobWw2wmJ69028sakpU81K1oL+rh3nzvGM1vPOJEgaL8VRbayUBgKUhTRGkwTavWcM
         bjdlrRUdMTSYJaMBTudbEsRYiWwIXuIKwyrMYtIrDRPiQuwpdHkyWkkwedKAAW2WgpXu
         VcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX4W+bGFQtjopHaRz1grkqNNRwJqfo8+CP9Ln5Qv0BI=;
        b=Kjh49quWZFUCBNROeons3MUoT9uxtC444IEt1XJQUNJNZXphaovyjRTrS/QHT1pfQk
         7YO7f5/iRG7o3ZWJhZ+CUCysLEFTAEBrRTVstKGdMrJfdj/MGuDjD3YaYTlFJLmkSd5A
         JJ2fstbePlPN2QL+N1ELnwGI4JO7cQjpoBlb8oj+KekBkK2QD0Rjf2MHS7y6CnugWDjV
         otWikd7rpzjB0rvx+4qMrNNT1yCKm0ybL3qGlxQ0MAoHGuHPCMZXWq0rDV+sT3M29NXj
         zN0Ji+mkNzUb/Sfr2CE5rpPl9mHRxoqbxK+HIN4NX8WEjDekM2Eonekg5oCKgQxs2fHI
         0ZBQ==
X-Gm-Message-State: AOAM531UWCKw4aw7eGZ1gSEs+ce3q+uLcqHu3tUOqwaF6+owbz8vlbOn
        SbFyzTAfK+JHPpqu1l+vN3q7zb1NANdNAvN0uV3QyA==
X-Google-Smtp-Source: ABdhPJz+fWL+9uC7FIeCCD2oIEFyp0ACaf6DWTwErmon2KdTz97T6qHOY4OdXauBwGED2CsgOrGNNeVLbADh/nmIa3I=
X-Received: by 2002:a05:600c:1910:b0:394:8517:496e with SMTP id
 j16-20020a05600c191000b003948517496emr5019782wmq.24.1652984722564; Thu, 19
 May 2022 11:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz> <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
 <YoQAVeGj19YpSMDb@cmpxchg.org> <CAAPL-u8pZ_p+SQZnr=8UV37yiQpWRZny7g9p6YES0wa+g_kMJw@mail.gmail.com>
 <YoYFKdqayKRw2npp@dhcp22.suse.cz>
In-Reply-To: <YoYFKdqayKRw2npp@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 May 2022 11:24:46 -0700
Message-ID: <CAJD7tkYwvtuU9vnwzewFDtvKtg=2BiVMGa1i0qRCa7-=NG6yPg@mail.gmail.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 19, 2022 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-05-22 22:44:13, Wei Xu wrote:
> > On Tue, May 17, 2022 at 1:06 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> [...]
> > > But I don't think an anon/file bias will capture this coefficient?
> >
> > It essentially provides the userspace proactive reclaimer an ability
> > to define its own reclaim policy by adding an argument to specify
> > which type of pages to reclaim via memory.reclaim.
>
> I am not sure the swappiness is really a proper interface for that.
> Historically this tunable has changed behavior several times and the
> reclaim algorithm is free to ignore it completely in many cases. If you
> want to build a userspace reclaim policy, then it really has to have a
> predictable and stable behavior. That would mean that the semantic would
> have to be much stronger than the global vm_swappiness.

Agreed as well. I will work on an interface similar to what Roman
suggested (type=file/anon/slab).
Thanks everyone for participating in this discussion!

> --
> Michal Hocko
> SUSE Labs
