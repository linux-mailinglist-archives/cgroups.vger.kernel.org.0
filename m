Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CF23DD27
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHFREF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Aug 2020 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgHFRC7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Aug 2020 13:02:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8562C0A54D6;
        Thu,  6 Aug 2020 07:30:34 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so16110201qvt.10;
        Thu, 06 Aug 2020 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LteJlP8Yogs33/2uiEGaGLM6yuhYrOVPJn4ZtRs/VAY=;
        b=l4QJ+RmI532zvjM5xWTnembw7sAHBExPkpfcibAnwteNcSCn8+o18CA9tyM5SyqYkA
         D97lt1UEgCP9gZdJXb2toIh0k08nTp/MnQaFMgSGtYZswjn+WmHuGLHGAhC2Yl7qHV04
         LAmBgQ2DkLermDebM23pPpfr5S1akiR3cXZkt8rXS3KBiXuaP0XgawjaNbkGjXW16m+T
         kuART3o962Obu0Ct/gZXgqiZRFAJ9+3S/0zrtuI69BtPIYug4kUCT8aqhGMpgt1QFM21
         j4j2DPyhulDwUy6r+hjcPf8hfRJyMXbviv21mXo+3jNhf/U6xWMbcAg0rF3vXfNRZDRV
         w8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LteJlP8Yogs33/2uiEGaGLM6yuhYrOVPJn4ZtRs/VAY=;
        b=Ta7koeESmBKRGwK5/to5c5U/g4tmrX5aXGo+iXW5zGw3/su7thV8eFukte8aMJZw3J
         RzoAVsvXyRXY1vvyUdobI42YWuAUsVAF+2b1iyQlNb57Q4TtS6IAkSubddH1KFOsF2sC
         7QTr9CY2/bnygbGzJhuFBme4b9qpnAaDcimjQ8fTh7zmAAT29rKeWBnLojBybREmWq+j
         9OYIUafiCavNHOETCvqnvAI6GqLaZaBUki1C/LgdnTWQ7AHnmYaLoiSz8sjEPkdcbRfR
         PBVqsuSJmYBkg4Kh1H3X6QixMJzXLRDsSx3pwL/E2pwr1EFnAL3tDEQ/BWqw3oELTkiQ
         XXxQ==
X-Gm-Message-State: AOAM532J4JBomgOvGk6aUfuUxdXv1FBAL7Map0ievROXZM3QMQWF3wu9
        zIJ/7TaHg/HX4PxcrdAuoNk=
X-Google-Smtp-Source: ABdhPJzrGitPt/+PJNzfdf75KAeaNk02QZK65suKLVFW1doQ5rA2JRXtSiisTRDFeqFIES3zdcmGzg==
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr9023965qvp.191.1596724233309;
        Thu, 06 Aug 2020 07:30:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2e8b])
        by smtp.gmail.com with ESMTPSA id m26sm5292746qtc.83.2020.08.06.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:30:32 -0700 (PDT)
Date:   Thu, 6 Aug 2020 10:30:30 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: add plugging support for punt bio
Message-ID: <20200806143030.GB4520@mtj.thefacebook.com>
References: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 06, 2020 at 09:54:42AM -0400, Xianting Tian wrote:
> Try to merge continuous bio to current task's plug fisrt.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
