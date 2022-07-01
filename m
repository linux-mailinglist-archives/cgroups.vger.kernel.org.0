Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C456288F
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiGABuU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 21:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABuO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 21:50:14 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95D8917594;
        Thu, 30 Jun 2022 18:50:09 -0700 (PDT)
Received: from [10.8.148.37] (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltABXOEW6Ur5io5YBAA--.508S2;
        Fri, 01 Jul 2022 09:49:47 +0800 (CST)
Message-ID: <5a6df5c4-e24d-1171-87a8-b013f861f0d5@wangsu.com>
Date:   Fri, 1 Jul 2022 09:49:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cgroup-v1: use find granularity format identifiers to
 make /proc/cgroups show pretty
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630082539.83602-1-linf@wangsu.com>
 <Yr5JVHhSUCrbT8OH@mtj.duckdns.org>
From:   Lin Feng <linf@wangsu.com>
In-Reply-To: <Yr5JVHhSUCrbT8OH@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: SyJltABXOEW6Ur5io5YBAA--.508S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1rGr1xCw48GFW5Aw15CFg_yoWkGrg_ur
        yktws2kw1DGFs0v3ZFyrsxXrWDKrWUWr98Z3y0qry7t34rZFZxGF4Fkr93Zr1rGF47AFn8
        CFZ5tw4j9342gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8GwAv
        7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCF04k2
        0xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUhtx6UUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On 7/1/22 09:09, Tejun Heo wrote:
> On Thu, Jun 30, 2022 at 04:25:39PM +0800, Lin Feng wrote:
>> The listing subsys info is unaligned with the header columns and we can
>> make the output more intuitive to read by specifying "left alignment"
>> and "fixed length" format styles for seq_printf.
> This has been proposed before but the file is useful only in cgroup1
> which is in maintenance mode and the format has been like that since
> forever. Given that there's some chance that it can break dumb
> parsers, the choice has been to leave it alone. It's such a dumb file
> format to begin with and just leaving it to wither and die seems to be
> the right direction.

Thanks for your explanation and sorry that I missed we have such a consensus
before.

I had considered that if this change would break the parsers, but it's likely
that it won't else the parser is really a broken one and needs some improvements.
On the other hand, cgroup-v1 still has many old users and kernel still has to
maintain it for some time for back compatible reason, so I think this tiny fix
should not be a bad idea.

Thanks,
linfeng

