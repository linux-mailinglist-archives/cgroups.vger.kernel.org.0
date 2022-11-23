Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632AF6368EB
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiKWScy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbiKWScE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:32:04 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987FA58BCB;
        Wed, 23 Nov 2022 10:31:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q1so17448156pgl.11;
        Wed, 23 Nov 2022 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WaeNxRFAhW4+njSz3oymHAfGYjiGBjYSgTnlxkSAys=;
        b=jxxUgRm3rae626X/F21Ixmc+goaczD8yETEXBu7QKc5qDMcofymNGMqTIMRVMFSRgo
         MWh0pdG+HtHw/CoioHszw6hAOBoiZlBfcQaWru3S0hQoUOw0a150L6bPjTztvDXr6EHd
         LQHcc7w27lcEfmNURWK2YGbv5ooe00NXtY9/nHbuKrqPlRfT6GjcjDNIZQx7wHCcEeiK
         uFNz1BwW7Y/3JL5VqEoKKeLWI94+tneUv4fB0k9afElk693ZB3qerfUL+jP+GlR6/LAb
         AmqWawnah09OIwkxNg3OtH5d6XnCCa5Bp02R8mdnjDRzhKp8PWkO5lPULhVQTq8eJzxB
         cxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WaeNxRFAhW4+njSz3oymHAfGYjiGBjYSgTnlxkSAys=;
        b=qV2I9ZlBNcgVh7XNmZiRe0zt/KYqIWQ9WWH9Pl+LayIF0oQxeaZTiDAiMGOxo+rtr7
         jJHLwPJKcP5lRMx8OT0bXhZzTsLc43sVq0QvLKluoTEf7ErlDBNMlrFlQ9j1gSUJocmV
         sikYP5NpOkQh84zYGUIN8jH/PORcFP6L6LA/pjhN2DDiLezFPOr8ASioCNHJ4ABviY84
         8sjPJZMgbZ5Bg9absx0s2oRwQQ3aFcISFl4dzkGyF7nWpKhRnEkFf6ATPO+B49SFbzZr
         eNwDLWoiTaDv+U6G3rSLuvb4+jD7JXhMlSjvTAQf08c43GVaVNMhTPE3gYRh6Yvt6BJ9
         f95A==
X-Gm-Message-State: ANoB5pkXIx9p8hjO0tOvgHsRgnzsopvNf/iiVXF4uG/9qcJKfW8S/Sms
        TPGxP71G7V8nX8VSfy9EkiM=
X-Google-Smtp-Source: AA0mqf6FUu+yUZDk/M5N06NEv5Vf/o2Bx8fJlwotaqECXvlaAArqcZacDD1GVmK05av44gGaKR8KTQ==
X-Received: by 2002:aa7:810e:0:b0:56b:f23a:7854 with SMTP id b14-20020aa7810e000000b0056bf23a7854mr14683565pfi.66.1669228316945;
        Wed, 23 Nov 2022 10:31:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090ae38100b002132f3e71c6sm1699262pjz.52.2022.11.23.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:31:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:31:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] blk-throttle: remove unnecessary check for
 validation of limit index
Message-ID: <Y35nG1CguzXf0GX8@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-10-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-10-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:59PM +0800, Kemeng Shi wrote:
> We always keep limit index valid as following:
> Max limit is always valid and low limit can only be invalidated in
> blk_throtl_update_limit_valid. Each time low limit may become invalid
> after blk_throtl_update_limit_valid is called, we will check and make
> sure current limit index is valid.
> 
> It's reasonable to always keep limit index valid, so we can remove this
> check.

It's not obvious to me that it's correct and I'm not sure what we're gaining
by removing this while risking subtle breakages.

-- 
tejun
