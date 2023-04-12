Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356446DFC5A
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDLRM5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLRM4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 13:12:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBDE76;
        Wed, 12 Apr 2023 10:12:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q2so16962655pll.7;
        Wed, 12 Apr 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681319575; x=1683911575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSVn8k9Iy2lv6cYKmPXJRFy7/1j4dCRyeMR+P+kHP9s=;
        b=Vm0yTlaxfj0mkM1OMk6w702fv0lCHyPPKK1wFDHLEBg8wEDgQKYaM7uQwJ/2HxKZly
         pnBYN17K6zKbuOn64ERSrTiD33ydFcCQVN+GSvQURR6Nzyx+9zvl6qFr3iLe0MhziFjt
         SvcivMdT1Ei+O77Gw6Ccr+e/G2ZC5ZnwWuwLgZ3a1rhpxRwG6Z9oFGhgJ2+03KKQEQYL
         UH1XNv23JqW6eWhbS+ozo1swoyo/+vyvqCaEjI0XgvZoPfbrVrGfVyX+OBnZLhEpmTjd
         E/YGui7kLu8X1l35IMFhGSs3LYfIQZYjv5DeLUUM6WMHkdSt5LD1fmzXHTYxVNZ1NM1E
         0Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319575; x=1683911575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSVn8k9Iy2lv6cYKmPXJRFy7/1j4dCRyeMR+P+kHP9s=;
        b=ZaV21WDqNckcMmKTbdnnT/lqypZNuoVNebEotM5oty7Z+W1T3QmC+DbSMy5Uq277/M
         HWrMhWvxTMUjRaMg+/7ieotayamgWMRdVafnbhoxrMRght4LSi6gvNnRQepADXR23/T2
         +hSIjBz8QwseYC1MidK9rh8L/Vzv6McgjvG6QpfClLvSzpiYenFYyDWriQGRNFyEZtvU
         sy6h4AJ5RByP3T+FCemhjxQjk4aHADPXJxqE1DnoAE7Ow/Ui73epRGuJ8cSeOWnzXbla
         bXGO1fUGHiNYbhggTcHdIBmdl1Fz2JxTQ5bcENGmzksxTb7muc/iWzT+OcbOtg5hVBWu
         ZSCg==
X-Gm-Message-State: AAQBX9cMiq59ABHna2j2scJtFvkevhvXekBPGp4wyBUDXUaLZuHKyggN
        3VeP0g5ntUTnoPON/PA9B+LzdPm2QCA=
X-Google-Smtp-Source: AKy350busE9hpWlgD8VHywqkpzwREj5cRFnQ41TD7UYs1NEnmsloZjPv1CbZzBsl0klrhCqafKmm2A==
X-Received: by 2002:a17:902:c950:b0:1a5:1bb4:adb1 with SMTP id i16-20020a170902c95000b001a51bb4adb1mr23237517pla.37.1681319574826;
        Wed, 12 Apr 2023 10:12:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902b10600b001a51f75ed5fsm9194989plr.242.2023.04.12.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:12:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 07:12:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] blk-stat: fix QUEUE_FLAG_STATS clear
Message-ID: <ZDbmlYIrRpkWRZla@slm.duckdns.org>
References: <20230412160754.1981705-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412160754.1981705-1-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 13, 2023 at 12:07:53AM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We need to set QUEUE_FLAG_STATS for two cases:
> 1. blk_stat_enable_accounting()
> 2. blk_stat_add_callback()
> 
> So we should clear it only when ((q->stats->accounting == 0) &&
> list_empty(&q->stats->callbacks)).
> 
> blk_stat_disable_accounting() only check if q->stats->accounting
> is 0 before clear the flag, this patch fix it.
> 
> Also add list_empty(&q->stats->callbacks)) check when enable, or
> the flag is already set.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

It'd be useful to explicitly illustrate the buggy behavior in the
description (e.g. if you do X, Y and then Z, then X incorrectly loses
accounting). Can you also please add the appropriate stable cc?

Thanks.

-- 
tejun
