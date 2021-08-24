Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B043F698B
	for <lists+cgroups@lfdr.de>; Tue, 24 Aug 2021 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHXTJh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Aug 2021 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhHXTJg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Aug 2021 15:09:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1726AC061757;
        Tue, 24 Aug 2021 12:08:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w6so12829753plg.9;
        Tue, 24 Aug 2021 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5v85tm4s0OVyrps1zXJuM/Q2kA3ef4+GfrXQL7ocGJo=;
        b=eTWbKzVS+hWBZeRV4rxr+xSLbNZizV0nGboZUx/ayYMgYbiorgrctYYHDhadFmbZ6j
         ta27nCsuAXS45M4Hjepp5eNSlYePNL+isUtTNjkiqXEh72tx089E1GZEtyuXb7SCM2Q5
         iVPQr9ONqTQ7ApxFfWgeXjYx0NiXkgad2MW2TFs4lglI00xLqY+sB/hjQ2MlZyXvIK7e
         61noAFQP4Cy8YqlDhsSx/O5BE2hxojhA5vib+QI4CX5QKb/cMgQzoytSSc500sHAiUzE
         gQj+df8XIAWM0EcfJNj7vYwD3sD4xEaA3KHZiaR9RujEAW+GdI/lK0RW+bpGaPl/FiV6
         qhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=5v85tm4s0OVyrps1zXJuM/Q2kA3ef4+GfrXQL7ocGJo=;
        b=ZGepcOZm20qpS7LFtn0ylLWNvvnbjB+lIpWhzGa79Qq96Q9v/vnXTW86Jtf9XR4W8g
         RT9Ado9QMhS9itAapwWCMsIOEFGtjfjAgNLRuaUjlB5UKoYYK6Z5ShYfyM7cW0BnowtL
         cb/qQ+ScfHeTcnUrl/WPfhKhtcGsyKxK1AFNZX3/T6+EaDE58daiq8kXneCA//VLQ5gA
         I5FCZEuHts74yz6iAoiQ160RGcIeQTv0tHGJaXR18pgRFiiiHcpeqvjaSS3Y8ar844NB
         hDeI1Ejwhr1AjJNslEOW5oqm7hqGmlo6Ca3eotwmK7vDWiuXZyFYsbkUuySvwvZ+osmq
         v6qw==
X-Gm-Message-State: AOAM530Lm8r2EOP2NL+cBgRYVe7WQf+EW9EYKKygg/Zqrbc27GMpR9Gt
        HYx42Nk67zwwbrEddHlIGWtgGZSEYfSDYg==
X-Google-Smtp-Source: ABdhPJxKr33I/iZkaQWWR7IIGlvx+4TSVio521c+MFyplGVepWDFf2pfz/EveoDnK388RU3KlE33Vw==
X-Received: by 2002:a17:90a:af8f:: with SMTP id w15mr5944488pjq.90.1629832131447;
        Tue, 24 Aug 2021 12:08:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q102sm3150182pjq.54.2021.08.24.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:08:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Aug 2021 09:08:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     brookxu <brookxu.cn@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
Message-ID: <YSVDwc/1sEmXdOK9@slm.duckdns.org>
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210824164423.GA11859@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 24, 2021 at 06:44:23PM +0200, Michal Koutný wrote:
> However, the non-hierarchical failcnt interface looks like v1ism to me
> (I think new features should come with v2 first in mind).
> What about exposing this in misc.events file with max.$res_name entries? 

Ah yeah, good point. misc.events sounds like a good spot to put these.

> Or if the hierarchical reporting is unnecessary now, there can be just
> misc.events.local for starters.

I'd prefer to stick with hierarchical counting as the first step at least.

> (That reminds me the forgotten pids.events[.local] rework [1], oops.)
> 
> https://lore.kernel.org/lkml/20191128172612.10259-1-mkoutny@suse.com/#t

I think both counters are useful - the number of failures due to this type
of limit in this subhierarchy, and the number of failures caused by this
particular limit in this subhierarchy. It's a pretty subtle difference to
encapsulate in a counter name tho.

Thanks.

-- 
tejun
