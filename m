Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05569739E5B
	for <lists+cgroups@lfdr.de>; Thu, 22 Jun 2023 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFVKU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFVKU1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 06:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4C129;
        Thu, 22 Jun 2023 03:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC60617BE;
        Thu, 22 Jun 2023 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF4C433C8;
        Thu, 22 Jun 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687429223;
        bh=SYl7L3El4kLgtnTMh7BKKEOpmUvMHtKtirHsySgizNw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=msh7+e24+6Qq8hiSGIlXgZfnJmz/CXyamAAP5FY6G3LrO6XQNaRMxsW7HNqWIzMvn
         XHg3Esi9AHN4l4bhAMYc18e/iTf3yBUvu9eYF19KNZnYfurj1+RX36rwkqwqguCSdZ
         BBSXFsPBwPsjIMj8NbFDKR+Rk5FMvT1aghffwSYbBBN8vZzcf/BnC9TYj/4D2eZVVN
         KMUNB3dhaP76Tf969sdwYzKcf9IEgDtC7WE7I/CDmxaVN0SeRQlgUmSq7fUxJWnEtg
         AxTGbQgqAN74AiFIsXdgFURf6EOJag3g+8/xOdAMxo6TuzluJPB/zpE/7CNFc8bdWH
         /FSDHYe/3jnLQ==
Message-ID: <361c2f87-1424-f452-912f-0e4a339f5c46@kernel.org>
Date:   Thu, 22 Jun 2023 12:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
References: <ZIpm3pcs3iCP9UaR@work>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/06/2023 03:18, Gustavo A. R. Silva wrote:
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 

Hi,

This patch landed in next but causes boot failures on
Exynos ARMv7 board (32 bit) with systemd (exynos_defconfig):

NFS-Mount: 192.168.1.10:/srv/nfs/odroidhc1
Waiting 10 seconds for device /dev/nfs ...
ERROR: device '/dev/nfs' not found. Skipping fsck.
Mount cmd: 
mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
:: running cleanup hook [udev]
[   23.752917] systemd[1]: System time before build time, advancing clock.
[   23.851828] systemd[1]: Failed to mount tmpfs at /sys/fs/cgroup: No such file or directory
[   23.868459] systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such file or directory
[!!!!!!] Failed to mount API filesystems.
[   23.914562] systemd[1]: Freezing execution.

Full log:
https://krzk.eu/#/builders/21/builds/4110/steps/15/logs/serial0

Best regards,
Krzysztof

