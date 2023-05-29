Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E67714F77
	for <lists+cgroups@lfdr.de>; Mon, 29 May 2023 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjE2Sxm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 May 2023 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2Sxl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 May 2023 14:53:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F05C4
        for <cgroups@vger.kernel.org>; Mon, 29 May 2023 11:53:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c9e9e164so6904866276.2
        for <cgroups@vger.kernel.org>; Mon, 29 May 2023 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685386419; x=1687978419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb+xGJEzAuTS5TrIgTU4fcvFK43ao8HwfzBYRc52TTY=;
        b=S5vwol9vE0JkslbkyRPxKAkNViXqytiqtwh4nsd9eEgwmZ719gWuFJVhrVRcYMhMhH
         I47+gsK59+oMFCcm/r1itjNdraOXhmYJZhEWSuRWoUYXc7Dp070Pa2Yyvj4dEuYLGKoh
         AVGVBgumYkPyDju0i+9bhA5sVMRSAbgmt/bo08Ofp93ulaxvSQqkzkIXUIKt60Qxt7aS
         ckbLK5h8mRGy+3ePq+B0w88MS07aczR+7j5ah1Mo10ytZ913dDcxeiCeTs6HWF478yhB
         CJ70hGrv1bkk+tSU6BqdFxjeOmCN1out6pHgQpdSrk/bLD1zCrblrtDWLbN3YGdezv4T
         flqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685386419; x=1687978419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb+xGJEzAuTS5TrIgTU4fcvFK43ao8HwfzBYRc52TTY=;
        b=dCxauNaliqaGyrwlDsl0TqnApmQQ3UFqaqgBRO+uaqyccvGVrRxU9nXm0hIUjVbaYP
         aYKah5BYWAyxWKCbpgOhc7axdu6ZzkPtjpktmjcJIVm65JYrMDChrPlan/uCqEWbkmPF
         v5TRxNV553ogWXPZLiWH9AYMup7LTNiJpjuZudQgqVDCbaJD2r9AS/x64LuWkD+651Z3
         SspXmPjWprURxhR6f8zPvslGH9RIHd5wHPDXjg1cxZN/6Q705/9S4VjXzrqw0fYKWQcB
         fV6TsocD+Y3n8thi1bUABxZXuqQTAZxs/gEuyXnwPT+MBrdZGoYvZ+sxn6BBcdC/GV+f
         xBWg==
X-Gm-Message-State: AC+VfDx3um2AoFyvJusrDkxLlxWXREjWeigmVXeohRhsR1pEK1b6z8/C
        Y2ycVYqhbGB9b79DMxd1R2WwudQ8ep17Uw==
X-Google-Smtp-Source: ACHHUZ7Vn/Q5HrLEkQuw5sBuUMFb7N55w2kESh9lJCpvJqW43vVCYmwyZoVIhiVBp34GVFj710bX4NkVKlJqoQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:ad1c:0:b0:bac:a7d5:f895 with SMTP id
 y28-20020a25ad1c000000b00baca7d5f895mr31364ybi.10.1685386419461; Mon, 29 May
 2023 11:53:39 -0700 (PDT)
Date:   Mon, 29 May 2023 18:53:37 +0000
In-Reply-To: <ZHOtS67ZtMPsyNVk@casper.infradead.org>
Mime-Version: 1.0
References: <20230527103126.398267-1-linmiaohe@huawei.com> <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
 <ZHIcnOV/mrkcerlG@casper.infradead.org> <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
 <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev> <ZHOtS67ZtMPsyNVk@casper.infradead.org>
Message-ID: <20230529185337.3gk3ww76sdxdgv6o@google.com>
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
From:   Shakeel Butt <shakeelb@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 28, 2023 at 08:36:43PM +0100, Matthew Wilcox wrote:
> On Sun, May 28, 2023 at 09:01:37PM +0800, Muchun Song wrote:
> > with *init_net*. If Vasily does not want to bring commit 1d0403d20f6c back,
> > this patch LGTM. Otherwise, let's wait for Vasily.
> 
> If we're not going to bring back 1d0403d20f6c then we should
> simply revert fc4db90fe71e instead of applying this patch.

Initially I was thinking of adding virt_addr_valid() check in the
mem_cgroup_from_obj() but it seems like that check is not cheap on
arm64. I don't have any quick solutions other than adding a check
against init_net in __register_pernet_operations(). I will wait for
couple of days for Vasily otherwise I will retry 1d0403d20f6c with the
init_net check in __register_pernet_operations().
