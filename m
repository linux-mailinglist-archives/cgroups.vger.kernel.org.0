Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A677D308
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 21:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjHOTJm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbjHOTJi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 15:09:38 -0400
X-Greylist: delayed 286 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 12:09:13 PDT
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D1210D
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 12:09:13 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id VhTfqg7dyfaVXVzKSqNJNx; Tue, 15 Aug 2023 19:03:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id VzKRqXgBverBrVzKRqyDp2; Tue, 15 Aug 2023 19:03:43 +0000
X-Authority-Analysis: v=2.4 cv=E9veGIRl c=1 sm=1 tr=0 ts=64dbcc0f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=4Y44Ad61Qo6RRudwQyUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oDTpbnZtb5YY58cxQ1+wqrLvX74qH9kX1x/86gt1r6c=; b=GYqk+IEZHDNl4F1KNkrjKQ4GCv
        A8WuEZWAoPnmMiy5LJ5rLCvLrfBUjja3movkQMpr/X3RBuLXmLXSa2djw6dKXzKucDKJi/n0OzHsC
        lgCkFhGiIVfQpofwfVRHtXlcHDGmrQXJIlLN2PSiVfQxmdIM0765db6fe82HYihlPM2Wgwn0/D8eP
        i5nCbb2biNKRb53PVBwCZRjEqtmn5+EFTXARPbPFiG9+6QkFJxpCavWSSp4tRVGiuoVBC2TDajzeg
        upx233SUSeGEbPUt3NXjHVv7jeWCyXSBmlaN+7ngIYg5E/XAJLYVujq0sfutwtvAhpl2ITu/tH/74
        MUNzFOSQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60524 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qVzKQ-000zkG-1t;
        Tue, 15 Aug 2023 14:03:42 -0500
Message-ID: <e1c07dd0-e6bf-ca9c-107a-97c5043b1bc7@embeddedor.com>
Date:   Tue, 15 Aug 2023 13:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZIpm3pcs3iCP9UaR@work>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
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
X-Exim-ID: 1qVzKQ-000zkG-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60524
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA2GCnGy3lce7Ee8howxycisSZuhIgn+ZT6YaImhVk3oOVa1c5VX2WHIcZmKW9oTn0C7p+W1z8CQ9rGaTfQNO1iG0drBHc+dB4MDehnrPL3LH1JTMH8S
 jFhxhGYJ0pSD70RBIb7S47CLhKceO3vsb9Faz4lBwnTrj6ABykMInoaWWh6qnDu5PVYJ57B29nAol5/5Pz8Nv/T9Dfw+0NjJGi4=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

I wonder if you have any suggestions on how to address this issue. As it seems that
my last attempt caused some boot failures[1][2].

At first, I thought that the right way to fix this was through a similar fix as this
one[3]. But it seems I'm missing something else that I cannot determine yet.

These -Wstringop-overflow warnings are mostly the last ones remaining before we can
finally enable this compiler option, globally.

Any help or advice on how to properly address this is greatly appreciated. :)

Thanks!
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/726aae97-755d-9806-11d4-2fb21aa93428@arm.com/
[2] https://lore.kernel.org/linux-hardening/361c2f87-1424-f452-912f-0e4a339f5c46@kernel.org/
[3] https://git.kernel.org/linus/d20d30ebb199


On 6/14/23 19:18, Gustavo A. R. Silva wrote:
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
> warnings with no subsystems").
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   kernel/cgroup/cgroup.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index cd497b90e11a..1ee76e62eb98 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1200,6 +1200,9 @@ static struct css_set *find_css_set(struct css_set *old_cset,
>   	unsigned long key;
>   	int ssid;
>   
> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
> +		return NULL;
> +
>   	lockdep_assert_held(&cgroup_mutex);
>   
>   	/* First see if we already have a cgroup group that matches
> @@ -6045,6 +6048,9 @@ int __init cgroup_init(void)
>   	struct cgroup_subsys *ss;
>   	int ssid;
>   
> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
> +		return -EINVAL;
> +
>   	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
>   	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
>   	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
