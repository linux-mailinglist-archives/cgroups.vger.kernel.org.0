Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02364128EC
	for <lists+cgroups@lfdr.de>; Tue, 21 Sep 2021 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhITWe7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Sep 2021 18:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhITWc6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Sep 2021 18:32:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34845C0DBAA5;
        Mon, 20 Sep 2021 10:36:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so11554694plp.7;
        Mon, 20 Sep 2021 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OU4xzWoGEyQRbV0io9yUzpEtxuso6DGtbaEY+PN0yXY=;
        b=UWm0G1Ww+g5nv8MIKnO9ITpymPJN2u7uYFkxWjd1PUOcBKrjfgli6E6founBl6k+y7
         us7VaQS55ELql0B4EdD5cV8NqN1IxNwwd+9oedfl6poL49bXXjSDXBzJ3uigtvICUf9/
         i1mtFj17iiz7RRsQHxYfUoMWWcraEXtiL/2V4NFXA2RCVHPSYYrp8LZA4t7Ep+T62X1i
         +9hg5760L5nZ9bEQM14936PQHk8HOHG74410RUjD37TIJkEtRL/xaydv80IX2XgDMr5Q
         nZfw6O64Rv8W6V9G9a6OIrlh8PIfZy3zavqTOu71sEaQwsz3LyQNBApDYOAcZ2GTG+Li
         X4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=OU4xzWoGEyQRbV0io9yUzpEtxuso6DGtbaEY+PN0yXY=;
        b=Vaei+VhboDLgfy+h1jpu2ybLrCImeyBMwwujPdxvclLPCLsEzoj/szFDxMIExXBcm+
         LVnUdzMpk44QgXOD1dzn7F723OEoo8VWk6ld7W+znbiXiuEnXTlyXIKkZaoigzSuMlpS
         dGfj1rJ2TJC5RDp5MxXONaPZ3hKQ8q36mOoA6GAG2WtRZmxb8xKcfsgtXJUuPRf1fD3f
         pDOcusnvgyngOe57Oj6QJc7WDJEbBCRxF6H/8dVfP6U3d47aFndvREtCp3z0jH06Qwpe
         1IElCjlT3AU0fRC68YwpP9lmUIqFnh4qKCO0k2c9GylMfdLVeC6m+9tzxAVUL1aa+Q7X
         y9Iw==
X-Gm-Message-State: AOAM531R8Yk5Gb6mUkY6CIVfG+SZpjZy7wBoIB/RmNV8gnR+CBe3pj1G
        CUCDKtvwPwc0sNXShTE/Zjo=
X-Google-Smtp-Source: ABdhPJy/xEhb9UFKsWXyqXWTn2tK+XGuSIsf++rNqoqZv0PSrdQ1jPKekDzoCA2hfG+qJr96CpPtPg==
X-Received: by 2002:a17:902:7b83:b029:12c:2758:1d2d with SMTP id w3-20020a1709027b83b029012c27581d2dmr23690925pll.80.1632159393545;
        Mon, 20 Sep 2021 10:36:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id t14sm15672081pga.62.2021.09.20.10.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:36:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Sep 2021 07:36:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, vipinsh@google.com,
        mkoutny@suse.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] misc_cgroup: introduce misc.events to count
 failures
Message-ID: <YUjGn27Ryt5R6Cs7@slm.duckdns.org>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631881726.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 17, 2021 at 08:44:14PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Introduce misc.events to make it easier for us to understand
> the pressure of resources. Currently only the 'max' event is
> implemented, which indicates the times the resource is about
> to exceeds the max limit.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Vipin Sharma <vipinsh@google.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Applied 1-3 to cgroup/for-5.16.

Thanks.

-- 
tejun
