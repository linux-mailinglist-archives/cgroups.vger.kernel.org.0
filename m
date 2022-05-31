Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D14538960
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 03:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbiEaBBZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiEaBBY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 21:01:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16C70924;
        Mon, 30 May 2022 18:01:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t2so3919224pld.4;
        Mon, 30 May 2022 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJogN3IYLaA0/PYlQIBsunkdnH4gONu4lSZ4HSWPFBg=;
        b=BXpzd1eUKcwVwUU83YwPDVhBhh3yJZK6vwP+l6BQ0eANXd4G4rGkMYGwVNG58g81TR
         FRdBloytdVM9FuHTRCYWZxUFPIB+TwxM8AKv+L2jeO/7ul/Hn3QGFAwc/WKRILeAUZcH
         pRIJUfCJCAzkXBvoWF1EMIwKRQEYNfCCsKCLiZHjLyKgU7eEYXodFIsGN/kDgQ7fVmdJ
         4nrdNE7+rMKUSz9p0uajY72fJ0pD9laF02Sq+4yCUL0VoaTaVOHqHh4S72+Py6RwzTFp
         EsQynD1EBpGZpOHXo2jLWQI70kH5AFlZkJjb6gOisOmAySgftbphAzvyC5JqgI2j78Rb
         R4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NJogN3IYLaA0/PYlQIBsunkdnH4gONu4lSZ4HSWPFBg=;
        b=p7dEgsVnkczHhzreJO50yL1N2qHKPsuYPHxMmAW/KnVE6qMA7/Cqaf3nEP9Lx0wUmN
         yUeAU4ETaruey/zyKtg0gtSvWVmb5pSkpVqPP8aIJcGyv9XhFtTzDrX/dGgBmgqDCXix
         DrMoYIE32VAz45AY9hphfgTdXk+eIGyXp7Ou7JigLLHVuNul5fUj7ErzGZFfdhCA8pZ8
         l4p++2m+gbX+1dVJGDJlkys4ZOG497JhsYUpxeezR+nyhSiYdN6t+lYN0YB0Cq5EWKtU
         LMxyZII9UY4BY1MRBvIJKkKP6+sFt+S7czrMKlZGyaRQKO6SKXwMHSQ8OaKNcH8yJEg9
         BlLA==
X-Gm-Message-State: AOAM532Y6kyXs+e9vtov6clz5Vgfx3Gyy71v9NFzscnaYF3L+85cf84t
        MaFHtgcRWX0lEMdN1+/ONFo=
X-Google-Smtp-Source: ABdhPJyzf7SA56LuaYJGbsLW9Jel0hQbWl2Ig9oQorCyi1+iZdXyshzcwokWBTRuaSl0qfn4G+ibhQ==
X-Received: by 2002:a17:902:704a:b0:161:996e:bf4 with SMTP id h10-20020a170902704a00b00161996e0bf4mr57900290plt.118.1653958883862;
        Mon, 30 May 2022 18:01:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e23-20020a62ee17000000b0050dc76281e4sm9327678pfi.190.2022.05.30.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 18:01:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 May 2022 15:01:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
Message-ID: <YpVo4XiIDu68w40Z@slm.duckdns.org>
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
 <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
 <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
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

On Mon, May 30, 2022 at 09:53:51AM +0800, Hongchen Zhang wrote:
>   When I test the LTP's memcg_test_3 testcase at 8 Node server,I get the
> -ENOMEM error,which caused by no avaliable idr found in mem_cgroup_idr.
> the reason is the use of idr in mem_cgroup_idr is too fast than the free.In
> the specific case,the idr is used and freed cyclically,so when we rmdir one
> cgroup dir, we can synchronize the idr free through wating for the memcg css
> offlined,and then we can use it the next cycle.

This is a micro benchmark specific problem and it doesn't make sense to
change the overall behavior for this as the suggested change is neither
desirable or logical. Maybe you can just incur the delay only after idr
allocation fails and then retry?

Thanks.

-- 
tejun
