Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2587697F3B
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHUPoG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Aug 2019 11:44:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46746 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHUPoG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Aug 2019 11:44:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id p13so2188944qkg.13;
        Wed, 21 Aug 2019 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WsaM9eIl3JXCekJs4SyvVa1WU1qEuim85t6paiIn/CI=;
        b=gBwwCIlRoRsncPrLfulxtiNtBqDslrrk01qoUakj7ROxgUCe2Z1Jkie5QrOYx6cy1t
         ittH90Nf5mi+zTDNL+DT/YD22t+Gq4e4G1xT2KXF/IWYBadFqyiJVb1YtkbDxqokGJbz
         2FUoS6prtlCz8ZqXUlLW/C+7dfISWWedqHkc26+Sgeb1Mqp2ByRaRx/BYT26Raskd9fG
         dZjhnF77bE+uuLLYKItQJogKGqIj7IlYf1ScdYDDqpVrQjz0D4D0XBpaB0hrYBHvxLq/
         4vetyes91YzvtHonebCbwxVB9w4U7blReA094/muNGax4e8R6EiuBSsk9XlEvN3/ON/Q
         mn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WsaM9eIl3JXCekJs4SyvVa1WU1qEuim85t6paiIn/CI=;
        b=FL+kYhAHDCr1z9tg7egO3tgoYVjsPgTrnQQmMOatTqndvwWqAaKNNlF/Yipv0TltsH
         MBVwMrY3JWhOpcZKrisU9Hski//xTqISoSTseS34Qm7C5Cp8HYJwXvC4tghkglklZvnx
         SFirOgQi++FUUDMJkpdfv7Zl87uD5SrPFT1oDNJ4r+Cxcki6iDFnCRlISwrr7O3tAF+l
         3YQkUJOOyFiqiIj9Tn4P7xPxVbD0Dd+/Wo13cQ8aMy94i2+8kPqp5ips1+nZ6GAMCfvX
         6NCL3jotSMn4A+/Y/Sq7xrL//4prXptLf7ymxsi6sAF+2UbRYC0y63cIiRQ9zAODYvBl
         6Lzw==
X-Gm-Message-State: APjAAAX6tuADOYs0IVz6qnfo19mpwuv7i8crTjwqE39CNzkfKKghU/0R
        gXBSJkjLoQofoBxSoNP8lTs=
X-Google-Smtp-Source: APXvYqyoo7O4zfbKH6+h9K44hSm5hrR8vMIas7kYusKUQEoRDkhQgiXDaxkhQ2c9BF00wPuPLVmdAw==
X-Received: by 2002:a37:8c07:: with SMTP id o7mr16922667qkd.491.1566402245255;
        Wed, 21 Aug 2019 08:44:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id r4sm10171491qtt.90.2019.08.21.08.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:44:04 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:44:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Fam Zheng <zhengfeiran@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, fam@euphon.net,
        paolo.valente@linaro.org, duanxiongchun@bytedance.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: Re: [PATCH v2 3/3] bfq: Add per-device weight
Message-ID: <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
 <20190805063807.9494-4-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805063807.9494-4-zhengfeiran@bytedance.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 05, 2019 at 02:38:07PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>

Looks good to me.

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
