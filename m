Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA416366CC
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiKWRRY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 12:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiKWRRX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 12:17:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902DF59FD9;
        Wed, 23 Nov 2022 09:17:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso2406992pjq.5;
        Wed, 23 Nov 2022 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBz/jPEo0AdygTb0AMG6NqgeBrl1ABCdg1oxZbrfO3k=;
        b=c0ud+PEDpPrVVxb2HtgXI/Cy/uAjLetHga7MsVSR0VVQeQKxY2YLimB9yXCvuNQvW3
         nOxOU2OgeEMc5K/bz9SnyvZ7wOZb3EA5ey7ks9SXpi6Fe59HZ70cZvIEOOOAGqMHU3kp
         yGUOQyDbVMW2DpjTANip8QhOCPxkvmjSqWINcfvOI7BPFwTUWrx2BI9XwYMi94BVH9cI
         IlgjkVE1J1mHPovoNjiUWlUlqkR1HKziHkr77ZZHgyLU+xeawTkeBmPgPWYuVRCGb3Sk
         eyGWY8qYCdrB6eppQNYpVRoXOVlpmYn2xwC4FzruO4qJ2UYAaVw+srAC+lqFDLNQIygw
         KUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBz/jPEo0AdygTb0AMG6NqgeBrl1ABCdg1oxZbrfO3k=;
        b=DawfP2z+ULUeJAmrB7MwLFFEuFfjk/Vthixf5cHLrQ2hLfKo+2c90cRjzpsst0cGG1
         CiV64P5Bw9IMIStXRsW666IX7odLo28+/cxzsXJvTnnoOauZzV3sb7ZUg2NsiKVeDTi6
         o5ZFS7ybVdqPja6cPTTDg72KimOxz2jvv3TuxkDyjrpLiJRJmu5OqO2CI6w3IlE/Y5dL
         QugHFWwDU0ex6IypqhYmZQd+CvyAco+ZSBTj6sx5boUOLLBiBegYaKq4rOcLoCzFF2pi
         b3VvK83pBG0ycfgaarGneBBzIxM3N2YhHUMxTq8L3EGEcCIiPednHCi8d8P4rkq1ZCj1
         vasA==
X-Gm-Message-State: ANoB5pmQ4ltqVeFEakRB0QfaC4CkbSw5AuBkGuFH1HSu9An4CvHnqYWc
        ZBaKI0OpEWZlhrrg+uI/D0g=
X-Google-Smtp-Source: AA0mqf6GKGFrg/mjNcyN7caifjOfPclv+6AD8EFQHD+T7+p25AIciQWzA2B+ElxuoHBPpstN43zptg==
X-Received: by 2002:a17:90a:5317:b0:213:95f:d37b with SMTP id x23-20020a17090a531700b00213095fd37bmr37026482pjh.60.1669223841989;
        Wed, 23 Nov 2022 09:17:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0017bb38e4588sm14644241plg.135.2022.11.23.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:17:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 07:17:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     tianran_trtr@163.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, brauner@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup: remove rcu_read_lock()/rcu_read_unlock() in
 critical section of spin_lock_irq()
Message-ID: <Y35VoCelSK7b8MOw@slm.duckdns.org>
References: <20221123144514.21178-1-tianran_trtr@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123144514.21178-1-tianran_trtr@163.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 10:45:14PM +0800, tianran_trtr@163.com wrote:
> From: Ran Tian <tianran_trtr@163.com>
> 
> spin_lock_irq() already disable preempt, so remove rcu_read_lock().
> 
> Signed-off-by: Ran Tian <tianran_trtr@163.com>

Applied to cgroup/for-6.2.

Thanks.

-- 
tejun
