Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15852576569
	for <lists+cgroups@lfdr.de>; Fri, 15 Jul 2022 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGOQsE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jul 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGOQsD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jul 2022 12:48:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA6B7E6;
        Fri, 15 Jul 2022 09:48:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p9so6117722pjd.3;
        Fri, 15 Jul 2022 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UwC5anEg0yjsg9Rw8IcHiu3GinY8BZcocAU9uCH0MCI=;
        b=kRPX1ruM5CjMlu1wj9auhM8ser8wATC3gVJCAiI2vCbhcBXZUWMyDTYhDsEN/2ow6z
         C7+1TvQrQD+ErLtFG/kwIDtsu18cPtzxGuZpGEVGPFYl3nQyigz+bLUFOvO8aqhIeQJW
         4FSZJpcLxa1UNYvKt0avG7GV9ldTRpmJsArPWoQDpxzmoAeCe0mKq4oRFAnuTUE8JlYj
         ZBKcF2ZN1n8f1akV2/h1+4YiqKiFPWla4bdyW3gCXvq3GTO0h7JXURDp3MXRfzNjWyoz
         2UzQFer9HHCToT+r6naorvjdplG/zjIyDzUKHeaM8cEww4he+LQ0Q2IQqBilO84FpZme
         AYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UwC5anEg0yjsg9Rw8IcHiu3GinY8BZcocAU9uCH0MCI=;
        b=lS+USKH5CXn99mTQS4TfcEWDzW1SsrVzXPvs5t9y9qsP2YWH4RLhAkmXbWMktx6qg6
         Fl8Evi4oehfxEdUm2sr+FJFv/+lNHBkhgnOx5QtQ6S7fVM/vzg8PE/v2I2xnzPkRWwvo
         DOU0fmYW3gE6tkP9Lte6RetvT0TsxjuxLzXJ4Ns1FO3zjUTgcCbjAkw+iFTelVrbvUiO
         sjxaDaEXOhgm8WOBL3mGYPrMo47M70uXz+xiVJEta2r3Jj77JYm76tZneeBxSLsBRPlP
         aDG1EKGETY39zmTPFQxz35zaufeK365XdC6+vtf6mD++AHS9I2a+Hv8vPSXCVy3Og9el
         oygA==
X-Gm-Message-State: AJIora/IRtWsd94mAa9s5kdaKMBZXzUl8F0POlUNzCV4DCGMT0EZ8U+i
        +zQDhuTrJ68p3AhpYyA6mJ4=
X-Google-Smtp-Source: AGRyM1vZXzm78rR8Sz4+dl+obcrdf+Xsglp4KJK1yWRu+Aac5B5Bc6klC5UyLMcJy6xRLFKuFTMfdQ==
X-Received: by 2002:a17:903:3093:b0:16b:deea:4d36 with SMTP id u19-20020a170903309300b0016bdeea4d36mr14423269plc.126.1657903681751;
        Fri, 15 Jul 2022 09:48:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g14-20020a62520e000000b00528d3d7194dsm4123824pfb.4.2022.07.15.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:48:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jul 2022 06:47:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Shakeel Butt <shakeelb@google.com>, wsd_upstream@mediatek.com,
        lixiong.liu@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com
Subject: Re: [Bug] race condition at rebind_subsystems()
Message-ID: <YtGaP+e35DZYSQf0@slm.duckdns.org>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
 <20220715115938.GA8646@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715115938.GA8646@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(resending, I messed up the message header, sorry)

Hello,

On Fri, Jul 15, 2022 at 01:59:38PM +0200, Michal Koutný wrote:
> The css->rstat_css_node should not be modified if there are possible RCU
> readers elsewhere.
> One way to fix this would be to insert synchronize_rcu() after
> list_del_rcu() and before list_add_rcu().
> (A further alternative (I've heard about) would be to utilize 'nulls'
> RCU lists [1] to make the move between lists detectable.)
> 
> But as I'm looking at it from distance, it may be simpler and sufficient
> to just take cgroup_rstat_lock around the list migration (the nesting
> under cgroup_mutex that's held with rebind_subsystems() is fine).

synchronize_rcu() prolly is the better fit here given how that list_node's
usage, but yeah, great find.

Thanks.

-- 
tejun
