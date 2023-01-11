Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E266616B
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 18:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjAKRJK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 12:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjAKRIH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 12:08:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA732E8A;
        Wed, 11 Jan 2023 09:07:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g20so11887219pfb.3;
        Wed, 11 Jan 2023 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4Ltazrwl/l2bFldORo8VUeEFxLxrMEFR8+gfbzAdUs=;
        b=UFZI8xA6j4lfGzbM+8ybzfcwAYyEF34IaXTIqMSvwvftTCWP9LC1faQd84iRVL4+jV
         FLLFGnk2vFj2dT7UTT/jZmZqv9xxQaMdNmr6o3vp+pNFs6pHSg4wt6q2qm5D+6yEum+6
         +L0s467ooed8epoM+osT2be4A08T70dM2vdnbZzqgbN3DFR4Jc6FPO8L6IyDaEH3rAb9
         QiY91aVQ4jjoTHOrJ6Wc6CW/AazOVENVedlX5hIL6lyuP4QZzHPqJQBxIEB1szKpOG9z
         tRjimvJNb8NkZCYdxnLQPTfKuSOE7dNaoUqA1zdGxvfSp5vCrEiemfAFc6a6vdxQaSw1
         83qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4Ltazrwl/l2bFldORo8VUeEFxLxrMEFR8+gfbzAdUs=;
        b=jVHHu3PVqtH2lco0bBhFfugVzFmOTvtzidRAk/QQL0NsLRVYQFesESn2u61W9LH9KH
         0fpoC1Qu4AnPMu4Wqwh4NKcgyQIsiJDKSTbyZGe+erDz2T7K+/nbnmZkL2kreUNoI655
         RuOLdcaeLSOyvIuiZ6ecpdopoYtAN0SF2IuYi28hQO56SGNYeIVWxGYRphgDYXIyOzey
         51MIQjKR9EBTKNUKOuoHRsx74s7vRRwnVWSTHtmTQLj3Ce4/T43bozAqBZJhFtcPPI03
         TKC7XWL+QC3+GrAzlBNvtaVePepj/D8o9GJOv7ola6GSqDFsV/arcgN1udTYw94dqB+v
         zQfA==
X-Gm-Message-State: AFqh2koQCFPKW+5CFhH6bexjGA11c6asbZJpmErd/OMeQEF+p9e65Uge
        z4NlR+bHY/qxaJoNoahQtVw=
X-Google-Smtp-Source: AMrXdXtiI2reTRu1AQ/aiUhAHnp5TC09nRddU5nz7s1IqWJh5tkSo3DpQagIATPbk1HXW/CebTkkWA==
X-Received: by 2002:aa7:9156:0:b0:57e:f1a2:1981 with SMTP id 22-20020aa79156000000b0057ef1a21981mr77900899pfi.8.1673456850823;
        Wed, 11 Jan 2023 09:07:30 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w9-20020a628209000000b0058a72925687sm3809664pfd.212.2023.01.11.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:07:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Jan 2023 07:07:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y77s0f741mFfGlTO@slm.duckdns.org>
References: <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
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

On Wed, Jan 11, 2023 at 09:36:25AM +0800, Yu Kuai wrote:
> I'm not sure, of course this can fix the problem, but two spinlock
> 'blkcg->lock' and 'q->queue_lock' are used to protect blkg_destroy()
> currently, add a mutex（disk level?) requires a refactor, which seems
> complex to me.

The fact that the two paths can race each other already seems buggy. e.g.
What prevents them from running pd_free on the same pd twice? So, it needs
to be fixed anyway and the intention always has been that these callbacks
are called in the correct traversal order.

Thanks.

-- 
tejun
