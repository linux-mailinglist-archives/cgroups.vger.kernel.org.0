Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DCF2304
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 01:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfKGAJD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 19:09:03 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34585 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKGAJD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 19:09:03 -0500
Received: by mail-pl1-f170.google.com with SMTP id k7so89000pll.1
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2019 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqDRoSA2IlRCgtZEklSoyPJxix3jduddAsTI1/jyNJM=;
        b=X2Ic0fSApnzTHNdrcWe9ggsXClLt1ZYXt51dLoiznXpJfWYe3WV0JSVtA1y/6Be8bk
         HohaOtxR35Sl1zMaaCuBEU2N7beBAJZ2RGI4bSzq0bz0ir/9PX0PQ4GkHuPfV3Tm1TiA
         8gHEAUPHwZf8+bIjL1S08URkQ/1PEnfN2DsVLfp5tonTKKUgKFExNd3mP7Q9z+dZEdi+
         kQegPZECwkYzCfuFG9PngeOxvXCXj1yp/FIhILtDJqzFKtbqNLiEjUhqqzmiufO0F/Em
         9ORpFhWbqBXvN/KD6ROet7VPkhdoEDubSk9PGlBk5PGcpq0Xcu/jpcL/NGK10FpQBF/j
         9YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqDRoSA2IlRCgtZEklSoyPJxix3jduddAsTI1/jyNJM=;
        b=esxy4PYJByffJaknMOOVquHW0fPtrhtaXW5VirYlwesx25VDNa5ZfD4PCj07LKke4F
         FYGCdsy1OAsSLqTWzFRiUbTrpAdZ7ceRAzlc6/zOwwaduCVqI3Fa2pnF3kuv7MRB9jBC
         x/7TR0repSgb2SnKUFNMMjzDunhS8W91jRaaJIdpZhuMf1FNVChgryRoUXJpgJ3IT/Pd
         CsyAWsgRK3HC6+G9ZQxge1lKqNe6tl3FNbK2wfr1fX2uV/+sZAW8diK+b/uXxNkKJtwE
         G9sUd2A2l9b8CcYjSh3EStweLiP3QiDexJoGkzmyWCGIhUZmEKXsJ9cYpKBPnoZQtbB9
         +drQ==
X-Gm-Message-State: APjAAAVo48sd1lpfQm6bgrwvzXFzhXejBmTepLqf0NvpDv59MSRhB6xc
        5AvzHrv41TjKIevfg20n+86y7w==
X-Google-Smtp-Source: APXvYqxqztqU9P4k3+g7ZoHWN0J9tb648zdmiFnKzrsyZaQHcNLcnwOFJw9OIFwA5s+3SGE4WdvJWg==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr432341pld.248.1573085342309;
        Wed, 06 Nov 2019 16:09:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j14sm116231pfi.168.2019.11.06.16.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 16:09:01 -0800 (PST)
Subject: Re: [PATCH block/for-5.4-fixes] blkcg: make blkcg_print_stat() print
 stats only for online blkgs
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>
References: <20191105160951.GS3622521@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ef277bb-8591-6029-2e9b-319820b3460c@kernel.dk>
Date:   Wed, 6 Nov 2019 17:08:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105160951.GS3622521@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/19 9:09 AM, Tejun Heo wrote:
> blkcg_print_stat() iterates blkgs under RCU and doesn't test whether
> the blkg is online.  This can call into pd_stat_fn() on a pd which is
> still being initialized leading to an oops.
> 
> The heaviest operation - recursively summing up rwstat counters - is
> already done while holding the queue_lock.  Expand queue_lock to cover
> the other operations and skip the blkg if it isn't online yet.  The
> online state is protected by both blkcg and queue locks, so this
> guarantees that only online blkgs are processed.

Applied, thanks Tejun.

-- 
Jens Axboe

