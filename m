Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB677FCEC
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353831AbjHQRY0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353967AbjHQRYK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 13:24:10 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 10:24:08 PDT
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA610E
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 10:24:08 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id WgINqhDpCyYOwWghhqnnHh; Thu, 17 Aug 2023 17:22:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WghgqW2wW2eFNWghhqoqDm; Thu, 17 Aug 2023 17:22:37 +0000
X-Authority-Analysis: v=2.4 cv=VvAwvs6n c=1 sm=1 tr=0 ts=64de575d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=F_Hwzj4YBZH05EUnCpsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XsIhFA6p1MkMu1lgiaxFpYzkM6VAgL0B/RLP+o3ibj0=; b=PPXTDZN3LckRmEB6i0+w8aLhVh
        bknx7JpDqM62KROQHLSlbSJQKUE2IzMxM6axtrpJ2xUrA00LnpwKOglWINcFWkSoLC/6RO/P2i5dH
        YJNak3Bae7X6n7PWsTS4NVAsABO6yq/RDV8DdVE90Tb92hYnCI9Il+2I12kkQP9XYyXwcxNZ1owNQ
        c6FZ9CHc7mvrYkbtBvye2XWtMmhAX3AsC0P3GyGbxpK5INA/jUloBKpMoUcCpgfyouWMe42Lq+U7A
        +EGL8HEDWMReC0D5mT1I86G0SI+sqt1KRWUAgAO+HP4ctNo/f11AeOFVa0SCtkw/6XuR1xoPoPRO1
        c5LtNlPw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34402 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWghg-002eWO-0c;
        Thu, 17 Aug 2023 12:22:36 -0500
Message-ID: <32c7ea41-8b00-c92e-02ec-d535428e55bb@embeddedor.com>
Date:   Thu, 17 Aug 2023 11:23:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2][next] cgroup: Avoid -Wstringop-overflow warnings
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZN02iLcZYgxHFrEN@work> <ZN02wFqzvwP2JI-K@slm.duckdns.org>
 <202308161356.4AED47263E@keescook> <ZN05IZBfaKkPKJfH@slm.duckdns.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZN05IZBfaKkPKJfH@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWghg-002eWO-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:34402
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNbfB9R3qd792OqLFyR5rTCehK0o9zSw827D7H3dNrWsD7UEh9ewsAjlDBymoJWcQBsJT6wBcCSeVLUFFtXq05tho41rB2fmVl7dfU1rIM7BYsmX1+9m
 0jNqY4z5YuwAAQ2vucZRo8pHFCYOXmvVRqw9R7xZavrOMevF+ZpPIEW0R84zDypgatQmif2L6dl5RfR5As8OXaE/0h3IUSnzPjQ=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 8/16/23 15:01, Tejun Heo wrote:
> On Wed, Aug 16, 2023 at 01:57:16PM -0700, Kees Cook wrote:
>> On Wed, Aug 16, 2023 at 10:51:12AM -1000, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Wed, Aug 16, 2023 at 02:50:16PM -0600, Gustavo A. R. Silva wrote:
>>>> Change the notation from pointer-to-array to pointer-to-pointer.
>>>> With this, we avoid the compiler complaining about trying
>>>> to access a region of size zero as an argument during function
>>>> calls.
>>>
>>> Haha, I thought the functions were actually accessing the memory. This can't
>>> be an intended behavior on the compiler's side, right?
>>
>> I think it's a result of inlining -- the compiler ends up with a case
>> where it looks like it might be possible to index a zero-sized array,
>> but it is "accidentally safe".
> 
> Ah I see. It's not that the compiler knows that ** access is safe. It's more
> that it only applies the check on arrays. Is that right? Gustavo, I don't

That's correct.

> mind the patch but can you update the patch description a bit explaining a
> bit more on what's going on with the complier? It doesn't have to be the
> full explanation but it'd be useful to explicitly point out that we're just
> working around the compiler being a bit silly.

I just sent v3:

	https://lore.kernel.org/linux-hardening/ZN5WkbPelHUSTXOA@work/

Thanks
--
Gustavo
