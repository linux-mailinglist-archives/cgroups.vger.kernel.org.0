Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D109D59BA47
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 09:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiHVHaq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 03:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiHVHab (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 03:30:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B51AF3D
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 00:30:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 20so9146211plo.10
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=WsjMP58d6ZpqOpY4g9K6ddeUAxtCR0pSHuJhrbzNXTo=;
        b=Ls+0KIV/R7C/J45UdABQdD2zPd+7rtN4jhl8+/KMzRRsPlHQiMW14XHUIjj4mOLM+D
         adYE7r9KD7biiD3hGUtNsE79kJrt7tFlB9IYrroqyGa+axqcNxGFZcKUXx5rot/MwwGZ
         XMvmyjhg9lpFLDTqVroPAgj+eOhz9fsTlp6qP440GVNWyRVlZkD6BgIxhLznaUI9zLKO
         MHJA2apgk9+giWRvCNWeh9OEVfQfriea1HY5pDxCKGVKi+feozjMmbMBrs4x7V69wLCk
         pmDolW1g/fZ2pm/mPJqPyWOZLjAHZYMA052bwBh/jN4ftuMd7S9ziiimxWJull3rCci5
         jBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=WsjMP58d6ZpqOpY4g9K6ddeUAxtCR0pSHuJhrbzNXTo=;
        b=i47kKNasDxEQQKBb75uYJoZL6lmsQBNcgUHvGKGhM01eayH2Avci5Dr34CYA6naEjj
         QkGV9a/TnMkyKQlLqXqOnMEH5pcTnrsfOX71Pj++ORnxFbQ+1iTk1UfLH9JxIfsMsHio
         oKNNpbtGcXbg1sbViU8AAIVkDNuiwf9p/ACobmDsX69BcTqg4hFSD70U88URtxKtiCgy
         lUSj17yYzcCo45G0+uJC6mtpNYYwM9z21xttawDTY61utT8H/vFi8wv2p1afoq/hMxEh
         scEF9ypFT68YePqvRVMLAn7Tu70yvxsdNq9ALzkXzSZGLAQQqbO+ygwR4h2S8tYYvazH
         dOdA==
X-Gm-Message-State: ACgBeo0xaSYLCvlJRJD1h5M6Xwt248V7O3DB2LSyww4ZOmjbc5CWhePY
        le/VTWVTWig8XsIWSnztLoY=
X-Google-Smtp-Source: AA6agR5UhIDCHesNrgL73zNUv/4pbh57NdDCaP4R6ogVo2zSwDFYnp/jNRhr8ECBEy1I0SO08LX4gA==
X-Received: by 2002:a17:902:ce82:b0:16f:9697:1d94 with SMTP id f2-20020a170902ce8200b0016f96971d94mr19415221plg.12.1661153429976;
        Mon, 22 Aug 2022 00:30:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e81200b0016edd557412sm3668816plg.201.2022.08.22.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:30:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 21 Aug 2022 21:30:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: cleanup the format of /proc/cgroups
Message-ID: <YwMwlMv/tK3sRXbB@slm.duckdns.org>
References: <20220821073446.92669-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821073446.92669-1-feng.tang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sun, Aug 21, 2022 at 03:34:46PM +0800, Feng Tang wrote:
> Currrent /proc/cgroup output is like:
> 
>   #subsys_name	hierarchy	num_cgroups	enabled
>   cpuset	6	1	1
>   cpu	4	7	1
>   cpuacct	4	7	1
>   blkio	8	7	1
>   memory	9	7	1
>   ...
> 
> Add some indentation to make it more readable without any functional
> change:

So, this has been suggested a couple times before and I fully agree that the
file is really ugly. In the past, we didn't pull the trigger on it for two
reasons - 1. It is user-visible functional change in that it can break
really dumb parsers 2. the file is only useful for cgroup1 which has been in
mostly maintenance mode for many years now. I don't feel that strongly
either way but still kinda lean towards just leaving it as-is.

Thanks.

-- 
tejun
