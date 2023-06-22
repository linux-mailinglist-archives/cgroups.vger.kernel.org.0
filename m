Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0495173A2AD
	for <lists+cgroups@lfdr.de>; Thu, 22 Jun 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFVOKJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjFVOJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 10:09:52 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 07:09:46 PDT
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3471BDA
        for <cgroups@vger.kernel.org>; Thu, 22 Jun 2023 07:09:46 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id CEIXqf0rTKBQaCKysqhxob; Thu, 22 Jun 2023 14:08:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id CKysqrD0aN7O6CKysqKany; Thu, 22 Jun 2023 14:08:14 +0000
X-Authority-Analysis: v=2.4 cv=AJoHy1G7 c=1 sm=1 tr=0 ts=649455ce
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=f5R3gcx-rqYdtmm8484A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o3nVrYc6RnMxf0e4iXIYtKi5C8Jg0CJJ5aA5IElG1J4=; b=NgA+pmIXcZG44sheyyW+4X1RXY
        smpeQnJ51qjrJ/tGhVsmFIqY7x6nBKhE8k6xCuSipNQc1IP19DirM4La5M1Ge9T6pbANFk6+/t0B1
        M4kqNHjb02rpzZI6hy/+OCv693WiSmAdv7SI4hSMAKhh6LT3laJeSStXoI+jMknLTGdPu0Y6j+k5M
        u3NY4wbs3bt0hYozTpgWxUOkcZKN6k53nBBJ3279HPdS3HH3D4WbFAfUcDGguMvJZhavp9U1IXX1P
        27FMwsTERckNPsUodrrztxoo9JNMj78L+9fXGe3UK2ZaViArNdjSUuqZ/TkhIwyP8BCdYgaWQf1Iy
        Jm3+xxAg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43202 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qCKyr-000Aa9-Dy;
        Thu, 22 Jun 2023 09:08:13 -0500
Message-ID: <0d6377ef-bc34-784a-8694-478d0ade085e@embeddedor.com>
Date:   Thu, 22 Jun 2023 08:09:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <ZIpm3pcs3iCP9UaR@work>
 <726aae97-755d-9806-11d4-2fb21aa93428@arm.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <726aae97-755d-9806-11d4-2fb21aa93428@arm.com>
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
X-Exim-ID: 1qCKyr-000Aa9-Dy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:43202
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFMb5WdH/P9SqVjDOJ3TI6cGn7E2EVtW1U//uslECc0RGsHCmn3ZtHo/z1qGLgRBOkjgout6/mnuiuz+Y2e6CGJKAIvI7UnPB9LLF/gaQ6G7q3pskRm4
 eMmY/TSZ4VMal2JW00PLINhVpA376WDH+AhSdxnRLB69+p2bx0glJG86+gE8qLJ0vjKy7jrLAo19iNPhOPiBNQnZsOWvCs5DASA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi!

On 6/22/23 04:11, Steven Price wrote:
> On 15/06/2023 02:18, Gustavo A. R. Silva wrote:
>> Address the following -Wstringop-overflow warnings seen when
>> built with ARM architecture and aspeed_g4_defconfig configuration
>> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
>> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>>
>> These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
>> warnings with no subsystems").
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   kernel/cgroup/cgroup.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index cd497b90e11a..1ee76e62eb98 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -1200,6 +1200,9 @@ static struct css_set *find_css_set(struct css_set *old_cset,
>>   	unsigned long key;
>>   	int ssid;
>>   
>> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
>> +		return NULL;
>> +
>>   	lockdep_assert_held(&cgroup_mutex);
>>   
>>   	/* First see if we already have a cgroup group that matches
>> @@ -6045,6 +6048,9 @@ int __init cgroup_init(void)
>>   	struct cgroup_subsys *ss;
>>   	int ssid;
>>   
>> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
>> +		return -EINVAL;
>> +
>>   	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
>>   	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
>>   	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
> 
> This change (which landed in linux-next) causes a boot failure on my
> (arm32) board because the cgroup filesystem isn't created which upsets
> systemd:
> 
> [   11.474767] systemd[1]: Failed to mount tmpfs at /sys/fs/cgroup: No such file or directory
> [   11.489933] systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such file or directory
> [!!!!!!] Failed to mount API filesystems.
> 
> Reverting this commit on the head of linux-next gets the board working
> again.

Thanks for reporting this issue. I'll take a look.

--
Gustavo
