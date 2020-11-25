Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE92C409B
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgKYMxg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 07:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgKYMxf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 07:53:35 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7672C0613D4;
        Wed, 25 Nov 2020 04:53:35 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id y11so829300qvu.10;
        Wed, 25 Nov 2020 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2X0u1zymrYQOExBICa76gdQ48XGpkWMEvIhEcoogarU=;
        b=h7OFb4cEn3IpHhhmZsFcA2eih4hE1UpgsipaoC3FI2JkDg6aKHoI1bASA8i3rOFMzB
         RrPBAUJWAS+C7jH6bfxUekTUIfftfA/e2mf7MGBFHctQIlbpHuum4v/Oqwi80+CZszaP
         /36qAXSlJkmebZWFvlGQgg6buFqwe0ePfG2VJqk58y8bOoqNsEfLyzR6+ckzM8sFCWK1
         5C6rU+hO/4CCwKSLu/gQCovGnIz7UBzovijPSThu1Whb77PECc/SsguTi2Ep2+/+assZ
         l35vCvidV9OAgmqAyO7q1fdcOJmw/JI4UC0M5Rs73SylB8xrhqAyTVZUaGSUgTLmWqZO
         mIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2X0u1zymrYQOExBICa76gdQ48XGpkWMEvIhEcoogarU=;
        b=Q8nNzOc67AacoCs59kaKaxgRcAqIzG1ZwHYIaQ9WIbtDIIyFGaMXrG12VvJ3JR72L7
         E/HyT7oguG+KVn0pwWT17AZ/vtihNexcFCaN+7B/JXKGnit+84unBDQjHJ8p6dFFlfmM
         AG7X+xZncjrgmqfDU9lx81FP+grVY/czchAhg5iyIJcYXQRY7auecOHqny6LZ/tzk9oy
         GsfMsOAtyKR5T5lqA9/w4pcp7Dik2pZsF1ETu7Ro8j+6qBjR2S0GKGY2XJy7bDBqKBpv
         MzJHwzVOfPu7bzwEeh/FmlE9e2cDYU2cY0KlWuP/cLqo411PVrLtWh+j57pSPF+r4Y3D
         YFnA==
X-Gm-Message-State: AOAM530B5rXB9+JI+5vhnsA4ZFD+wnzw+v2sl8VXxNjV7qrPP4oO2CBc
        vgy8+0yA0DIp42iTpArTaM0=
X-Google-Smtp-Source: ABdhPJwotE2y9hQoQS9N1nGwrTGSUxiAQCHyd9CM4dgXKm89kDF1OzE9AXingzDvopSqKtJjo1rc8A==
X-Received: by 2002:ad4:43ca:: with SMTP id o10mr3368150qvs.25.1606308814790;
        Wed, 25 Nov 2020 04:53:34 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id b3sm2131612qte.85.2020.11.25.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:53:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:53:12 -0500
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com, houtao1@huawei.com
Subject: Re: [RFC PATCH] blk-cgroup: prevent rcu_sched detected stalls
 warnings in blkg_destroy_all()
Message-ID: <X75TuKMuO2Ru+rVt@mtj.duckdns.org>
References: <20201121083420.3857433-1-yukuai3@huawei.com>
 <X75O8BNVSX3ZE86w@mtj.duckdns.org>
 <a24c48a3-6f17-98ac-47ad-770dd7e775ec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24c48a3-6f17-98ac-47ad-770dd7e775ec@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 08:49:19PM +0800, yukuai (C) wrote:
> > You can't continue iteration after dropping both locks. You'd have to jump
> > out of loop and start list_for_each_entry_safe() again.
> 
> Thanks for your review, it's right. On the other hand
> blkcg_activate_policy() and blkcg_deactivate_policy() might have the
> same issue. My idea is that inserting a bookmark to the list, and
> restard from here.

For destruction, as we're destroying the list anyway, we don't need to
insert bookmark and start over from the beginning. For [de]activate policy,
we might need something fancier or change locking so that we can sleep while
iterating. However, policy [de]activations are a lot less of a problem as
they aren't operations which can happen commonly.

> By the way, I found that blk_throtl_update_limit_valid() is called from
> throtl_pd_offline(). If CONFIG_BLK_DEV_THROTTLING_LOW is off, lower
> limit will always be zero, therefor a lot of time will be wasted to
> iterate descendants to find a nonzero lower limit.
> 
> Do you think it's ok to do such modification:

Yeah, sure. Looks fine to me.

Thanks.

-- 
tejun
