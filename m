Return-Path: <cgroups+bounces-8945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F4B16943
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 01:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1821AA36F1
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377984D13;
	Wed, 30 Jul 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShHoe0Lc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BA22318;
	Wed, 30 Jul 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917565; cv=none; b=UDA0hI70Nwl6wZauBg1gGMEjcR5KSeIK1RQldqe5X2qxHFGP7qcYUWjwNDmxYQ9ke9EgGyez0DsIE23UvgOTIzWhDncIhJxV2Bbc2VnaCjcZcYP9+Dce/ZUs7V5+SRVloTBAEBqAs6iz+YT7SoWUspSPsaKNS8+AZk6XbLcaILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917565; c=relaxed/simple;
	bh=pfMEPyAlmbg51/rRRPFggrrQ5K9ogyYDkxL2xa53jH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRUCgpjGrq8k1nFwKAWUKMHgjJcSHDKYE7/2wU8skuSlkvRpdmVzLBs4wfyeNOyem24Zm4dwQ1H8g0gaEBrzv+hVC4LxEDShxr9Iy7ZvL9NYV4TIaDEFb+3fooD7YqF/TXs8fXfppreZJnhgQZtqX85Fd5pQ+BN6YSjpNHi9jnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShHoe0Lc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24031a3e05cso2163295ad.1;
        Wed, 30 Jul 2025 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753917563; x=1754522363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8s2S0s+Q/X3hyGBkcdxZoJhfiSXZ24fRAddp33bdKFs=;
        b=ShHoe0LcUxgHICekZHG0QGliUId9s0md74EgYKchiIdW9OEQ9Glm80k/pvvg0j9apV
         ti3cY9J4IwKtDH1kFjYoxgAg5uyAApkjy8E3cILSmJLuSNsxaGorn5Ai73CbyRbUeIiK
         tzmWpYFdvv1WAgrdWnuLSyOwqgUfwmoG90E3/DhIulgpLe5GgDu5DdNDOCnJKTaTkw7X
         Y/dBti53uXtWJwFkBjwn00mE07+BcTrb6yEdgyR5cMujiIMKW9IwPKBCxBHaC34XUplY
         IBRG8R59LlORZvYXoNpMZs6QfWtFCVzO/Yl8g0fJvtc5Un4aipx6wZ+K/qDtqREPHDHa
         cfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753917563; x=1754522363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s2S0s+Q/X3hyGBkcdxZoJhfiSXZ24fRAddp33bdKFs=;
        b=P7hOSY03MzvXir5P+Au12nrQam6xYW5qwwHVJuHpHfQ5ZfiwQNWCL+yhR67h9Jgl4E
         bWDqjwLxCaVCeXy3m/ZhrnBa9PMOVURxIRU3HZdPDyHpU8JVTlb/8bslfBrVoIaYbSRA
         WlRWvtC2DEpJcKeK4H42oqz6Bpcu7iw+gyfE1fnAEIS2vGqMnvRw2EZ4CgxtmWxZwXW2
         iUwvyOio9PRMWjXqoSV/lS6C5WpfWcNoxjG7C2EEf0ktNkVP39wXNNs74/EtuaLbiIku
         uhxmZDtylCGnBKPbujwTS8JOS/zCDZpqpBmtWThXeB7ipb+udRGNHCr9FJDqKKcgpZXz
         Ch/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKjIGEvvLzXWXtCorAw3n1oLXrQkd4dq+4Ya8R4rhdiU/kobhH0Vtby+F2OvuEJO6XN570/4s6@vger.kernel.org, AJvYcCVuXVR7rRiwXFMna/DzPlfTGO3bPEvHNKCESMWXTTJ18Jp21VAY0+Ni8xYZRMs2gLnWPQICZlqEjmRve1A=@vger.kernel.org, AJvYcCWxGvi9DszWnzdVAYRrCw48fdsfmFC6q2J5/dV/a03EBxTXls+ytSPffAdpbnjznBG7VG6vByfL8rj2tJOX@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCvmMEMbky7LVnNlZ4dIWlWGDrxfj7EONCj/9/B9YdVSTq0CJ
	RKvpWO66aoKqE6vTXCOYZgLlwBe5C07cRCzESlpYKkxg7YO67U3YBMZbvUki5A==
X-Gm-Gg: ASbGncuQTbE7G+C036IUT9UOB5HPc4HDwF8mdj5BnY2nmL98AmLDltvvgObR2ZktN1z
	gofzNqKt8QrtSHmMWSr1SPtL1fuDm6twCAemE+AO5mNK4RryBFVEcqnsouiDls6H8767obAHbmw
	k3CU1uSbg+M5Dpg9G0KHqMB+kzRVt8DBqGKK7bh+I0YbaeejF0YAEIVj8R+4f50EH5p65vFOJn9
	YTkFayrkC93XPOMP9g4zxTI8mV89o3o4iIaCmla2frP0/C+v1n1GZMoq9hXo4b6IWv0n0ARdXD6
	XFG9A9KxThJjWH7Jqb0z6xeXMIuDkeOS6dXLbJ/ve+qxPCruE2O/FkrMRaXm0hPsuAVqOsJO+Hb
	NEBro+pwQnloofi1UgtX9QzKQHPNtT3Vh4S0QP3pDoe4Hc5/jcmTQnkjkNwRAjp2W3ZsZ+2A=
