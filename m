Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC5526702
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiEMQ2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEMQ2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 12:28:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2391567;
        Fri, 13 May 2022 09:28:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so8450275plh.1;
        Fri, 13 May 2022 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewPlolLGmE/a959g4ZA9emiwMLzM/HuRgbAmtM/bKKM=;
        b=hBiN6IheDSJjCVGBGxNiJqN1NO8KxR5odY3itzDXivs7PJf8NZMHpFBtiOwWS44KpC
         5QByrr9xl4phn4Ex2VvkCcHFs7vkuwG83TbENksSTbJdRJfDqAyJoFkeIWC0OmVnNYwJ
         anTAfEIj0J+TXXUq8DOCMGeeJy4GwiDk5eMQlqXmvBI1ciYLvFqOREiudh/miO3Ug2lp
         Sem0FDhxzNBnr8WKZmCbmJ+xgk0k0Z/+JmJLa3zxOnDTJfwDMn4qRo3ynvCG1rJk3rqz
         UONgy6PF+YxDv4fwpfWtlrwBWekAQfPxtH74R5/TdAENGRNc44h2zM8/RoYnOpGYnYSm
         qKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ewPlolLGmE/a959g4ZA9emiwMLzM/HuRgbAmtM/bKKM=;
        b=CzgYh7HRobHxXhj9Rh7tqETu/PK708J07pnsuM3bHBqeg5wnpj1xq0xDjTNmM84ur6
         EF4N+oZFekw7xibRo0JRI96+RpxI1xZR/GvV8VZAQ7RhIkgQotNIs8JNwRiecVyNmBwd
         mt1slcCKp3kFTibh2DA9rwCNDM5kELp7LzFHFy65VKf72yJn8VWm//B9epUx3E/etkps
         t3NKrRjlSF9Fksmm9M9g7hdwqysF6eMW/N1jGVswNXtcu87wklcxYe2YDSi54lEJw5uM
         RXOl3+Ygjqfhgas/0V++Zc+ip/O3qkh8w122fUtNNgJVeYTwC8NqKInz8jsiZU60rJ4S
         57WQ==
X-Gm-Message-State: AOAM532J2lfmzz0K7+mM/HbzbLtYe/jtaktFHQKtYrITpHjk0xzLiBIv
        cvQZdP3g7pSL5ZuGK5jfJl0=
X-Google-Smtp-Source: ABdhPJwT/dE+TDl8hBshKtguIUYZXsn7hWUYiz6ETIvxyAm9GztrLfAZoYOm3xuWA6x2QvGGXpC94A==
X-Received: by 2002:a17:902:b94b:b0:15e:f33b:ec22 with SMTP id h11-20020a170902b94b00b0015ef33bec22mr5512470pls.119.1652459323334;
        Fri, 13 May 2022 09:28:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:5607])
        by smtp.gmail.com with ESMTPSA id u12-20020a62d44c000000b0050dc7628159sm1961602pfl.51.2022.05.13.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:28:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 May 2022 06:28:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yahu Gao <gaoyahu19@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, Yahu Gao <yahugao@didiglobal.com>,
        Kunhai Dai <daikunhai@didiglobal.com>
Subject: Re: [PATCH] block,iocost: fix potential kernel NULL
Message-ID: <Yn6HOSAE/aAeMGLU@slm.duckdns.org>
References: <20220513145928.29766-1-gaoyahu19@gmail.com>
 <20220513145928.29766-2-gaoyahu19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513145928.29766-2-gaoyahu19@gmail.com>
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

Hello,

On Fri, May 13, 2022 at 10:59:28PM +0800, Yahu Gao wrote:
> From: Yahu Gao <yahugao@didiglobal.com>
> 
> Some inode pinned dying memory cgroup and its parent destroyed at first.
> The parent's pd of iocost won't be allocated during function
> blkcg_activate_policy.
> Ignore the DYING CSS to avoid kernel NULL during iocost policy data init.

Thanks for the analysis and patch but I'm not quite sure the analysis is
correct. When a cgroup goes down, its blkgs are destroyed
blkcg_destroy_blkgs() which is invoked by blkcg_unpin_online() when its
online_pin reaches zero which is incremented and decremented recursively, so
an ancestor's blkgs should be destroyed before a descendant's if the code is
working as intended. Can you guys dig a bit deeper and why we're losing
ancestor blkgs before descendants?

Thanks.

-- 
tejun
