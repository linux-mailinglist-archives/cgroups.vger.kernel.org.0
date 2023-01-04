Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92965DF37
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbjADVqQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbjADVp7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:45:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5374263C;
        Wed,  4 Jan 2023 13:44:52 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k19so16168832pfg.11;
        Wed, 04 Jan 2023 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN9NPhWClQWUyrodOitLH/xXA1FW1Ui0r+TGvgzsk+I=;
        b=cXrEG+Rp4bpoH5QyJuX+T/ITDUTrmTAEJgtTakf8Fr9Z2UG0eudj3G1B3lDoHATS9X
         Pm6qsmfthZzQfo5pwH5129XqjfONgWZpmjQsh6hCjB+U3UFtQApzIPA0V4UIicMRHLVf
         ULndJXZPOxNjsIVje3f6lnnvitNlrJ8pNe+cARywmDSANC5W+7zE1wsgyInuVxBGp+Oi
         GDTviBGjbYgvqpnJ283V4Bso2KLNrk9rYlt6fgtCBOOOhMfEHDYoT7LyBJxXrtwzdEtt
         GgtXjLoCt0V+UpuVq8WB7HCl+4VoRTlnuxfUcdagBib6D5T5KVB0CQcjGu4of9j+dW7r
         2Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN9NPhWClQWUyrodOitLH/xXA1FW1Ui0r+TGvgzsk+I=;
        b=Jd5j4p4YRFkrmRkLQvDccQiKLvpSBYRNf2BnQgMPl5k6AOfNfnBEC/TVQUhbZVV+tE
         9AIbtDtsNBtgVraInxvYYNoXbKTsoFcvdqWbmCiQV+ftKicw7kXUSNuu2L1p+3WMTksZ
         oCNK4vDWBcx5XCZEKXi+I1kZv1pxCjFgqDa60N12gwrAAM8X1lDHwsb2PRz8gTVueQFY
         r/kibLmi8Bs6m9F1iJLSt6dW/zGZUEViEMo8KBnxeqPBkw3y3Oe1Fv2aW9mrV2nCyNOi
         xoAfGO0iDsM6J6GXtC0Q/dj6HTBd/JhnxyXvS5qXmwN2Wwp6AbF1SUQ/kCDs53FabEru
         6uWg==
X-Gm-Message-State: AFqh2koKLJINQSOW9kSqvtPctMlzCeOeUS+l5SR9BH5+EVzMRgIVCg7k
        3YZxXsKIa9TSUgllL1wyQcM=
X-Google-Smtp-Source: AMrXdXuTHCH9flQwoBm7vKxBB2ohaXZZXszddwEh2M95rh9I33uHzbvHViHclGxyaiB1f0bxZfSIHQ==
X-Received: by 2002:a62:1b42:0:b0:581:eca3:fd05 with SMTP id b63-20020a621b42000000b00581eca3fd05mr20626920pfb.16.1672868691483;
        Wed, 04 Jan 2023 13:44:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u16-20020a627910000000b00580e526cd33sm20004883pfc.198.2023.01.04.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:44:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:44:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227125502.541931-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 27, 2022 at 08:55:01PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> iocost requires that child iocg must exit before parent iocg, otherwise
> kernel might crash in ioc_timer_fn(). However, currently iocg is exited
> in pd_free_fn(), which can't guarantee such order:
> 
> 1) remove cgroup can concurrent with deactivate policy;
> 2) blkg_free() triggered by remove cgroup is asynchronously, remove
> child cgroup can concurrent with remove parent cgroup;
> 
> Fix the problem by add refcounting for iocg, and child iocg will grab
> reference of parent iocg, so that parent iocg will wait for all child
> iocg to be exited.

Wouldn't it be better to do this refcnting in the blk-cgroup core code
rather than in blk-iocost?

Thanks.

-- 
tejun
