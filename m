Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D533D7206
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhG0JbA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 05:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235946AbhG0JbA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 05:31:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02CAB600D4;
        Tue, 27 Jul 2021 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627378260;
        bh=gs7eJAOqHz0y0MgMzJHu3ENkS4NCcGHEBd0dG2aBni0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8yO2l0eRWB/MYAfEFD4kEBZ0ammK/F7vGp/bD8qlkWhbdzyXMf5OTl/WV6aCmwRr
         NjqHbDxoErEydeC8LzISazDpfl2UqCz38OFhI8qHtoyHWruTnfX7LCq06bvpwH0OCe
         3FVEiM1doxBuTndQ+PNs0joLCTlKBAsCLyBhHks8=
Date:   Tue, 27 Jul 2021 11:30:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/10] memcg: enable accounting for tty-related objects
Message-ID: <YP/SUlucImu11zT7@kroah.com>
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
 <b8baa04f-e789-0321-b39d-07c5696ff755@virtuozzo.com>
 <1eef95fe-6172-796e-edd1-095545da6e74@kernel.org>
 <d42bd2a3-74a0-163f-6e3a-ad702f6d2817@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d42bd2a3-74a0-163f-6e3a-ad702f6d2817@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 27, 2021 at 11:02:31AM +0300, Vasily Averin wrote:
> On 7/27/21 9:54 AM, Jiri Slaby wrote:
> > On 27. 07. 21, 7:34, Vasily Averin wrote:
> >> At each login the user forces the kernel to create a new terminal and
> >> allocate up to ~1Kb memory for the tty-related structures.
> >>
> >> By default it's allowed to create up to 4096 ptys with 1024 reserve for
> >> initial mount namespace only and the settings are controlled by host admin.
> >>
> >> Though this default is not enough for hosters with thousands
> >> of containers per node. Host admin can be forced to increase it
> >> up to NR_UNIX98_PTY_MAX = 1<<20.
> >>
> >> By default container is restricted by pty mount_opt.max = 1024,
> >> but admin inside container can change it via remount. As a result,
> >> one container can consume almost all allowed ptys
> >> and allocate up to 1Gb of unaccounted memory.
> >>
> >> It is not enough per-se to trigger OOM on host, however anyway, it allows
> >> to significantly exceed the assigned memcg limit and leads to troubles
> >> on the over-committed node.
> >>
> >> It makes sense to account for them to restrict the host's memory
> >> consumption from inside the memcg-limited container.
> >>
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>   drivers/tty/tty_io.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> >> index 26debec..e787f6f 100644
> >> --- a/drivers/tty/tty_io.c
> >> +++ b/drivers/tty/tty_io.c
> >> @@ -1493,7 +1493,7 @@ void tty_save_termios(struct tty_struct *tty)
> >>       /* Stash the termios data */
> >>       tp = tty->driver->termios[idx];
> >>       if (tp == NULL) {
> >> -        tp = kmalloc(sizeof(*tp), GFP_KERNEL);
> >> +        tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
> > 
> > termios are not saved for PTYs (TTY_DRIVER_RESET_TERMIOS). Am I missing something?
> 
> No, you are right, I've missed this.
> Typical terminals inside containers use TTY_DRIVER_RESET_TERMIOS flag and therefore do not save termios.
> So its accounting have near-to-zero impact in real life.
> I'll prepare fixup to drop GFP_KERNEL_ACCOUNT here.

I'll go drop this patch from my tree.

thanks,

greg k-h
