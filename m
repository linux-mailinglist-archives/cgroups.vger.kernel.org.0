Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849B63E2B3
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK3V1c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiK3V12 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:27:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88869134D;
        Wed, 30 Nov 2022 13:27:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3230622pjc.3;
        Wed, 30 Nov 2022 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaE3ZpzHZEl5tZygmK1eZMJQnqTDFVpbnuVQbcFSMpo=;
        b=fhIxIC91fJgssn5wrwTNqq2fpyPkj4ANNZqyK5aq6JD3fM2trj54irFW0Oq/ERk/Nn
         b1tPCOESjVmOvMZG+fWJ71rfAKe3GHNOcRwxq5IvtLDZOLCrmI2q86+BYBXT6pkGoeVQ
         Tfhj7nSBa4GAViv6nN5JqGHgWk+aM9gf2a8+UMUxzWMiqWvXhVf4xFfOGHZS5Gc83q5G
         7dDMVAAB/4NUbVZcnYIko8IDx3VGepkVRv54w/gX8LGgr+CoCxYiSyyd5JEhlwdVExIw
         zRR2BdjyjZxXMPGlVt+OebFF2GWWFXcjOgQ4c/Zx6t1rlDIwXTyzq8RJ/CXuLB2Lpcq0
         idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaE3ZpzHZEl5tZygmK1eZMJQnqTDFVpbnuVQbcFSMpo=;
        b=GjC5tK2TnyfhfUR1OPjfLwlnjAqFX1VKLWc5ff06ajcoROgsyUmM+7ok13cWxmkAVb
         VlZzo7IGYdIqJMwCNMOolZkvUB+mmJP2PIOlQyJN++h/PGmScjCu95wOux9jzCRxJ6Vu
         p7/b6P+1d9WrN5+SoZLuOYNARzGGvCFJRkEzweyTAoQOb87JH1HK0OxgzIapodwacFZU
         nNr/nAe3ZKZu+trBCKfWnESd5y37RTjYYZGUJ43uOmWwliUrkGVBnyy34HCBMgyRBLuJ
         Gb9kxayNnORawT9eutX+i+jjUgxBJ0IfqDMsL7yqY7KJJGrXLhpp68DaTVfeAfmqnlWX
         3ETg==
X-Gm-Message-State: ANoB5pnWtslLJYwSWVkb7ML5sDdHPmdvbrFsUtdRBoSc/6GKqFukUbPf
        sWrf0hC+3iihkX2X7S3kil8=
X-Google-Smtp-Source: AA0mqf7PIIPwmZ/hR+lg6UdJlfTzdW3wVbJB7QtSJ9YhUNtJkRrWy9VO0T7uE1X6X370e1tYNaBbyg==
X-Received: by 2002:a17:902:ce86:b0:189:48b0:807 with SMTP id f6-20020a170902ce8600b0018948b00807mr37294564plg.81.1669843643034;
        Wed, 30 Nov 2022 13:27:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b00189a50d2a3esm1916569pld.241.2022.11.30.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:27:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:27:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] blk-throttle: correct calculation of wait time
 in tg_may_dispatch
Message-ID: <Y4fKuZPlfhf3+eUt@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-5-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-5-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:41AM +0800, Kemeng Shi wrote:
> In C language, When executing "if (expression1 && expression2)" and
> expression1 return false, the expression2 may not be executed.
> For "tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
> tg_within_iops_limit(tg, bio, iops_limit, &iops_wait))", if bps is
> limited, tg_within_bps_limit will return false and
> tg_within_iops_limit will not be called. So even bps and iops are
> both limited, iops_wait will not be calculated and is always zero.
> So wait time of iops is always ignored.
> 
> Fix this by always calling tg_within_bps_limit and tg_within_iops_limit
> to get wait time for both bps and iops.
> 
> Observed that:
> 1. Wait time in tg_within_iops_limit/tg_within_bps_limit need always
> be stored as wait argument is always passed.
> 2. wait time is stored to zero if iops/bps is limited otherwise non-zero
> is stored.
> Simpfy tg_within_iops_limit/tg_within_bps_limit by removing wait argument
> and return wait time directly. Caller tg_may_dispatch checks if wait time
> is zero to find if iops/bps is limited.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
