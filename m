Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67462462927
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 01:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhK3AhD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 19:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhK3AhD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 19:37:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29400C061574;
        Mon, 29 Nov 2021 16:33:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so79341716edu.4;
        Mon, 29 Nov 2021 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAWGRtmFkA3dGuVLOofW70iShXqEXTjub0/LjbjNnFs=;
        b=IQRCFvgoknPXI0N4anxUO98CR3D/fjWKhTqrhYTYwOKYZsKOEniugBe0rkgFDw+pEU
         DYclfBs3n0AJ5fN2vus+UgQSerhKFugGcb6Mgd7kxRc1vYsU/DHjCV9fFtV/ymONFo4U
         LA1VGMzsfHSyWs5RXIv3SdFR/hzBwbKXS0WGdTu38+8JoJD0maFQIsPL+h6/Jq44ezcT
         p+X1xcJLRcr82Ge3gKfMSIAFbmwPKjBxN5AaNadC6jgyqyIgRnGfQ7RITSQPRobf5+Y8
         gk2GMJdFxz8lfROwCzTbf45184nSX0StWPKlVXexB1B778+GjEdlyaC/+NcBi5arD68v
         E12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAWGRtmFkA3dGuVLOofW70iShXqEXTjub0/LjbjNnFs=;
        b=BwXVCCi9dkmHLCPyUQ8uqwEndzrLIY8Wh1Nj1+cCC1NKjnKleqEFtVaY5HF2l+MpZm
         oeRQu+piyVRfBW0CHon13AjLNWjcqPu5pEFuF0XeyGOP6VmGP9WBroCuVMHkt0oq1RBB
         UKQUj5HVSnq2UDONmTVlMoF47SL0d7bvGOeD5lHq2i6uhHsNL3AHx/bjd0yphrhYe4Ey
         jUjkY5FTRdnpSpMvatkc9scX+pz1T8uDidiFsbA2pgt5yWO3ouRqD9aYlCSFgRWJx6Tl
         xj6Sqp8FLKXiY7Dzj/dHjkRpdfl5N0+SvMu/NvmIahTvZEqpi/bFcpGflVJZKyTu5VvF
         PFlw==
X-Gm-Message-State: AOAM532Uobb5mjiOlUUpuIyd5iz05lOhg5ZS2Czuelk4s/8ZGMI+bV3s
        feMQPA9/lx+MZ+NDwyhgLsc=
X-Google-Smtp-Source: ABdhPJylgZCE0afSuwYl768krAFtUqxsKvBOtr2B8YBB4Gp3PnDkZuvBHoXju5xrMbFbWso2TPXY2w==
X-Received: by 2002:a17:906:b304:: with SMTP id n4mr19543422ejz.116.1638232423198;
        Mon, 29 Nov 2021 16:33:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c7sm8397536ejd.91.2021.11.29.16.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Nov 2021 16:33:42 -0800 (PST)
Date:   Tue, 30 Nov 2021 00:33:41 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: cgroup_subsys[ssid] is never NULL
Message-ID: <20211130003341.kbakqtpjffvprxxm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211127145919.31159-1-richard.weiyang@gmail.com>
 <YaUPej4QUZoFAuOM@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaUPej4QUZoFAuOM@slm.duckdns.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 29, 2021 at 07:35:54AM -1000, Tejun Heo wrote:
>On Sat, Nov 27, 2021 at 02:59:18PM +0000, Wei Yang wrote:
>> When the check, (ssid) < CGROUP_SUBSYS_COUNT, passed, it means
>> cgroup_subsys[ssid] is defined to its proper value. It is not
>> necessary to use a true to enter the loop.
>...
>>  #define for_each_subsys(ss, ssid)					\
>>  	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
>> -	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
>> +	     ((ss) = cgroup_subsys[ssid]); (ssid)++)
>
>So, now the compiler has to test whether ss is NULL or not before each
>iteration even though we know that it's never NULL. The whole point of that
>"|| true" is telling the compiler that the pointer is never NULL.
>

That's interesting. Thanks.

>Thanks.
>
>-- 
>tejun

-- 
Wei Yang
Help you, Help me
