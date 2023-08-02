Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749F76D810
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHBTj4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHBTj4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 15:39:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376A199F;
        Wed,  2 Aug 2023 12:39:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbc7b2133fso1780875ad.1;
        Wed, 02 Aug 2023 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005195; x=1691609995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rFutDxBgZhZo31eTKpgdfljMmJjMzZzs4YBvj8FxUQ=;
        b=f4XCjfndDhfaxdmM1yNNCJ476A8m9gRFvnsq9KUpu51lDvsurKQGPcA29EON1TrUBQ
         b7UXwXLMGoIQ1AoIeziTB8r2FszgQ6JhpZcyZND0+0IYUWRZ98csRu25HffVdrVo+giK
         KqX46je97CCz3Yg9XeHNsW2EWj7bpOHrRcxHh5BgC86sbILLgmkC9JyJ5I9DJt/4Z/y0
         nJV2sDIIJjbpJp3askED1MV5GHJxu3Mi9iTv7jJgXxr4hZ5sLbmzDj/OhKhMMskU9nwF
         JY+goaNPlgb0Rzbm3amyTMSMoUexs1z8ctMhmD2a3W+TA3kWxA8F5KRVz0kiNTbAcEdw
         rAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005195; x=1691609995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rFutDxBgZhZo31eTKpgdfljMmJjMzZzs4YBvj8FxUQ=;
        b=YZl2ql6HiVxP/41H8hwESlSDDNT4b/QPSmlk3TZ2dPayGQ3kZcwf/TMRXrFHaArNg/
         8sayZxZfKnV0hM2zspfKopsjzfhv2amQLzKuL9KTWLd5wkVZOrbForDynhHVVnJfi8RM
         6HlB78C/R1eae0qSxvkpgzw/GDeOWelsQ+BtjEz9MF7XO2y5lNYC8PdbqotpD/LKYfya
         r1nfnbZle8apvYcyhWvXNyD1o/PWn08yGrRw7yIW2mOp+31NIVFBODg3VCJT7JVjxL+8
         t95yhqbXGUqC8tl5xXrVxPT+PDoskvuiw68lH/Kbxkt7LPcDYvaKteguCNly1kptst+O
         1MlQ==
X-Gm-Message-State: ABy/qLaY5ci2LV3kiQa8cp3F9CeuhFt/d0mdF3DTPTCVMx5VEYdCcaQh
        a0kRTRZqGxCThW6gzWF+wOw=
X-Google-Smtp-Source: APBJJlEWO2trnVIozIqv6EQe3624u8OChoKl1SNXr1isNYfYSrAvyzRtG2PE4PT54G5Kw6i1JZ13+g==
X-Received: by 2002:a17:902:ec8d:b0:1b8:35fa:cdb6 with SMTP id x13-20020a170902ec8d00b001b835facdb6mr17725569plg.13.1691005194667;
        Wed, 02 Aug 2023 12:39:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001b87bedcc6fsm12785457pls.93.2023.08.02.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:39:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 09:39:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Message-ID: <ZMqxCVOkU7pKK9OO@slm.duckdns.org>
References: <20230723031932.3152951-1-linmiaohe@huawei.com>
 <ZMBERCXR27X_gRAt@slm.duckdns.org>
 <ec3df402-7681-3d0c-b9ce-d50eb7383b1e@huawei.com>
 <719a19c4-3be5-2260-7349-b3f1bb774f4f@huawei.com>
 <ZMhIFUsxEtA_B781@slm.duckdns.org>
 <3ec1f5d9-4887-4583-a973-92298a9bc924@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec1f5d9-4887-4583-a973-92298a9bc924@huawei.com>
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

On Tue, Aug 01, 2023 at 03:48:09PM +0800, Miaohe Lin wrote:
> On 2023/8/1 7:47, Tejun Heo wrote:
> > On Thu, Jul 27, 2023 at 07:50:11PM +0800, Miaohe Lin wrote:
> >> On 2023/7/26 9:06, Miaohe Lin wrote:
> >>> On 2023/7/26 5:53, Tejun Heo wrote:
> >>>> On Sun, Jul 23, 2023 at 11:19:32AM +0800, Miaohe Lin wrote:
> >>>>> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
> >>>>> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
> >>>>> called when CONFIG_CGROUP_SCHED. No functional change intended.
> >>>>>
> >>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>
> >>>> Patch doesn't apply to cgroup/for-6.6. Can you please respin?
> >>>
> >>> Sure. Will resend the patch based on cgroup/for-6.6.
> >>
> >> The commit "sched: add throttled time stat for throttled children" is still in the linux-next tree. So I think I have
> >> to wait for it to be merged into cgroup tree first.
> > 
> > You can just send the patch against cgroup/for-6.6 branch. We can sort out
> > the merge conflicts later.
> 
> Do you mean send the patch against cgroup/for-6.6 branch assuming commit "sched: add throttled time stat for throttled children"
> has been merged into cgroup/for-6.6 branch? It seems the current code in that branch is fine itself.

Ah, I see. That patch isn't going to go through cgroup/for-6.6. It will go
directly from -mm to mainline when the merge window opens. Can you please
resend the patch to Andrew Morton <akpm@linux-foundation.org> with me cc'd?

Thanks.

-- 
tejun
