Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FFC65F3CD
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 19:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjAESew (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 13:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjAESeU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 13:34:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC25C1CB;
        Thu,  5 Jan 2023 10:34:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so2870496pjq.1;
        Thu, 05 Jan 2023 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mQKhwxd6wO5ViZt789nL1Ad7LwoQ9znLjQqgKEtgoc=;
        b=PLmnhW6S/xa9/GRccEErxoGsX8p0bhIfLgXwql14zIkCBWjVtDCYlHmGQLvE31isNO
         tVJ1CstNrlD0nBt/dBg5AvGe0E4XKNhI6mbH/PilnX2lXQB/pp+BhhWNW8yWynT2ZMjP
         O0oaobYqAg4iYrn8VCx/tSwgyAud0Ua0yr6ohF4kZKd75dhVsoMcZttGL4+TkOeWxdZY
         OxFdj47cNiGxRiLzqF7l1+4VDB3dklXsdNjhJ9Ye7tTTTWMeUuRFZL+3zqzA4/gcmPnl
         3HyN+fjmR0Qo8p7Vp+g30s1g9wg5mpF96GXmubWMCjhOF5NkSs1ky6ug9HgyZyQ/DXCz
         zB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mQKhwxd6wO5ViZt789nL1Ad7LwoQ9znLjQqgKEtgoc=;
        b=66ffGGnMoNBA/BIXZ6pWstLzRRKk/CrLwXp2IBecebI2qqOApwXtRGFq2fCyasjJ14
         5kii6M0OJsqyAgkarO7eZyjkc8Ea2h9rnmxAL4dJ8qOyctEhaM8sLlD1xLYSd4IN5znP
         nRGtbKA/7F3JwCqZ5iK/h2kIBkZ6zJw66pCsVWDVm8HAGggORlqCFPghyr8YCXYV4GVv
         AdYBrruiNtsMkuSKcknSC+yGoOA7ueFg9pKlwpOH8MrwCFCY/iMymVVp6H0Nmd2g6BYY
         6yLXBgrF3kC/2/t0e1ZvbRzJutqc8uk5Z8K2djYu2Bif+eAY6D4b4f5grxGOEhTQGqe/
         8TBg==
X-Gm-Message-State: AFqh2kqOJWC4VxDaZnVQzRN/7OdlSRuytZeujLffxSeCgWL3x/XH+eSZ
        0KnA62/mUL6rl5ZuhT6VGqY=
X-Google-Smtp-Source: AMrXdXvmX1Us0U5SvBoGjqHMZ6NGd7MTBA8+mPJpg/JFx94R1r4cpxAvqL0Ss/FiBV2lzpb6aYPxuA==
X-Received: by 2002:a17:90a:d3d2:b0:226:b52e:f1b8 with SMTP id d18-20020a17090ad3d200b00226b52ef1b8mr6616291pjw.24.1672943659385;
        Thu, 05 Jan 2023 10:34:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u11-20020a654c0b000000b004a03cdc82bbsm9983912pgq.55.2023.01.05.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:34:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 08:34:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
Message-ID: <Y7cYKdOwSlfHtj7t@slm.duckdns.org>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org>
 <Y7YZnM/nqb0gxOei@slm.duckdns.org>
 <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jan 05, 2023 at 09:35:21AM +0800, Yu Kuai wrote:
> > Can you please take a look at the following patchset I just posted:
> > 
> >    https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org
> > 
> > After that, all these configuration operations are wrapped between
> > blkg_conf_init() and blkg_conf_exit() which probably are the right place to
> > implement the synchronization.
> 
> I see that, blkg_conf_init() and blkg_conf_exit() is good, however there
> are some details I want to confirm:
> 
> 1) rq_qos_add() can be called from iocost/iolatency, where
> blkg_conf_init() will be called first, while rq_qos_add() can also be
> called from wbt, where there is no blkg_conf_init(). Hence it seems to
> me we need two locks here, one to protect rq_qos apis; one to
> synchronize policy configuration and device removal.

wbt's lazy init is tied to one of the block device sysfs files, right? So,
it *should* already be protected against device removal.

Thanks.

-- 
tejun
