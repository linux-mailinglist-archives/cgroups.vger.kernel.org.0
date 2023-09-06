Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6C7943FA
	for <lists+cgroups@lfdr.de>; Wed,  6 Sep 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbjIFTyi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Sep 2023 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjIFTyi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Sep 2023 15:54:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4895;
        Wed,  6 Sep 2023 12:54:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68e26165676so986529b3a.0;
        Wed, 06 Sep 2023 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694030074; x=1694634874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78FtW2KEHALXSnzrqPSgIRmAweaQbL/r9j+Tz4zHoP0=;
        b=kN6gO2yekwMFtZOxyO8eNxTe+9aehaNg395ML2/jcgEpxq6B0OZkA69NH6bsxqyh1+
         GM38w3CsqQM8s+yYDghT2rU6uyQZ9496ZqIU2ILZ4DyIhBxPgCaSdUR79IcGjdhT4daa
         uhxNelSzB6XRq04xWBSXL8wbBrnHf46fvM39R05A6yqbqzmXYp2w4KFNU5EE+LuoYCGP
         P07U20S449mc0BoSkSVnK5KMERtbaSz7NDfVAknZxXSWTZEbt7R88aLZpHb6DJVQGTDj
         X6Xj4VyHp0Q/CZOzuXyfhrl+X242Kv8qXPIG8DvcNOay64kMska1PI7/Z0Owq9jMPIyc
         uHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030074; x=1694634874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78FtW2KEHALXSnzrqPSgIRmAweaQbL/r9j+Tz4zHoP0=;
        b=E19qysSVSmgkdv50Eb0Xq6XyqIsGovF4rEWPw1kCY2chEAx3amY6DXHEk/0pQEPlFB
         q4XJhcMfAAs2SasVobjep9bF06Q5jJyqoE8XQsgscX0Udxs7szK4BZc91O32c4pKHm84
         zQ1yGDq6L8QmOzLisbkbdNT6Bu3sDyiwvdtW7egJKLCaeRtm1U/bW6/MA8IL2HAiNPBY
         dAkAuzgYSWhV2ppX/wJN2yXIzTCiGlzlyI54DA8ughtN1gTLnviVI8fW2NxniP3Dc3Ah
         SrRnvL7jViBmwsl6niy9yctmpy7eQPgWGQ0E17zFQoxX8FeYTpQ33l4W1HJi2M0btEzk
         kMLA==
X-Gm-Message-State: AOJu0YyBhczTtg2bOuoiXwRcGjeKCAr93cfc3s8oSGAjEnxw1uJxcDWi
        cnNP3QrBAmWxiw57tn0E9dI=
X-Google-Smtp-Source: AGHT+IHTbQKXnfh0RLYopIMrbIOWtsBDr6TQ5k7MWBfzOtyLWQgfHs1Qemb4YKKiinxjdgrs/E6doA==
X-Received: by 2002:a05:6a00:1c94:b0:68e:2623:cdb with SMTP id y20-20020a056a001c9400b0068e26230cdbmr738157pfw.17.1694030073643;
        Wed, 06 Sep 2023 12:54:33 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d4aa])
        by smtp.gmail.com with ESMTPSA id r7-20020a62e407000000b006887be16682sm11094445pfh.53.2023.09.06.12.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:54:33 -0700 (PDT)
Date:   Wed, 6 Sep 2023 12:54:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 2/5] bpf: Enable cgroup_array map on cgroup1
Message-ID: <20230906195430.udj6suj32meoraju@MacBook-Pro-8.local>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <20230903142800.3870-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 03, 2023 at 02:27:57PM +0000, Yafang Shao wrote:
> The cgroup_array map currently has support exclusively for cgroup2, owing
> to the fact that cgroup_get_from_fd() is only valid for cgroup2 file
> descriptors. However, an alternative approach is available where we can use
> cgroup_v1v2_get_from_fd() for both cgroup1 and cgroup2 file descriptors.
> 
> The corresponding cgroup pointer extracted from the cgroup file descriptor
> will be utilized by functions like bpf_current_task_under_cgroup() or
> bpf_skb_under_cgroup() to determine whether a task or socket buffer (skb)
> is associated with a specific cgroup. In a previous commit, we successfully
> enabled bpf_current_task_under_cgroup(), ensuring the safety of storing a
> cgroup1 pointer within the cgroup_array map.
> 
> Regarding bpf_skb_under_cgroup(), it is currently restricted to cgroup2
> functionality only. Nevertheless, it remains safe to verify a cgroup1
> pointer within this context as well, with the understanding that it will
> return a "false" result in such cases.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 2058e89..30ea57c 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1291,7 +1291,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
>  				     struct file *map_file /* not used */,
>  				     int fd)
>  {
> -	return cgroup_get_from_fd(fd);
> +	return cgroup_v1v2_get_from_fd(fd);

This part looks ok.
