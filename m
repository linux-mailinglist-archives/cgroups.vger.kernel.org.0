Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0175A596375
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiHPUCe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiHPUC1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:02:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12BB7F0B0;
        Tue, 16 Aug 2022 13:02:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 12so10185823pga.1;
        Tue, 16 Aug 2022 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=O9E2tV5Eqs8B8X15RAsfJgS9BzNTXZL8afuu3Y2YeCQ=;
        b=VdvdhuNgrENNkEhNdbQw5mkcYIDKMm6VZZaymqscCs3nYQeDbAeEYrugm2EjVWv7JE
         0G3Wwz8I348ukIAY2KsK0JBYB29l4gr8tFHK8cgpCxz8mzj1YrrVaqF+8SU+J3JL5D6d
         uxKSrGLmjm4m139pZoUo+RJD2jQQGrz0AC6hfZH4KVrKWXkIaC6Pnu3OwEYlg52ZddEF
         ZwFUmMmE9Glr6kwNxSqJPx1WbYNnzzE8sDSMZRjMWoT9vCRsYQvfa4VoTtsdsrzKvEoe
         dHLUE0doTB27/OExjwPqW8rFoQ0aBxOOJH4Xdo3RIV6jI5krIPgjDC8C6Ly5DQ7O91Nn
         EQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=O9E2tV5Eqs8B8X15RAsfJgS9BzNTXZL8afuu3Y2YeCQ=;
        b=mw1aU82vXRsNc83JkO/TeI/wFkSjdtPRtNq3o7ZvWj9b5tzZE2O78Z2COB/vpxKUxh
         QGG8kDLFHspd1yeBsN0nsLAjujchjPn4EpZNDhAoghI/vEutWKli8k4otEgrlqOce99a
         vB4nvvMhIf71gGn86080ihX1bj2uEeS9u+g/Yhh1pOvavOTS0rkMZrA8KzRYjSTXTQtf
         uNoq2hvFwDwQT+wGNn3DMjY7BoH+RyeW13/yH/s4xCbFUVZGzIhmgDeo3DzLumZXsN4e
         dm/fnyEYakiELPH6nLZURCqkUNQf6JoEhYoladFaTXyAG1P3UxUcAw81zMV2QTE7QsBh
         jkUQ==
X-Gm-Message-State: ACgBeo200u7pk6Nfrc2aogyKt5ZVV7LLNQZpYH/2souFngM3EtTATQtl
        R9agzmMM4Iz16YA++sLfosA=
X-Google-Smtp-Source: AA6agR6mDv9NV0U8FomO6wqYX2w2zNt/6mFgZau3yfdwpb8fCQ8f92IrUhTXcFMjHk9vrVLrKUTXrw==
X-Received: by 2002:a05:6a00:190e:b0:52f:db01:5c56 with SMTP id y14-20020a056a00190e00b0052fdb015c56mr22908776pfi.1.1660680146165;
        Tue, 16 Aug 2022 13:02:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id cp9-20020a170902e78900b0016c50179b1esm9455570plb.152.2022.08.16.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:02:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:02:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 5/9] blk-throttle: improve handling of re-entered bio
 for bps limit
Message-ID: <Yvv30FjQMcLnC+aB@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-6-yukuai1@huaweicloud.com>
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

On Tue, Aug 02, 2022 at 10:04:11PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, if new slice is started while bio is re-entered, such bio
> will count multiple times for bps limit. Since 'bytes_skipped'
> represents how many bytes will be skipped while dispatching bios, which
> can handle that case, increasing it instead of decreasing 'bytes_disp'.

The same thing. I think we're working around the problem in the wrong place.

Thanks.

-- 
tejun
