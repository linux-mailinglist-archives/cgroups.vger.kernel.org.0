Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0B628C27
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiKNWeJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiKNWeJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:34:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F5A1B9;
        Mon, 14 Nov 2022 14:34:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h193so11498172pgc.10;
        Mon, 14 Nov 2022 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5kwvrCfGArJDPvV4Au9rhARUgfYWksZx0biBAjHeX0=;
        b=CbVG/1M3midj8oTdfJZ785aSjwVPMxHG0nuAFAYsEyTDwi3uPSXQN1z8MAIqvwYEip
         XAP6exWKi2UjN5zQli8rg3kLgSKuxLYGGL6QozqLhHgX0GB7bwyRQoVL/Ky3I7Qp3Po6
         myDuKwSi5ITGfb2lbyiwf7PkrQgkU1/gaJdEo53vZ0RzmQdHL1TR90vGP586aWfdXoqB
         z4o8aP8aZXVtvU8+nYxLZDYrGGdDxRAc59CXwyJN4N4bGbIYG+mrgf9EgckBPG+FRk4/
         A/MAt7TfltQGZUzfwm/WBTHTLRzNoSu3jFwon2bMxfnNsNHA9OnwgtlMfkDo0D5FyA9b
         Zt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5kwvrCfGArJDPvV4Au9rhARUgfYWksZx0biBAjHeX0=;
        b=sTSyWciwiMaMVGatpQYf+E/8Beju1zT6yJ6v08mwxMo/yerF5ccNreLGIrNBad5AJ4
         HaJS5r5nggEKytxb57Y3szsRyXxGQyylDD3NdbxjXtbI0KnXitg2QIw+KV7fWwHP/MTe
         4e2wYI4SbpnDtRO0pTu3XSyhJ/nk1OFx649NQ6zANb5C/mur7RIdliK9R0oprIerjjv5
         SVPdb7vmsZ2TgmAs+LAlnqjthWKydb5cSMn2rHPk3CKB3wuqXu7izNPsWrVJX6BiYFLX
         CfT674nEuWn7XNF5XfzwFbwiIhtKEWs0VsdOA2j/YmtpTYux60+Cw4324lxISWHZ6Ugu
         jLBg==
X-Gm-Message-State: ANoB5pn4xGXTJ7PW2xPrL3LEyQqPcJLOuw2APZXGJohMQe3lcGm2WGWA
        V02YBOrnfSFY5aT7sXAmmiM=
X-Google-Smtp-Source: AA0mqf7TlKYSZrHo8etQ5Ei/VoqL8glW9j5/KoSNFFM04cX2wR4+DYTPNNpQ7kIsEWmJZNok+ovUOQ==
X-Received: by 2002:a63:401:0:b0:46a:e5d0:6e1e with SMTP id 1-20020a630401000000b0046ae5d06e1emr13382157pge.530.1668465248110;
        Mon, 14 Nov 2022 14:34:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0017f7c4e260fsm8082043plb.150.2022.11.14.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:34:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:34:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 22/26] cgroup/misc: Add private per cgroup data to struct
 misc_cg
Message-ID: <Y3LCXo9SLIleMmh2@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-23-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-23-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:27AM -0800, Kristen Carlson Accardi wrote:
> +void *misc_cg_get_priv(enum misc_res_type type, struct misc_cg *cg)
> +{
> +	if (!(valid_type(type) && cg))
> +		return NULL;
> +
> +	return cg->res[type].priv;
> +}
> +EXPORT_SYMBOL_GPL(misc_cg_get_priv);

Yeah, just deref it. I'm not sure what all these accessors are contributing.

Thanks.

-- 
tejun
