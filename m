Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F06368B5
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiKWS1Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbiKWS05 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:26:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA37663C5;
        Wed, 23 Nov 2022 10:26:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so2851162pjs.5;
        Wed, 23 Nov 2022 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExI+gqwMwbbQGJtDcMkFI1iGM13TFlKZnknvNLszb/A=;
        b=J/C5kMhyMAvP6iYfcxmfKxz0cDRWDZMuBogH8Tl/MJrBTJMQNCSFeNy55eOlhBbcRu
         5CI/dw95TZFrNUjLWYdSrGz8dkL1lDQ8KkTdMJAFwWdM9FSA5o1P7H0uHgJ0bQBvwPPk
         Iy/JWUnixVn4/+COYZHzCJoAVFOWBrAsZC46J+9TW4g15rmPTePHv5rh4PiHe+Qd6R7u
         1EOgCQCHCCk5bX0BOTtYGeGn9ifVlgxgYBQCSFvPEAgPmnpxe2c6Dwtt+0Owef2fAWCZ
         PafveCoWYKs8eyh9YBTFgCrv+Wi1qpuD12PCv+fXWvPED37vvKHSGxh3SGd2LYv5RA4h
         yizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExI+gqwMwbbQGJtDcMkFI1iGM13TFlKZnknvNLszb/A=;
        b=AeXGE82NqHAmsJW38YO65FsVwGWrffBaiVDvdqtG14SdJQtylnsVG6nZ2caNPcbJjX
         3DgE/WQi+XW0XZukjNWa/IVli1iu8EdBS3+lCH8P99VCA5d8I4IiZGaATNg7lFfIfxzk
         O+rnDTPpz3A0sRnCdGKyP8xzdu/jWZjr7ddyYNTgNpNmOStfr/maR+K4bD1i5oEaOpuP
         prf8cDICepoGn0Pqo5163y4cT9flfgy8pdALG5VQPPBQ+1LHW3jaYtuBZsNaZLXCIksL
         qT04BeudurUaW9Q0u1iOhiV5y2QcX5JwBzW6ppFgz8G5qn6+GD6p8KKmYLWBGOECSmn1
         zHSQ==
X-Gm-Message-State: ANoB5plch8rvPghCGzIA+//eVhnFor18DXVSOC5WDxWolnpbqOw44gud
        i5JZXx8VyOsrieBCAvN/FBttFIn5I9w=
X-Google-Smtp-Source: AA0mqf7xLG1ulqxZAGqU59e+ANK/PxL9PMBSKbOCl2rStMVgx72bqaSo7erR14efrQunFVy9u/l63Q==
X-Received: by 2002:a17:902:b416:b0:187:3157:a0ee with SMTP id x22-20020a170902b41600b001873157a0eemr15901898plr.146.1669228016026;
        Wed, 23 Nov 2022 10:26:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b80-20020a621b53000000b0056cea9530b9sm12873819pfb.200.2022.11.23.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:26:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:26:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] blk-throttle: fix typo in comment of
 throtl_adjusted_limit
Message-ID: <Y35l7pbl6L5xksfl@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-7-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-7-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:56PM +0800, Kemeng Shi wrote:
> lapsed time -> elapsed time
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
