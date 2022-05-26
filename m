Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF5535330
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiEZSPW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiEZSPW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 14:15:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F0B2272;
        Thu, 26 May 2022 11:15:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so5072292pja.4;
        Thu, 26 May 2022 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6qtpXMNwSeKb2/ZB0dn4b9L5gJCZbExzN3Ar6qUIAGk=;
        b=DvngC5Bk5mSGIVEwnc//TJTs6pULwXNDU5y3gFp4sI2ZDCXte23y1tV1Vb4ZPYlkqC
         aTfWZl2UvanZ6Xz/ozofK9h1prT+sIi0W6zZqomwx7FPYOdZQItLDJJIu3pOUOL5Xtg0
         VyYRokizo6Ar77W4aMzNK0Vdz5OzizMyUafqvlWqERKtiJuqHzXNc3vfWCoGxyO0P+Sr
         JeAP7D1jg66OsWSSGebw1QRpMfN4O8dhRQz0Zqie3pkqGDp83GXkni1SXi98ctQ3catV
         /rINz2RtcTf2We8eYodn0tL6fzO/3A1gPPEhFRrFoq4GUTKuOtNuRZvz1ea3mTADZsyf
         Doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6qtpXMNwSeKb2/ZB0dn4b9L5gJCZbExzN3Ar6qUIAGk=;
        b=UQ8MNBG0ylzGUgdoBldJgJlqudqb0+4cLdKn9ua03ELWT39l5e0PaVWHyLVR34pyYV
         FvJQI9j6v3S5dLzDehWj3DaHo/l80ReWI8+2uZ7k2ZMquii+rV+C8vpGEy2fQzn0vH2z
         LHEWLu0fDjWr9Z0RxEl8hb9w1kG5JSNTt/qJ/o1dRSxdW3JaEHvJhefpK0755sf965oD
         547T3HhRkvlAzhgt3LzYxNp/NrzXdBAl+uvdi6L/TJYxKgqhrvDyfB6tydYeyMhPc/b3
         kjuDSsh2bz09aOIzL2Ozq138swihG+FITj/tQshFhvP7HwrRw9grwhkPbKVAosWSM+Pu
         TEww==
X-Gm-Message-State: AOAM5308EXYdsn6RY8uB67Ayw1uj2ED2S+rTsI1yBxz0qxgQH2ftKV6/
        4Lx5GcfqCqej+gMnw9T/VrA=
X-Google-Smtp-Source: ABdhPJw0HR5gUdv0QEXdguE37Xg14Jx1/rHIBI+LfikekeFeDFtlCQ/k6Bp1iS+4Wy53FGQQ+UKKug==
X-Received: by 2002:a17:90b:4b05:b0:1df:db8a:1fcb with SMTP id lx5-20020a17090b4b0500b001dfdb8a1fcbmr3913425pjb.54.1653588920857;
        Thu, 26 May 2022 11:15:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id 66-20020a17090a09c800b001d7dd00c231sm1830156pjo.22.2022.05.26.11.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:15:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 08:15:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <Yo/DtjEU/kYr190u@slm.duckdns.org>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo7KfEOz92kS2z5Y@blackbook>
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

Hello, Michal.

On Thu, May 26, 2022 at 11:56:34AM +0200, Michal Koutný wrote:
> // ref=A: initial state
> kill_css()
>   css_get // ref+=F == A+F: fuse
>   percpu_ref_kill_and_confirm
>     __percpu_ref_switch_to_atomic
>       percpu_ref_get
>         // ref += 1 == A+F+1: atomic mode, self-protection
>     percpu_ref_put
>       // ref -= 1 == A+F: kill the base reference
>   [via rcu]
>   percpu_ref_switch_to_atomic_rcu
>     percpu_ref_call_confirm_rcu
>       css_killed_ref_fn == refcnt.confirm_switch
>         queue_work(css->destroy_work)        (1)
>                                                      [via css->destroy_work]
>                                                      css_killed_work_fn == wq.func
>                                                        offline_css() // needs fuse
>                                                        css_put // ref -= F == A: de-fuse
>       percpu_ref_put
>         // ref -= 1 == A-1: remove self-protection
>         css_release                                   // A <= 1 -> 2nd queue_work explodes!

I'm not sure I'm following it but it's perfectly fine to re-use the work
item at this point. The work item actually can be re-cycled from the very
beginning of the work function. The only thing we need to make sure is that
we don't css_put() prematurely to avoid it being freed while we're using it.

For the sharing to be a problem, we should be queueing the release work item
while the destroy instance is still pending, and if that is the case, it
doesn't really matter whether we use two separate work items or not. We're
already broken and would just be shifting the problem to explode elsewhere.

The only possibility that I can think of is that somehow we're ending up
with an extra css_put() somewhere thus triggering the release path
prematurely. If that's the case, we'll prolly need to trace get/puts to find
out who's causing the ref imbalance.

Thanks.

-- 
tejun
