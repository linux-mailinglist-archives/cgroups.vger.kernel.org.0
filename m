Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC53477028
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhLPL0k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 06:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhLPL0k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 06:26:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB2C061574
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 03:26:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso1485458wms.2
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/iZFXBIyAByjsB3GJFOohpxukrwP21FfjWMfhDCvudw=;
        b=HIFde9vm8ylWeo3wONyehTRk81AyUekFbi0/8yqHcpmod9HnZdEpAT/FBJji59SFX8
         5e5GEUQIRNkhnazvrypRzsK+RAOoeiQYmhp+ZiYTpV6w0LIr1Gcs3NeFUMauAIoclYzv
         deXwqUJdxLOXuo37MFxpUrmTvJPXXTDL0fZgUCsuH65oYC86R7pgwBYiPjFO6Y9gw8eI
         9y5cgTai9OwH3lIO6k/EF/2XTRAmgcmilhvufm946Kc6Fasc5pFO2BvILQg8+S0qdzqg
         dt1J8hEqCz4JyKOrCeWbn3lBgdW3asfPdLB21m5bzScu4ne46qzh+tnIFaVLsSUyUh6X
         HPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/iZFXBIyAByjsB3GJFOohpxukrwP21FfjWMfhDCvudw=;
        b=VNy2JvXKWXGz62CuBnGP5RFDpTJIJ8lx0sYrZiiJ6plXUCAOV30uAZrpgYWRVpJ+k7
         2/RuBjS/PjAPYg4H/EwWsfvYhW4WSwhuMTm6DBip6kPcFfZPW7Hdel5rQKkR5rvJs1N/
         lQSiNZJaDXA6YvEhy7G+fSBa8NYRNqRSvoinwn37UgFLmC0V0AnoIFGqfR6aPhf3hkVX
         dD+qwiXW5g7LWIuMxeaj6jDOUDALR7pboHGT3IhHIStZIXyN9q0streyGDIMdFAbOiUj
         P7TrTMOkZppul6QpH21PRgpXcCTnC94IjVpFLFXkFNBMqbMbZPY4mrW7TDI1lw9mNtdc
         rP5A==
X-Gm-Message-State: AOAM530PozgKQ9oZHNBEEAJIhH6i/74rwzsActu89Lmr26NRmGzLz6Wn
        /UnJco2FzY5CAs/Qy9EvDg8UQfUrGy0/9I38bPGm3lgq
X-Google-Smtp-Source: ABdhPJyEEeE1TqtnVLg81N0gyic0nRs4xMnRuM+qr9PJEpB2NxSYCH941BHZDvSdtA4etPTPyi7APg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr4589806wmb.174.1639653998664;
        Thu, 16 Dec 2021 03:26:38 -0800 (PST)
Received: from localhost ([2a02:8070:41c8:c700:3d3f:77af:d3f0:b7f0])
        by smtp.gmail.com with ESMTPSA id l26sm1510161wrz.44.2021.12.16.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:26:38 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:26:36 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/memcg: Use struct_size() helper in kzalloc()
Message-ID: <YbsibBdUFhWGzojj@cmpxchg.org>
References: <20211216022024.127375-1-wangweiyang2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216022024.127375-1-wangweiyang2@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 16, 2021 at 10:20:24AM +0800, Wang Weiyang wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
