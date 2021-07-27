Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6223D6FBE
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 08:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhG0Gyg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 02:54:36 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:43573 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0Gyd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 02:54:33 -0400
Received: by mail-wm1-f53.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so1568909wmq.2;
        Mon, 26 Jul 2021 23:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aaW7cFw+oCFWM/dmmy7Fk93SXTQV0wxby9I/PRxiL4c=;
        b=mm+Lxm8cVSQOnilaLWWRArZ4654l0xlZSyBHgyDaMhy0+F43HIuhyue/KPMcnTIvEc
         E/VNDDCiMtJDEga4sSgz9XJTBf2MUxoC7+CWF6drYIxhVEBw4k2aK+kX7Ft9+VPFGFxG
         SyvobGT3hAHjaMHAZwyl3DGoIdQARN8JTyu5e+ro0i6Enqs02PUt2oAVafRQs/MU087f
         RZ+Q25ujjKKAVbWUdkzwEYLFI4rXfkNHRSsEuph9gJpW0ELyb40ZHNVHOEdN/HkCYjbk
         SaifLrPsUCqWILB7y1nLjFyfue5dBK05HZG9P5clWY2rsiYypuLQaE1TcQ6syT8WjsfM
         lBFg==
X-Gm-Message-State: AOAM532JtP36Q+YCBHWFkxBOBt2ZL/RIN6bPO3MWlRGEw0PP0kxNAXTe
        tkQ/GSGU8F4418Fnfd1hUOiu6cSfFXW5Yw==
X-Google-Smtp-Source: ABdhPJxIWCHbsXVIVvCyRBAf9hyz35xq2EdGm1WfHnZDkv4s9+x7rYlA1/oYB3fZBZCaca8Y+ES5vA==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr2518480wmc.21.1627368872670;
        Mon, 26 Jul 2021 23:54:32 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v15sm1738843wmj.39.2021.07.26.23.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 23:54:31 -0700 (PDT)
Subject: Re: [PATCH v7 09/10] memcg: enable accounting for tty-related objects
To:     Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
 <b8baa04f-e789-0321-b39d-07c5696ff755@virtuozzo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <1eef95fe-6172-796e-edd1-095545da6e74@kernel.org>
Date:   Tue, 27 Jul 2021 08:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b8baa04f-e789-0321-b39d-07c5696ff755@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27. 07. 21, 7:34, Vasily Averin wrote:
> At each login the user forces the kernel to create a new terminal and
> allocate up to ~1Kb memory for the tty-related structures.
> 
> By default it's allowed to create up to 4096 ptys with 1024 reserve for
> initial mount namespace only and the settings are controlled by host admin.
> 
> Though this default is not enough for hosters with thousands
> of containers per node. Host admin can be forced to increase it
> up to NR_UNIX98_PTY_MAX = 1<<20.
> 
> By default container is restricted by pty mount_opt.max = 1024,
> but admin inside container can change it via remount. As a result,
> one container can consume almost all allowed ptys
> and allocate up to 1Gb of unaccounted memory.
> 
> It is not enough per-se to trigger OOM on host, however anyway, it allows
> to significantly exceed the assigned memcg limit and leads to troubles
> on the over-committed node.
> 
> It makes sense to account for them to restrict the host's memory
> consumption from inside the memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/tty_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 26debec..e787f6f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1493,7 +1493,7 @@ void tty_save_termios(struct tty_struct *tty)
>   	/* Stash the termios data */
>   	tp = tty->driver->termios[idx];
>   	if (tp == NULL) {
> -		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
> +		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);

termios are not saved for PTYs (TTY_DRIVER_RESET_TERMIOS). Am I missing 
something?

>   		if (tp == NULL)
>   			return;
>   		tty->driver->termios[idx] = tp;
> @@ -3119,7 +3119,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
>   {
>   	struct tty_struct *tty;
>   
> -	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
> +	tty = kzalloc(sizeof(*tty), GFP_KERNEL_ACCOUNT);
>   	if (!tty)
>   		return NULL;
>   
> 

thanks,
-- 
js
suse labs
