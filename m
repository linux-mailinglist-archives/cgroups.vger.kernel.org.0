Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E073916A
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjFUVXX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 17:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFUVXV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 17:23:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DE171C;
        Wed, 21 Jun 2023 14:23:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-780c8df59caso15776339f.3;
        Wed, 21 Jun 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687382600; x=1689974600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4rxMNbWqvL7SlrQRGe8uFSm6XpuYw7vzKHdGgmcjiI=;
        b=MSf3PCXq6wdLohcP9gMgCzMabwUNVmiy4Osu4b3QDHklikztVAPUZkOPJaihAdm1z4
         cKDA/Zb36eDxDxF/+j92qnBpKTjKp9o8FPaqZaPw4KdEaiTPHoy8t0rCXJ/ytda3tKtS
         wUi42M5xqm0IeiQ6aF096aYo7xjYAzNDPdOS1HVoaOmwnvVVQ3GdmoT9oVj60i3UeOnK
         nBnJFEZHfvRvi++CwEzljmyCohdD2tZQ5aSD4piwJDOvGgrayNoUkG0oGTpYoN3coPJM
         aAyoM8KEMMRJgcckSr6tUgfo4L5r2FuiKEssu4ZqtvoZc2Ye5PuZw+l4sSxXQhS/NpRR
         cf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382600; x=1689974600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4rxMNbWqvL7SlrQRGe8uFSm6XpuYw7vzKHdGgmcjiI=;
        b=f1Ge2RcBheRk7v3qw5gCfwjAV4H8VvVZ2c+R15Vopt+z4PzdcyZs+qSMezshuQdk7t
         vl1acXPKKvHmFs/r6MMLwNA4+DZ2ZM10xD1OeCQejHYHRwSap9g9NnzFPFV5kKt3Z3dl
         P8M7R7jH2j/g19I3XTBYq/bv9Jw3uKtzAqGsapT8Pm0UE5K8ttDQEmN+EdQWSc9T6IDR
         cWToHaKcCrW76xyvEL2wzCBmCoR5+A+A1BtRDxn3s6nZbdt7sIdYy3epYDiIZAQeUX8M
         HkGKyoi/r9U7XH2gr67iBUNCkvHWIgl2aOG1kEZ72yE8dt4D66RGwbdfai6u+UNImg8X
         wYMQ==
X-Gm-Message-State: AC+VfDweNU1Bu6BpCcOLv27FUfLvoownUoymE59+Y8SRE2kWkdlbsrjo
        l/0m6Bq1+Ey3sPmB0ijbg78=
X-Google-Smtp-Source: ACHHUZ59vHYbRmPv7y5qCCQCB5u/mULMuwGcmFXF++o1FnUnV7zSBzGuHPvW43JW6pHWJIZSlGXThg==
X-Received: by 2002:a92:c10a:0:b0:340:774d:cf79 with SMTP id p10-20020a92c10a000000b00340774dcf79mr16219310ile.6.1687382599636;
        Wed, 21 Jun 2023 14:23:19 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056e02010d00b00341e955a541sm1581631ilm.16.2023.06.21.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:23:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 11:23:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkoutny@suse.com
Subject: Re: [PATCH v3 2/2] sched: add throttled time stat for throttled
 children
Message-ID: <ZJNqRefKRP5mxFaw@slm.duckdns.org>
References: <20230620183247.737942-1-joshdon@google.com>
 <20230620183247.737942-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620183247.737942-2-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 20, 2023 at 11:32:47AM -0700, Josh Don wrote:
> We currently export the total throttled time for cgroups that are given
> a bandwidth limit. This patch extends this accounting to also account
> the total time that each children cgroup has been throttled.
> 
> This is useful to understand the degree to which children have been
> affected by the throttling control. Children which are not runnable
> during the entire throttled period, for example, will not show any
> self-throttling time during this period.
> 
> Expose this in a new interface, 'cpu.stat.local', which is similar to
> how non-hierarchical events are accounted in 'memory.events.local'.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
