Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD250A91E
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391767AbiDUT2q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391610AbiDUT2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 15:28:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832B4D270;
        Thu, 21 Apr 2022 12:25:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so5883581pfh.8;
        Thu, 21 Apr 2022 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBrbiWDBHEqVzD/h6n2uk0w0Vf7EqWqgPo3W9iAFxx0=;
        b=HTZ57TThs2gZgtm09J297EO0M3RO62RHz/zVoetmYhSGSzXIWjGtQNVlcT/am6ElqW
         +cTLNQXaPDGTicHPztmAQxL3KOlCa0xow9uOS0FV7+JXKwDeZShuUEbBQiE0Rvus2mm5
         eLMesI2o5ptZFTctQwjDDGBVhqCeowgcfZNMhAiMxUibIPc0sbqguwSOhdL28aF/wAhR
         OZ5HsLcodEdCdqfjUtovF9t5paSvEko+HnTNyqgzeng1bpWq/xgmjewQjuDsQDeCZo73
         Hqyj9I01JfoH0aaOvVNTvMQISmhsF50hwZGJaZUherneAHdfPc/CDIR4kCzKfbNxpgrg
         5ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cBrbiWDBHEqVzD/h6n2uk0w0Vf7EqWqgPo3W9iAFxx0=;
        b=0+EBFbQC2kVJpggDuSgsKAxBIWswb38o0V17mfZymlkzF0K4qG1CZbjxEZF7lN+A3V
         TQaeREQxT4u4RIxHYzCtZm1pnrkrFdUkWV5m3lsgSWA7RsTzNOasHw0+FE4dld/IVxPX
         VaIuDlfKHWxFNhQovx8Yyi2huNX7O4vLtjamslfodyXN+vgGvT/P+KIW5MUKy8yB3mDS
         W2jWAPb86n3+ICPFdNEwpptnbtAhLsMfgEK5+oY2zQTolsCf6+pthIdOwQDXkFumpb8W
         W7qXsVr1FgI4bj7/+/5p5GpsWXUWIZBGGd72xb9b/zbebu8NFeQ8+RjQ3yTXkNWQudv6
         rQWg==
X-Gm-Message-State: AOAM531isdSk7DvXdRzUWgOKV06jLS5J5qpJuuRAjOzhXsupfccU7IR4
        M8vzNGzC4DzruAb41nFIOZM=
X-Google-Smtp-Source: ABdhPJydgd/xmb2yR2CCAMjNeInbLx5JdrgHVbwNiCA8VKBZYu2tb2FGgUU1dxdUfy8WyP5TnL9L3A==
X-Received: by 2002:aa7:9522:0:b0:4e1:d277:ce8 with SMTP id c2-20020aa79522000000b004e1d2770ce8mr1170604pfp.16.1650569154975;
        Thu, 21 Apr 2022 12:25:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2c86])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm14868920pfb.189.2022.04.21.12.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:25:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 09:25:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 3/4] MAINTAINERS: add corresponding kselftests to cgroup
 entry
Message-ID: <YmGvwPIAA1LqCcku@slm.duckdns.org>
References: <20220415000133.3955987-1-roman.gushchin@linux.dev>
 <20220415000133.3955987-4-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415000133.3955987-4-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 14, 2022 at 05:01:32PM -0700, Roman Gushchin wrote:
> List cgroup kselftests in the cgroup MAINTAINERS entry.
> These are tests covering core, freezer and cgroup.kill
> functionality.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

I suppose this can go with the rest through -mm? Please let me know if I
should pick it up.

Thanks.

-- 
tejun
