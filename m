Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73975D428
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGUTSb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGUTSa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 15:18:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18330ED;
        Fri, 21 Jul 2023 12:18:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8b4749013so16938125ad.2;
        Fri, 21 Jul 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689967106; x=1690571906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxUJQYgkClQx653D+GLhwGjuASPJZY3UChFEBbRQygA=;
        b=mAkNV7/TkrTRt+4xRyYVs8bvaw/fK1B7/XnSKv8lxCseRRpsGfLzQfkVn+eOClOviz
         88azYzYMlLiQwxDNiTu9AYJAdsHizyT/BwQ8Plm2itEb9RnWNeRgCSFf4EdIS16a1sak
         aYRBKLeMZQMW9EVuXp0t0qMaCiRc1rHmVMWfmOh5gDdfXGa0oG+YG2830o3mTPdvHL6e
         vH9U7Mt3P3EmCao0guiqhKMLkn+xj3uxeSldJ3kgXK9mSNRmQ8CAWR6EavAWBeJ6WDMN
         pp1i6eklTZCez9JN3tl2Y/wC2ZsyC0RyRmxlVGUPhyrr/flYK7KV0HpNYHCV9Cf2ZY33
         kxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967106; x=1690571906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxUJQYgkClQx653D+GLhwGjuASPJZY3UChFEBbRQygA=;
        b=Vt6/cjf7psGIRBjRlT5vBt5u1R5ZcGos20AzIZ0AXXlM0jkYp3GgbwPWVrzk6k4w5b
         VqA40+R4ZgcH5iHR3EWa0SORAnWFg0vkvH/uuwJIxrJGs5ftgKVbr3lBR8I9L0NRo9Yh
         jZ+W9mHER4CoZjgSrr3iB5r/1ayyKEd/8HiGWi1VDvgujyd3CzFDG1WiQIQ0Vf18dV3F
         m2YNRp75VtJU7Qq2K8mT+MnKDGzI4n2W1AwMJqQ4WyvBLFHTONyy3rb/vQNgFgzzKLRN
         Vi3eSpMkP7FcrZeMPL4JpoEx4d3f9ndBJRq65DkpE6klWRzWxcp2Rs+frpCek7g+EV1q
         pGPw==
X-Gm-Message-State: ABy/qLaCI9bLW41FvNiTbeCl/XbkkwXLPbTgNyWCgJRkgqE4uOCKhEEa
        x1Zek9/o+rF6oLKEfl1VG5U=
X-Google-Smtp-Source: APBJJlGeYWelvP7ZZbyjEZlPKBLxUVkhczU84qA1NP9Ce5DxHPwDt6oLQPJhLTBvJ17Xc7dYMPuMNA==
X-Received: by 2002:a17:903:120f:b0:1b8:4b87:20dc with SMTP id l15-20020a170903120f00b001b84b8720dcmr2917727plh.37.1689967106467;
        Fri, 21 Jul 2023 12:18:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902728e00b001b88da737c6sm3855710pll.54.2023.07.21.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:18:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 09:18:24 -1000
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
Message-ID: <ZLraAD0F-McgdJNv@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
 <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
 <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
 <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
 <ZLrN1BE42Tsybm6j@slm.duckdns.org>
 <CAJD7tkatz1JhKVj_iP9J0H7fPJnUSurZkCT1iJTJ=+qRen_nLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkatz1JhKVj_iP9J0H7fPJnUSurZkCT1iJTJ=+qRen_nLQ@mail.gmail.com>
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

On Fri, Jul 21, 2023 at 11:47:49AM -0700, Yosry Ahmed wrote:
> On Fri, Jul 21, 2023 at 11:26 AM Tejun Heo <tj@kernel.org> wrote:
> > On Fri, Jul 21, 2023 at 11:15:21AM -0700, Yosry Ahmed wrote:
> > > On Thu, Jul 20, 2023 at 3:31 PM Tejun Heo <tj@kernel.org> wrote:
> > > > memory at least in our case. The sharing across them comes down to things
> > > > like some common library pages which don't really account for much these
> > > > days.
> > >
> > > Keep in mind that even a single page charged to a memcg and used by
> > > another memcg is sufficient to result in a zombie memcg.
> >
> > I mean, yeah, that's a separate issue or rather a subset which isn't all
> > that controversial. That can be deterministically solved by reparenting to
> > the parent like how slab is handled. I think the "deterministic" part is
> > important here. As you said, even a single page can pin a dying cgroup.
> 
> There are serious flaws with reparenting that I mentioned above. We do
> it for kernel memory, but that's because we really have no other
> choice. Oftentimes the memory is not reclaimable and we cannot find an
> owner for it. This doesn't mean it's the right answer for user memory.
> 
> The semantics are new compared to normal charging (as opposed to
> recharging, as I explain below). There is an extra layer of
> indirection that we did not (as far as I know) measure the impact of.
> Parents end up with pages that they never used and we have no
> observability into where it came from. Most importantly, over time
> user memory will keep accumulating at the root, reducing the accuracy
> and usefulness of accounting, effectively an accounting leak and
> reduction of capacity. Memory that is not attributed to any user, aka
> system overhead.

That really sounds like the setup is missing cgroup layers tracking
persistent resources. Most of the problems you describe can be solved by
adding cgroup layers at the right spots which would usually align with the
logical structure of the system, right?

...
> I believe recharging is being mis-framed here :)
> 
> Recharging semantics are not new, it is a shortcut to a process that
> is already happening that is focused on offline memcgs. Let's take a
> step back.

Yeah, it does sound better when viewed that way. I'm still not sure what
extra problems it solves tho. We experienced similar problems but AFAIK all
of them came down to needing the appropriate hierarchical structure to
capture how resources are being used on systems.

Thanks.

-- 
tejun
