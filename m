Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C708D46269D
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhK2Wz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 17:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhK2WzA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 17:55:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FCC111CC7;
        Mon, 29 Nov 2021 09:35:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p18so12734707plf.13;
        Mon, 29 Nov 2021 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNad6ulQb2gA8R5sf3rwypcW1oTk+N6PJavU21UoSX0=;
        b=FWGyKh4ir5dwLU6wzNY4AJLk7HljqhNMYCeFeVvaqxs8gCT50QJ3U9flAKWziqBkf2
         FzjNYNrbWyJuqX3bpLJzG1t/HB6WsNsu5AZQRT+j276x6Xc+sIHok3QqohhwiNvjEt+I
         bHs6cBnaZ7EOnF3Djjg4IftrmvvmsLvavkapkrluDn9Vem/m/8k7LrMKjHm7/s8TzKgj
         rWCb6qsPd4owm4M5CTfPXHnKfeiaMsCargSrBEpRCZ1HYSqvDpWmYv1PSeLXfTUNfKsq
         +J7M722MkLXPzJBLNbw9Ohzriae/gSsCaenN6sbv+znTBeXsbnn85WHsWn2m2+qa6XWA
         8pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MNad6ulQb2gA8R5sf3rwypcW1oTk+N6PJavU21UoSX0=;
        b=Gz9xmxBzJwupE2SzEKAV1OpM+aLintZGC/S1eXK3DXQrM0ZJuDXOYFZbuoY1J8RNjq
         GUzu1Yp9/wDBVGEh/NOZXKv9IIryw2U2PbKyrmDhB8LrzO7GLUHPdw++EK6ehZHUHYln
         mQnEpU5Uzz8VOMjnMRRkHt+WDBBODyNlT/KsYYXpjZClRRryoApEk7DmR8KJOLxtXDcz
         bfUsifoYHSkEr1t3P+9CwX6H2ur9I+B95h/W2mGz2bciVD/Lb4K2RYlOtZ7fAcTq+CAN
         hcBUoCmJmP4mUdYnevEqhxKPEVk6XtCJSw5DewbZxZqjteTOeCZDICkcwJ5J+uJYzsdV
         FqCA==
X-Gm-Message-State: AOAM530UDkyZVEdmtGL9oUT/Kl7bd70fw6RhiOkxBXMboI7GG0s5Pc6a
        V2RT6gUn4nwA3VEBGGqgAwk=
X-Google-Smtp-Source: ABdhPJzcjotUvZx4joQPXiT8zC2zS1X5J4SXyJ1sKQR1Fd/gEc326Rm0xoaCsUBLCHLC9nLDPV+/AA==
X-Received: by 2002:a17:90b:33cf:: with SMTP id lk15mr40118985pjb.85.1638207355841;
        Mon, 29 Nov 2021 09:35:55 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p8sm19319216pfo.141.2021.11.29.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:35:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 07:35:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: cgroup_subsys[ssid] is never NULL
Message-ID: <YaUPej4QUZoFAuOM@slm.duckdns.org>
References: <20211127145919.31159-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127145919.31159-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 27, 2021 at 02:59:18PM +0000, Wei Yang wrote:
> When the check, (ssid) < CGROUP_SUBSYS_COUNT, passed, it means
> cgroup_subsys[ssid] is defined to its proper value. It is not
> necessary to use a true to enter the loop.
...
>  #define for_each_subsys(ss, ssid)					\
>  	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
> -	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
> +	     ((ss) = cgroup_subsys[ssid]); (ssid)++)

So, now the compiler has to test whether ss is NULL or not before each
iteration even though we know that it's never NULL. The whole point of that
"|| true" is telling the compiler that the pointer is never NULL.

Thanks.

-- 
tejun
