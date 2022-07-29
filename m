Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02C58570A
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiG2XCb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiG2XCa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 19:02:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38987215;
        Fri, 29 Jul 2022 16:02:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so5771370plq.13;
        Fri, 29 Jul 2022 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=yzM0hFgBu1xt2XGwoIjXneNwzi+RimX6tpHZJOB2AP0=;
        b=ir7GiNB0OtmgqVQSXzwqVX4judqnkcrnIfnBM7W7//ath+Cf1M9QQr/nih9LwFKQhd
         Xa4dOdcLKH8PZYbt4jwaD8IxZge85e0vQBo1HoGBeCy0J7BiW1VeySTnbOVYrkoKX+6A
         7+0JYNE4fig26gCwwxYFXn+qMSK1nzbz0xe2LB7wSIoSRGW9ueeAsfCfUhormv1+RLqo
         LswZMbiHTtZQuUUrL7PB4EvbYbY9X5obMCdQfUCL2+toUnPip+XOfakHrnwvbAiZL2Ix
         Urh2Os7d4+lQrYQRdzS0KgOU/Ic+0mJ2o30wS16tCE9fM1uwsSN6rTl+ps9VgczAo/2l
         gTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=yzM0hFgBu1xt2XGwoIjXneNwzi+RimX6tpHZJOB2AP0=;
        b=tPOfFVIDBBaHaqPRIH3ccp3GyIs4XOfC0lfewCpQ/OP60OV4BAAsC/dXaHxeWtb2La
         HA4aVB6Wu55QXYf418BqNUQBBbYr3Kx7D6XZGrfz5HMVxbGflB4pfc001EuS7JVMfQC5
         cXFq5z8LSXUL6kWDc/zFJa+TC+8LvogvSa2I4SLmQInIjzZNvFKjSFuMyUILQePp25P8
         eXNXiaogy0ydo6TmzySovMMxJRrjiQUrDwjJrhpVyh6IcJ2XPpU3Ab49nEnvegO99Izm
         jYEh9MzOWpe/tBGEVu8oTowqRVs351oS8AhgYVAFCxGKVD4QmmlZXw5RYNhr929Qweqi
         22/A==
X-Gm-Message-State: ACgBeo3w/7bSJd5nC0TEzv7Bb4qNyMArAREV1eRQHAG4W3bfJoUPFvZb
        mYAyzWuU25hKfT2e/Ish4eU=
X-Google-Smtp-Source: AA6agR4JUutFcoRxZ6GluGT+YeEGvzGq8+IsI2NnGrU696TA5ppnrURTd2RCObDkpjQ8nrxrV56TXg==
X-Received: by 2002:a17:903:1110:b0:16b:6968:1d08 with SMTP id n16-20020a170903111000b0016b69681d08mr5994440plh.3.1659135748891;
        Fri, 29 Jul 2022 16:02:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b0016c38eb1f3asm4097730plo.214.2022.07.29.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:02:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 13:02:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH v2 cgroup/for-5.20] cgroup: Replace
 cgroup->ancestor_ids[] with ->ancestors[]
Message-ID: <YuRm8s/CFmGKYPc1@slm.duckdns.org>
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
 <YuRJ7uzKY5/fokH5@slm.duckdns.org>
 <YuRiQc35guAWcbjt@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuRiQc35guAWcbjt@blackbook>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 30, 2022 at 12:42:09AM +0200, Michal Koutný wrote:
> On Fri, Jul 29, 2022 at 10:58:22AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > @@ -520,8 +520,8 @@ struct cgroup_root {
> >  	/* The root cgroup.  Root is destroyed on its release. */
> >  	struct cgroup cgrp;
> >  
> > -	/* for cgrp->ancestor_ids[0] */
> > -	u64 cgrp_ancestor_id_storage;
> > +	/* for cgrp->ancestors[0] */
> > +	u64 cgrp_ancestor_storage;
> 
> Just noticed, this member is (and was AFAICS) superfluous.

I should have changed the type to struct cgroup * but that's the space into
which cgroup_root->cgrp->ancestors[] stretch into.

Thanks.

-- 
tejun
