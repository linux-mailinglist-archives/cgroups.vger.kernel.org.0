Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0954E756C2E
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGQSfC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQSfC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:35:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C4394;
        Mon, 17 Jul 2023 11:35:01 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7878e573827so117410739f.1;
        Mon, 17 Jul 2023 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689618901; x=1692210901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goViAJVjt+VltPBDimAYth5M8v49WVfPG0UW7xjQVYs=;
        b=m6IuYLbfIdqHXBTmqDzWjN/BPrMu8eNhSlUTEXVXkTUr+Dt9u06nULrTWUdTy4FxKj
         XEQVoB1xkBIHKzTbsQsvnbskF1lGL3UWOP6eh+bCAiUKIzIngnWRhU12tW/TOdchEBXr
         kFwG1BBw94pFYxDLc25C9y+UaWEr5+w+B8gbY+t5mBqNE78wysiR9LXxYQNETRrXwb45
         WNCTq58auz6vSzBSP6eB9QX1DV4GnRq7rNNzBK7psbLgioU1fFqGP2ATSB1U78dyumYz
         UjJn3KjnqVk/WoatKkTiL9sesGS9NB88H/xe1QP8shzUVEFDohglpnWsTLWGqE8aagZm
         Kt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689618901; x=1692210901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goViAJVjt+VltPBDimAYth5M8v49WVfPG0UW7xjQVYs=;
        b=SmyXcTznqU42Um4sj7XjcDF8LKvSokffUxuPRpNrct0MrPyDqGBdjaH5IUracaznrT
         qyBhIO1J8whGLgZtoY6HiVjOP4EnsbRpja6dJvGPR4I3kzA72FaZlykjIm5CtNK8L2kL
         kabzXvO3RUVzcbOQoiyIploYmGvZvW2ywtKe7TgfecDquC+WEpFEfV6heJG5uvq1QWXh
         POJF2kSlnr9AzoEinPJAZ3Ow8zmf17pF6d/QvdXcS7PRJFOlnFAOiNcWMNR0+HrBAFEK
         5K8612tyQuqsVJdanYwhxvmqDBWqDpVlqHugtBbjxzjuv8/3HlCydzcAj683/8EML4vv
         aTGA==
X-Gm-Message-State: ABy/qLasriYYNkK+HNs+GuCWALMKQ/6gZYKiT4xRoihUQOLXpza/EchC
        QMqmEtLxdUR5iU0mGBrwDL4=
X-Google-Smtp-Source: APBJJlGVRmDSn3ht4EW/FvoSR7HSHquWs4mYU5kTCDuF49abVKehOriJc7qsTWhC/OvOIgk26PF1zQ==
X-Received: by 2002:a05:6e02:1788:b0:347:6c77:2c1 with SMTP id y8-20020a056e02178800b003476c7702c1mr744478ilu.13.1689618900667;
        Mon, 17 Jul 2023 11:35:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id d18-20020a92d792000000b003460bb48516sm112233iln.67.2023.07.17.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:35:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:34:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: use cached local variable parent in for loop
Message-ID: <ZLWJ0jYbNxK0q1Hw@slm.duckdns.org>
References: <20230715030829.2343109-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715030829.2343109-1-linmiaohe@huawei.com>
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

On Sat, Jul 15, 2023 at 11:08:29AM +0800, Miaohe Lin wrote:
> Use local variable parent to initialize iter tcgrp in for loop so the size
> of cgroup.o can be reduced by 64 bytes. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
