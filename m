Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355475D160
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGUS0g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 14:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGUS0e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 14:26:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639052D53;
        Fri, 21 Jul 2023 11:26:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b318c5cfso16327105ad.1;
        Fri, 21 Jul 2023 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689963991; x=1690568791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nDLHNSovJBpy7GRacDMrAtqiXNHt1dAkEqDxo04+EA=;
        b=byfrvwVRXmfGcyKN0KQNikPRt347H2lBT+iMj0kENUcWDzoABxw2A1ju6iy+Q2GQMc
         7q4YHsL7QX6EC58wN8XJAKbLpmTB0tYiZi/mNH+UYz2ZlHLJlRtD+M9pctqgDpqsJwg2
         tbUp1cXMC6ADjVdFvQmS7GDyfZJ6aQZukkkYLUeTTOjQ20JnB3Z/yScrbSUiwBadHWIv
         rGS5FD8XV3pn6yHnleEwQCsgvfcPn1eOCbg81jEHC8934W+iElMm7hkxa+K+PxDONGBj
         YQFP4HzpB0eck75pBEN2A+0N918Eq2NtywUkigZa5YV6Hpt7vq70Ea1UKYJEtSuIEY3d
         SMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963991; x=1690568791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nDLHNSovJBpy7GRacDMrAtqiXNHt1dAkEqDxo04+EA=;
        b=ctRGlLc5AjxwMpoCJuiY2m1qJXtalRxg5i9v07jMvUEnFM8YschwwPgcQoI7l2P25O
         kJ9KxQ135KnGrdobDGF/BMZlLutKHTgN4rQp0XWDtmBU5IlYWvjYmAR5erDj3aaRijeN
         CpLiFLOXfUg1C6Q2T9Mxl43DbsfBkbRdswyDl3hcg0MUdFlHBgpw2BhX+pmQY2E42t3L
         HxwJzkfQ5Ynv++WZJe1w2L1JYm9LS/rnrhQzQSJJ84p99sWM9c6p19/VQUn/CVmFFAyo
         JsrgZDHisQnIfHJkKVLotjEXXFUwqqIwuLCk02nMAmcJTjzc+sPjHlWIQKo4kG0jYrd8
         r2KQ==
X-Gm-Message-State: ABy/qLbxM5j7NFW/O0CEcfCId9+ep+6SvwgZnsaA65bEtlzb/PYeiGOZ
        ZsNTdKkgXtIHYHQ4KyKx9sQPdwxnnv8=
X-Google-Smtp-Source: APBJJlHVZ3RSQbVzj6jDDoUYKFAaSfmkR0nBXzxyaRrjiuftEh17LxJmg3pf+fzL9Hmg6KnxEUJHPA==
X-Received: by 2002:a17:902:eccd:b0:1b9:e97f:3846 with SMTP id a13-20020a170902eccd00b001b9e97f3846mr3436799plh.15.1689963990617;
        Fri, 21 Jul 2023 11:26:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001b8b26fa6a9sm3853213plb.19.2023.07.21.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:26:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 08:26:28 -1000
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
Message-ID: <ZLrN1BE42Tsybm6j@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
 <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
 <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
 <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jul 21, 2023 at 11:15:21AM -0700, Yosry Ahmed wrote:
> On Thu, Jul 20, 2023 at 3:31 PM Tejun Heo <tj@kernel.org> wrote:
> > memory at least in our case. The sharing across them comes down to things
> > like some common library pages which don't really account for much these
> > days.
> 
> Keep in mind that even a single page charged to a memcg and used by
> another memcg is sufficient to result in a zombie memcg.

I mean, yeah, that's a separate issue or rather a subset which isn't all
that controversial. That can be deterministically solved by reparenting to
the parent like how slab is handled. I think the "deterministic" part is
important here. As you said, even a single page can pin a dying cgroup.

> > > Keep in mind that the environment is dynamic, workloads are constantly
> > > coming and going. Even if find the perfect nesting to appropriately
> > > scope resources, some rescheduling may render the hierarchy obsolete
> > > and require us to start over.
> >
> > Can you please go into more details on how much memory is shared for what
> > across unrelated dynamic workloads? That sounds different from other use
> > cases.
> 
> I am trying to collect more information from our fleet, but the
> application restarting in a different cgroup is not what is happening
> in our case. It is not easy to find out exactly what is going on on

This is the point that Johannes raised but I don't think the current
proposal would make things more deterministic. From what I can see, it
actually pushes it towards even less predictability. Currently, yeah, some
pages may end up in cgroups which aren't the majority user but it at least
is clear how that would happen. The proposed change adds layers of
indeterministic behaviors on top. I don't think that's the direction we want
to go.

> machines and where the memory is coming from due to the
> indeterministic nature of charging. The goal of this proposal is to
> let the kernel handle leftover memory in zombie memcgs because it is
> not always obvious to userspace what's going on (like it's not obvious
> to me now where exactly is the sharing happening :) ).
>
> One thing to note is that in some cases, maybe a userspace bug or
> failed cleanup is a reason for the zombie memcgs. Ideally, this
> wouldn't happen, but it would be nice to have a fallback mechanism in
> the kernel if it does.

I'm not disagreeing on that. Our handling of pages owned by dying cgroups
isn't great but I don't think the proposed change is an acceptable solution.

Thanks.

-- 
tejun
