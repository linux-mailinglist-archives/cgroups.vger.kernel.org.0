Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7A6688F1
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 02:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjAMBOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 20:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjAMBOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 20:14:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEB13EAC;
        Thu, 12 Jan 2023 17:14:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so17034819plo.1;
        Thu, 12 Jan 2023 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+22Q56bJPrledR2Cz6M9kGSFqzu3U0nD7pq3Hab+AU=;
        b=LskLqLtZroGnCLT7v2RAIbLULPmZdsvu+XzR5D7MTLPsEC8wXxf272Z1o+0hiCjvSw
         qCJB26/ruPEjGO9FEme6GxPxk1Jpqhmzx/rcE2woX5PtAQRllglFJUqPzPqFgHxqLuUX
         JMS8qq+fXNeUZjx7jY80f2+gg6DHsNPa/+ihzIx/5qH3t3iPZiFPRrlkD/34R3crlFxC
         0N8G1VAb51W/zqTdhDE9f+Ox7hgVcOUiN8GVadsvOUT7oovyDsc16OIZ8lve1Qgmdc0W
         tzcL6hwJ49DJ0/nkeSsYJvoBbW8nMevIDVzqk5CFywnuWwFtDcYxU22PgihW9CgQH/Qk
         HIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+22Q56bJPrledR2Cz6M9kGSFqzu3U0nD7pq3Hab+AU=;
        b=6qwkYP1WInkwJuVEoxdg3xZPW70OnAahaZ6+VsckNXazX5q5+qMmriL369tDkDtTe+
         6BQ4CaIgz5mDKuCr614F8v5jaYg2fJEjZmKocamYmlsMiyXLApk+61Gv00NT6lEhn12p
         yZafqCB2cR/T4qswZ6pY43or6C4WUdpIwtKErEQwlfcv4P2K/5urlCp1f9vlM2VbZMO0
         OHvqvLDAt7SOdCV+Rvzh6H/Y4P90HAsoRpAmLxDocsPwQGGdou65U99+TwcHLP9MnxXp
         kymYbJMfyycyIVJPlhUc+JN0275ozTFumrWdE5vpXsppoaji9akCC6HMbaQRE1Tsc5eG
         exQw==
X-Gm-Message-State: AFqh2kpls+hbVZ3LVCFAXBjlgx/B/T5oSrfZk2IRY5hxhJbiAeuLPFQJ
        ybQXFsXuKJF+hBKqecJTV0k=
X-Google-Smtp-Source: AMrXdXujFy2LOPaRirPf6arh4aphG8TPOW1quE5cVwOxrk1jjMoBJkSKwNXWKVmknjsIZv2gbgAjJg==
X-Received: by 2002:a17:902:d918:b0:194:4b9a:ca90 with SMTP id c24-20020a170902d91800b001944b9aca90mr8498898plz.4.1673572472408;
        Thu, 12 Jan 2023 17:14:32 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm12700852plc.291.2023.01.12.17.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:14:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Jan 2023 15:14:30 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     Lixiong Liu =?utf-8?B?KOWImOWIqembhCk=?= 
        <Lixiong.Liu@mediatek.com>
Cc:     "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Wenju Xu =?utf-8?B?KOiuuOaWh+S4vik=?= <Wenju.Xu@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jing-Ting Wu =?utf-8?B?KOWQs+mdnOWptyk=?= 
        <Jing-Ting.Wu@mediatek.com>,
        WJ Wang =?utf-8?B?KOeOi+WGmyk=?= <wj.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andress Kuo =?utf-8?B?KOmDreWtn+S/rik=?= 
        <Andress.Kuo@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: cgroup user-after-free
Message-ID: <Y8Cwdsk5pYNd8fX8@slm.duckdns.org>
References: <697032f2331a92eec0e03e85e46cb78bd975a788.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697032f2331a92eec0e03e85e46cb78bd975a788.camel@mediatek.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 12, 2023 at 09:48:55AM +0000, Lixiong Liu (刘利雄) wrote:
> Hi,
> 
> We meet cgroup use-after-free happened in T SW version with 
> 
> kernel-5.15.
>  
> Root cause: 
> cgroup_migrate_finish free cset’s cgroup,
> 
> but cgroup_sk_alloc use the freed cgroup,
> 
> then use-after-free happened.

Sounds similar to the problem fixed by 07fd5b6cdf3c ("cgroup: Use separate
src/dst nodes when preloading css_sets for migration"). Can you try it out?

Thanks.

-- 
tejun
