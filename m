Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8F406D9E
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhIJOah (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhIJOag (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 10:30:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6632DC061574;
        Fri, 10 Sep 2021 07:29:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so1245449plr.12;
        Fri, 10 Sep 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o86Ela2dKbz2GzHznXe/g7ScOOJeqlE0Zm5503NyBDQ=;
        b=Bxn804R0i4B8zYlx7gxgC59R+MuM6Dyg5UPT8+rmC10z0AGCD6J3RNEhD4t8PqcsUy
         XjMywQShlJsNUa+mJ9R3hTGfLxIvIo07GAicJZuvELS7AJouCi2m6hd1QT85YqLEVt3P
         XXQ9urfO7RBljpYSWvgX9x2iQRIUdVRgj0X77MuEt+hZ/M168SMbUg/Y5X/r+BBhbaSo
         V4w3Y1lCO9+JsoJHPpuhPazv6MIKsYMSV0vY+xb/4+r2sN927yPTM5HUm5qXYPk881E2
         dIWPDgI/Ph4IXh9dIIRKZ8jG0g/FhwDO8RHAg45Co+dMRiaSOo7umTTON+QCRPQJZ3Sq
         ZVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o86Ela2dKbz2GzHznXe/g7ScOOJeqlE0Zm5503NyBDQ=;
        b=XOqeU5aFyZX4rMXX/vZK6tDA61/qV1B3D3CipjHAFc41W39+asr+t0a0a/RDJSVZdk
         S5rBTGtLBnOaFmePXk373EtJWqF5xNDqNbiPY+nG6PvHSLrRDZIZJoglGFZl+GpP1sAS
         fbwWxSh3MsmquS1zKgnMnYCH0ZNtKXhcMQmv5P7h3W+w+1C+PmdeuQNWLV8OpSzn+sqp
         h8q2uRiL8xW+Ey9i7+1uPCryGGQxe3SxuPb4Litl4O1Ls6n/SuQ7p67VDRlqtbDr1bkS
         3ySF5jT4QvbzvCBYDb0re47wNnu4LiiWvvKEUPO++GDgDE5RnuiLdMykYl5NlMWddeQV
         sTUw==
X-Gm-Message-State: AOAM533YJq3FyHTYZyf7spEpMkJzzctBGYAPqVEu2OLtIh93aSF3eeJ9
        VD1OQuqezNIXI4PIImppMF0g+ULd1ew=
X-Google-Smtp-Source: ABdhPJyoIdwdFlmc48GY7GWGq03DQnpSMhTFP0FoOvjB+9/36dIF4EcDA+56SuktLEAMcBU/i3W8wA==
X-Received: by 2002:a17:902:e5cb:b0:13a:f7fd:cba2 with SMTP id u11-20020a170902e5cb00b0013af7fdcba2mr3855598plf.85.1631284164660;
        Fri, 10 Sep 2021 07:29:24 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id s17sm5134942pfg.4.2021.09.10.07.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 07:29:24 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Vipin Sharma <vipinsh@google.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook> <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
 <20210910092310.GA18084@blackbody.suse.cz>
From:   "brookxu.cn" <brookxu.cn@gmail.com>
Message-ID: <1679f995-5a6f-11b8-7870-54318db07d0d@gmail.com>
Date:   Fri, 10 Sep 2021 22:29:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910092310.GA18084@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

On 2021/9/10 5:23 PM, Michal Koutný wrote:
> On Fri, Sep 10, 2021 at 01:30:46PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
>> I am a bit confused here. For misc_cgroup, we can only be rejected when the count
>> touch Limit, but there may be other more reasons for other subsystems.
> 
> Sorry, I wasn't clear about that -- the failures I meant to be counted
> here were only the ones caused by (an ancestor) limit. Maybe there's a
> better naem for that.
> 
>> Therefore, when we are rejected, does it mean that we have touch
>> Limit? If so, do we still need to distinguish between max and fail?
>> (for misc_cgroup)
> 
> r
> `- c1
>     `- c2.max
>         `- c3
>            `- c4.max
> 	     `- task t
>            `- c5
> 
> Assuming c2.max < c4.max, when a task t calls try_charge and it fails
> because of c2.max, then the 'max' event is counted to c2 (telling that
> the limit is perhaps low) and the 'fail' event is counted to c4 (telling
> you where the troubles originated). That is my idea. Although in the
> case of short-lived cgroups, you'd likely only get the hierarchically
> aggregated 'fail' events from c3 or higher with lower (spatial)
> precision.
> What would be the type of information useful for your troubleshooting?

Through events and events.local, we can determine which node has 
insufficient resources. For example, when the ‘events’ is large, we 
traverse down and use events.local to determine which node has 
insufficient resources. 'fail' counter does not seem to provide more 
effective information in this regard. When 'fail' is big, it seems that 
we still need to use events and events.local to determine the node of 
insufficient resources. I am not very sure what details can we learn 
through 'fail' counter.

> 
> Cheers,
> Michal
> 
