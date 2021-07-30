Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758A23DBCD4
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhG3QHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 12:07:30 -0400
Received: from [43.250.32.171] ([43.250.32.171]:23291 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229581AbhG3QHa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 30 Jul 2021 12:07:30 -0400
X-Greylist: delayed 8607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 12:07:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=O4d9n4ICcjZvP1yV8qsRv3XRzfx7tCTKYQ2aa
        0KXtu8=; b=Kz4eDKI7BEwhgD2daN1cegtO+OEbsoT205wytpeIjj9CSchmTT0e+
        bHH8q0RfPEfWtbgEI+JXjNxWSXRZe4msCTeTDejCzJrJSadgrf+d6NRIbsiMXcFi
        pS7VpR48hWwHGbJps9cq7hklUjHUSedirXK5lp/jmQmKwS2IY6aQuo=
Received: from [0.0.0.0] (unknown [113.251.12.143])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAXJAOpIwRhiQYPAA--.21639S3;
        Sat, 31 Jul 2021 00:07:06 +0800 (CST)
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
To:     "Cai,Huoqing" <caihuoqing@baidu.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cgroups <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210730051605.2626-1-caihuoqing@baidu.com>
 <0516372e-0120-ff52-bf9a-cf1cda9a633f@email.cn>
 <CALvZod6sUh0XQGVb4wEfzGNDcrLabgmjEdu+wh0g1c=cvvci4Q@mail.gmail.com>
 <437db356f1b44a19837dc7f24f9adfcb@baidu.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <a46dfadc-6615-cc5d-84ac-4e31def00bf3@email.cn>
Date:   Sat, 31 Jul 2021 00:07:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <437db356f1b44a19837dc7f24f9adfcb@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgAXJAOpIwRhiQYPAA--.21639S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw17GF4xZFykCr4Dtw47Jwb_yoWfWrc_ua
        yjyF1xCr1UZFW8Ka1vvrs3Zry5Ka1xKF97X39Fy3yav3ZrArW8ZFn3tr9a9wn8WF1fCryD
        K3Z5Xa97X3srujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8w
        CY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUOpnQUUUUU
X-Originating-IP: [113.251.12.143]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2021/7/30 下午10:54, Cai,Huoqing 写道:
> Forget it - -
>
> -----Original Message-----
> From: Shakeel Butt <shakeelb@google.com> 
> Sent: 2021年7月30日 22:53
> To: Hu Haowen <src.res@email.cn>
> Cc: Cai,Huoqing <caihuoqing@baidu.com>; Tejun Heo <tj@kernel.org>; Zefan Li <lizefan.x@bytedance.com>; Johannes Weiner <hannes@cmpxchg.org>; Jonathan Corbet <corbet@lwn.net>; Cgroups <cgroups@vger.kernel.org>; linux-doc@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
>
> On Fri, Jul 30, 2021 at 6:44 AM Hu Haowen <src.res@email.cn> wrote:
>>
>> 在 2021/7/30 下午1:16, Cai Huoqing 写道:
>>> Fix typo: iff  ==> if
> This is not a typo. 'iff' means 'if and only if'. For details see https://en.wikipedia.org/wiki/If_and_only_if.


Sorry, my mistake.


Thx,

Hu Haowen

