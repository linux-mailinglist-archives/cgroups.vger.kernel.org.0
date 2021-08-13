Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764C3EB9DF
	for <lists+cgroups@lfdr.de>; Fri, 13 Aug 2021 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhHMQRP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Aug 2021 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHMQRO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Aug 2021 12:17:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B883C061756;
        Fri, 13 Aug 2021 09:16:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo18so16110867pjb.0;
        Fri, 13 Aug 2021 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JeOfnYXXUD0uawQ0bVzU2z5A2fd7nhB1MsbBkE12QoU=;
        b=V7sQT4KCgtnVpRX90o4X/FqgPaiKH4o6jvDypjFYfwZyXYnhyjnUb9+Vr2WelHEk5j
         vKp0QRk2LjsafSp8wmQnVcd8Jr+SLzWSIpm6D3zG7wHIY/2QhFG+hcMKN9Oo7cMohrQ3
         4VDmKxdS+hvcvZaD4CqmrMUkFnc0G1D2uv1dimHQxWaZhfckfKU6bgwFI0vppyBb2Rov
         EM9/BZvvM9mQdaGuHaGQiWojIjIQOhUAkPHecWSjpnLOvOOJYgGizkAkDKs4lPCSzcIl
         w3KLTLRQiWy2NcYDeRgvVG5JOstQQEuwPwpXB2oPZ59inEn7N1OKKfx6ibt+J1XyLfH8
         gJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JeOfnYXXUD0uawQ0bVzU2z5A2fd7nhB1MsbBkE12QoU=;
        b=JsHo0JhO+yTtyYSm+vExpQJ336lVpuBqo0zm9NvZfT3e6itNgoTskyD35KDfFuzl4U
         l2JftkcBanqzvsHH+s+yw5giOAfRsxgew+xJBzeHJV8ZaJi6AWqqDFENPXRL91EFod8M
         fQyh+5P7iRzUR8LGWGdRrUOzuJS4XSEvBcXqVJJTxzh6CeSHE0B4jT+BOQenkdgrMlSn
         NQS2oc/CdunehSfbWqNWm4GdPfp35e1bHGsXUYK8V9wJDCrPhVS7EVRJ2zaGoSqtb7vH
         edfFX2ebI0RgzJFf7wo6hhw+tU8zghnB/6a7afQZLoJ0BfwPK2UrCT2zXmRoQUTwSVif
         Kw4Q==
X-Gm-Message-State: AOAM533GDDAYD3B3yBd5WxqUB0Tn672kIR7RwC8Bm26lu0ugznrJG5xk
        LWn83WuLWpg0Xy3M66uEnHA=
X-Google-Smtp-Source: ABdhPJyOkGJkNHePuKgw0Vmur+Cdhb4/TaV0LrXCv5Qr6uulsRr4xwxhUaKi3FuwQKHCRThl7jPXvg==
X-Received: by 2002:a62:cf01:0:b029:3cd:ee82:2ee with SMTP id b1-20020a62cf010000b02903cdee8202eemr3118320pfg.78.1628871407407;
        Fri, 13 Aug 2021 09:16:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id 66sm2968564pfu.67.2021.08.13.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:16:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Aug 2021 06:16:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] misc_cgroup: use a counter to count the number of
 failures
Message-ID: <YRaa7R6niNQMpqZm@mtj.duckdns.org>
References: <1628832371-16382-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628832371-16382-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 13, 2021 at 01:26:11PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> For a container, we only print an error log when the resource
> charge fails. There may be some problems here:
> 
> 1. If a large number of containers are created and deleted,
>    there will be a lot of error logs.
> 2. According to an error log, we cannot better understand
>    the actual pressure of resources.
> 
> Therefore, perhaps we should use a failcnt counter to count
> the number of failures, so that we can easily understand the
> actual pressure of resources and avoid too many error log..
> 
> This is a partial patch of the previous serial, which may
> be useful, so I resend it.

I think this approach is fine but can you please

* Cc the original author of the misc cgroup who added the warning
  messages.

* Rename failcnt to nr_fails?

Thanks.

-- 
tejun
