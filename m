Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1478CF73
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbjH2WUV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbjH2WUK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 18:20:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483981B7;
        Tue, 29 Aug 2023 15:20:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68730bafa6bso186426b3a.1;
        Tue, 29 Aug 2023 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693347608; x=1693952408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFuNpAVo+v+BaNd7xetve7hcqsQN8Vv/yJKgXgf5i4U=;
        b=K2O1r+ZclVj+dWaqFq/Qzm8fiu08xZa7R6nbxHsFQ9meQmlwgepdkpBZrUCluyvDi4
         PzQDsPreTH0A9FniexFSDI7aJ/uVC0TMd6VWXBueyfDimpfs87CEk4+iO3YloGut03OH
         1aGLvCwH0Atm2a6ADCz1PB11Qvg/Nk3hDtKi1stSp9ewIVNbDoA4bLnD27Bcvn3DoGty
         hzMdWNG/AG+V6UxwTzalZVKnUFwnmn7Cge1Q7BmZDS1aVohX3AhRqiy2HKBks6axar9o
         fJ7UrL11J5Lwn/umvFydB1jRNyXQRd4oCB5R5uBSwc9AsxFn6vwVwt658xw9p3lWnyTq
         OhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347608; x=1693952408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFuNpAVo+v+BaNd7xetve7hcqsQN8Vv/yJKgXgf5i4U=;
        b=WBzQKWCNxgn8EOMqIZc6oJq6F9sNcqteKUVq0gVteqzEXrDfQi4PkkpQrSkZc9BI9J
         fgliUh0KPWUKza+DoO3vyDtpWyrGV8EJlYyc8hAUgXQ7Pi2QvfXSCAuuFVKLJ47yCBk6
         dWXVEL2RmCF+qnI2vTPdw68j5GlonKbBWslQhRytYWcXDR0yLOjP6DsTdetDi2YE4Exz
         wEF2TVRjRanto5f/GqZO5NcNxfUqenXfFOl+V2WuRjFKQ7zaCU+NPG91WdiLVdgaOnAm
         cXOTpW239QnqgKo1ypB0MxEu9Jo3EgIT/v2RON9BWPuhYT6OkY4oiuTGxQWLdtTUtpnn
         rgIg==
X-Gm-Message-State: AOJu0Yzxuk3BI8NFy15G4l2MXEV4GJgsTAalScRV1NPdm5LgwWA3df3+
        BO+xk5aPo+jISbrc/C0woUp/Ouy8two=
X-Google-Smtp-Source: AGHT+IHek7uiDRWm5mFIQcAnx2uDOaw12JGte4lf8hYoT4LmuAVqXKaviBG65uvNPeSKnyCU/4RmDQ==
X-Received: by 2002:a05:6a20:7489:b0:148:99fe:1fde with SMTP id p9-20020a056a20748900b0014899fe1fdemr816514pzd.18.1693347607612;
        Tue, 29 Aug 2023 15:20:07 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78488000000b0065a1b05193asm8891044pfn.185.2023.08.29.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:20:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 12:20:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 3/4] blk-throttle: use
 calculate_io/bytes_allowed() for throtl_trim_slice()
Message-ID: <ZO5vFujDLng0kg_x@slm.duckdns.org>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
 <20230816012708.1193747-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816012708.1193747-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 09:27:07AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are no functional changes, just make the code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
