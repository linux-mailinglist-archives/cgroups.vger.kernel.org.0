Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65165DF51
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjADVtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbjADVsq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:48:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EAA33D43;
        Wed,  4 Jan 2023 13:48:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g16so27651599plq.12;
        Wed, 04 Jan 2023 13:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn0mw+HyY9jD6nVegketh+9oP4bvjOwnt4T3S5lMN4k=;
        b=oSBIFS3lQw/ho5ZV8fR2DJe2VfEGp02hP+GWAFf49EAu7rer/fkCo+EeozXc+N+9ae
         7BoOHdRhElv5q7X1mgvnmc0PyZgyg++4lbc0rM4UiUtHJC3iC6Eqt3dbVtHaw6MRd/KR
         /xWfnhB5cc4inU72pw02pHZTM2yW93JG24AC6NRHVDmzAJkTV4VOmLl19o290Zh9tqrC
         kCPFD5+eEX9dszZKjL2yufzj4DVfLCQBvjz4vWOsS4Z4X3lTNguY2XXSG147ra2dfupa
         JxxOKCMlp4KVDE/cq/HxQ28rBil/x5XvSCIzkJeeT7Hw+rRh/mi5OXateR6g6x0wnmhO
         GShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn0mw+HyY9jD6nVegketh+9oP4bvjOwnt4T3S5lMN4k=;
        b=tmfprhj0su1Z2dkuNFZCIvWH2JD7PnAg9FrbzcPhiae1jjr1yxsOmlFaoQ28d8gqli
         cwDvZyO7nq6aIYvsbSjp2d92lt6ABvAG2nByEZYKdJ37Xf1Rpa+mUhRli85xK2Yyt3o0
         6jZVv8T668RO/70Im7hUFc3d/IBez6kfgA1hL0xZcV/7zVFjsukj7T1iibT2ZpBwlj0K
         Qld2oZ299ixx0SX9ucr0oA3K+IQQPInPOrwL0C4ijYah5H7AmjclnSdmECuPXalKZCGW
         4ObDeBs9AwZ4TD+TKEohGKkLDNv+LE+GBsPQwqd5wiSADHQSSqLsT/snfL00eexeqA+U
         wKMA==
X-Gm-Message-State: AFqh2kq8VaCjJt4jUF/8Fpdo6hGKu7+wVNvKNX5ZKZ4hZ0IYSg2GHQ+r
        EK0nJ1hmCnhdi2NHCEp27tU=
X-Google-Smtp-Source: AMrXdXtORO4QW9P4hCUb8EoS/fiJjD8df+nc62GkkOTM1uCH07QKuewB03NdBrvaIAuuu1G9iKpdfQ==
X-Received: by 2002:a17:90a:e54d:b0:219:681c:9f29 with SMTP id ei13-20020a17090ae54d00b00219681c9f29mr58041221pjb.1.1672868925348;
        Wed, 04 Jan 2023 13:48:45 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a678b00b0022698aa22d9sm22134pjj.31.2023.01.04.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:48:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:48:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 5/5] blk-iocost: change div64_u64 to
 DIV64_U64_ROUND_UP in ioc_refresh_params()
Message-ID: <Y7X0O910GBm/zB9r@slm.duckdns.org>
References: <20221226085859.2701195-1-yukuai1@huaweicloud.com>
 <20221226085859.2701195-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226085859.2701195-6-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 26, 2022 at 04:58:59PM +0800, Yu Kuai wrote:
> From: Li Nan <linan122@huawei.com>
> 
> vrate_min is calculated by DIV64_U64_ROUND_UP, but vrate_max is calculated
> by div64_u64. Vrate_min may be 1 greater than vrate_max if the input
> values min and max of cost.qos are equal.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
