Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96E3D720D
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhG0JcJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 05:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236125AbhG0JcJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 05:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A30760E09;
        Tue, 27 Jul 2021 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627378329;
        bh=5Ez4IXemr8M6FoN3lv3kTwfLMCVrpyMcVjl7PW1H/ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUPRPfJGcA1bM6D58QeUAcuHwuh4hTPgHONhJ4hMVTUbs4zthrO/+R1Nd/jGKB0GY
         cyW6nGQbFKuu0V+3K1AOOMTFOpLeu6W+2MVXw00LUiUBb8r6Hxo6sQ1//wCkA84Jbj
         H5qGKbffQbrfOnP6ID5NNBkygNmzIHPnOvEDEC/k=
Date:   Tue, 27 Jul 2021 11:32:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH TTY] memcg: drop GFP_KERNEL_ACCOUNT use in
 tty_save_termios()
Message-ID: <YP/Sl8a5PqUFZAi5@kroah.com>
References: <d42bd2a3-74a0-163f-6e3a-ad702f6d2817@virtuozzo.com>
 <afbaec7c-1872-d43a-1240-e077adc0d6d9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afbaec7c-1872-d43a-1240-e077adc0d6d9@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 27, 2021 at 12:26:12PM +0300, Vasily Averin wrote:
> Jiri Slaby pointed that termios are not saved for PTYs and for other
> terminals used inside containers. Therefore accounting for saved
> termios have near to zero impact in real life scenarios.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Fixes: 854dd8a572a0 ("memcg: enable accounting for tty-related objects")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/tty/tty_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e787f6f..a6230b2 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1493,7 +1493,7 @@ void tty_save_termios(struct tty_struct *tty)
>  	/* Stash the termios data */
>  	tp = tty->driver->termios[idx];
>  	if (tp == NULL) {
> -		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
> +		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
>  		if (tp == NULL)
>  			return;
>  		tty->driver->termios[idx] = tp;
> -- 
> 1.8.3.1
> 

I can just drop the original patch from my tree, it has not gone into my
unmutable branch yet.

thanks,

greg k-h
