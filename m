Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87052628C3B
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiKNWm1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiKNWmW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:42:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F1167F1;
        Mon, 14 Nov 2022 14:42:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so11504911pli.0;
        Mon, 14 Nov 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv0RF9FjcySyliu+qAVl2fypXUgmAr/MY6Cbxd80Sz8=;
        b=eSgJ8ipCFU8uWn7ioQiHixpjSI530v8dcOHQJaH+Il8EKjYSq/C3UntNbW9AWG1uyL
         5lnt+ZiHYIaprJAq+HQe5BOu2/dBE6/l58VWMvYmTsF1TUVN+So55HqBquzLN/NsvIG6
         TGNmqinUqbHSH0VYFFNRAOmTjw8BKJJ6TF+PUcyXcNJQxus/qIlKy2zhDLXwzBC5lut+
         jS3EpUsqjWgG/lq3fblL8cKjYPhnWZkrO9WBBZKXg6D1cF/NpIX9dRuT0Pm+JKISCGGk
         ZN0Dio+ukJxJAGGcrNIKHKzvMQO8ReBPY40POFPqNst/adBwLjl6Qh6UAMoI5y18zxb6
         ZuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv0RF9FjcySyliu+qAVl2fypXUgmAr/MY6Cbxd80Sz8=;
        b=MN1j7FNFAqP7Wh8RZJe8EvrHx2K8eMEjUxYjJNWFKrWiHMvb1+rEj2GhbofxSVSMWL
         jNMd0mfH/IKHIi8FW1YOkeEG4+G5psYIGRaQwUINqrOFdxE/4OU3Mr7vMCFuqM4wLG4R
         Jld97k11+7/E5nlXRz9NiU1MPUyIEXL1MtvZP9OAJXWlOzh5kW2zcZFJ6QklfHdUo/RG
         465wNoiTPv4iiysg3uxRc74qkI/KvKTs/o5WqEHYUceK16MGQ4N71/EPC7aa03A7J49/
         4D7LKurOQGuN0Yb1zwaET9K2HGi47jq5x9Rtj4dOn3p9cHmUWrr/hLXyhdSdK2hfZwJv
         VsBA==
X-Gm-Message-State: ANoB5pmF3MwxjvrRMcbFaIKFvSB1tkXYceWEsZekyxHbCvzxDaEqV2ar
        +tV9LkdrULJ13lHc/ldeRLo=
X-Google-Smtp-Source: AA0mqf7gPPzruf7lf7JrXP1fewft11eBWPwC/u2lJ8VuFFA5smtrYMHiueZHj19vv9DQMgYwgZ0SXw==
X-Received: by 2002:a17:90a:e60f:b0:214:1a8a:a415 with SMTP id j15-20020a17090ae60f00b002141a8aa415mr15355219pjy.197.1668465740654;
        Mon, 14 Nov 2022 14:42:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a648f00b0020ad53b5883sm7078235pjj.14.2022.11.14.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:42:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:42:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 17/26] cgroup/misc: Add notifier block list support for
 css events
Message-ID: <Y3LES3rUIZ/PtwzV@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-18-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-18-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Nov 11, 2022 at 10:35:22AM -0800, Kristen Carlson Accardi wrote:
> +/**
> + * register_misc_cg_notifier() - Register for css callback events
> + * @nb: notifier_block to register
> + *
> + * Context: Any context.
> + */
> +int register_misc_cg_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&misc_cg_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_misc_cg_notifier);
> +
> +/**
> + * unregister_misc_cg_notifier() - unregister for css callback events
> + * @nb: notifier_block to unregister
> + *
> + * Context: Any context.
> + */
> +int unregister_misc_cg_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&misc_cg_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_misc_cg_notifier);

So, I'm not necessarily against this but wonder whether it'd be more
straightforward to add sth like struct misc_res_ops which contains the
optional callbacks and then have an array of pointers to the structs which
are initialized / registered somehow. What do you think?

Thanks.

-- 
tejun
