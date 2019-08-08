Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E653785DF1
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2019 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfHHJMn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Aug 2019 05:12:43 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58775 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731054AbfHHJMm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Aug 2019 05:12:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 07E4D46E;
        Thu,  8 Aug 2019 05:12:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Aug 2019 05:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/yDPqiyoQcG4L5I/Fc0HWZvCNnn
        E3ZyIohcVauOG3Nk=; b=Nnm7xaWZ6mAroeNYrg4EVe3CEMSFh9ye6WOzXEID4Xv
        /+lv8HO64nzDm44olMULEgY/uwIjjxbN3ZQio6LUyNwLp9b+pO8YQwnzPDLZz7UI
        yoafCz4ciJD2uPS9GVWBEsUC6v/pOo5vL8GH7IofrUbs4GcYJDlH5RuKnEGfnoPY
        p40cP7SViwyd4sWSVO8sU13AQX2BWmGI49bQo0oXFgzH8q2jNprtqw6fz1UqH99y
        MU5rRlGH1klHtD2t8gHCRzr+hadSz8BDzDqCzCdxrYKCjLfJKgd43/iEpG0jGR8P
        m2jPMdCQ/KZbHW03d3RZkkCBmdAZ2rrlctjv11dsnGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/yDPqi
        yoQcG4L5I/Fc0HWZvCNnnE3ZyIohcVauOG3Nk=; b=FpurUzGu/MIHV3FGw2hLj/
        ied5TDD91XMwt3XR6OiFA+jFy40NK1qvby7dGRSd7sbLmsFFPIz5KEBNbs5aNTkx
        //y4pKIvYn/5+iAuhFU6TqABFvARypdjmMVSexIwSoWIXseOaNX7uCtUbTGP5GNm
        r9dZ4du6aV7n3xmcPmy56jximq7JP6zBvBmXIHSi7tk1ebxhuMCN9f2+KZttNCrN
        BCt+ctGuBypoC/qdd19SiJfU8HxdOQ4+SUzKwWXNODRdFJtG1q0dUbEbQVR0B4wb
        9R/huALmCM9kx46bJO7ZNsW2wAEpcdr6kOl5GJT5S9wogfAMD0fF5xFFSFWtdfLw
        ==
X-ME-Sender: <xms:h-dLXVWJT3ksAsDKH6eS5fzjMm6nFBFGxbHK8Rv0OlwdeSr_7FvwSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduhedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:h-dLXZ3MwA2jGqkOmWhpjVrfD438cvc3l7DqBQ1C0qTp9c6Sz8rlZg>
    <xmx:h-dLXcYZU5ugGLEQVWQzocoM1iWyfEWjY50r_nAmg71hOgoB3MgOgQ>
    <xmx:h-dLXcrmEFEORh1rXZCRkEflUzercuNo3bBMtKgvonAP573Bhr6G7g>
    <xmx:iOdLXQfYvOiHDvTf9FbXvh47DU9AC2WjJ3FnTuC0eJJZ8j-6d-IQ-Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3318E80061;
        Thu,  8 Aug 2019 05:12:39 -0400 (EDT)
Date:   Thu, 8 Aug 2019 11:12:37 +0200
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
Message-ID: <20190808091237.GA21454@kroah.com>
References: <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
 <20190531174028.GG374014@devbig004.ftw2.facebook.com>
 <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
 <20190610161619.GB3341036@devbig004.ftw2.facebook.com>
 <20190802075709.GH26174@kroah.com>
 <20190805173614.GG136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805173614.GG136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 05, 2019 at 10:36:14AM -0700, Tejun Heo wrote:
> Hello, Greg.
> 
> On Fri, Aug 02, 2019 at 09:57:09AM +0200, Greg KH wrote:
> > These all made it into 5.2 now.  Should they also be backported to 4.19
> > and/or any older stable kernels?
> 
> Yeah, I guess it should have seen enough exposure now.  I think it
> makes sense to backport them given the screwy failure mode it fixes.

Ok, now queued up for 4.19.y and 4.14.y, thanks!

greg k-h
