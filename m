Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BF25A1B2
	for <lists+cgroups@lfdr.de>; Wed,  2 Sep 2020 00:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIAW5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 18:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAW5q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 18:57:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B03C061245
        for <cgroups@vger.kernel.org>; Tue,  1 Sep 2020 15:57:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c142so1708583pfb.7
        for <cgroups@vger.kernel.org>; Tue, 01 Sep 2020 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SCB1R5S0rIlXAP1gD/42mN3rEFGnClEAzglzWI/f5A=;
        b=kx9pMxbaG7HxeA/hSNOaElEvYF6zneOI88aycKG6Q8jpxb2w7bV344cmhdkTDMxzM8
         s4owDu6/DO5Uv9cHyTnKBdmy+nqJhz7wwHz61yAXmFMMhK4Cu789DJwxYjlbPXe0s5+l
         1eE7XdCSERl8fSlQzYXHj1ACbWfO6xdmj6kFMFBA+oZIO+F0oUEUFwv1qB4zVLOSf3Tb
         cEm0nPav5qtkrw25Z04awrm9iRz2WofDvEuWX38Z7ApDCYln3CV04pw1ye/mPQ710zxe
         cuHimPUl3H9I9rn9HJAOO2hqAuXJqTUInl3Y6aiY+aq7bLFN524E3gnv+652wfX5cgO4
         qCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SCB1R5S0rIlXAP1gD/42mN3rEFGnClEAzglzWI/f5A=;
        b=JYoddV53qUusbjiGC8Ul2kyTqKbwt52/EnD2s5mMWVcYhqsMpA0PcygT62C8wThy8V
         TWYWKLSS2lg8xZ+ybH6ezY+pAtHIsikTHKFD5ktTY4RVQPgNzRTdHGhk2k8SCFXzYhhO
         XBgKUoFuF4XGo0PBxQ3ThpmLW2oY/qxY1MzyztarvYE8EQVjoLbq+rabUuhfGO3VhET9
         VEd4FJF64qCzuTu85U/GojMpvmk+e8YZPSnKh1B/SgqKHXGdsCigNaO1OMzKjW/Pcqqe
         uJ2OtbR0cFWhOmvHhhs2ul2uYLUAAfjY1f8MQwBSrn1/CPvkxYqZf/swotuT7iNDvgeD
         tY9w==
X-Gm-Message-State: AOAM530ZdMFdLAwfaDL94fxYH4QQmCsO8Ot8FqeGCEzTN19xzG1n7W9/
        NM7wqoet8UB5zLlmmvX2AtMKJA==
X-Google-Smtp-Source: ABdhPJz7/PuTI6toqDV7Y9ZAOMNodGuUCNOHnU2Zfi3eqQltoMCij8HkSX98gsEIVX42xBTyba1VqA==
X-Received: by 2002:a63:521c:: with SMTP id g28mr3479485pgb.247.1599001065304;
        Tue, 01 Sep 2020 15:57:45 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q5sm3122211pfu.16.2020.09.01.15.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:57:44 -0700 (PDT)
Subject: Re: [PATCHSET for-5.10/block] blk-iocost: iocost: improve donation,
 debt and excess handling
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com
References: <20200901185257.645114-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cac016f9-ee13-9fd4-22b2-8be0d830f076@kernel.dk>
Date:   Tue, 1 Sep 2020 16:57:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

1-2 applied for 5.9, and the rest for 5.10. Thanks Tejun.

-- 
Jens Axboe

