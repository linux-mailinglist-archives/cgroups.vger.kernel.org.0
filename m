Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D2792D41
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjIESPz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 14:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjIESPo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 14:15:44 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2F3C28;
        Tue,  5 Sep 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693937447; x=1725473447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QaGIBp+4yXT+4ZJENNV5tF4S5zI+vHTeYurxUnNu70g=;
  b=CIioFm80Lqy8nX6NZjJL0Z8296AbZefvcwJxNGcgZb8DUTl7tix6zCpo
   UcXwqq9fPR2t3cQ0utQG58mXTSCLxxapsQFVdHHpK/s9+iDf3WbVCKLIp
   y+wE1q+qR8cLzDKAEkdq2Xpu6wmpcXFGhTrK6BddoDzCaIgRp/oGuIEQx
   U=;
X-IronPort-AV: E=Sophos;i="6.02,229,1688428800"; 
   d="scan'208";a="236876355"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 17:03:29 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 1D65080EAA;
        Tue,  5 Sep 2023 17:03:28 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 5 Sep 2023 17:03:27 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 17:03:27 +0000
Received: by dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (Postfix, from userid 23276196)
        id AF4648FE; Tue,  5 Sep 2023 17:03:27 +0000 (UTC)
Date:   Tue, 5 Sep 2023 17:03:27 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <longman@redhat.com>
CC:     <lcapitulino@gmail.com>
Subject: Re: [PATH] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <20230905170318.GA16629@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
References: <20230831142046.37177-1-luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831142046.37177-1-luizcap@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 31, 2023 at 10:20:46AM -0400, Luiz Capitulino wrote:
> We have a need of using favordynmods with cgroup v1, which doesn't support
> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
> build-time is not an option because we want to be able to selectively
> enable it for certain systems.
> 
> This commit addresses this by introducing the cgroup_favordynmods=
> command-line option. This option works for both cgroup v1 and v2 and
> also allows for disabling favorynmods when the kernel built with
> CONFIG_FAVOR_DYNMODS=y.
> 
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>

Hi,

Would somebody take a look at this patch please?

Thanks,

- Luiz

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  kernel/cgroup/cgroup.c                          | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0c38a8af95ce..672f76a3c002 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -580,6 +580,10 @@
>  			named mounts. Specifying both "all" and "named" disables
>  			all v1 hierarchies.
>  
> +	cgroup_favordynmods= [KNL] Enable or Disable favordynmods.
> +			Format: { "true" | "false" }
> +			Defaults to the value of CONFIG_CGROUP_FAVOR_DYNMODS.
> +
>  	cgroup.memory=	[KNL] Pass options to the cgroup memory controller.
>  			Format: <string>
>  			nosocket -- Disable socket memory accounting.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 5fa95f86cb4d..b625825e270b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
>  static u16 have_release_callback __read_mostly;
>  static u16 have_canfork_callback __read_mostly;
>  
> +static bool have_favordynmods __read_mostly = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
> +
>  /* cgroup namespace for init task */
>  struct cgroup_namespace init_cgroup_ns = {
>  	.ns.count	= REFCOUNT_INIT(2),
> @@ -2265,9 +2267,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
>  	fc->user_ns = get_user_ns(ctx->ns->user_ns);
>  	fc->global = true;
>  
> -#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
> -	ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
> -#endif
> +	if (have_favordynmods)
> +		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
> +
>  	return 0;
>  }
>  
> @@ -6767,6 +6769,12 @@ static int __init enable_cgroup_debug(char *str)
>  }
>  __setup("cgroup_debug", enable_cgroup_debug);
>  
> +static int __init cgroup_favordynmods_setup(char *str)
> +{
> +	return (kstrtobool(str, &have_favordynmods) == 0);
> +}
> +__setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
> +
>  /**
>   * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
>   * @dentry: directory dentry of interest
> -- 
> 2.40.1
> 
