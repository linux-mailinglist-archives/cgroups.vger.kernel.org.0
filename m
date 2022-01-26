Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3221449D044
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbiAZRDL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 12:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbiAZRDJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 12:03:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE28C06161C;
        Wed, 26 Jan 2022 09:03:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q63so267780pja.1;
        Wed, 26 Jan 2022 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AwYHKz1GfwyPBAeaDvfhIvi+S5N70d9KsK6NMZPpRu0=;
        b=G43+bA1dTI/pzs7p8eykDJ6DRBvA00FoYTGWOy8LNRG+HKOJndQBXGBO0TJvffG7rB
         t2X5cteQXJTkmavc0204qAqPFBZi0Q8Ki8to+HmHZlNc7BEPiZw+LS+dd3lwrys7tjF1
         ZkwqkPS1xpGGj3fr9hCnkQrefH038dMHVFlSGd7LL0HNcLN0j+vTifguCFW1BwBlhJ1x
         HZCRCeJGKa0D5k0TRNUV5Ws1eB7T8JLVe3k4t87kJJmeq9yikZVeTi1+eIwlYOk3FFWg
         hYug8J9JYnWru2MIomZE/ucY+Vi/dK8dMqVNVxgSvruDnFRBZUN0kfmluLWJ52LTdJq/
         q9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AwYHKz1GfwyPBAeaDvfhIvi+S5N70d9KsK6NMZPpRu0=;
        b=s+AqZKWhkaX0ahZdXtdt+fsh0fnoU8Qz4/RKleCx05ksW40hSVFwAjNoio0gr924UN
         gDOnQ6Xp+mJ3odZgqq1Jn2b6op/AqdxNAMLGEDz4s0qx77Vy5hssixotmWV/86mHbWkd
         qRFaFcNp8pEeedZ2LbpleWKyvLwNiEqqqR4BDiaMDfOOP2wTOrKSoXpJ12nx/KPrNysE
         RDzbUpGvlEBzzqDZtZ2KbjHVp3Uj77JcFL/rIQLOWIOT5QLMleFVAjJoka5qF+swRIZZ
         UXkWmBxOMbqbfPJPcwX5U+JngXsY3Jt0F8DLHCHRRMN0+Y7B4dS0yCWu3VQ4pKIdNesU
         drwQ==
X-Gm-Message-State: AOAM531SnefFQaROOlmf9lEKLCKxu50o6QbXuFu6Yu5e4pyXFi6BVDFD
        kxhTaBw/gmUK1bMrMqZEnXpk2i4rP9H06g==
X-Google-Smtp-Source: ABdhPJzvh9mx3WdIHhtTFJLWTT6rReaznN96IPnxqWS/fXHUnoItf130BP6IhM6Q4HUOTQ8Uo3M00w==
X-Received: by 2002:a17:90a:2b85:: with SMTP id u5mr9468410pjd.197.1643216588136;
        Wed, 26 Jan 2022 09:03:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 17sm1824699pjk.51.2022.01.26.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:03:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jan 2022 07:03:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, mkoutny@suse.com,
        paulmck@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YfF+yukISfkuc9IK@slm.duckdns.org>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com>
 <Yd5FkuhYX9YcgQkZ@T590>
 <b416e6a6-f2c9-caf3-dacd-f937746207da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b416e6a6-f2c9-caf3-dacd-f937746207da@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 24, 2022 at 11:50:11AM +0800, yukuai (C) wrote:
> Both ways can fix the problem, which way do you prefer?

Ming's suggested change seems simpler, no?

Thanks.

-- 
tejun
