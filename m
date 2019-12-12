Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3447611D0C2
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 16:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfLLPRp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 10:17:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39792 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbfLLPRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 10:17:45 -0500
Received: by mail-il1-f193.google.com with SMTP id n1so2334216ilm.6
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2019 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eomPDhGlMkJa5hw3SQ+p2cD6ocrcZ+qwzGvgSybIfF8=;
        b=1jJNlB/qae3h4JgDt0Y1SB0vy7eormUawj6HVkWTr65WDefAU5u/FrkwRsajrRIyqd
         PPDomMVapKmGshnA/M6jzftaLfeNEQQEwvjVULCS8qqqq2DcgDmcHA4T+sza8JGU3MbT
         I4pYW8iy8HJt+5ySxolimSHNdFTwguypU+5RLDwSww/k3uA34IoGCzwHxzAc0PDMu9rW
         gdHiupPvY8SKPJoDA7zDwHgMTmuQ/tporqWmoMh/HYRpY0dYyFfjUAMG/aWUVEcLmqML
         z36CE77atWeGRtnlkg1pH8xKMh6iKN4JMQCT9cCGrDCQtNhtFr9RPSeVKBK1XtW+EWTh
         Pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eomPDhGlMkJa5hw3SQ+p2cD6ocrcZ+qwzGvgSybIfF8=;
        b=lFK1xdDVPSW84csUEywqcKz8/htndaox2lhVJhNT0pOUrRJv0a0OEgIMazKq7OVx2T
         vr4PRrlQfO4HIaC4jAbVIsA9WSoWFWp5nd6+E6haMew61VlK4JEKd3aXbkd/jRHYLS4x
         fKEjyUalj0SGeUiXo/ZLEvy7FWWxYsXJHLHg9Y5txRSyBRM6Iq/gFWi2g385uVT1L6pO
         KS5C0x8+RRZr0HHtBZTE1l+eg+vDp0GvtVPr8aHKp6gAagFCFebhdzMXzne3ijPqjbTt
         OIPbVnNAgWcNfg7sqfbCZEFTVCagLUTsbZgydv3reO8TXTK+JKr8sA4wtSEKyeCn31Ov
         xLgQ==
X-Gm-Message-State: APjAAAUpV7gSLkm0HdCVS7fNcVX2RO3KqQTL/BErSjNfnmW2gROr6E4k
        e7HxkQCHUKZ4ovPPRDoU0O1LKoePZ/trXA==
X-Google-Smtp-Source: APXvYqztPbope+PAr+dOEEI1P5hXeWFYdrfFlD+f89jbYQG+6Th/TE7e1VyRTiwlCiNSqrQJAcZ/vg==
X-Received: by 2002:a92:884e:: with SMTP id h75mr8730645ild.199.1576163864702;
        Thu, 12 Dec 2019 07:17:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm1302166iov.45.2019.12.12.07.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:17:43 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: remove blkcg_drain_queue
To:     jgq516@gmail.com, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0cb5895c-aa35-b65a-83bf-81f5444e562f@kernel.dk>
Date:   Thu, 12 Dec 2019 08:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/12/19 7:08 AM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Since blk_drain_queue had already been removed, so this function
> is not needed anymore.

You should remove it from include/linux/blk-cgroup.h as well.

-- 
Jens Axboe

