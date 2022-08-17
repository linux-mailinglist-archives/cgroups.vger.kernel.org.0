Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D46597536
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiHQRkg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiHQRkf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:40:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BFA1D62;
        Wed, 17 Aug 2022 10:40:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q16so12558513pgq.6;
        Wed, 17 Aug 2022 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=T2VfnDiJkdhY/17kNIzqsKCO/jg0LojKsxYaZr+7Rkg=;
        b=KusRphF5DTFe7mhRnFmNMOI7jOlvj2TNyhLSCDAfuKCkSZkVyILc9k4eWlCXBjo/D8
         2J2lHM41jl4/+729s5SBzsqUMEvrC57GMo+IgkG1gNUzbCt9r3jDVrQTcIU+h/Ltg40v
         /WBy0rO5O4U24ET4N/ABS9JvMy0TJRmIIIOBHh0kT93W1Mw5dEnTfEkSHdViKcuks9vK
         iLbVHtjFTztE53D3sBOZqsmTce3BHEOgwhyvwKl3adB3ENzkvc4mRxl8MlYYm94htLUG
         +Ztsng8Hqv8SEzQRYgLzU9Iy35ACCmGVIWJS/G/haSnqrp2BafNL88aZARskAu+SuQJ8
         4EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=T2VfnDiJkdhY/17kNIzqsKCO/jg0LojKsxYaZr+7Rkg=;
        b=WTM2Gwlxty95rhFveUzMKw+sukHm4RdFhDXGQ4BRriuLI7HgUyDloR70XHPdsCgb0N
         0PSkKmGcgga5I33J9al4ggeu2UYLWYksPYnc3OtvAc/mJy09z6VQRhC61U8DAsTnxdgR
         /9BVCVZmW9qiwqtQSiIEQ0qbQGmU0chynCyFdFy96xOKuBEuy1/peZjny7Tj8BuW4McN
         ZmE2XFYu8PVTi8nmOl8BldyxLmQcLlP0UzHhQsr70GFcalrAJJlUMyt0Vw67KH9nZDjN
         nNNgDMfJgLQdDZhiCccC2YZfRbkSZKihFmYEi8SMW1jdx7JVlGsapujUwVqh4fkelTlk
         Ry1A==
X-Gm-Message-State: ACgBeo3AWMfwJp8cJezvTcRneU8yPODpcHbXg8rmv2G+sPkgGgDqJ/Fo
        J7GDyU1AQot5rh25iAopxIQ=
X-Google-Smtp-Source: AA6agR6+7z7osmZv0Xqd5YkMvSapXLzjYDM02hv/ytXpbZkfU+WfpooBrrnWGc43yI1lf8QcdP+Cag==
X-Received: by 2002:a63:80c7:0:b0:41c:62dc:7d10 with SMTP id j190-20020a6380c7000000b0041c62dc7d10mr23382200pgd.313.1660758034134;
        Wed, 17 Aug 2022 10:40:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902e3d500b0016f1319d2a7sm160185ple.297.2022.08.17.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:40:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Aug 2022 07:40:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: [PATCH cgroup/for-6.0-fixes] cgroup: Fix threadgroup_rwsem <->
 cpus_read_lock() deadlock
Message-ID: <Yv0oEOXddKp+Xo1U@slm.duckdns.org>
References: <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org>
 <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
 <20220815090556.GB27407@blackbody.suse.cz>
 <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
 <20220815093934.GA29323@blackbody.suse.cz>
 <f584fecd-6ca4-4ab0-763d-2ed219009c61@quicinc.com>
 <YvrWaml3F+x9Dk+T@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvrWaml3F+x9Dk+T@slm.duckdns.org>
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

On Mon, Aug 15, 2022 at 01:27:38PM -1000, Tejun Heo wrote:
> Bringing up a CPU may involve creating new tasks which requires read-locking
> threadgroup_rwsem, so threadgroup_rwsem nests inside cpus_read_lock().
> However, cpuset's ->attach(), which may be called with thredagroup_rwsem
> write-locked, also wants to disable CPU hotplug and acquires
> cpus_read_lock(), leading to a deadlock.
> 
> Fix it by guaranteeing that ->attach() is always called with CPU hotplug
> disabled and removing cpus_read_lock() call from cpuset_attach().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-6.0-fixes w/ commit message and comment update
suggested by Xuewen and Fixes / stable tags added.

Thanks.

-- 
tejun
