Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC478CF75
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjH2WUw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbjH2WU2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 18:20:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D61B1;
        Tue, 29 Aug 2023 15:20:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf3a2f4528so38766415ad.2;
        Tue, 29 Aug 2023 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693347625; x=1693952425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4J2rbxAFjfp7sOlwJ88FE+lmdis9M2FRPFOfqh2wKcA=;
        b=KbXbxf6xPoayllgDXklz5FTcjILcyk4nl5NJJLO+rUG8YC+n82O2+8BByDDZ09JMkY
         PuM5d+EVVYDUyn7tI4sri+Y/X89Cs830F2BAK7f0ljWfS/kEPl4pnAQSw/4nnQkzQtd4
         yfzzt2Fxw1ehkpTJRskQVEv8ccCEbqqQuSglP35dlV5Vp/tek9iC5XjegbSEabDfoEoO
         bz2St0mBliPDu0xtkTkt2cmwW7mgCa2ImDe0YKO5b6X2478MjpBiV/h/mwxObSlhc8k8
         hLGY2wajQgUWrPgc2jppHYKya/rJMDbJ781EWNP+EAG6heMSUp2RnCM5OkN4YyEmIb2+
         V6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347625; x=1693952425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J2rbxAFjfp7sOlwJ88FE+lmdis9M2FRPFOfqh2wKcA=;
        b=ga2y5h/HEISxPnT8JdAGDp9DFgUsQ+pGL3gNHSvLWR2dCMATiMFgNhb9n9DR2cKrmQ
         2cMmP2B/ygI1pDaa7zou95Hec2t7uJvOz0/408wXZhGTuZzNjLORRvqOUz7JRZc61dnM
         LFRtrz4oV6XPvyRXOAXe9aKqMWJrw7F3ztNDsUNvXtUJxc40nef/xHLzuBFQEkz7Rt5b
         036iWw1M69N9d4yz/W/fsxvxwgdB61lXkqL3M9Z81+UTUF36r1bCPp1HNRoZ6iaJD8QT
         iB2M36wGW/JE61uvgaNqngNVVggWd9CdD65TUqPfua2sUYxYPa/DlLYH9CmAqUxgBjt1
         y82A==
X-Gm-Message-State: AOJu0Yx77W5L+BheKfNMPlbUg/EpZIEMNa7CY+aaHWRF7LX/rg1xzVT8
        3pTdUb8kzAhUxyYLRbt3aik=
X-Google-Smtp-Source: AGHT+IF2fVXd4Vn1dSRwPBbsF3aJmvAkwbUbiTaXxWWLBFPtBKhUKtl+cSyk6vS/L+7ijfTVXZLq2Q==
X-Received: by 2002:a17:902:a411:b0:1bb:9f07:5e0 with SMTP id p17-20020a170902a41100b001bb9f0705e0mr383039plq.60.1693347625213;
        Tue, 29 Aug 2023 15:20:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001bc35b14c99sm9812861pli.212.2023.08.29.15.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:20:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 12:20:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 4/4] blk-throttle: consider
 'carryover_ios/bytes' in throtl_trim_slice()
Message-ID: <ZO5vJ2i3qfvtBC7B@slm.duckdns.org>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
 <20230816012708.1193747-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816012708.1193747-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 09:27:08AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, 'carryover_ios/bytes' is not handled in throtl_trim_slice(),
> for consequence, 'carryover_ios/bytes' will be used to throttle bio
> multiple times, for example:
> 
> 1) set iops limit to 100, and slice start is 0, slice end is 100ms;
> 2) current time is 0, and 10 ios are dispatched, those io won't be
>    throttled and io_disp is 10;
> 3) still at current time 0, update iops limit to 1000, carryover_ios is
>    updated to (0 - 10) = -10;
> 4) in this slice(0 - 100ms), io_allowed = 100 + (-10) = 90, which means
>    only 90 ios can be dispatched without waiting;
> 5) assume that io is throttled in slice(0 - 100ms), and
>    throtl_trim_slice() update silce to (100ms - 200ms). In this case,
>    'carryover_ios/bytes' is not cleared and still only 90 ios can be
>    dispatched between 100ms - 200ms.
> 
> Fix this problem by updating 'carryover_ios/bytes' in
> throtl_trim_slice().
> 
> Fixes: a880ae93e5b5 ("blk-throttle: fix io hung due to configuration updates")
> Reported-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
> Link: https://lore.kernel.org/all/20230812072116.42321-1-zhuxiaohui.400@bytedance.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
