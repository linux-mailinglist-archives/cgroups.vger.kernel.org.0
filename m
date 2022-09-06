Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41165AF397
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIFSaq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIFSao (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 14:30:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC317E3C;
        Tue,  6 Sep 2022 11:30:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u22so12084348plq.12;
        Tue, 06 Sep 2022 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=XgR/VP7NAhWauMOsrwcgIw4hBbhzAc1gPVaPVW58FU4=;
        b=S0fGy3Amy4jLKzuOHjKtRyPXTXPwsHuseA5jDpGwgXLMWKnDw9zRiwSKKo7O5Q/hOS
         LouY1sFAeHQBoDjypEXbFeLyxrjIzIiq//XsVdH9HR8vYwJl9TsrdpKS3ETQdJR7SAcb
         LDXBubAEA2lklGik3H1FSYpdt7J2XoaJlUr7sH3ht/xkgT2hAlWId1cjanJn4WNCSYkD
         qwA+UwuSZoYf5J1TeqNALYVszB4PYXcjVbLXWs7E91eAKhvFPM2byJ8TUSIrdcFZOQ1R
         xZIXH+U3kSC5zEdIPoL3lCrE1nPLx2y4A1djzpPAPsIwaqBXqYM9BuRC7NvWENr09cCq
         bLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XgR/VP7NAhWauMOsrwcgIw4hBbhzAc1gPVaPVW58FU4=;
        b=Qg37A/4vlOclBnY5e2UvksUqx/syAieGjsQ5LAw1Pb8io12JwaeCoh2GVCqHIhBWDL
         hPtN2MkHdKfF2nwAgjEKhgFkc3yYRldp+RDJTIZ3TpyJ17xD8r/2j0HuEUiKC0ClMejT
         zmmp8mt2s+tmJvNfELll/ScZO9zCJGvPwkFGbJ8ZJgatoBTavNECGoaJJ7LcOeGhQ98+
         owMxA/LddOORInEtwOxSCtimpRRj3qYKPYOUw5lmybrjk6l0L+9VLEY64MgcyqetDNEX
         sXAunKhd0YbKwSE/UkM4qmU5U2PIPiBBh7Iy0AUZRlu2r+JViNffBUNz4CDEhnufh6t1
         2aag==
X-Gm-Message-State: ACgBeo3nT9VcsQDzfBjajOyoVRMTEsHNDtnpS0ik5hrg2nhQPeGcZe6T
        XaDDlc1TzrVcagsk3utbxDPwY5Zfy7c=
X-Google-Smtp-Source: AA6agR7xwQzeEteyz/qsiN1TMQKL/kt8HG+oZBtL6gOlaPJR0iFY+K5yJ6jN1awDrocqkyJ2OZtU3g==
X-Received: by 2002:a17:903:41c2:b0:174:6cec:8d0d with SMTP id u2-20020a17090341c200b001746cec8d0dmr28511777ple.123.1662489043141;
        Tue, 06 Sep 2022 11:30:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001709e3c755fsm2588998plc.230.2022.09.06.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:30:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 08:30:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, lixiong.liu@mediatek.com,
        wenju.xu@mediatek.com, Waiman Long <longman@redhat.com>
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Message-ID: <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
 <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
 <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
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

Hello,

(cc'ing Waiman in case he has a better idea)

On Mon, Sep 05, 2022 at 04:22:29PM +0800, Jing-Ting Wu wrote:
> https://lore.kernel.org/lkml/YvrWaml3F+x9Dk+T@slm.duckdns.org/ is for
> fix cgroup_threadgroup_rwsem <-> cpus_read_lock() deadlock.
> But this issue is cgroup_threadgroup_rwsem <-> cpuset_rwsem deadlock.

If I'm understanding what you're writing correctly, this isn't a deadlock.
The cpuset_hotplug_workfn simply isn't being woken up while holding
cpuset_rwsem and others are just waiting for that lock to be released.

Thanks.

-- 
tejun
