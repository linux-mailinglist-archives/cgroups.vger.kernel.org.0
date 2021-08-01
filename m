Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7223DC97F
	for <lists+cgroups@lfdr.de>; Sun,  1 Aug 2021 05:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHADjl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 31 Jul 2021 23:39:41 -0400
Received: from m32-153.88.com ([43.250.32.153]:13690 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230353AbhHADjk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 31 Jul 2021 23:39:40 -0400
X-Greylist: delayed 136505 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 23:39:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=HPiF0gjTXrWW3nXeBh9k7on9SjUI9wWXMvbjR
        vl/P0s=; b=HvX+utebY+tIz7tKyXgj3yYl7sEtTDCcHjUifi7grxwiQ82gm2oC8
        GbC5V5ewEsdND8UzhtTE3OPJQnCKAQgQAxiGzjwouegOOVEoXZ4SrfrNxqBTUGeV
        DGG5zpVhqjyzZ22BA1uAunVMc2EWDnUVjBiOXEYMjz4wCzYLm0Uc+I=
Received: from [0.0.0.0] (unknown [117.132.196.23])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAnpqZbFwZhN7cUAA--.61115S3;
        Sun, 01 Aug 2021 11:39:11 +0800 (CST)
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210730051605.2626-1-caihuoqing@baidu.com>
 <87lf5nc0su.fsf@meer.lwn.net> <YQQUwX+/1N9utKEN@casper.infradead.org>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <4f44c9b2-15ae-1ed9-0c0a-f0cef648c416@email.cn>
Date:   Sun, 1 Aug 2021 11:39:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQQUwX+/1N9utKEN@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgAnpqZbFwZhN7cUAA--.61115S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF45ur47Aw4fJryruFykZrb_yoWfurcEyF
        WkAFWvyw1UtryktanayFW3ZFZ2kFy09FyUX3s5AF4aq3s8A3yvkr1Dtw4xZr18tFW7Aw1a
        qrn8Xas2vrZF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbo8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY4
        87MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07jHBTOUUUUU=
X-Originating-IP: [117.132.196.23]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2021/7/30 ÏÂÎç11:03, Matthew Wilcox Ð´µÀ:
> On Fri, Jul 30, 2021 at 08:51:29AM -0600, Jonathan Corbet wrote:
>> Cai Huoqing <caihuoqing@baidu.com> writes:
>>
>>> Fix typo: iff  ==> if
>>>
>>> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>> This is becoming an FAQ ...  "iff" in mathematical English means "if and
>> only if"; its usage in these documents is correct.
> ... and yet it's clearly not understood.  Similarly to the [start..end)
> convention (also the [start..end[ convention).  Should we deprecate
> use of it in kernel documentation, and if so, what should we replace it
> with?

What about establishing a documentation section which gives clear
definitions to each words whose meaning isn't easy to understand for
common people, such as this situation? In this case readers are able to
get rid of their questions on their own, instead of asking maintainers
for any explanation.

Regards,
Hu Haowen

