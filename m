Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB99266063C
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 19:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjAFSQI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAFSQH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 13:16:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232DD66;
        Fri,  6 Jan 2023 10:16:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z7so1615200pfq.13;
        Fri, 06 Jan 2023 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFVy3Y9MVCWte671WOFf60PfUPv+ycHx3SxmfV5kFG8=;
        b=lbibIMuJyMXbJ2f2OyL1viffjumwMgpmMNynEDue06Z/2mLcY1PturmpBQ0tKz+++O
         zcR2ZA6fIwexsqo2cb8HATM3qQbVR1vIJDfjMrJwfXDravZuN2XGnn211EJY2m4Pekrz
         ZVat6RYBgxyrhjNjFOy4L1ereNBKykwwzQU/zYEZPSqFIHwOjbamjqY2NijUtQK8BrJo
         2nW31/OdZsXqJn/cfjY7+T6dm/lg933yEtQaz4xDtodbAm6qvYILdifMMTBT0N3KQvvv
         2aIxeB9W2cozL3Gk8bbaJX5HG9/ThseB+GM55mLOAURBKE3rgYfSMlL4/rdL1Nq/cJVC
         GLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFVy3Y9MVCWte671WOFf60PfUPv+ycHx3SxmfV5kFG8=;
        b=PPL41cYIKZFsAhrkDGoTYxIa7nQOKjrQam58Tz+V7lL0yroZT3DvQJsta/b2h8oH9X
         L/+0r2weIRrrPxgQPdlhd6scDbBxwDebugEFZdyydOVQzHOJquHbGs1Ep9ZWktA9KLMI
         xGhLWOUOlm280yNizy+ymhIvNc3GfnHlB4nEi8kEi4OWbVaTYSd+aqwmf4fOmHx9s2es
         uNQgFyBaaXrnaOaVDViLOG+sPB7qXP4EEig1mCHg68l84WuxgEHHHBsI1yoP3RGpatdO
         iCapoXTEEvgywTaFPq4YcRcOInS+TbmAGZkxFX6BWawgjiavbadEFzdBNvXQAf8iKtg/
         CtfQ==
X-Gm-Message-State: AFqh2koWGvvnXUVDCIbK3WQdX/YljISfP7+1cQCyTS1Jh1cXSVhaazje
        2Ir6k5DjhZircEHvC1RcPY4PugVhyaw=
X-Google-Smtp-Source: AMrXdXvWvTQTEvbZZvU5rS7I/TFVOA3XTgW8/cQSAawotu8/CeTy0IWLWu3FuNa7GGXNslr470w3xQ==
X-Received: by 2002:a05:6a00:d52:b0:585:64d2:54a0 with SMTP id n18-20020a056a000d5200b0058564d254a0mr1659785pfv.24.1673028962204;
        Fri, 06 Jan 2023 10:16:02 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w2-20020aa79542000000b0056be4dbd4besm1406580pfq.111.2023.01.06.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:16:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 08:15:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
Message-ID: <Y7hlX4T1UOmQHiGf@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
 <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Jan 07, 2023 at 02:07:38AM +0800, hanjinke wrote:
> In our internal scenario, iocost has been deployed as the main io isolation
> method and is gradually spreading。

Ah, glad to hear. If you don't mind sharing, how are you configuring iocost
currently? How do you derive the parameters?

> But for some specific scenarios with old kernel versions, blk-throtl
> is alose needed. The scenario described in my email is in the early stage of

Yeah, I think we use blk-throttle in very limited cases currently but might
need to deploy hard limits more in the future.

> research and extensive testing for it. During this period，some priority
> inversion issues amoug cgroups or within one cgroup have been observed. So I
> send this patch to try to fix or mitigate some of these issues.

blk-throttle has a lot of issues which may be difficult to address. Even the
way it's configured is pretty difficult to scale across different hardware /
application combinations and we've neglected its control performance and
behavior (like handling of shared IOs) for quite a while.

While iocost's work-conserving control does address a lot of the use cases
we see today, it's likely that we'll need hard limits more in the future
too. I've been thinking about implementing io.max on top of iocost. There
are some challenges around dynamic vrate adj semantics but it's kinda
attractive because iocost already has the concept of total device capacity.

Thanks.

-- 
tejun
