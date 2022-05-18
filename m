Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6152C00E
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiERRDZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiERRDW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 13:03:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C71A7D03;
        Wed, 18 May 2022 10:03:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so6231111pjb.2;
        Wed, 18 May 2022 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PZ3XZrh23YKpTQBXyyyesP7NAmJ1EfYKnoyuawcBqe0=;
        b=KmBqcA1c47T3IqI7qZnw1e+G/2uUP/yPiBVthOYegGBYFrAV2UMc5bEMEgTV6HgsWp
         t8IkHzeKyzZPhYfaWgyvHcdIJQVOAXJLzN0+itYeOk9GovPH+YSIUgZEDWZAou4QOkzk
         YDJPG7mP7PXJtPo3gRnGq38utyS6abWidyBu7oi+CHp72goeRhVSqbkmhk4fVaRM1trU
         3A6G6h3ZNAvNBedbycotR2kbrX1yI8Tw482ONL+6eQ2Ks8SOJ9KJHljlVNpoq8pIqPBm
         U0NydR6B5CUyEWH2xtrHCC4N8SP7xcoXylwoXoqjkFx1QO1b4+cWX+w34V9fTyTD360m
         lovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PZ3XZrh23YKpTQBXyyyesP7NAmJ1EfYKnoyuawcBqe0=;
        b=4+nXFEDfXFn8G8WzQQZtEDviKnXsUE69G8fVbWgU5x2TK+ddVFoIQerWBnQ61uNa4G
         tUD9nYjA7MENXEXnjN0vTuSYvHmWOpW864Ij3gOs3oV3PTgWz4knme52/wHwuhICTFiy
         WfHim9AqMHKts5tfHJ4BoqtPpYgc8d1J+UqBDvp4NLpIySbyD0O/UF69/SgrEjpQKbwK
         YD6Epwwql/dgDB1wtXmHQs7XtcGO57ADyF8Zvv3JpeOERH4k/BHPMUJcPARXgn2+gsP3
         1FYA9E0pWV3AmGANcpODSK03fD0Azmflp8u6+nxU5ljl57EDt9MnEuThNCtBK9Sj63x8
         lULw==
X-Gm-Message-State: AOAM531+SSxpKCLvnzL9g2r6cuMizLSjt2Wj1XJNsZbpm5oc2nCpmnVb
        W1pWSNiRPCc+jTIos2Uxyq0=
X-Google-Smtp-Source: ABdhPJxMUPGzRXnZWP6WUfxo7HXCyZ/M7IlOcVmCdD9RGsk+j1KdJGr0BLqQ+wNNEPdDJdJ5Al6k2A==
X-Received: by 2002:a17:90b:4c48:b0:1dc:a631:e353 with SMTP id np8-20020a17090b4c4800b001dca631e353mr391634pjb.218.1652893398720;
        Wed, 18 May 2022 10:03:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b0015e8d4eb1fcsm1957970pll.70.2022.05.18.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:03:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 May 2022 07:03:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Make cgroup_debug static
Message-ID: <YoUm1C9ozORHfFk1@slm.duckdns.org>
References: <20220517112523.243386-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517112523.243386-1-xiujianfeng@huawei.com>
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

On Tue, May 17, 2022 at 07:25:23PM +0800, Xiu Jianfeng wrote:
> Make cgroup_debug static since it's only used in cgroup.c
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-5.19.

Thanks.

-- 
tejun
