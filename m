Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5675BA48
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 00:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGTWMC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTWMB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 18:12:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A5C186;
        Thu, 20 Jul 2023 15:12:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89600a37fso8660545ad.2;
        Thu, 20 Jul 2023 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689891120; x=1690495920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yyk+1akDqEk5I4HX+iaGF6X13C0u0JYMqRauqkNOe8U=;
        b=NA0WXFjj0OpKZjyiDZaTzkQ3U0kUE85I86+6zcqR7zjTAjF17ktJr20AQoERxT02kC
         2fR/wGnihnbW7LuV1LCk6+1Q4OEhkBDZdXqa0IdN4HU8ynq+somylkYx14dr75Fx24k9
         CLBBCw7T3bJnCIx6Tr6zC2NqMGPq6pZ9oJLN8x9DS3fpqLvCo4/DxwBYqyOwzbdOyx5d
         XjbJleeCani28OQgN52POgHzpVfc5CqvCXovkl8WTPLRoOY2bBzjcLqQs6faAVYdXr5B
         nHATugm7zOyFNUl6WNEG6XkwJYQZUk+lNHVxDGzZ7zReCzBrHKbTxHmsauvt/8JV6eKR
         IWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891120; x=1690495920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yyk+1akDqEk5I4HX+iaGF6X13C0u0JYMqRauqkNOe8U=;
        b=Z5xi3qFLpHiuI1viqbTCscaHQz5DbioTxelLxVTVG8m4dfnuqeYRcjB2CeqU8g0h5y
         EJlIw+ibNfIas+bObfkNZUps+AwtsqdldbCnccGYAxItYy1wZulojNBUlxfTQYGk8Nw2
         dta2I7cmnhKD9+KziQ9O2GRMXbC2StfE/03gxUMwMarVty2d9OJkhrMnbeyTQCeQDGdD
         1KuRrs3/ajS3O0lVS4/AjlmD6QP49mIdpogxPE8phJK1GZivU/d39SlYMBOqEuwUG76F
         w+N5t3Jw+Mg5fnBZLJWdPM/C3AbnQkrRLisNSjgldbTYYhOeov8vin7n528dKdgsLPVG
         LQhg==
X-Gm-Message-State: ABy/qLaASN1ppQlGmDpFlw6UXDFNmdLlphiOxANVPBsD9szVCYSHcxxz
        IFaGvsWp0vxgymZ9Uw6CDCk=
X-Google-Smtp-Source: APBJJlHX/VJZM2WUkAygJroxRsEzFx60munEJlxZ+ORzKpaCGbVeOKOwwPh9c9YlNyCbqHDL+x1gNw==
X-Received: by 2002:a17:902:ec84:b0:1b9:de3e:7a59 with SMTP id x4-20020a170902ec8400b001b9de3e7a59mr381057plg.10.1689891119647;
        Thu, 20 Jul 2023 15:11:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001b8baa83639sm1891440plr.200.2023.07.20.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:11:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 12:11:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
 <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
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

Hello,

On Thu, Jul 20, 2023 at 02:34:16PM -0700, Yosry Ahmed wrote:
> > Or just create a nesting layer so that there's a cgroup which represents the
> > persistent resources and a nested cgroup instance inside representing the
> > current instance.
> 
> In practice it is not easy to know exactly which resources are shared
> and used by which cgroups, especially in a large dynamic environment.

Yeah, that only covers when resource persistence is confined in a known
scope. That said, I have a hard time seeing how recharding once after cgroup
destruction can be a solution for the situations you describe. What if A
touches it once first, B constantly uses it but C only very occasionally and
after A dies C ends up owning it due to timing. This is very much possible
in a large dynamic environment but neither the initial or final situation is
satisfactory.

To solve the problems you're describing, you actually would have to
guarantee that memory pages are charged to the current majority user (or
maybe even spread across current active users). Maybe it can be argued that
this is a step towards that but it's a very partial step and at least would
need a technically viable direction that this development can follow.

On its own, AFAICS, I'm not sure the scope of problems it can actually solve
is justifiably greater than what can be achieved with simple nesting.

Thanks.

-- 
tejun
