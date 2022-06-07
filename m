Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0957F540471
	for <lists+cgroups@lfdr.de>; Tue,  7 Jun 2022 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiFGRM1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jun 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiFGRMZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jun 2022 13:12:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341E17599;
        Tue,  7 Jun 2022 10:12:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u2so16079448pfc.2;
        Tue, 07 Jun 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLGsBB+R+Y7B7KHGHWSxqZCFvRmylkKZbWB3sA14MH0=;
        b=oLvveGNDVWzqyzP67UJA4WVF9pRh7nH3lgY7otES74HwEqlpsHB2KuZ73+XbuTnCG3
         NQ0W4JcSrDbByxyqCSz5HcmIxSIhE+/6k4jTxOnoHZrf5frvi3VWiE5cnv68GWllEDaE
         /JaT35fAp+rhmFa9SnKCYlXe4HyWRnYlwAoFSrPib4PZQidKpNLVZPjfdQTwbGOjPGyg
         U/4wWGgbim+Dw47QFdLJHfYaWe2OgndP8vp9NbX00eP+SEdbgFn94eB7wuARP8te7BEE
         ihq3Cw1VCttarncMGtOKyi9Uw7SONKrvAQegMoFP7XAopWPALVkixmmK2h9s/hzVkgsw
         AWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KLGsBB+R+Y7B7KHGHWSxqZCFvRmylkKZbWB3sA14MH0=;
        b=X/j6uRNeToCNB6/NFCDinA8Db9wIx+F9eaGwXzIIvJJ5XheEfRcnweWSnPOB3XuYbB
         HxV3K3izY1y2wYsywfTsKrZ02fUPMMNbKE3hLfL7wp8s97OL/AT3TQeyE6Lu/AYkxvoo
         27116A1v6ds1j6t1de82Ng20ildPHWOKEaxn5RyE8z3lMxH6lkq089ZJ8f26ELDCrVvF
         qExmQXAhAemJFdg+LzSsovIbJwecIaGZPEpAyoB8L/IiKnM+Hif3Dayr3dSJrSqjxzbI
         EEE2rdbduO0734FsFeetHnSS26Ers0JmmWnSATcX8ojvPmPfpZEvBZP93wo1NoC90rkY
         Rklw==
X-Gm-Message-State: AOAM533SQ0hT51MkU6IvfXNtTCT7AXT03O9G0qpjZMIHZM3j0igoYjv/
        H41VqJclDKw0xgUvECcrG7Y=
X-Google-Smtp-Source: ABdhPJw/swvVhpkFaFtR2C6K6VFvPTPLIk7gQYLECmRs/XM05IqUFhwbmvSbPgoSSY/Mi5wmcjdqcQ==
X-Received: by 2002:a65:6a15:0:b0:3fd:c66:eb3d with SMTP id m21-20020a656a15000000b003fd0c66eb3dmr22512042pgu.111.1654621943998;
        Tue, 07 Jun 2022 10:12:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001640beeebf1sm12764857pla.268.2022.06.07.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:12:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Jun 2022 07:12:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, surenb@google.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: dont alloc memory for psi by default
Message-ID: <Yp+G9o2wuJNfLuLk@slm.duckdns.org>
References: <20220526122656.256274-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526122656.256274-1-chenwandun@huawei.com>
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

On Thu, May 26, 2022 at 08:26:56PM +0800, Chen Wandun wrote:
> Memory about struct psi_group is allocated by default for
> each cgroup even if psi_disabled is true, in this case, these
> allocated memory is waste, so alloc memory for struct psi_group
> only when psi_disabled is false.
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Applied to cgroup/for-5.20.

Thanks.

-- 
tejun
