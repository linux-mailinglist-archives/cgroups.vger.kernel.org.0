Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF543D7AD1
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhG0QVR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhG0QVR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 12:21:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246AC061757;
        Tue, 27 Jul 2021 09:21:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k1so16233982plt.12;
        Tue, 27 Jul 2021 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKSXNwDjopSziuCU/tjPk+z1jeKEq3gWP1NdV3AtHro=;
        b=p0y3P4/22F5hQkn3WFmpiaZsoG3SjwD9e4gQmaK7VA6kHL2uLm//Kv2uEa3ojTXZNc
         XwxeYKIpE5ECCXztRDAzRUyUY77SSexmcB38ytVKWg1dgKp45Xmej1t+YsnnliSFzJrn
         OMWdfRoXs218uT6SCOfCikE7/9GtnIjPzbP5jfRCTY/w4wdQALgtYlxSHXUg36/a3LD6
         UG2gADHwg1LleP2jxPRM6H5sstIO4THOD1fXqD8HDzZL5G6K4D2/cXHaRE7XxHZNtsPj
         Y8DwM8N0T7h/cyO8ZJvBnyoSnmLpeX9JZUw0cyBA7pKQpBWkqVwoJhkAmgfrqnyXzsQn
         S8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aKSXNwDjopSziuCU/tjPk+z1jeKEq3gWP1NdV3AtHro=;
        b=kPCqjhI2qeKN4F2w5UubIzA8/4zVJvnLs05o5yFDtcusP4S+LeUhWQsyD4aTF76tCa
         46OAxTfGIRyzW9IWtfcPpuyVLoMJwnrULlqmdD3EpGHLeQWfdENRYv+2t796Vx9qSJ8c
         Fxz5F9A2M0hUFk1mLWlwe0gifp8b4cRfdrQzF5+VPIgTaELOkD4y9TF6w/KbCbeBsao+
         R5BpRjfpQVSsRVUia2Tm+jrrA9pHDtLn1uUk+6oiV4756RqMcHMfNe9m5W0MmhGGiT8k
         8mXMDWXWFIwcxt3KJIg+NumQsyPF+j/Px4wT8ppOXyFiRafM4rkSRfhpgTU/ItNMGdhZ
         OcdA==
X-Gm-Message-State: AOAM530yis899O0G3Dn1jTj1rdq7rpMA/klRtY04sanvgJyiWdKRCYbc
        DsDrqs/dc4N1KdMiDFsi6SY=
X-Google-Smtp-Source: ABdhPJweTq3Ojivolqcy6qYNEBQsLjn3/pc/Xj+J0oNtgS/8KrT/DtNGDcD88buZ9HFONA/Y+oJFUg==
X-Received: by 2002:a17:90a:d595:: with SMTP id v21mr23649976pju.50.1627402875481;
        Tue, 27 Jul 2021 09:21:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7502])
        by smtp.gmail.com with ESMTPSA id 78sm4291181pfw.189.2021.07.27.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:21:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 06:21:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
Message-ID: <YQAydzEhZfPUpzWI@mtj.duckdns.org>
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
 <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
 <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
 <34a6f4b5-9055-e519-5693-068f8dcb169c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a6f4b5-9055-e519-5693-068f8dcb169c@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jul 27, 2021 at 11:06:18AM +0800, brookxu wrote:
> Make blk-throttle use rq-qos may be more elegant. But I found that there may be at least
> one problem that is difficult to solve. blk-throttle supports separate throttle for read
> and write IOs, which means that we cannot suspend tasks during throttle, but rq-qos
> throttle IOs by suspending tasks.

Ah, right, I forgot about that.

> We may be able to relocate the blk-throttle hooks to the rq-qos hooks. Since we may not
> be able to replace the throttle hook, in this case, if we register a rq-qos to the system,
> part of the blk-throttle hooks is in rq-qos and part hooks not, which feels a bit confusing.
> In addition, we may need to implement more hooks, such as IO merge hook.

Would it be possible to just move the blk-throtl throttling hook right next
to the rq-qos hook so that it gets throttled after splitting?

Thanks.

-- 
tejun
