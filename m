Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468DF74DE51
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGJTkG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGJTkE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 15:40:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF69E;
        Mon, 10 Jul 2023 12:40:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8ad907ba4so24106095ad.0;
        Mon, 10 Jul 2023 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689018003; x=1691610003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivhLVKhACKnZhgX7GHkfgbJfc6Z11Wv6X0HCdw2KFv4=;
        b=ig89NSSNCjVNIUtp+LTVjG7HGB9E2wmkZykr4cZYhYKHnJFmCdAGyPdHPq24XHeZ5t
         hnJlw4JRuHka8VDdhWnaF6l4pvXy5vYPzk1YOJk0BMhyTBtJl/WAso1qUD9w8T5i4sfD
         sP+V8Z0/l0dO+K6u8JrMmWsvjD3pq2ldsDSfS21zyooQOmjDkGzgZgoFFKiAVTodTlLf
         HRa0L0HYZNmrg8tPBz/z9BB5+lD7zUb1TCDiTowsYQreCy4xRFPUtFrQGDjHM8UiLiFf
         hK+bIaVW6ZCjCO7gDPGpGf0WMVGRe9PcCiGNrl7BvNDMKJNF3PA7fflK5i2ggufGx7if
         /4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018003; x=1691610003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivhLVKhACKnZhgX7GHkfgbJfc6Z11Wv6X0HCdw2KFv4=;
        b=i5K4unldR3lyuca9fB7M+fKUv2qsexgjs69w8CY+tsZEHqf7ZJpkrSeAY0tUaWv7aR
         UGtpnaikLxycWrfdy1M/Z+1UxU5EFkqlv4FGrCb2btKg5gig4motsbznpxuWkPHFZtX4
         PYCBVMHP3AMJP4XTibLsu5B995i8gvmjrVh6T3ujLoE6W5yJHTsYx3l8HpPsVmdCg9PA
         6fUfRGDJtVvL6Ib1Xucz3INdFSv9q0X+MTJyJOpVCns1pzHMvQjkyuXZtmv10XndYPP6
         WqxTRicNdrkI3V5NV4tc5ZjMY9nzY29caFNOac0xxSTerMeWe4OzcYiPmZNS2vJxHyG2
         s5bA==
X-Gm-Message-State: ABy/qLYD+iuwS2YZKIlxLRR/pbcRVryaopU7v6sDCGo6Ytok6wNDaIIv
        VwDelNd1EoTljVG/mrK9wGk=
X-Google-Smtp-Source: APBJJlGhJ5LBKMDr4CCM3ZThpk48jeo5LFLqFMRq3t3f7w/reTZDgvC443zAHkPiDzeWQii5dncJUQ==
X-Received: by 2002:a17:903:1110:b0:1b8:4199:edfb with SMTP id n16-20020a170903111000b001b84199edfbmr12883806plh.25.1689018003070;
        Mon, 10 Jul 2023 12:40:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b001b3acbde983sm290359pla.3.2023.07.10.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:40:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 09:40:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
Message-ID: <ZKxeke6SfBe37Jso@slm.duckdns.org>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701073856.2095425-1-linmiaohe@huawei.com>
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

On Sat, Jul 01, 2023 at 03:38:56PM +0800, Miaohe Lin wrote:
> The return value of cgroup_rm_cftypes_locked() is always 0. So remove
> it to simplify the code. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6. Please feel free to follow up with the comment
addition Michal suggested.

Thanks.

-- 
tejun
