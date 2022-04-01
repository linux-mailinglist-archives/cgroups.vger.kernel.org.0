Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7F4EE58E
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 03:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbiDABIm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiDABIl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 21:08:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C922BD4F;
        Thu, 31 Mar 2022 18:06:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i16so2661516ejk.12;
        Thu, 31 Mar 2022 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4Oi4+nEs2DuySa9fWn+II5/KnAf5RCOAxddnuEBjOo=;
        b=lfJTMOnXLxxBegeJG4M42CyKemTU/7xuAJV2g/QkGorJ5kHTAh/M5uKr6kG4xoBNfR
         L1xhi5B2ZyPy/f0mZ5YRo3ikrGrYDzZRu3RAdN18kTWK+UujBZoPAObDDm+F9YRAGl+l
         FOw9eob8rUJZ/k8ShN5GTEUW0dc6D+LeL5F/EO/BDprdVBrO5HTrWdE9CSvV6SdLG+X/
         Gpy6uKexODNQePKE2QVgrMi3JfsQhqsK4g6innaeK6jizr/lMKYbhtOZS4+ONqPy8B3m
         wZWZqn/cMxIqqWyzj7B2Nyk02w5F6p87DndFTpuoA+usFGlgs94EnlTR30hzdxOktTrD
         hiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4Oi4+nEs2DuySa9fWn+II5/KnAf5RCOAxddnuEBjOo=;
        b=HqDLySsj7A5n83PWdqT5EA2bxwtrBLfxG7EvSFVlivAYXGJvweX2Ca+DMyuWcvcx3L
         JZiZ5MYyuK084u9xLObcgjP4dGale3A2UDbHizrWNKXHTnolCdsHt9/J6yvbaMOva/mv
         nqsrhMMUOsKMXMYVhDf1mLhOYgJ3Y7I49WWZn6hmLtl5UBUhfunJ1ROnQx0Vk+Li1Mi1
         ur212Gaoe6af4MaIP7cCXsXuqTvEUFeJkQrmkXHnEKgc/X2O9WGCom1i/wwsZUvXczV8
         IVUhHh1s3x5xrNVIdakZZzIRxUwawLSluq+DY/+Um2tSwvsaDL1XQomt9s+HhSo9ap0P
         hcPQ==
X-Gm-Message-State: AOAM531BZDYWzha0q2jAiOlkDYwPd/MC2MF+oOi4+YYLsKzqkDWxraZd
        VcJbuOPLshqBafTL7svWxEex0REmJz0=
X-Google-Smtp-Source: ABdhPJxWYORqg1aGyeVipbJ7gxove0y9p8dziuySXgQOXHQJbl0nqN7QD9cS5vTk0DVTJr35j8dDpw==
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id z19-20020a1709063ad300b006cd382b86e5mr6832212ejd.145.1648775211380;
        Thu, 31 Mar 2022 18:06:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00419651e513asm468720edc.45.2022.03.31.18.06.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Mar 2022 18:06:50 -0700 (PDT)
Date:   Fri, 1 Apr 2022 01:06:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove unneeded nr_scanned
Message-ID: <20220401010650.reelvkf2pbxkf4gl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220328114144.53389-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328114144.53389-1-linmiaohe@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 28, 2022 at 07:41:44PM +0800, Miaohe Lin wrote:
>The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
>does *total_scanned += nr_scanned. So we can pass total_scanned directly to
>the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
>of adding nr_scanned to total_scanned.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>---

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks

-- 
Wei Yang
Help you, Help me
