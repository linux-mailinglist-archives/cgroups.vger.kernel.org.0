Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC7367F83
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhDVLYB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 07:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235917AbhDVLYB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 07:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3547161435;
        Thu, 22 Apr 2021 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619090604;
        bh=Mx/79Tlvzv5GZtxiqgvpFLyIp0xUSUvc0zLjb/CPgfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM18T0Su4Vlx98O/ybn/9SaDiRhFaXQtJwf1ePRALyjnUITAfJYC5wqL3e9wzNtro
         rVVshchUl0iYW/7PMJK8UBaQUMjEFlW1XNg/IOBJc8IMF2aIy5ssPEclGieQV0Evkz
         U4VRi+JjIXSOrg3tEjARIl6joWlpseTFcYhnURQc=
Date:   Thu, 22 Apr 2021 13:23:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIFcqcd4dCiNcILj@kroah.com>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
> At each login the user forces the kernel to create a new terminal and
> allocate up to ~1Kb memory for the tty-related structures.

Does this tiny amount of memory actually matter?  This feels like it
would be lost in the noise, and not really be an issue for any real
system as it's hard to abuse (i.e. if a user creates lots of tty
structures, what can they do???)

So no, I do not think this patch is needed, thanks.

greg k-h
