Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987E78CF6A
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 00:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjH2WSM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbjH2WR7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 18:17:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F6194;
        Tue, 29 Aug 2023 15:17:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso30471075ad.3;
        Tue, 29 Aug 2023 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693347474; x=1693952274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpZA2JcHwH/YVwVIjbgRb69BfPVjsSUKqWdoLWaX5IU=;
        b=Rn/1Js/KDV0Yr/7/oRlebVVeYNY8jb3g/STkLRFGJZ4h3NepPW8qIVA/OZI/LVrCnp
         1fSAV8boAnS6n1lRv0Niti8qBGNS6Cx0AbcGiAqQuSg4Mp2ILgJR3Y3wwloCjIQQ+Ol1
         DDNrj1PoJuYS6SvX+Apl3/I1AbpAhf8beg7+04dmvd/I+ufbx4X/SVyg2lB6rVaSezsc
         UHjrKJzWHWsUDgShL22Tz8jpNV+IWj1dvrrZbzkJvSmm/fwV9gtnJKb6Xnm5daIhsvmj
         uB2CjTkaI4D8lvClzZASiwzxN1L5DpSDffgtmtu1Fs6ZC5uBxoun7axKPHcfwflP6NB9
         /Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347474; x=1693952274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpZA2JcHwH/YVwVIjbgRb69BfPVjsSUKqWdoLWaX5IU=;
        b=FdAGlsq8zfKiUd6Y2jAnxE0WFI3IPTaD44FN+IPdaygSXneK8SwCHA9WQ+f9oVfaCC
         pokeHZlyG5O8dmYFBBtAZrbI0akNgf6GL4vpmxJ+0h4XtIx0Os6uOdDaDhoiGF+7GYyB
         7wmitRbEE9CdkuIRUUMWRuAd21wYC30MQRBWp8S36yJBRWM+IswWoFE+K68tpnFVcRIg
         RyFK56GUIXMD/ir9WqNCnciLDqGbe/Xjulbpfq9GvVGsyWtujiArsnX+cK910gJx6rjG
         KovIZu6ZsL8y01GxhsgmHss1/xjcgItEBh9oVUqijX3a9SVMVpmYHcMhuuRUk19se3UR
         5EZg==
X-Gm-Message-State: AOJu0Yw8qmJMQOF31OTEr8E0AFzZyK58HwgjSKZF9IeDMvFm2myKIl1t
        0BozT7rhtxa1ma41QBNyaAs=
X-Google-Smtp-Source: AGHT+IHgV7nflrc8oxbJqrHMUriWQbjBaXrI9qfMmln8eWwNuvV9NRz6tKrF5wv0+hbnaG/xMsdAeA==
X-Received: by 2002:a17:902:ab93:b0:1bc:6dd9:82c3 with SMTP id f19-20020a170902ab9300b001bc6dd982c3mr368344plr.37.1693347474369;
        Tue, 29 Aug 2023 15:17:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b9e9f191f2sm9884102plb.15.2023.08.29.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:17:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 12:17:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 1/4] blk-throttle: print signed value
 'carryover_bytes/ios' for user
Message-ID: <ZO5ukKSulqnCviAs@slm.duckdns.org>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
 <20230816012708.1193747-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816012708.1193747-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 09:27:05AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 'carryover_bytes/ios' can be negative, indicate that some bio is
> dispatched in advance within slice while configuration is updated.
> Print a huge value is not user-friendly.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
