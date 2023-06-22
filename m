Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A1739E13
	for <lists+cgroups@lfdr.de>; Thu, 22 Jun 2023 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjFVKLu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVKLt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 06:11:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A4F9DE;
        Thu, 22 Jun 2023 03:11:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A956C1042;
        Thu, 22 Jun 2023 03:12:31 -0700 (PDT)
Received: from [10.1.37.34] (e122027.cambridge.arm.com [10.1.37.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F1E3F64C;
        Thu, 22 Jun 2023 03:11:44 -0700 (PDT)
Message-ID: <726aae97-755d-9806-11d4-2fb21aa93428@arm.com>
Date:   Thu, 22 Jun 2023 11:11:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Content-Language: en-GB
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <ZIpm3pcs3iCP9UaR@work>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/06/2023 02:18, Gustavo A. R. Silva wrote:
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
>  kernel/cgroup/cgroup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index cd497b90e11a..1ee76e62eb98 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1200,6 +1200,9 @@ static struct css_set *find_css_set(struct css_set *old_cset,
>  	unsigned long key;
>  	int ssid;
>  
> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
> +		return NULL;
> +
>  	lockdep_assert_held(&cgroup_mutex);
>  
>  	/* First see if we already have a cgroup group that matches
> @@ -6045,6 +6048,9 @@ int __init cgroup_init(void)
>  	struct cgroup_subsys *ss;
>  	int ssid;
>  
> +	if (!CGROUP_HAS_SUBSYS_CONFIG)
> +		return -EINVAL;
> +
>  	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
>  	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
>  	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));

This change (which landed in linux-next) causes a boot failure on my
(arm32) board because the cgroup filesystem isn't created which upsets
systemd:

[   11.474767] systemd[1]: Failed to mount tmpfs at /sys/fs/cgroup: No such file or directory
[   11.489933] systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such file or directory
[!!!!!!] Failed to mount API filesystems.

Reverting this commit on the head of linux-next gets the board working
again.

Thanks,

Steve