X-Google-Smtp-Source: AGHT+IHp1T7v3GeCocoi+vdpH0GVxi/ojy+El4cAzOnyOVrliuqPIbmBJ8oLLpVSUzUfLZCNcqUVig==
X-Received: by 2002:a17:903:1cb:b0:23f:fa47:f933 with SMTP id d9443c01a7336-24200a5a8aamr65125ad.8.1753917562757;
        Wed, 30 Jul 2025 16:19:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm1813515ad.99.2025.07.30.16.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 16:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
Date: Wed, 30 Jul 2025 16:19:20 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: yukuai@kernel.org, Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730164832.1468375-1-linux@roeck-us.net>
 <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/25 11:30, Yu Kuai wrote:
> Hi,
> 
> 在 2025/7/31 0:48, Guenter Roeck 写道:
>> Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
>> introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
>> was enabled. Commit bf20ab538c81 ("blk-throttle: remove
>> CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LOW,
>> but left the device type specific throttle slices in place. This
>> effectively changed throttling behavior on systems with SSD which now use
>> a different and non-configurable slice time compared to non-SSD devices.
>> Practical impact is that throughput tests with low configured throttle
>> values (65536 bps) experience less than expected throughput on SSDs,
>> presumably due to rounding errors associated with the small throttle slice
>> time used for those devices. The same tests pass when setting the throttle
>> values to 65536 * 4 = 262144 bps.
>>
>> The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
>> CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
>> problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert to
>> the original code and re-introduce DFL_THROTL_SLICE to replace both
>> DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
>> commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD").
>>
>> After the removal of CONFIG_BLK_DEV_THROTTLING_LOW, it is no longer
>> necessary to enable block accounting, so remove the call to
>> blk_stat_enable_accounting(). With that, the track_bio_latency variable
>> is no longer used and can be deleted from struct throtl_data. Also,
>> including blk-stat.h is no longer necessary.
>>
>> While at it, also remove MAX_THROTL_SLICE since it is not used anymore.
>>
>> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
>> Cc: Yu Kuai <yukuai3@huawei.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   block/blk-throttle.c | 15 ++-------------
>>   1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 397b6a410f9e..924d09b51b69 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -12,7 +12,6 @@
>>   #include <linux/blktrace_api.h>
>>   #include "blk.h"
>>   #include "blk-cgroup-rwstat.h"
>> -#include "blk-stat.h"
>>   #include "blk-throttle.h"
>>   /* Max dispatch from a group in 1 round */
>> @@ -22,9 +21,7 @@
>>   #define THROTL_QUANTUM 32
>>   /* Throttling is performed over a slice and after that slice is renewed */
>> -#define DFL_THROTL_SLICE_HD (HZ / 10)
>> -#define DFL_THROTL_SLICE_SSD (HZ / 50)
>> -#define MAX_THROTL_SLICE (HZ)
>> +#define DFL_THROTL_SLICE (HZ / 10)
>>   /* A workqueue to queue throttle related work */
>>   static struct workqueue_struct *kthrotld_workqueue;
>> @@ -45,8 +42,6 @@ struct throtl_data
>>       /* Work for dispatching throttled bios */
>>       struct work_struct dispatch_work;
>> -
>> -    bool track_bio_latency;
>>   };
>>   static void throtl_pending_timer_fn(struct timer_list *t);
>> @@ -1345,13 +1340,7 @@ static int blk_throtl_init(struct gendisk *disk)
>>           goto out;
>>       }
>> -    if (blk_queue_nonrot(q))
>> -        td->throtl_slice = DFL_THROTL_SLICE_SSD;
>> -    else
>> -        td->throtl_slice = DFL_THROTL_SLICE_HD;
>> -    td->track_bio_latency = !queue_is_mq(q);
>> -    if (!td->track_bio_latency)
>> -        blk_stat_enable_accounting(q);
>> +    td->throtl_slice = DFL_THROTL_SLICE;
>>   out:
>>       blk_mq_unquiesce_queue(disk->queue);
> This looks correct, I do missed the throtl_slice for ssd is only used with
> BLK_DEV_THROTTLING_LOW. However, I think it's better to factor the
> track_bio_latency changes into a separate patch.
> 

I had combined it because it is another left-over from bf20ab538c81 and
I don't know if enabling statistics has other side effects. But, sure,
I can split it out if that is preferred. Let's wait for feedback from
Jens and/or Tejun; I'll follow their guidance.

Thanks,
Guenter


