Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD058F23F
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfHORbx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 13:31:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34314 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHORbw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 13:31:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id m10so2528402qkk.1;
        Thu, 15 Aug 2019 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=no35aRJk15zFWg1jR8wwX86QzYLoUfFHVUo7VWQ/svc=;
        b=N47XHCOSmAXueVA0YYaev8/a4K3QvUHId7wqDd1kKuzb9i0XsPGZt3JSFV4fwHmm1o
         079FfdNxA44u+Lpn9KWO67P5gdQDjS8yLNUwxRyP+az0D6idFOXOvoIL6oT/ByHrYA+e
         5x2GXXGdhLQUUhHxcna9tpQrgumRatQu40F/xy7UzP2oUcoOJ5ObUyU55Ybx+CjVdZVf
         ZGK+QWvr7EafhXZLjXcXxcSaDgonosEcUP9Kh6/WmBW5wIhcwJ7Gd5u11eGiOYvLgYRX
         ruJyUluXJcICik/5Pis1nVgLz6wleggRuqyNbfxBltc6VpOrVEuqmr44g/tLfUNGnReK
         /wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=no35aRJk15zFWg1jR8wwX86QzYLoUfFHVUo7VWQ/svc=;
        b=LAhr5b4LaF3OckGln8l8++cxyNw+taN8eKEypTdvjAW5FfSa62SK0RTiRUC5PIv/Y7
         c4CKp2gPG8gJC10xiPWskoxsGjKF3mXl6YzO0LFrWTHaDP5uGGtqV1N91u9fvO+PP3gI
         RwoAVdkphHbfTibxxGI9f94wG4LO0uGyxPIPoZrTw5hX/OtNgjytNYaJSm5bFuRj8tV7
         s95QZR6bC0hTudDARsBRqwow6n3HAYWXeYLxtIpZxbVtpO7IxFwh55knd17D9bqbGtjY
         JSZmhj1d3c2EiJcWZqWjSUFS7QcnwwDSN4YwVPz50AkWBNyjobtviZ1+AACRVpgcgaUz
         vkmA==
X-Gm-Message-State: APjAAAXyGYUTXOiLbsOEDLp5Rt9JBaz4c1t9taYJMKR1yDGTvivHnowg
        2H2NJBiP7QNDs2L1NLaKm2A=
X-Google-Smtp-Source: APXvYqwTF1AugQK16mXeTAc3YHU1jdzIKEshxpTbcRaCWmkGxQukcPJXecgkAY0Igu5HQb1bcCAfWw==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr5056219qke.34.1565890311488;
        Thu, 15 Aug 2019 10:31:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id v24sm1928599qth.33.2019.08.15.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:31:50 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:31:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 4/4] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190815173148.GD588936@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-5-tj@kernel.org>
 <20190815143404.GK14313@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815143404.GK14313@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Jan.

On Thu, Aug 15, 2019 at 04:34:04PM +0200, Jan Kara wrote:
> I have to say I'm a bit nervous about the completely lockless handling
> here. I understand that garbage in the cgwb_frn will just result in this
> mechanism not working and possibly flushing wrong wb's but still it seems a
> bit fragile. But I don't see any cheap way of synchronizing this so I guess
> let's try how this will work in practice.

Yeah, this approach is fundamentally best-effort, so I went for low
overhead and mostly correct operation.  If something like this doesn't
cut it (w/ bug fixes and some polishing over time), my gut feeling is
that we probably should bite the bullet and synchronize cgroup memory
and inode ownerships rather than pushing further on inherently
imprecise mitigation mechanisms.

Thanks.

-- 
tejun
