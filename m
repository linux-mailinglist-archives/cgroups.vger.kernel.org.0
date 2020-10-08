Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800A0287588
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgJHOAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Oct 2020 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgJHOAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Oct 2020 10:00:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C10C0613D2
        for <cgroups@vger.kernel.org>; Thu,  8 Oct 2020 07:00:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y16so1640568ila.7
        for <cgroups@vger.kernel.org>; Thu, 08 Oct 2020 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQYn98Q50q5N/GLYfX3Z+7jVvi2JaNHakYRoBkO7GXY=;
        b=EHBbaI6273UHbYRwW0lrb+qFFTEFHFvupZksJI9ZWuORueuFoTwZhEsf7VVtmqCpsZ
         Cht1c6ZwHY9nTo/m1TMEZ+h1yTCXN7lRxFHAiuiLVHZ1Mt/P7fibkhs6f/xiAfrpFsOl
         Bwp/PSx7VrCPK+CzQZ+JCzm66XSv3ueEWynzvV1I8plJv+Ap2mytPr9bRQNDrlhvDhP/
         h2kequvNzD2Wxm2xY509SjVvJIhaApynr93c5UffSxxQdYeU58D9f3G1E3lYCLoAXAtA
         6VgUDhKGXGPpAR2x8XGW/+KZ52yqzqZfYYILIIc9eO8tVY1rdWnaQb+gK0fAArhzBBFD
         QE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQYn98Q50q5N/GLYfX3Z+7jVvi2JaNHakYRoBkO7GXY=;
        b=WSMtb1L1wOccWioDZbURclFE/cq2kDIkBuiS31obRxFshr5M5tgs3pjSxCoNPriPJj
         PoHG8OEnCLSBTQpgxloRRCQ8/yyyYUIsGI69R9YdElYZ7Lf6Qm3Lzghn0UMs59biU+PA
         ozMP0sYpVeGfJzsF3OoS5ymC28PT6/YrZTCtC5Zuj2GB6jTD419l8ZMj+gbSXTYRKrvQ
         vA3aX18lNM84LjmGJsi0gEfFSCNpBgNa5DxSoFRBYPdoXjvJ33Evu/hDxr6SDOx91jit
         EGxRJEzAP0dnwuLyPOaBBGpui6DmQ8nXIS3l/t42QLU33ryN4anh+s5yQ5ka5EIQmnUj
         m5Ag==
X-Gm-Message-State: AOAM531h0yAHGVQ5UysyPghg4DpCW27qSYivQsNHf3fdS1vrXwVgj335
        tw4VmIENUcZq06MnqxUXvzls9Q==
X-Google-Smtp-Source: ABdhPJz8bTfhkuOj7kbL7x6L9bDTWe0Ocjzlxf+GJBUuot8ZUyumBYV3HK5f2YHawtln4Fe/QRgBJQ==
X-Received: by 2002:a92:9408:: with SMTP id c8mr6221774ili.61.1602165621179;
        Thu, 08 Oct 2020 07:00:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j3sm457630ilc.25.2020.10.08.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:00:20 -0700 (PDT)
Subject: Re: [PATCH] block: Remove redundant 'return' statement
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <902fc772-4f41-d6a2-0c6b-162da8165f46@kernel.dk>
Date:   Thu, 8 Oct 2020 08:00:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/27/20 6:42 PM, Baolin Wang wrote:
> Remove redundant 'return' statement for 'void' functions.

Applied, thanks.

-- 
Jens Axboe

