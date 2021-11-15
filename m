Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5894C451767
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbhKOWZv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 17:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbhKOWRz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 17:17:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB2C03E03F;
        Mon, 15 Nov 2021 13:37:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x131so16157514pfc.12;
        Mon, 15 Nov 2021 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sy0cBwSY9OB0AfhJQItSKu5D9CkSMvp3AC0Bk6Ha4VQ=;
        b=pN6KNRwqQkwkOps2PgEPNWx6ZqE9B6BEhhsEEiyYN7MYDinla+sbz/gXcJ2ygSQhJq
         7z3VZJaa/DEz0KQ58iKtuRH5SsFuyQ92/N6vUoBv/9dDKUW7K7qPAkRKPuN2kQpuAGZ8
         8Ei+42gAjmPc8TZL5pV8KQvgGGYy6VZFv6X6zQQ8F8Nk4XJqV+TdlZ8g/beGlO7knjdu
         iTWmYMHh7t3zasaqNfMIvD99JnxyeSZMC8mEVBacCZbIvI/L8zZQOG6nxXoXnBUyQc2W
         inCJcZdDwvNBZlTM7IsZkrub7/Q+/9X1vrdlI6g6z5gULncLtvNH/cwVtPaotIizYEZp
         mEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Sy0cBwSY9OB0AfhJQItSKu5D9CkSMvp3AC0Bk6Ha4VQ=;
        b=ILTjJp16jW+/3Eb83+PE8tgG24cY5t2gcCUt2a/e7zSh9LDzqmI/J23NTijDE44aaD
         FWtEPO/LJ4iT3qTpqRUwAtn8RaHAzm3i+ookMGttAIvwMeNEGcCy+prxQAAuFa6NF8gU
         P1rZFnDLtBfpasLoVdsLEx+PXo9vVsHa2o0hr1BKgAhL3jJAKjTRaTLjK4eJUO5wy4x4
         G1C7xiys0vn8njphMxwF+hnJ8acq0nV0UnB7nNbmSdtxK+zx4SQBHKm9NKtOudheoRoo
         7CfLlHVfpyO/4N7p4z1L05GTEAUDY719VaW4erY9Qqj1iFxHjn4SvdbiyTNr8DpJO6jZ
         XFmQ==
X-Gm-Message-State: AOAM532SwLwgCbANeNPrmrq7B06vu85lyQHsiw1GJB+Bg46Sm3glvH5a
        ha+EM3xNI5ArIPQCpvagKD8=
X-Google-Smtp-Source: ABdhPJzxoEiP+heMxH0Z2jUQxgSXbZsg9q3n2L2yj/seOLNJg38GYvnglBfSC4AtOVzpjRUom5ybYw==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr1401145pgb.83.1637012243829;
        Mon, 15 Nov 2021 13:37:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ls14sm243463pjb.49.2021.11.15.13.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:37:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Nov 2021 11:37:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-cgroup: fix missing put device in error path from
 blkg_conf_pref()
Message-ID: <YZLTEZS66QqRxjuX@slm.duckdns.org>
References: <20211102020705.2321858-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102020705.2321858-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 02, 2021 at 10:07:05AM +0800, Yu Kuai wrote:
> If blk_queue_enter() failed due to queue is dying, the
> blkdev_put_no_open() is needed because blkcg_conf_open_bdev() succeeded.
> 
> Fixes: 0c9d338c8443 ("blk-cgroup: synchronize blkg creation against policy deactivation")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
