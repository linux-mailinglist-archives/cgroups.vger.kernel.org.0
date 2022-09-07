Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC65B089B
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIGPcV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIGPcU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 11:32:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765A7696B;
        Wed,  7 Sep 2022 08:32:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pj10so4491204pjb.2;
        Wed, 07 Sep 2022 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=2y84KoxHvAca0x2HYNXqxqJj776eiDbPEKIjReMrg0U=;
        b=RCPz9p+Nm7+WOSNmOPN1+QvBYB8EhdBwxeXR6gnhlbAts2QrkYbmNTYTpJZ98fgPPF
         PBl/6LoKGUlg+AcfZkjDU6xf7r8RtInGmJHbDUCjURuh+T2Vll6Praux5Orn4iaeDqwm
         jxV4YJvo9RbSCftdHfGjhMCV8QNHdXBUzVJ9lt9ijth/jwtdLgnIZtyD2tBora/s4YKV
         ChT9rFNyrRAFZc546muYP38fxNj7VYw4s7kDHXMvjcBWNOcDwGcVs0Y6TZP/A0ESSHFp
         B8cRLWxPlzfh0r+Vhc50oXUgfnsdNkI1V8eO1TF0YKSIopG3NCUBnN6VSmRDkQpeM3Ly
         hiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2y84KoxHvAca0x2HYNXqxqJj776eiDbPEKIjReMrg0U=;
        b=Sm3W1WwJnj4AKM0QUUTaOEYYUH+1Lkx5NjB0WO17XLfgRQ6GwZBq9NgQXRJeVPeH5/
         xx094+uANThRUpb1gVQknr708oy0WVgWw2uHg1yb7egMAdirSWoPiAGLr+HLZCLEFpP2
         gMMqQX4xoH4w/kZRhD2u2JViW8Z2MA4g+TCpKrRwGiI/eUZl2Yb3nnHdjUX+ilwNr+nY
         VdnbNVCZhvFkJK3B6xABT8b13HsaxJD9EB34JbokKNdgsvP0I1v91XdeGaohWSoLbN1B
         WW3GVHH2V5cTvIbXVL+u6Rxs03a7C1MDZ73MMuqk8sN1+aECbRJU7YCX5fCNWyQjQXo7
         Q/qA==
X-Gm-Message-State: ACgBeo3helQZ1q6cuEj8uH3pw0q4NWSgup/l5W2nMKooXht0dUQgOryM
        d+a9gCyf39J9qboozE3WdnE=
X-Google-Smtp-Source: AA6agR6CoHdWVQeSggz2rj+Be9WXzcSrS5L0JFdC4/ip2osl35mQ0JDhjPAcVxs+NdHQowGNYh7Wiw==
X-Received: by 2002:a17:902:7796:b0:172:c716:d3ac with SMTP id o22-20020a170902779600b00172c716d3acmr4489711pll.137.1662564738413;
        Wed, 07 Sep 2022 08:32:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b00176cde52192sm4456191pll.251.2022.09.07.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:32:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Sep 2022 05:32:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: remove unreachable code
Message-ID: <Yxi5gI1f2MxdC0c9@slm.duckdns.org>
References: <20220907040112.82030-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907040112.82030-1-jiapeng.chong@linux.alibaba.com>
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

(cc'ing Waiman and quoting the whole message)

On Wed, Sep 07, 2022 at 12:01:12PM +0800, Jiapeng Chong wrote:
> The function sched_partition_show cannot execute seq_puts, delete the
> invalid code.
> 
> kernel/cgroup/cpuset.c:2849 sched_partition_show() warn: ignoring unreachable code.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2087
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Applied to cgroup/for-6.1.

Thanks.

>  kernel/cgroup/cpuset.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6baa977a71ba..b474289c15b8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2846,8 +2846,6 @@ static int sched_partition_show(struct seq_file *seq, void *v)
>  		else
>  			seq_printf(seq, "%s invalid\n", type);
>  		break;
> -		seq_puts(seq, "isolated invalid\n");
> -		break;
>  	}
>  	return 0;
>  }
> -- 
> 2.20.1.7.g153144c
> 

-- 
tejun
