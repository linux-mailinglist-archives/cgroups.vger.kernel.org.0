Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68C73DBB62
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhG3Ovk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhG3Ovh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 10:51:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97EC0613D3
        for <cgroups@vger.kernel.org>; Fri, 30 Jul 2021 07:51:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5CB62A0;
        Fri, 30 Jul 2021 14:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5CB62A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627656689; bh=11tsRvWqxa857A4Loa4QydFr4xgnp3s3Ast3UUgdn+0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VN8pSMY/6VyMSZP1meyUIrBqFBjrUbbgFVmCyesRBGTMpmETD1yXzrEc52grBRSo2
         U8COBlGrfOWLxmyOrz6F5tLHVEpUttpiv0BxARkODmWFSv9i01tPrWBlfH+8Q2O4TG
         IfkUiD6JU5YPYz+arEeDZ9Ue+qpM1PgHkW4r8Ak0TcfuKodWmXo7ZWVLUCDDLOWNO0
         jn5SRoj3sNcrSIgksC8ujEslevYMqBCvZuWGrokVAT3SC04SBxVh5SCBx7cvaAB4Ti
         B7S3mKpTvxemKZTAWusUBz4mLFzsvcncVyyw0+beAzNhvgD6syn1Qmu1q2qRR4HmJz
         4STtbzjHAmJhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cai Huoqing <caihuoqing@baidu.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
In-Reply-To: <20210730051605.2626-1-caihuoqing@baidu.com>
References: <20210730051605.2626-1-caihuoqing@baidu.com>
Date:   Fri, 30 Jul 2021 08:51:29 -0600
Message-ID: <87lf5nc0su.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cai Huoqing <caihuoqing@baidu.com> writes:

> Fix typo: iff  ==> if
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

This is becoming an FAQ ...  "iff" in mathematical English means "if and
only if"; its usage in these documents is correct.

Thanks,

jon
