Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A86D7EE24
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbfHBH5P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 03:57:15 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43551 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733079AbfHBH5O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 03:57:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DB7A7396;
        Fri,  2 Aug 2019 03:57:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Aug 2019 03:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Hr4s+2enj+l1mmH04OZlM0hoJ/x
        4fNLnfJYyrd9Jdyc=; b=X67/JBh5/t/0n74GFHXO6bqLS764/oxBsd1NYhrNNAJ
        VweeDCX+xKMaQMQhb8p9bkyL9OoZwNTLhq74oR5mo4oc54dUdWNIeKTVt2oCOhlS
        DGtez5g64+dtJjWvCQ4GSq92cQuzI8oiWXmVaHOuqi+aT8p8XL8sxZo7kV2w/VuE
        dBiq2ZpFMHcZJaONnx4fF3Zr8LZy+fO5xxCm3eoFPwSYomkUAG1yFwX8dnwdWSyo
        ZTgtIfXcaINh4JdkHVqcbUIwLxPPBaaTFweXKYso34J2C6bGKqGMbvd8gMaNbfbO
        lUIh7Ojf1ZqUfO8hcAN4DEbBXRt8URPrB/yc9nY1Kbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Hr4s+2
        enj+l1mmH04OZlM0hoJ/x4fNLnfJYyrd9Jdyc=; b=PnSTLsvwkP/9aF33LqkxCv
        Mu/bUr9KMxQE8sLDFxdqirK7gIW1l2sRtGHs1W2bcgWB/ddQCrZbrC2JsQ0KpHu8
        FCu3lZVBC0F8HSgQN7BwehyeKFfbVV+yPNhWo4T6hDYaH4CHNd4b2HTHNXkBB5+N
        w18TFIE6hmjFOArTqVV37kRmAM7Q00R74aQXibBQN0788ImyJLvOjMWgIF14dyxO
        Rt8DALtMCwBSzxi9AWU6XqvJAEbuIP0eNQNaM7qs2y+AfFrf3tOL0zJ+9zuKuul+
        Uo7J3+4ycZkuI9zQdjPYObEIMdlSAkNB7Cv2fmG/tRYlu5BLeXvzKDoXo8FyMzGQ
        ==
X-ME-Sender: <xms:1-xDXWSUyuuBxNlS90-pf6YXzvFv2DXiBRwyrSj0u0ZmpeO2DFxqPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:1-xDXUKG8eqd3qm-fdif7e00wYeglLbpovMvWSJQv1-8Y9I5fOL3kg>
    <xmx:1-xDXf6r2wQXMv2eQzlDLByijbeAPdorKm4uMdfDv58nXbwD7W1U3w>
    <xmx:1-xDXXdApN__pwdGcOoDkLZ9SB5SV87tAtMozN60Bydh34vDNgHGbw>
    <xmx:2OxDXUGQxuEMRndbB8ewvmTDNhmrV0FaruYWLxDJ4ZEeviu8OqrByg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 243048005A;
        Fri,  2 Aug 2019 03:57:11 -0400 (EDT)
Date:   Fri, 2 Aug 2019 09:57:09 +0200
From:   Greg KH <greg@kroah.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: Re: [PATCH 5/3 cgroup/for-5.2-fixes] cgroup: Fix
 css_task_iter_advance_css_set() cset skip condition
Message-ID: <20190802075709.GH26174@kroah.com>
References: <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
 <20190531174028.GG374014@devbig004.ftw2.facebook.com>
 <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
 <20190610161619.GB3341036@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610161619.GB3341036@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 10, 2019 at 09:16:19AM -0700, Tejun Heo wrote:
> Hello,
> 
> Fix for another fallout.  Applied to cgroup/for-5.2-fixes.
> 
> Thanks.
> 
> ------ 8< ------
> >From c596687a008b579c503afb7a64fcacc7270fae9e Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 10 Jun 2019 09:08:27 -0700
> 
> While adding handling for dying task group leaders c03cd7738a83
> ("cgroup: Include dying leaders with live threads in PROCS
> iterations") added an inverted cset skip condition to
> css_task_iter_advance_css_set().  It should skip cset if it's
> completely empty but was incorrectly testing for the inverse condition
> for the dying_tasks list.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in PROCS iterations")
> Reported-by: syzbot+d4bba5ccd4f9a2a68681@syzkaller.appspotmail.com
> ---
>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9538a12d42d6..6420ff87d72c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4401,7 +4401,7 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
>  			it->task_pos = NULL;
>  			return;
>  		}
> -	} while (!css_set_populated(cset) && !list_empty(&cset->dying_tasks));
> +	} while (!css_set_populated(cset) && list_empty(&cset->dying_tasks));
>  
>  	if (!list_empty(&cset->tasks))
>  		it->task_pos = cset->tasks.next;
> -- 
> 2.17.1
> 

These all made it into 5.2 now.  Should they also be backported to 4.19
and/or any older stable kernels?

thanks,

greg k-h
