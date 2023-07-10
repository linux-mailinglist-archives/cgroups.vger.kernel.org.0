Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476AA74DF31
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGJU0k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJU0j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 16:26:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C4197;
        Mon, 10 Jul 2023 13:26:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8a462e0b0so24350845ad.3;
        Mon, 10 Jul 2023 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020798; x=1691612798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xgjrQEr6levT2Vh4gm5c8CAJzd+VPW+vgoJrm3ih5I=;
        b=EsZBIRtDuJuW04K32p8u/Gh+PXrCbedviP0ImFheHGcG49q0PAmTdS14ZtPsv3tQPJ
         C2MOrVq12H6sUuqpRZVJ7+Bs31Dbfpff0lo5Ky2t08zmkpl4ff9SJCK5zyq1Z7o5AnS5
         2yBQk7FUrYUVrVRVMoGN2jrPiRpWjveMsSZPeQZPlkwXbmvTbl2Ja2/GTaYZ6+IDnFrb
         FdbtcgZFOPo2OcKcUcok4j4ERb43A7D+mdssF3rSgzA6JOYnZBbCo1AllZzg/nfG0UjT
         zbvbaw1mXEngcRIU4M2bK1clyOetrCBqjFhDmPNWzps/4bqGCwLXvJb7bJ5pRBVIr2lf
         L5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020798; x=1691612798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xgjrQEr6levT2Vh4gm5c8CAJzd+VPW+vgoJrm3ih5I=;
        b=Nb2Pewt7NZpU3tsgdFsG0p/2TWFItSEKvlh6XenXiLotPZO/oD/3wXj/D/zIix44el
         xboVNo7E+sU0xh//nDSt2f15SMhR9Z4xiG8jlB+uSfNyntjSwc7byzrL2hMozqnfqwU4
         +HSEevbtFEptFZkkV5xjdt2kqalTYrmnqeE+r3KFvYEBlmd4Eza/aT5IT8/xztsV8qyW
         /VLdCbXHj5K4Si0XrmNFhpZMN0+dZCVYnIHq/yMm1MF0qLH1DbCgWfn42Z1ySDC8IhoT
         DO9F0eT/3GhT4xVU0DD0OSlY8ai2KbjX0qdlRDr8dTjWz+/MqVZXQLUT0jpt3pQgd58R
         zIlg==
X-Gm-Message-State: ABy/qLYUIY/ycbWU5izSPzzt4fKvAEQ1jP6D/iU+v7Myz+ovXPBunbDb
        CIz0GyfBxDAipwbeqwuCUkA=
X-Google-Smtp-Source: APBJJlGKZz2PSudUa6YDGl5Te6sz/BeLWDf42vCWm4nGwak/qh80AkAlyjnd4zusmKOjd0J06m+cDA==
X-Received: by 2002:a17:902:758b:b0:1b8:5aa2:d17a with SMTP id j11-20020a170902758b00b001b85aa2d17amr10531955pll.7.1689020797760;
        Mon, 10 Jul 2023 13:26:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709029a9800b001b8a3e2c241sm316348plp.14.2023.07.10.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:26:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:26:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     longman@redhat.com, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: avoid unneeded cpuset_mutex re-lock
Message-ID: <ZKxpfFeUVc3IKL74@slm.duckdns.org>
References: <20230704120352.1226787-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120352.1226787-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 04, 2023 at 08:03:52PM +0800, Miaohe Lin wrote:
> cpuset_mutex unlock and lock pair is only needed when transferring tasks
> out of empty cpuset. Avoid unneeded cpuset_mutex re-lock when !is_empty
> to save cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
