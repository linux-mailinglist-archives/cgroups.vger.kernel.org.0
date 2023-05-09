Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F296FCA62
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjEIPlP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjEIPlO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 11:41:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759374690;
        Tue,  9 May 2023 08:41:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52160f75920so4071819a12.2;
        Tue, 09 May 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646873; x=1686238873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoUKheuGGoabhTr4uxkvUyDn3oFM2xkZ0jYUH3Rrng4=;
        b=Ow/qrEULGpmS7Za4OSRrLz2ncagpT+asShIr6m0nwant11xFKyXBYpO+RwQf/W1mFu
         +NuKlfWc6F9T4yG/FCmVwB5ot7NGpmeLXck1fRW6X9+XMWYA2A1gHdjnQsxUQo56c5DJ
         J4oJBFuhlH4gf7g+c8fWNLF1NkO1pFxdsWN+21zuDPsBBuPAthKw9sZ1KkkczZB4TMWQ
         1qVOjubqM22LbqJFkW0IMkes2JgbA6O+F73KA8W7r788B/qIawJKANWGmTGhuqD3gp2J
         P8FoTbiMzDUziR3gxWvUjhCUYbL8F1zJM2WjCj/FCEuhwBVEMSiT8hdHi53i8Umq9ZGG
         OAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646873; x=1686238873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoUKheuGGoabhTr4uxkvUyDn3oFM2xkZ0jYUH3Rrng4=;
        b=lNr/lYB1NsxK36L1+QbKKGt0Nv0qyizhhl5KHn++rrx1l9CtZ9KTZ4O4t/zKA8eMTj
         15Ig+ZpuJDZU27zET0DbtBPYvXpK92Qyr5XSStoWo2N9EmL2qSksIVQxdDcKzDcm2Vzf
         j40BhdiOzT4co0JmCL8JgwUH8Ss4zpub85qj6yAW1gR9oI3vR6v495JAVnbpyNu0rxtZ
         G7J6szDFW9bH4Z2X9JnMgYaGitw0OCze1zBLhcWVQwx9KshSvFQkfkZv8m5AznQj+yVH
         ddbYi8+vgQF8Mt0ncfKHJk+G2eMdElfXgKgasDbB27DIcBtkaBKLHCdJPsQiMUJHD6+7
         wEkw==
X-Gm-Message-State: AC+VfDyuTTIo2G3xWr5kEfMrxlv0vbdWJtpN647QhPpyom1WHQXFwTxb
        rcDD2kbJiDqsiJNTc792E4s=
X-Google-Smtp-Source: ACHHUZ4Fqr0Yi2yKnYAexDwzj4yewtWHFgjUvGEpqADdTb7034mlfs1EJaas9ZncJH/1DOJgAx7Qpg==
X-Received: by 2002:a17:90a:c283:b0:23b:3422:e78a with SMTP id f3-20020a17090ac28300b0023b3422e78amr14392965pjt.6.1683646872703;
        Tue, 09 May 2023 08:41:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gz5-20020a17090b0ec500b0024c1f1cdf98sm11831916pjb.13.2023.05.09.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:41:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 05:41:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, andrea.righi@canonical.com
Subject: Re: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
Message-ID: <ZFppl9jJNqM_GCzS@slm.duckdns.org>
References: <20230507170631.89607-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507170631.89607-1-hanjinke.666@bytedance.com>
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

On Mon, May 08, 2023 at 01:06:31AM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
> 
> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
