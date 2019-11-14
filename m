Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC50AFCFF2
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 21:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNU5O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 15:57:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37888 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKNU5O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 15:57:14 -0500
Received: by mail-io1-f65.google.com with SMTP id i13so8422364ioj.5
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2019 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+zRyTXSqsn14PHcbRVeqya++muSJS/9tbPO2TQmYKyI=;
        b=JXthpDS2Apo9bS0yseA7zp9cQw9BxxKl98mjs8tYCAgoOE4ohNuBJLekoHzyc743rY
         4IkJz78r92cUaMzbva9yPNFGwfk4K9GseDXO4VFknvUyZAFHHKWwazXA+d6w1uEbL5ve
         BbYnJTsWAHNlK3hHjq1F9BZ6x6T8YLDBtXx2hAU5q/E68FIqwZ/L51u+hp1ka0hvhfLC
         OHKKKQT+Ew9UuECOdPsVsflaR2mWIZYjmXitwmP0aBZ4rEgEQclcPFshMzKyTQrjHg6W
         UONoKPO+Rhs31wA2jBrleq64lpOQ3gUzxMhlp0pqUKR7ba84Joms5gIvk31xyua1cY1o
         MRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zRyTXSqsn14PHcbRVeqya++muSJS/9tbPO2TQmYKyI=;
        b=Ea+6BUfQv6sifa/vl+aDcjyhlFRRR+MQRzVCn5UXePyVzGHlpghzUeHm8JrHS1DhGn
         cZl5XA7KPia3TNPW4uwdzMelq1YXLqN3zwYHbUeNkfwZGwFxNS9tTwPi/2KpwI/NsO41
         gwhY+p+6s4upzSRxO2SWxSTpZIn+zacVBQckVGX2C2fwLWoaEm+jRZNlit3mcyqAqQ4G
         utlk43IjxSWBA8F0/F5ZE1MMtkqYpViVOjuErOcdF6i6J3BVOIBkIQOOFQ8PcqPY94ci
         tURSYb5P7YlZ/cZ2icG8xlsqK8wJb/1BO/pGWCGWMQbGTQvDEH3Ynmxxnv4hKYRNp/Ge
         yNjg==
X-Gm-Message-State: APjAAAWl8HIFR2BKHWQ8yUA9yNFYljyiqlclVCGB5QBO6/obetqzdx7Z
        pSQOhFXFmsbEtGbw0oS9hUGX4w==
X-Google-Smtp-Source: APXvYqza24GgqwgSnIzFlA6lqAbdIACAyJMIKBue2pGr3gGh6xt7XisuDUJ1ildp0zfFEJ21CmzsJA==
X-Received: by 2002:a02:742a:: with SMTP id o42mr9402201jac.24.1573765032948;
        Thu, 14 Nov 2019 12:57:12 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q144sm654621iod.64.2019.11.14.12.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 12:57:12 -0800 (PST)
Subject: Re: [PATCH] iocost: check active_list of all the ancestors in
 iocg_activate()
To:     Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <1573629691-6619-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <20191113162045.GH4163745@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e07d068c-5b30-6327-d8df-1be42bcf943a@kernel.dk>
Date:   Thu, 14 Nov 2019 13:57:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113162045.GH4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/13/19 9:20 AM, Tejun Heo wrote:
> On Wed, Nov 13, 2019 at 03:21:31PM +0800, Jiufei Xue wrote:
>> There is a bug that checking the same active_list over and over again
>> in iocg_activate(). The intention of the code was checking whether all
>> the ancestors and self have already been activated. So fix it.
>>
>> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> 
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Jens, can you please apply this patch?

Applied for 5.4, thanks.

-- 
Jens Axboe

