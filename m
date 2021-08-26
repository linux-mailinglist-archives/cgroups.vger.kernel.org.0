Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA73F7FF4
	for <lists+cgroups@lfdr.de>; Thu, 26 Aug 2021 03:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHZBff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhHZBff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 21:35:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E51C061757;
        Wed, 25 Aug 2021 18:34:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u6so642627pfi.0;
        Wed, 25 Aug 2021 18:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tp+HuDAKrxLDg/2YbkAeAyqQwvPdfQEmonlSS0UrGxo=;
        b=ZuvSEK/4HcZ8UVE3rknY0O62RhjbNmlM4gEgBj2bbfUbVSAoMuvtM97YrfYp3qe1lN
         6E9hgnUnwNPHeFXaq1qXa0leSC5VMhIMRrTtqpLPot4dWLngA8rR+yOJQoDhYBm+yGaM
         ljoO9lXixo7H1kxUgZoluJtxxSEYWFe/Qyknei+Jr450NjXggnqDeXaZYMfefLxwPRhJ
         uAsBKBpVzkP4ZTxyIBlkNTDVcXoBG6Q70u18czI80t+OIvbvlNwktNg22ACKBPNGgvHv
         +l4ot/+eqqtyz65V4BsUeD67OCbPMBQz6wc0eUoS3mG9ghSwU7xRuJ2WGdSix+2lDRYf
         E8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tp+HuDAKrxLDg/2YbkAeAyqQwvPdfQEmonlSS0UrGxo=;
        b=mcgSiu4avDEt6LZbI1VS0fWwHOprKeEGDFdA3xULtz2ohhLXOLnlr8lD6jnU726bGC
         hG8ik4lOIFe9KIXiDK4vyvbg1+mRCGN/sdtuRhGINI0qiCLgXQhNljyJaNp76TVnbMBS
         3UChKEHPgTaukcZ5mjBvkrJi30Wm5JImgEjNt+iEuRhPJnuku1pb69zP0ttmVerjStA/
         gOnSkBr4NRvIBfHpXIhgRDhPCJA9JGEBMxXkc0j/dcBigIE+9G04EMb5JLumOjgWiiQa
         +Uv0WpQptryR6IlJmvJp/NIbwts5rfN7Y3qiTZC8I8xIZFo2JeQ+4iGLGBCVEe7MtwGL
         A7vw==
X-Gm-Message-State: AOAM531Flm+pFay9vZIA73aws9sp6SV8TFD3dyqSsUxDlkZXLJ0oHyJx
        hv8zm9te73viZn1OQZhnFjEIN5f02e4=
X-Google-Smtp-Source: ABdhPJw/HUoTKAlv3DlYHCajZpXTM2u5p8zX5RZ71b6M8hNz98irMrxMh/CNt7Q4DF0mwUM9jVBJpQ==
X-Received: by 2002:a63:1a65:: with SMTP id a37mr1058222pgm.338.1629941687842;
        Wed, 25 Aug 2021 18:34:47 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id t13sm675427pjg.25.2021.08.25.18.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 18:34:47 -0700 (PDT)
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz> <YSVDwc/1sEmXdOK9@slm.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <4ed67493-e595-e002-69f9-1f53662ba189@gmail.com>
Date:   Thu, 26 Aug 2021 09:34:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSVDwc/1sEmXdOK9@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/8/25 3:08:
> Hello,
> 
> On Tue, Aug 24, 2021 at 06:44:23PM +0200, Michal Koutný wrote:
>> However, the non-hierarchical failcnt interface looks like v1ism to me
>> (I think new features should come with v2 first in mind).
>> What about exposing this in misc.events file with max.$res_name entries? 
> 
> Ah yeah, good point. misc.events sounds like a good spot to put these.
> 
>> Or if the hierarchical reporting is unnecessary now, there can be just
>> misc.events.local for starters.
> 
> I'd prefer to stick with hierarchical counting as the first step at least.
> 
>> (That reminds me the forgotten pids.events[.local] rework [1], oops.)
>>
>> https://lore.kernel.org/lkml/20191128172612.10259-1-mkoutny@suse.com/#t

The core logic of pids cgroup and misc cgroup is similar. Is it possible for
us to merge pids cgroup into misc cgroup?

> I think both counters are useful - the number of failures due to this type
> of limit in this subhierarchy, and the number of failures caused by this
> particular limit in this subhierarchy. It's a pretty subtle difference to
> encapsulate in a counter name tho.
> 
> Thanks.
> 
