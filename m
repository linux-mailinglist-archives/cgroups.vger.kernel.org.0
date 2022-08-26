Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575CA5A30E1
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiHZVPL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiHZVPK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 17:15:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9ABC8F
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:15:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090a65c800b001fd602afda2so2820681pjs.4
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/r4GaceiE64/VU9cl6w/gnM+3/l95EwxcGXeU/3BkKE=;
        b=o/AKIAKsz4xMcPimPXLt137uSh8/jY5uoC1PaGLEF10bLPqupOMaPDTKxhgrNz2jk8
         B/mhoDzoQStmnj3mUeUY9GxckDDTI3pMfR3Q3dmaGscWIkwN4vcGY2lm9CeDKx6U7E4I
         Oa0tx4qUED5Jsc71/+pXNtl9/q1S5YNZ5k6N0BaytKo8w+vE6+wPPcGz/+2nK77ELfo0
         MD0N9FugW/dxedZfB3swJKGIzc3FdBHkGl1T+sxmBYZBCjCELyn/bZSY4+2sCgLhJWjc
         JlF82qnVtsx8skf2U8sTDtn9hbhMfwSsmNBBrCNufpoMYfZHr3IAb9IM1ZANytZW05Rp
         dK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/r4GaceiE64/VU9cl6w/gnM+3/l95EwxcGXeU/3BkKE=;
        b=fG/9Y6YhuBJrrOeVPZ1+DeraiFPK9NS2U/RziUxu+0U4Nrkw1TjDRjgovud2ZcD/k6
         lpZXOfVhZfmzvCAmzzOClBFVJeFC0vrMv1j9ZgA9U9d6NvD0fowK+x2lu3pdKGmedz46
         Wjz8LwsQ4TgFl9+26Jmv3nzj++hjsINzghRW8F74ojf0mvv7ytYl2TBkz+5i4JlxiIZx
         R2YzYtx5vulxbWiuq3DK1exx5ech3O6HoYcJpEVd3IIdRI/ol1NyPQjKA9KJkog1+K8S
         iluD8A+PMqup4htkEzLZrvEpncVf+5NnNV6NRVPmOYik/NEoatUPdn43jAM2KNFy8v4H
         qobA==
X-Gm-Message-State: ACgBeo0xTAzs7QrCb4b+uemoRIIX2VmUwXkoqXdaW/EYL/KAXywCoAnw
        ul4HbcVZUBtkxR0XTg0HzKU=
X-Google-Smtp-Source: AA6agR5DyyqMofAzCfkbhjeBrXlkpfuAK+X6na5XC7gSmZaIkNkr4jDVhQFLIgXevReECBgRl6RYog==
X-Received: by 2002:a17:90b:1650:b0:1fb:215c:8449 with SMTP id il16-20020a17090b165000b001fb215c8449mr6070460pjb.86.1661548508440;
        Fri, 26 Aug 2022 14:15:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id lt13-20020a17090b354d00b001f50c1f896esm2137359pjb.5.2022.08.26.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:15:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 26 Aug 2022 11:15:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Use cgroup_attach_{lock,unlock}() from
 cgroup_attach_task_all()
Message-ID: <Ywk32l/GFRARpZDn@slm.duckdns.org>
References: <5ea67858-cda6-bf8d-565e-d793b608e93c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea67858-cda6-bf8d-565e-d793b608e93c@I-love.SAKURA.ne.jp>
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

On Fri, Aug 26, 2022 at 11:48:29AM +0900, Tetsuo Handa wrote:
> No behavior changes; preparing for potential locking changes in future.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to cgroup/for-6.1.

Thanks.

-- 
tejun
