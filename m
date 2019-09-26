Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95499BEC5E
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2019 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfIZHMm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Sep 2019 03:12:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39068 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfIZHMm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Sep 2019 03:12:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so1290568wml.4
        for <cgroups@vger.kernel.org>; Thu, 26 Sep 2019 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/+FmsO2fNzcsmYglT3xz6RDpSXgM0989c2PSz8Zvf4=;
        b=VFGoxo+2NsxxwxjafuC2PpLHAFStjdosoGEbFmrM8SZ3rrImY4Sqc1/3J0DL/nSiek
         cKXmLnyFis+D0MbKrVE0ATCMolB8ETO3TmYRdu83WYIqnQN2/9Kr879GEZ2XHDJJp0Np
         sfEk1iSsp2VIf4BX2N7yHGkfOznLAcThCZOePG9i/g9qzTRvaEjv8bR5rGYL86uzXlQx
         FVWTg05Jc+tDb3dA6Y661ABAFal9Jdn4j3GNAfXvyNBLm7YFtNgG3YtiZnpvk0ZpjpRu
         SfIdUGBrMNXSt8Y7+NgK6sl1kd11BTn6K3rme6akMMJnevDRjfsXmJnf+0J+hfgcnGmm
         f3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/+FmsO2fNzcsmYglT3xz6RDpSXgM0989c2PSz8Zvf4=;
        b=Qz4tfU4uiWEzPJDH6f2IByOKT4gyr+e0jp3b8E6x+CONGorwkbOwPUucmR4BQkokVv
         Ejfbb5aOIL5A0ooZMQLCO9qTt6uqKRWFEz6nlKChsWex4hAz8bji9NuXTd8YPuxjuklI
         JcWkOAtaHdN87zCg8F96ZaYe1A9QN8lMRGk02qO2oKdpV5ujeZ3h2pRRo/RhJTO8FEmM
         aPPmVH7/rPSbm4T02RbSnAROoCloUL+JVOc/eniZNtOjLn++yNHuD0Bt9l42rLCCwtzj
         yEgtrnHmghMqxgfnbTi73vzLcUdf+qBenPh54cr6veFALoqyAavlqwOaWfx3gWoX3ETa
         MmaQ==
X-Gm-Message-State: APjAAAV8+0LD+Lo1DU98yQzZRBh+cXSTgvLUU7BoerprjlxF1K0Vjm3E
        0va+77di2xh7pbXmTw5ZS/YrLgmAL0w6PTzB
X-Google-Smtp-Source: APXvYqxUdYUgUVi64u3ylV/Yid+SC9QyZEwS24BKb72e7Ncis6ktKTA6eLgV/hoc7bSxXa1p5PZeZg==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr1547161wmc.36.1569481960055;
        Thu, 26 Sep 2019 00:12:40 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id a14sm1398033wmm.44.2019.09.26.00.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:12:39 -0700 (PDT)
Subject: Re: [PATCH 1/3 for-5.4/block] iocost: better trace vrate changes
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <310739da-b606-6485-9979-9bc03a592265@kernel.dk>
Date:   Thu, 26 Sep 2019 09:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/26/19 1:02 AM, Tejun Heo wrote:
> vrate_adj tracepoint traces vrate changes; however, it does so only
> when busy_level is non-zero.  busy_level turning to zero can sometimes
> be as interesting an event.  This patch also enables vrate_adj
> tracepoint on other vrate related events - busy_level changes and
> non-zero nr_lagging.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello, Jens.
> 
> I've encountered vrate regulation issues while testing on a hard disk
> machine.  These are three patches to improve vrate adj visibility and
> fix the issue.

Applied 1-3 for 5.4, thanks Tejun.

-- 
Jens Axboe

