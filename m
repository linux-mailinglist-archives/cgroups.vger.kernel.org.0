Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D06D54EA42
	for <lists+cgroups@lfdr.de>; Thu, 16 Jun 2022 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378430AbiFPTis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jun 2022 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378419AbiFPTir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jun 2022 15:38:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91957159;
        Thu, 16 Jun 2022 12:38:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e9so2205287pju.5;
        Thu, 16 Jun 2022 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3mANjjY0moGxiXZnHLX+UHOhvERe+q5moP+dgBuCZ9M=;
        b=F9CvRl3u0bPQkegn8gRDzTFpWVRsfPRpQInrBIe0BVAlITR/VWYRRA4RaFrE1lJ1BN
         QxOPr5FPEK7ztGZKRsasgt/szMabvzttgNQVb6YRE/J+GWn8Stg4Vse23xGOe+nL0Vi+
         oiTdkNApvaHhAmQdM+bRBQxjIvFtyNw8XoGkJ3auyWS3Je5pWqzGomJkA9LODLwhvxtC
         lgo3KyUHcvXBM8/Ac5BQIq8v9JKGO45rDaVaEWSRRimbJP0SbQaCElw22ENg/zyshET3
         +xY//2BI38BXicqIzmJGJGA2wyWUMOYoi858u/xLbGZkFFq3N1UYF+2HDkHv+i3CUNjp
         AFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3mANjjY0moGxiXZnHLX+UHOhvERe+q5moP+dgBuCZ9M=;
        b=oTXBPCCPqpyfjO+jOAFbgFaPE+OUtMYhPNjFUrgocOf2vMQqzLCU4LGLfv87Sn4ttv
         wctLIqHQdh/N2gpjZc1IBPleTdF0ytJh2TOgo95SsK+su3O70A4g5pkZKMVRQpFZPapi
         qjMsAAilgtL1mZuyRZEk54tpMJtjx67IswF185XwkAaNhEiXiCgqL6KyJJ6oFZqlgORS
         Ogxusm7LvWP1vXAWdmFP/3PkLP5lDumGTddaJ0LypEJKatOiM9gZAUlR/0aTYV8ZTfPb
         /S2Xlli8v3J4ZcHixNzUAHhYLz3Zq0MfOmrwA9vlalV9cSmgNgTnrYgSCtoz5TvwBu2/
         y3gw==
X-Gm-Message-State: AJIora+TVWPK+AqDL4PPUidmmu7yniakuL5Ncg5MD2nnOsQWImCtGemm
        JeOrSqBULZAR/SK3nThVGsQ=
X-Google-Smtp-Source: AGRyM1sK5DS6R3nuQSXiuNFAv5tzrx8Y+NYiYuVnj2DYE5e2vGjO1uAj8Df9AuNCkIKdsfJrOS9lHA==
X-Received: by 2002:a17:902:ea03:b0:166:ab55:d7ee with SMTP id s3-20020a170902ea0300b00166ab55d7eemr5940058plg.103.1655408326629;
        Thu, 16 Jun 2022 12:38:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:330c])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090302c200b00163fa4b7c12sm1882140plk.34.2022.06.16.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:38:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 16 Jun 2022 09:38:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     paulmck@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, brauner@kernel.org, hannes@cmpxchg.org,
        shisiyuan <shisiyuan19870131@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH cgroup/for-5.19-fixes] cgroup: Use separate src/dst nodes
 when preloading css_sets for migration
Message-ID: <YquGxN1IWLegNyh6@slm.duckdns.org>
References: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
 <Yh+RGIJ0f3nrqIiN@slm.duckdns.org>
 <8d21e655-4ce9-c7b3-2010-e484161bdbe9@quicinc.com>
 <20220516203417.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <9a93cf2d-0efe-5a46-dcd5-7dcd8f173188@quicinc.com>
 <Yqe4BjMZRohur3UM@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqe4BjMZRohur3UM@slm.duckdns.org>
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

On Mon, Jun 13, 2022 at 12:19:50PM -1000, Tejun Heo wrote:
> Each cset (css_set) is pinned by its tasks. When we're moving tasks around
> across csets for a migration, we need to hold the source and destination
> csets to ensure that they don't go away while we're moving tasks about. This
> is done by linking cset->mg_preload_node on either the
> mgctx->preloaded_dst_csets or mgctx->preloaded_dst_csets list. Using the
> same cset->mg_preload_node for both the src and dst lists was deemed okay as
> a cset can't be both the source and destination at the same time.

Applied to cgroup/for-5.19-fixes w/ patch description fixed.

Thanks.

-- 
tejun
