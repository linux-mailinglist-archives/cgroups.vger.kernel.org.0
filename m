Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1B57293
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFZU1K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 16:27:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40937 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZU1K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 16:27:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so2045489pla.7;
        Wed, 26 Jun 2019 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x1o8oqi0CP9ZDnGVZ99akUd6mY/E2omAq/EbskrFW4k=;
        b=POv1IyE+sfM8PtylMEWG9x0KHLapZZmKG9O21FYbI6DJsX5YyUowJrGlqsd1brIdG8
         4ooVgaj5bl5g67fjcD008OmeeshHnFYPER80FNuf5bYHxde/ukJ7bWPpS8NczoyEc+cd
         CKv88keWcLtmuhtiNaZoX+rSSEGKhfYIcDgDEeWjODEkilqjwNyropymwYsdONJxg/BT
         RNVNSIq/3Dm6bgbcxL3pgXBZ/PJQDE9Y849OPSdGMAR8sKJdGdQE52In7DcwfdXdT/zY
         0kLbMrXm0RsqOhLX7c87vpo1H5eqgA6gd/xXSJomam4kbPKHTDP711I23q8T80n26mkx
         3q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x1o8oqi0CP9ZDnGVZ99akUd6mY/E2omAq/EbskrFW4k=;
        b=SHDq5fb5Plw6aHWd+FfXsFUSEk/6rSZjetOcMVtIOen3dqZkZBI5jyWCEJd5z5FeF0
         cCRIo5Jxqj9iD/hgtEtR1pRGWmVTa3R/vKWkWrDksZT6I4J6wuGywRJzj6DoLcOsdVAJ
         ZnOUn8R3sQ0CVFvjHBXdQNjEQWZbivu/VRj/npDBuYXVrwawLoVMnINfs0A1A/qdqBis
         rturGjulM3NxeQwDNS3hbVWMj0kN60NWpaK0B+Sail50pGTROjVYeYU4GPa67IOpEVKU
         TBGJas6eTX/m2XOdtCTINLn1LHWuJwlUX6yspQdo0AxsHhnlwMSEQwO7YPuuAJhtL+Jr
         TNOA==
X-Gm-Message-State: APjAAAUjSExevr7Kh32l3zgULNXHwSjWdpKwM+IdeLx6q6W2s89y8jS5
        PEAn18fIVr0HlcPtgUiecmc=
X-Google-Smtp-Source: APXvYqyjymNoPT4b92sWLExLPDZZq/X+c5U+Nyf00E2YjebGqOGMookCtAi+tYDjxEy8W4ninii9dg==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr7962559plp.194.1561580829862;
        Wed, 26 Jun 2019 13:27:09 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id p27sm83702pfq.136.2019.06.26.13.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:27:09 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:27:06 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, keith.busch@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to
 read_queues
Message-ID: <20190626202706.GC4934@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
 <20190624200445.GB6526@minwooim-desktop>
 <CAA70yB5arvfaUsktN-cvd0yHpRi+FwFjL4r5_jTRWM8+rBVdnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA70yB5arvfaUsktN-cvd0yHpRi+FwFjL4r5_jTRWM8+rBVdnA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 19-06-25 22:48:57, Weiping Zhang wrote:
> Minwoo Im <minwoo.im.dev@gmail.com> 于2019年6月25日周二 上午6:00写道：
> >
> > On 19-06-24 22:29:19, Weiping Zhang wrote:
> > > Now nvme support three type hardware queues, read, poll and default,
> > > this patch rename write_queues to read_queues to set the number of
> > > read queues more explicitly. This patch alos is prepared for nvme
> > > support WRR(weighted round robin) that we can get the number of
> > > each queue type easily.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> >
> > Hello, Weiping.
> >
> > Thanks for making this patch as a separated one.  Actually I'd like to
> > hear about if the origin purpose of this param can be changed or not.
> >
> > I can see a log from Jens when it gets added her:
> >   Commit 3b6592f70ad7("nvme: utilize two queue maps, one for reads and
> >                        one for writes")
> >   It says:
> >   """
> >   NVMe does round-robin between queues by default, which means that
> >   sharing a queue map for both reads and writes can be problematic
> >   in terms of read servicing. It's much easier to flood the queue
> >   with writes and reduce the read servicing.
> >   """
> >
> > So, I'd like to hear what other people think about this patch :)
> >
> 
> This patch does not change its original behavior, if we set read_queue
> greater than 0, the read and write request will use different tagset map,
> so they will use different hardware queue.

Yes, that's why I want to hear some comments for this change from other
people.  I'm not against this change, though.
