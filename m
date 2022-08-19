Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB9359A4CE
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbiHSRq2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354960AbiHSRpx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 13:45:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4465E108F2F;
        Fri, 19 Aug 2022 10:10:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w138so2229947pfc.10;
        Fri, 19 Aug 2022 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=7WjX18+SJwTo5iBm+RDyyQ38vzw7KWPpCCkeot28T3I=;
        b=S2LQx7r114T3Une2zfGFyLwMrHa53oIGdjnC12/4bfWAbMWUv2OE+868ZxwJnKnTK5
         gIVgFaQYliBJlbsl93dYwckLq4nOrsq10YPb+jlSAjq9Umnyphckr+qnSL2aQVpzGVto
         vewKy7me+Lzo+L3NyBQSpckbYXsXXPhMFBybX8rTpvLr/JylVeX0hnH49TJcdqZADlz/
         EAdt9R3Hp5ulkjlW1/sWG3jBtntFH3F7J/pb/QIn81PIGqEbXw1nDsCA6B2zLes55j0a
         lqyzknuwoXDpW3Yokmnj3pI8Unzw9HnSTknRp/Z9t7fKbEETpV2Eg4zTWPxQK3Pq9zlH
         pV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=7WjX18+SJwTo5iBm+RDyyQ38vzw7KWPpCCkeot28T3I=;
        b=gpRYK45372CdZburhq2qQvsLrXqTSmpo5WCUgwfhggzYTe7gFgvs2TkNe04Y5m8ZIq
         DR3JeYR9E2YqP6W6iferXqT81Wzn5v8lIGs9TEf4oC6j20mg+AfRK41Krx6QvBXSmTMg
         j2AvdyRal43zHg01WHbfnJ5OVtIAGdZXuWdukjMl2gN+Y3Y+J7/Z0Q3b15N/O50foq8i
         pEZRfr26gP6lcSso/fSSS+tNXaU/OB7MCKL7rJrkbjWYXCqE+3b0DughXfzP9KhpbU8a
         uquAxBS1Piooq8Y4GePHgZYrJ0YQM4IsrhRE2uukwmYZ8ZyyO2Io/PtMIS6SIxbAfYRy
         RV/Q==
X-Gm-Message-State: ACgBeo0SbzLVbU8tkkLh12kPL9Uch1txTMb4ISpriUE8vVWtUmXcdhcJ
        DfMu7A+a9JmtcpkBDZCfcOM=
X-Google-Smtp-Source: AA6agR4N4u7pHPc2TIUiawaqfkhsiNKVDn/EG+sF93jrjzRMMKCrNOEKARKB8/S+80/4KDYKfmdAPw==
X-Received: by 2002:a65:6854:0:b0:41c:feab:e17c with SMTP id q20-20020a656854000000b0041cfeabe17cmr7097086pgt.256.1660929028734;
        Fri, 19 Aug 2022 10:10:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:db7d])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090a121700b001f94d25bfabsm5451928pja.28.2022.08.19.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:10:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 Aug 2022 07:10:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, ke.wang@unisoc.com,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <Yv/EArPDTcCrGqJh@slm.duckdns.org>
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org>
 <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 19, 2022 at 10:08:59AM -0700, Shakeel Butt wrote:
> On Fri, Aug 19, 2022 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > It is observed in android system where per-app cgroup is demanded by freezer
> > > subsys and part of groups require memory control. The hierarchy could be simplized
> > > as bellowing where memory charged on group B abserved while we only want have
> > > group E's memory be controlled and B's descendants compete freely for memory.
> > > This should be the consequences of unified hierarchy.
> > > Under this scenario, less efficient memory reclaim is observed when comparing
> > > with no memory control. It is believed that multi LRU scanning introduces some
> > > of the overhead. Furthermore, page thrashing is also heavier than global LRU
> > > which could be the consequences of partial failure of WORKINGSET mechanism as
> > > LRU is too short to protect the active pages.
> > >
> > > A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > >                                                       \ D()
> > >                           - E(subtree_control = memory) - F()
> > >                                                         \ G()
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Just in case it wasn't clear.
> >
> > Nacked-by: Tejun Heo <tj@kernel.org>
> >
> > Thanks.
> >
> 
> Was there a previous discussion on this? The commit message is unreadable.

http://lkml.kernel.org/r/1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com

Thanks.

-- 
tejun
