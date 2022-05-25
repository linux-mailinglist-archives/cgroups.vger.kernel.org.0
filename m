Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91E533BE2
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiEYLle (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiEYLld (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:41:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F19EA2043
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:41:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so18327113plg.7
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Di7XV4IGWF77tQvxoeiNfKzeIQMl+KEXZAhavQki9xI=;
        b=4PIrBTtSY7gdXmJ5owF/C1/ZrJroXty20T94JZS01Q1mZd4fgW+U09Ylg34REtQHwg
         VvHo688nCXJo+Q7+koX9lz+0tbnGoEkPPGZ2AgZ66FiiIBz/6J2zuZ2o6ahZyYplwi5a
         ZpYwEegz5Et296T5u2GHEruAMZ0J0oFI2MrnGS/px1P5ZBQ3T4Fw9BIIQZ7ilJbngsZX
         RuccrSfBxgHlo3I+FuYajmX7kRE146DU7yk3DvUqdzSiPKw6IAB1msE3q4MepqWL+Drr
         HByjp0hRrmK7RyClGTppcHZFzyvg58pywiCu6oaOmRd1JgAsrEtQimpdgiRstKiuADI5
         INkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Di7XV4IGWF77tQvxoeiNfKzeIQMl+KEXZAhavQki9xI=;
        b=ofsRCLbjflsdzKIAHa/iFLtkFOhJy5dhb2TKt1z8/l/Q4XHgLu33Aycmvc34qb7ilJ
         ivuZQSOPp7kqymyVfOPp40AGpekLTeO8qj57auJqP4Nan0/EEpZIxCUmcKrDxN3JIPwJ
         ALdutJrfrMckrf8NKUXKvaDqsV9yio7SyCT3CpIVzEE2lnhSRqAwxFPh0r2Kx4uMRnUo
         LmOxsM9HH7hF4rlYjR9JkSuI6adVYOkMC983m5TSil+lr5LIBp0dIU7++U/8rmQOgvGC
         LqLC4soQbF8v4zmob8+c03R02LZjqxkt5bbdFLFXJ+kPtubgnWBEjhRUnhdkWVHcBA+8
         k8wg==
X-Gm-Message-State: AOAM531pblU0NjVH99jViT3DVkigGhzXYiUw2K24caB+JzGiu9pLhSaW
        phejrRiEGzGnOMeHxGKrj075pA==
X-Google-Smtp-Source: ABdhPJz17xYLcQGQExhrQwEb4JqIELoJYEvW83JIvWk7UhoFB1UVcickRa/OeXecDgwrKutJKIJ8Fg==
X-Received: by 2002:a17:902:ec85:b0:161:cff5:17c8 with SMTP id x5-20020a170902ec8500b00161cff517c8mr32385262plg.62.1653478891804;
        Wed, 25 May 2022 04:41:31 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id i4-20020aa787c4000000b00518d06efbc8sm3393965pfo.98.2022.05.25.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:41:31 -0700 (PDT)
Date:   Wed, 25 May 2022 19:41:26 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Message-ID: <Yo4V5o0dasZSm2MF@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
 <Yo2Xt6zFxNrf9M5j@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo2Xt6zFxNrf9M5j@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 07:43:03PM -0700, Roman Gushchin wrote:
> On Tue, May 24, 2022 at 02:05:44PM +0800, Muchun Song wrote:
> > In the later patch, we will reparent the LRU pages. The pages moved to
> > appropriate LRU list can be reparented during the process of the
> > move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> > should use the more general interface of folio_lruvec_relock_irq() to
> > acquire the correct lruvec lock.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> With changes asked by Johannes :
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>

Thanks Roman.
 
