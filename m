Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678CAF78B4
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKQZm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 11:25:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44264 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKQZm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 11:25:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so11657396qki.11;
        Mon, 11 Nov 2019 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVB0hf2H7viNLDsJEXupjleQ32zh4paH4Y6V5CSZP5c=;
        b=g47F4YygVxrZqYHpcwdtLrN/z/E927SRGwe/1Qqe7N+MsN3BxpqhyD6lObpX1cYM8U
         dfI66M8XuwzO9HTWVGpylVZv4kLGsZqUFvZQ4Z33AlsxLhDSJFoK71Y5BMrVgDhIwfCu
         LSaduJ4Pt9g0uVuSpksHM5/8sFSsO+BSgMrhsZbWFZ1vZhGKL/usNoCQLbaoimpvWppw
         xC6CgmU5O4wqxDx1MX37uIpXoOF8iJKOkEY9R8M7znrboIMtG/fiqEU9t+ZN46zLG/Hi
         G9OkdHKv7fFEaKJdfgPW0URU/52q016c4BECAaeKaFnGBawxFrWVpVnpUhInMGZv3QXv
         4u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVB0hf2H7viNLDsJEXupjleQ32zh4paH4Y6V5CSZP5c=;
        b=dgnwXNNDR/JShk3t9HkBaXHXR4na9DpEJDfPqbiMvNAoFQ3dN5nnuZzchNHe9AXbgm
         MFhkoaVhSmTDw6O1X1BarQCS3jUEpBKzayzX1emHVb/m+7bABisN19IID1VH136UckhZ
         IwGakH7y4G1XfzHaHU+m3Dj2c/BBEQ+qnhpf6HhO32OAr+ZiOiOwF5bahn6JrSa9eZ/Q
         LktXftwv4udc0sT0juI+iDKdca0FqzO5l8nvkAyBMKK1MBvOWJlg7JImBFqrPZE3aK8P
         yvfRIbz0SPmVU1ezEvz4gT5/GodBNoC80jhX988ODj+wUeGKVPBUIa0W5Yc5IZPKkpEe
         D1ew==
X-Gm-Message-State: APjAAAU73Yktj70dghv8GYqz+bSHIVi6MZotrl6EeSZFtEGP3RnE+SS6
        ezXGRhT51mxxngYXxQHwDo0=
X-Google-Smtp-Source: APXvYqwwbBg+fIWBe36gKiX9RZA/pALq+FL9ViuRmoVY81YsUmfo3dwNykhC2goBM0oQllxOh5nPYg==
X-Received: by 2002:a05:620a:8d9:: with SMTP id z25mr1364094qkz.483.1573489540926;
        Mon, 11 Nov 2019 08:25:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:73b5])
        by smtp.gmail.com with ESMTPSA id 19sm8108167qkg.89.2019.11.11.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:25:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:25:38 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] iocost: treat as root level when parents are activated
Message-ID: <20191111162538.GB4163745@devbig004.ftw2.facebook.com>
References: <1573457838-121361-1-git-send-email-jiufei.xue@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573457838-121361-1-git-send-email-jiufei.xue@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Jiufei.

On Mon, Nov 11, 2019 at 03:37:18PM +0800, Jiufei Xue wrote:
> Internal nodes that issued IOs are treated as root when leaves are
> activated. However, leaf nodes can still be activated when internal
> nodes are active, leaving the sum of hweights exceeds HWEIGHT_WHOLE.
> 
> I think we should also treat the leaf nodes as root while leaf-only
> constraint broken.

Hmm... I'm not sure this description makes sense.

> @@ -1057,8 +1057,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
>  	atomic64_set(&iocg->active_period, cur_period);
>  
>  	/* already activated or breaking leaf-only constraint? */
> -	for (i = iocg->level; i > 0; i--)
> -		if (!list_empty(&iocg->active_list))
> +	for (i = iocg->level - 1; i > 0; i--)
> +		if (!list_empty(&iocg->ancestors[i]->active_list))

But there's an obvious bug there as it's checking the same active_list
over and over again.  Shouldn't it be sth like the following instead?

	if (!list_empty(&iocg->active_list))
		goto succeed_unlock;
	for (i = iocg->level - 1; i > 0; i--)
		if (!list_empty(&iocg->ancestors[i]->active_list))
			goto fail_unlock;

Thanks.

-- 
tejun
