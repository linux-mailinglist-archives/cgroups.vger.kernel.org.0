Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD666887C4
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBBTuM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 14:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBBTuL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 14:50:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6F28876;
        Thu,  2 Feb 2023 11:50:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o13so2917408pjg.2;
        Thu, 02 Feb 2023 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XqCItSDIlA9UN2KgN+ixgTMg/eGZMlJcrANVyohEDY=;
        b=iNBaT8Z+Ig7zrOQHc1RHN6iLOys2Q0io9gpYMeH9LzsUki6o83huVNzd3aSQV5JEzL
         QaQrK6iF24BTp/OaynHeDuVzOKVK72wVPLciBF0niO4O89anZ3czxsEFPo9KcbK3hZOt
         xG4jzE2Scyetx+HzYrSSxtl9aOcoJWt7DO4NNuUYH0sVPe9PeEABvNn+l8pjQ4rYu3hh
         1m/ogKgjMf6hFOFKPOWgr9Yndv0LRIChXjzkP0tt8mBZy2lLUtpjoTvaLh+fjVvLr1Kj
         EyoozxTzk5b4ThayMM0cCuOkOqWvXk59XVYxSz5oynrw23D0jagogoyMumcW0Jk+MF/k
         NQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XqCItSDIlA9UN2KgN+ixgTMg/eGZMlJcrANVyohEDY=;
        b=wMMiQFzHw7S22X1skFrobeXSOElW/CGRmNgFRIJdZSSD9QdGcXheDPZd1X19+kvw08
         jhvdqhH/C+cYf+ZH9pjRUQvKq4C/XtPWfgSoeCDvj8c/LRI+jPkFBGazkN0jx0jT/WOf
         uWsSxe5tFQw5wfnyj3nt1B6glfQSLUD0HZgKQHh95FNS981Lbfadc+pnC8MTU9hZhBgc
         IwZy2m55Y5TrYQUOYQH7AWaIkHXVYhfZDmHw2RpVJhSKxD8dtKGuJPv7aQWAi1Q4iirT
         dd9PQC+AlA6DWn6K55dAYm9w03hgAl2NTc1sJfElHSIRCl7gZ8f7ENlFz8NABILEStzA
         e0cg==
X-Gm-Message-State: AO0yUKVDpJH2yUzcwQ8aRlISgyzZBN0vbbYRWF8HQxC65VQd7x4PcM5z
        78lRdlN/0p9xyde4LFIk6/M=
X-Google-Smtp-Source: AK7set8UdMNY7Vm2C0NqcIGMDxS2MwKLVQ9fsxr+QAUN2RaNXftZlJ9+zwp/GclwyjOof6sss5w9Qg==
X-Received: by 2002:a05:6a21:33a7:b0:be:a9c7:5d12 with SMTP id yy39-20020a056a2133a700b000bea9c75d12mr9659198pzb.18.1675367410339;
        Thu, 02 Feb 2023 11:50:10 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b001892af9472esm37767pln.261.2023.02.02.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:50:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 09:50:08 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     Lixiong Liu =?utf-8?B?KOWImOWIqembhCk=?= 
        <Lixiong.Liu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Wenju Xu =?utf-8?B?KOiuuOaWh+S4vik=?= <Wenju.Xu@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jing-Ting Wu =?utf-8?B?KOWQs+mdnOWptyk=?= 
        <Jing-Ting.Wu@mediatek.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        WJ Wang =?utf-8?B?KOeOi+WGmyk=?= <wj.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andress Kuo =?utf-8?B?KOmDreWtn+S/rik=?= 
        <Andress.Kuo@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: cgroup user-after-free
Message-ID: <Y9wT8At0MF1S5v0k@slm.duckdns.org>
References: <697032f2331a92eec0e03e85e46cb78bd975a788.camel@mediatek.com>
 <Y8Cwdsk5pYNd8fX8@slm.duckdns.org>
 <f8b24df3bd009d112479e9d5db36ec4afff9bb71.camel@mediatek.com>
 <3bb8e65797b905e4e9d4fad93a8f4fe26b8958a4.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bb8e65797b905e4e9d4fad93a8f4fe26b8958a4.camel@mediatek.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 06:04:04AM +0000, Lixiong Liu (刘利雄) wrote:
> On Fri, 2023-01-13 at 13:40 +0800, lixiong liu wrote:
> > > > Root cause: 
> > > > cgroup_migrate_finish free cset’s cgroup,
> > > > 
> > > > but cgroup_sk_alloc use the freed cgroup,
> > > > 
> > > > then use-after-free happened.
> > > 
> > > Sounds similar to the problem fixed by 07fd5b6cdf3c ("cgroup: Use
> > > separate
> > > src/dst nodes when preloading css_sets for migration"). Can you try
> > > it out?
> > > 
> > > Thanks.
> > > 
> > 
> > 
> > Thanks for your quick feedback.
> > 
> > 
> >   
> > But we encountered use-after-free version
> > 
> > already contains this patch.
> > 
> > 
> > 
> > So, with this patch will also encounter
> > 
> > this use-after-free.
> > 
> > Thanks!
> > 
> > 
>   Do you have any suggestion for this issue?

Unfortunately, there isn't a lot to latch onto. It's on an older kernel and
there's no reproducer. Refcnting in the path is tricky and it wouldn't be
too surprising for some bugs to be there. If you can repro on a recent
kernel, that'd help a lot.

Thanks.

-- 
tejun
