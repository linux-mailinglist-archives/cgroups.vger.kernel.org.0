Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC205832F2
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiG0THh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiG0THP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:07:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A66C124;
        Wed, 27 Jul 2022 11:40:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v18so3647104plo.8;
        Wed, 27 Jul 2022 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=O7PRtfALKD26c9idwQS3/BsCO0uliH3vHN7FmxUyMrQ=;
        b=VawqO6rHCKwIX+rnfZ6sWjzncCv94kTQ+6I4ygjCdXlXxn9qtkAi6TZyCHWZLTrMEw
         QVeEPrmWcA10AYdsoYrYAMEDZAAnFEvgvxLwsZOOLn8nsHIe8kBItEISAAx/LNDbmg2l
         rE+TpFFag0cTUO3DPEY3eU9dfAWLSHnMaOZ4CRDNNJb4wSAGXWHC+qcm0AzkefG0gxz9
         nqZz6CQhN3g1JPQvFhxVvqBIyeX1qyVI/MdTsqZBItRdfFptrNpA21u+L9qwTzntYb4k
         RhBPJQDafthfa5LqUgj+4sTTFMY6UdeV14drKkCbjQ8wQGLiGV8bXrtwBc1Yol7utXWy
         rvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=O7PRtfALKD26c9idwQS3/BsCO0uliH3vHN7FmxUyMrQ=;
        b=AfngYLX86i/I51/BbBlqdKJ9gNPG/xRB9fveN52YdQmCgMqGvwg4aRm6uHnkRD5Tmb
         oz9MRvY/2J06OVDLSJ2LCznhY3VpD6jb5ZW5pft9GTQawkN8iTbVHw38uAr6GiSNC4DY
         hbZfWDVWOA40dDLbr2InL45/d+8Apag3ElDuOrVCGB109oVKo1xL5m48B7vNtd0oUU1B
         yzWQjmbncc8Z4W3Kd/e7ncWNF2U4knh5S36ABROs+d3rQgrG0Fh4822HP8unnuSfl9HC
         8z9moOLl0OEcgX75cfEWzCLzV37f163rhcijvRfRxhekFrqAWH6M42do+fv1I+S74aOn
         hv0g==
X-Gm-Message-State: AJIora/WH6C9tfSz06tPkAkbSyJbt4uROJGxheztA6qY76pCBr9Wz2q/
        Nr+2JDJif6pk0vZpCCc1Nsk=
X-Google-Smtp-Source: AGRyM1tjXpEouSi/hrZ2eJ68JCnaoR7TsbD/nzHvC9pzzxE6UdrFpHmQmkquXdVTtrnJKYS40d4RMw==
X-Received: by 2002:a17:90a:bd08:b0:1f2:e4b8:db72 with SMTP id y8-20020a17090abd0800b001f2e4b8db72mr6003555pjr.37.1658947248749;
        Wed, 27 Jul 2022 11:40:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b0016a3f9e4865sm14187433plg.148.2022.07.27.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:40:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:40:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 6/8] blk-throttle: calling
 throtl_dequeue/enqueue_tg in pairs
Message-ID: <YuGGrltCqPo/Fk9A@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-7-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-7-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 01, 2022 at 05:34:39PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> It's a litter weird to call throtl_dequeue_tg() unconditionally in
         ^
         little

> throtl_select_dispatch(), since it will be called in
> tg_update_disptime() again if some bio is still throttled.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Maybe note that this doesn't create any functional differences in the
description?

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
