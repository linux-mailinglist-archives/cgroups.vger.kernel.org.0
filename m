Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B239D583302
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiG0TI2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiG0TIO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:08:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8961B31;
        Wed, 27 Jul 2022 11:44:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b133so16870430pfb.6;
        Wed, 27 Jul 2022 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=om6BXy1+SA87/CyEYzLsfCaTtqizfiZkOOEb0xpUUBA=;
        b=B7/ER0VlJBi4Wqn6vZTg4IUv5o+ct1e++q+yV5mOqrDaPKS3wfHQVW1mQ/WfT13sbj
         PjX3ewiWbtX2QMD8qJrELmgFn5JY2jozltHeSCumUdlF6S6wAcFFTt+CbLs9JLMM/zbM
         OrvrvcthcbZDzrTRYY3MlZsImCnihzTJAQ2UMDm9P1thCMUJe7g69uEztIlHwKUJi7+8
         lQzgfVN5rM4l0MpEflVgy5AAbZOcDEwCxM3wFWKM940MOQFcQwU3mGJk4FDcby0kv+w/
         Sqxy21ZI6VoXDQzErkTC2yEw7n/V6LcETt89rlh0v8127+MFzwjRMJHen9+7RsVp3EY3
         XiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=om6BXy1+SA87/CyEYzLsfCaTtqizfiZkOOEb0xpUUBA=;
        b=rn0/oOOo0mB94qT7xee/gjMdv3q9GYFFM9x+dOB6/X5wzDYku7kJZ21+Ulq/g6Acew
         F9ZeSj9JAAtpucv0vdkrJfm2Y1ok7aQKoJq3g2JzLMqp2YcwxagegpueNnvVtf/F02ms
         khtOoVW3N5RkrmigFVjD9Be0nqRGBzrLrAiF7V2f1D5//Jetq4nxucTO3xZhpYgDVOvU
         sayOJpXsyN6Kh9ZLI/sSyoR9UztUOL9bzlGJYeRON1k6YmvOdABhupN3V7PMsD2bdrqg
         QJ4bumxV64XPQZNx7uDvj+QIbbxfCIB6M0aP+B2CLrWQd/DITiCG1pEugSifh4slv8zH
         TpCA==
X-Gm-Message-State: AJIora/UdebAj6jcX8jXFinW95396GXv1FcTuYp7ZPQHC8jFNo3jhyk/
        IxPVgts89ktJvdppXGHSszQ=
X-Google-Smtp-Source: AGRyM1tveaaJIUdeJQ3voQs/C4iVq+FCkaGjBMCwGE4eIDBbabbJr2KvV/+/cfMbU/DU6ZpXPots3Q==
X-Received: by 2002:a05:6a00:2312:b0:52b:928:99dd with SMTP id h18-20020a056a00231200b0052b092899ddmr22973465pfh.77.1658947472107;
        Wed, 27 Jul 2022 11:44:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id bi5-20020a170902bf0500b0016bfea13321sm13969740plb.243.2022.07.27.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:44:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:44:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 8/8] blk-throttle: clean up flag
 'THROTL_TG_PENDING'
Message-ID: <YuGHjf9MWjirOWcm@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-9-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-9-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 01, 2022 at 05:34:41PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> All related operations are inside 'queue_lock', there is no need to use
> the flag, we only need to make sure throtl_enqueue_tg() is called when
> the first bio is throttled, and throtl_dequeue_tg() is called when the
> last throttled bio is dispatched.

Ah, okay, so the prev patch was to enable this cleanup. Can you please note
so in the previous patch and also that this doesn't cause any functional
changes?

Thanks.

-- 
tejun
