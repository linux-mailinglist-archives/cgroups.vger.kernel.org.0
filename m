Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF9296571
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370378AbgJVTmy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370377AbgJVTmx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 15:42:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41821C0613CE
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 12:42:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so2987223qkk.12
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPTA51Icev/OImAexJIn3nNqguo6sqoMkgdEXm6+riU=;
        b=ScjsSosei205+3tvbkhCmIv/Pw6ud3+VJDhNx32/wv6M8CKD6NodvDDSiJVsinb1dD
         LmfEc6+HwEjyVbkmZQO75VS5aATAbvqizZ2z2FiaHOj69KTOxgkLOm0IcjYAYaoX2pAp
         9KmXyM8i8AZjWyvT3s/V55IYQpdT4AuyyniWyJ3AmQ28VbimlAJbKsbRJax9hnntzmxJ
         uYpThRmVhanjTy2NPJUTZxIYwTQNeBi+USQfe1Zq3F3isczednx3a3fVZlRWYJSUZC8x
         2f0k/REUrWjEjgEPj6GHZ9ssbW+8B3TPZeVJKP+XahQNcZ9LrWItqNHjvVq1lEbPcJCP
         EEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JPTA51Icev/OImAexJIn3nNqguo6sqoMkgdEXm6+riU=;
        b=XUEE4teXGPThNUSNXjDETgnIDQs53vSPHySVLWk8a9MmQl7UJoSkn53Cb6dJEdaLoa
         oamw3UlisrZ5xFVtdC/b0rl/NaQFQeCAs589p2BgF/dRVOvAzQAF3SqiYmRXbl7EIGiH
         cz3OKBfqqrTncO9rm/eJnHccDmZwWnDGgN5tNo+ibSbpLnj8ab8wmOeBKcDZT+stuCNU
         fvvrNc6b+ud2hKe60rRBJn0d13JmUOBLNSPdf3LxV+3eQF1rbRT69r0+5VIQ/stFi6MW
         aT7RuwDNfC1lz1vcUhIvfvaqbWh3ZVlVhcDekK62d09XBFN1MGGrKLz4WN8hufsgi2/v
         gPBQ==
X-Gm-Message-State: AOAM532bwwHSCkChJLvaNICwKAKaqFaeWmKItLWSyWX3YOTZMnJtLedq
        XeM5Ac1jiXg0csI5eBYpj0I=
X-Google-Smtp-Source: ABdhPJzrFtL1Oicodc186562jfGE96A+X50Ld1zQZ+kZXvOHjFc6oQmK2shbw0nO/RQ8nkdm+18hfQ==
X-Received: by 2002:a37:b285:: with SMTP id b127mr4039984qkf.323.1603395772379;
        Thu, 22 Oct 2020 12:42:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1be1])
        by smtp.gmail.com with ESMTPSA id z190sm1726037qka.103.2020.10.22.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 12:42:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Oct 2020 15:42:50 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com
Subject: Re: [PATCH] blk-cgroup: Pre-allocate tree node on blkg_conf_prep
Message-ID: <20201022194250.GC5691@mtj.thefacebook.com>
References: <20201022182945.1679730-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022182945.1679730-1-krisman@collabora.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 22, 2020 at 02:29:45PM -0400, Gabriel Krisman Bertazi wrote:
> @@ -657,6 +658,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  			goto fail;
>  		}
>  
> +		preloaded = !radix_tree_preload(GFP_KERNEL);

I think we can just fail the function if GFP_KERNEL preload fails.

Thanks.

-- 
tejun
