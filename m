Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E716688F7
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 02:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjAMBPu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjAMBPt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 20:15:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FD5D6A5;
        Thu, 12 Jan 2023 17:15:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d15so21944492pls.6;
        Thu, 12 Jan 2023 17:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeckwhmPMW45EEyivIGHK4a0N0SsWyt5j7qOc0U6OBc=;
        b=ndtl4m+cWjUg2p8DP6Y6KGeN0FtPY3sZb3XcirBM9bu1GUMQlwtHJWdPmTUFEBjH+W
         XIUAK3HLuTbzGYXntgLP9ei1RopAt9hihd9sCXmIDX+S3m4WiLKxB20s+BdL0d+Bnt+m
         f64bg4YJADgNJ0PDOfwkr6Wg/ExfAOKuxfVEvWYEoHjHdCioodUwI06nhdvhNvKEW9EA
         Tsvk2+u/r6Gw1axfoe8fobRJJO3qJI0PU/F5tspG4Sw0LtZ8BrHSoinbZyriuyTAUuG5
         FU2z8ucBG280+E0t+MhW7cf22gu8oihqsRHOXzMqeFoA4eOrReWX9uZkfNAPcWFPEa8H
         Iaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeckwhmPMW45EEyivIGHK4a0N0SsWyt5j7qOc0U6OBc=;
        b=T/clD773ILtFoDX26us9JNUrKaBLFegK/QEq0sOrT5XG5STZ6zQ02Gmnx7Wn+e21qo
         3LH4Qj4hIKq/JUtwQNvIAK8y1hQ6cfUkZtD+1B4MZ7wfwnakZqqcHudfpz87cPgBhVUR
         T8XuPLsdp92duCluJBettubNQY8HFlQ8FTJcENkCcYcRYw5kseP8InU8+/DLyNX7lk6O
         1qurJnC7HpOM57DdBADui/uQsjGKivi+0KO0n1gqti7HijDVmeUN1YwrVaxLXz467oov
         tZr99Jo+zexGkHqPVRIjCvCKJ8QQA00J4TmPFoRWA2lXiTmE/C5yRbonLSP6dx7HOIak
         HWUQ==
X-Gm-Message-State: AFqh2krjANqZ7Ae7GhpXaTNovNTZdKVru8usadxtNkY1CAHTOnWQmUMy
        DFXAnjtq9oMAdu2+GkhJYfY=
X-Google-Smtp-Source: AMrXdXuVwCE4XZhZVQ4FnmI58UnA2+FikdqD98sm4q4m2L0z8gGA6L/Ommzhpfzt5aH2D88FHtQzJg==
X-Received: by 2002:a17:902:aa96:b0:18e:8223:6447 with SMTP id d22-20020a170902aa9600b0018e82236447mr75801517plr.22.1673572547996;
        Thu, 12 Jan 2023 17:15:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b00177f4ef7970sm12878409plc.11.2023.01.12.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:15:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Jan 2023 15:15:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y8CwwghZ0adMsHFC@slm.duckdns.org>
References: <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
 <Y77s0f741mFfGlTO@slm.duckdns.org>
 <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
 <Y8CrloCDGhbU42OH@slm.duckdns.org>
 <efa1c73b-e94f-373f-e535-2cfc32ce2433@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa1c73b-e94f-373f-e535-2cfc32ce2433@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 13, 2023 at 09:10:25AM +0800, Yu Kuai wrote:
> > only activate the policy when the controller is actually enabled. So, idk.
> > What's wrong with synchronizing the two removal paths? blkcg policies are
> > combinations of cgroups and block device configurations, so having exit
> > paths from both sides is kinda natural.
> 
> I still can't figure out how to synchronizing them will a mutex. Maybe
> I'm being foolish...

Hmm... can't you just use e.g. per-bdev mutex which is grabbed by both
blkg_free_workfn() and blkcg_deactivate_policy()?

Thanks.

-- 
tejun
