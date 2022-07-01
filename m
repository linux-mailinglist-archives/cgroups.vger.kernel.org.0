Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E634F563B05
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGAUPs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGAUPr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 16:15:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439DBE35;
        Fri,  1 Jul 2022 13:15:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7464130pjl.5;
        Fri, 01 Jul 2022 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FKcO/SCOzVEFqjsxTXwwvXLK9141GPhQIT81OrUhUD8=;
        b=GLj2L+xs0nzM+HVU1wsfkOPJDQ6JWIefMw43krHXTkq/Ez2BSuy1s2nxPvy+dPmt7K
         Znt15z2omq0hydFdGh9v2Ism2wVYJxpiajCUt6oZ4ktj7yX9U5hiISqfsvrY9tqrZtWE
         dPZa46JpmGQ2RoUcPDnDhnQfc4aGUYXXGRkLunZx4ktENzcX37VwLgFrxERNffW87PkX
         dvb3atYQgmpzWFDwwlXtJlxjFC+FG8xipe5cecfpI5CuHVIDIujMmlJrhC95Z9OTTKHX
         S1+vgjWLUoKkvncK721jLfm25KwmjC+RQXzdOEjDR0/C8fgugv1YXSvvb9m/Aq3bgquC
         eO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FKcO/SCOzVEFqjsxTXwwvXLK9141GPhQIT81OrUhUD8=;
        b=eto0697RowT+gygG7f8apE470qjQE4V4c6kzgtX0LpUQCjImeqqnOwE+ea3uqU20tk
         TJ2utG5auiROy+vf5s8j/KgHPB/eVVEwRa/5+XdMvL7HnxtJRpk1Xf22PEzn2hyNaBA6
         aNVK7VSH+nLtCRdk9KTp5Zf13kxcFAtv7vKWJnU5oW+hETdOkPTw6pdo297mpyj6lQv1
         i6lTf9R90pqkNmTMnq7dML0vZPWylMXo2MJ8NgofO7TuKtsVqfrVmP4OYsD2dLh0i/0h
         mOtPDMgyXWokVzZXGbqDLZS0iGbef2UIQAt33nKCVxApGURS7RxDQa+zaQYWqA+Oy/Zd
         XORA==
X-Gm-Message-State: AJIora+QEwFc02iPL0EW3uvFq3Oe1HClKYyU9adTzybia0ljAanMyF9S
        8rNFLpuiOL+igeOml9xZsxI=
X-Google-Smtp-Source: AGRyM1t4vd7G3/usLB/KzZjKx1UCzOw6QfDEyavD0a7fud4+TTeySuVaNJg/ehBVoqOCGE4bWpQjpw==
X-Received: by 2002:a17:90b:38c3:b0:1ec:cb07:f216 with SMTP id nn3-20020a17090b38c300b001eccb07f216mr20770862pjb.168.1656706546455;
        Fri, 01 Jul 2022 13:15:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b551])
        by smtp.gmail.com with ESMTPSA id 63-20020a621542000000b00525204224afsm16302911pfv.94.2022.07.01.13.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:15:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 2 Jul 2022 05:15:43 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        vschneid@redhat.com, dietmar.eggemann@arm.com, bristot@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>, mgorman@suse.de
Subject: Re: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
Message-ID: <Yr9V755mL6jr20c2@mtj.duckdns.org>
References: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
 <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
 <f0f55f89-14db-de29-c182-32539f8d4e4d@huawei.com>
 <xm26czeoioju.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26czeoioju.fsf@google.com>
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

On Fri, Jul 01, 2022 at 01:08:21PM -0700, Benjamin Segall wrote:
> Yes, fixing (kernel) priority inversion due to CFS_BANDWIDTH requires a
> serious reworking of how it works, because it would need to dequeue
> tasks individually rather than doing the entire cfs_rq at a time (and
> would require some effort to avoid pinging every throttling task to get
> it into the kernel).

Right, I don't have a good idea on evolving the current implementation
into something correct. As you pointed out, we need to account along
the sched_group tree but conditionally enforce on each thread.

Thanks.

-- 
tejun
