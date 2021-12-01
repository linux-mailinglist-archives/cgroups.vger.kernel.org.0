Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7F465377
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 18:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhLAREm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 12:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLAREl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 12:04:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D72C061574;
        Wed,  1 Dec 2021 09:01:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z6so18194458plk.6;
        Wed, 01 Dec 2021 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TNnID0pM8oD7D3r3FRXAh0e1o2KiMtfDSMZ8UHjXvhI=;
        b=dA/1Ba+LXxVdHk43lnRtTzYYDEZnm1SeoS0qMwFyrvslSljbrcih2aHLkBv/eg0g/S
         Rf8+0rtVJULopDo6OM56rZ6WqrqPJ4CTvtRnO+l86qBYKxO3quT+wQApFx6yvrrWYODt
         xNl1JJhBLj7Yj1fmVIZJ7BDT891ygHW2J5ZOsniAQRXzPJQ3CEK7euX1Lg6spl9S1Gw/
         4TWulikB7LeCxicPmwmN9MH4Mbq/oh/w7VG6FcNqc7w8VTvgj1HE9coW4lWeVOSX9+Sa
         hmeWoS1nBVuWI8NXlK+9QgRojQ2NLvpzV27X3zhhHlxRKCLFX0UrGEnSceae5jt3myoG
         NCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TNnID0pM8oD7D3r3FRXAh0e1o2KiMtfDSMZ8UHjXvhI=;
        b=pi4btKJQxRCiGu9EqLlrD3Q3FRx3/miXUd6gZkf/1JhRn1j2+n+jMVOe+Ty+uQavXc
         7C5cCMB7XlACFNu6xKzyOGni4JUN8dcQWmqYa+PPYdqIjvIC66R2Sv0k59MsjxY3niWH
         VsHY7HWUd/rYAT1kNXO13zk2O+Kr/q7dlOJ7pHXmK7D/XkNcG85VMEU8kXPexkZ+ekUm
         IPTwogCG1uK5xKvhlk9r3ryfS691ClctvNZACZDt0Tyk/7k2gKO3ExVVYavVUJYPVBCU
         AF4bXWS1Wc7H7ckxM87dLwAF8UTMAnyA1FwhmRhdn/rQq2d4S1y6dOXeqEL15RSwbj5g
         JKBA==
X-Gm-Message-State: AOAM532W1aaICziJ7NGYBk4kSzPTEaxoxp43gmyXYvIMXKeM81ifLnlK
        QyP71rdBT/JJDBQvtySHFLY=
X-Google-Smtp-Source: ABdhPJyucVvt/YfqtQdG9SrG4xh3otrVYdY1njG/WRE4qIYlqfDx+AqWitbJBKNWj5dlcvS8Q71cHw==
X-Received: by 2002:a17:90a:c08a:: with SMTP id o10mr9052451pjs.44.1638378079307;
        Wed, 01 Dec 2021 09:01:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q21sm211287pgm.83.2021.12.01.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 09:01:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 07:01:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YaeqXU82Nta+PhF6@slm.duckdns.org>
References: <20211201094014.330165-1-yukuai3@huawei.com>
 <20211201094014.330165-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201094014.330165-3-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 01, 2021 at 05:40:14PM +0800, Yu Kuai wrote:
> +	/*
> +	 * hold queue_lock to prevent concurrent with dispatching
> +	 * throttled bios by timer.
> +	 */
> +	spin_lock_irq(&q->queue_lock);
> +	rcu_read_lock();

Can you see whether it still needs rcu_read_lock() while holding queue_lock?
Now that all RCU flavors are merged, I think just holding the queue_lock
should be enough here.

Looks good otherwise.

Thanks.

-- 
tejun
