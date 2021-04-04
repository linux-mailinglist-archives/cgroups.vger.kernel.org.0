Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395E23538CE
	for <lists+cgroups@lfdr.de>; Sun,  4 Apr 2021 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDDQJh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDQJg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 12:09:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D8C061756;
        Sun,  4 Apr 2021 09:09:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f12so6972235qtq.4;
        Sun, 04 Apr 2021 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IdKWx2ZVFrKT8K7Fl0vAas4WcyOSUW1ErabAnFzPiY=;
        b=jX96hJMhziC36OYDoWoeDNXvIA7cggPk7CorJz2BxjjrMbtNIlwlpylAvnWF+ZOTyX
         R7O0Tb1FjmEEOmOFKybqkuX8uLYt2kbD46H7Y9fQHbW5Kw+U3x2WI3624GWsb+cyX1Qm
         cJvWe7RpsV9BTo+zcEeHuunv76O9aeTVuLBEnsy91UoYI9wl35bYLsG/WBzjtikXWIVS
         s3A+KOz6W63YHWWmCPXPcHspclrqJ5KPq1reYAn/NMAUpaawH35cptaHti0MVdvLFkFj
         TCHTZmHAnWMdCuEb7ak9yytBgKRMd0BPNOVa3yfL8Ywmf86oBtWf6FmATEivJzIPJXX6
         O0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+IdKWx2ZVFrKT8K7Fl0vAas4WcyOSUW1ErabAnFzPiY=;
        b=Socbm3r9KuqQ4SBeGo8Xx2dumgZ4jB6AfjRVSdNh3Sf93xW2BZVbYkB02E+Sk8/CTh
         kEBHCwK1TRERC9vtTzcTt8w204dAxhhdgXwo0gtQ1XjbjqtO+pRn5iEWEoNk0tsZkM+i
         dd1ZdR//GPK6QwaO+UrLFCKk88CJaljsEyY1aKiq9IbIeGnyINi7m3jaIuRVgGBPJBQd
         GXyx837doZxkBwgs+ROdVA0iLQGK2qseCplqnQVLy751CsGrZ3mZDd1CxCrzKnhCaQpM
         ssStDwFleWIL0b4qxp991m6ku+VoIhwTrRDMQPCS0pswqmtxdFuUHMghAl1w983dwNFW
         k4YA==
X-Gm-Message-State: AOAM530btToySqh5JZjoEvSs8Lz3KZgcMsl44x7DZvlb82082fZWJ//Y
        WIKfYWxPhGWjnJDW+lwMQb8=
X-Google-Smtp-Source: ABdhPJxLgpABQNDDleoUVLspcpb59HfOkiFZYe1ChYhDNTx9EajnuFa8PHaF1K9LiqotRZ7N06ViAA==
X-Received: by 2002:ac8:4e10:: with SMTP id c16mr18973833qtw.268.1617552570980;
        Sun, 04 Apr 2021 09:09:30 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id 21sm11876324qkv.12.2021.04.04.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 09:09:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 12:09:29 -0400
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] bfq: introduce bfq.ioprio for cgroup
Message-ID: <YGnkuWYKeK7C8/Za@mtj.duckdns.org>
References: <cover.1616649216.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Mar 25, 2021 at 02:57:44PM +0800, brookxu wrote:
> INTERFACE:
> 
> The bfq.ioprio interface now is available for cgroup v1 and cgroup
> v2. Users can configure the ioprio for cgroup through this
> interface, as shown below:
> 
> echo "1 2"> blkio.bfq.ioprio
> 
> The above two values respectively represent the values of ioprio
> class and ioprio for cgroup.
> 
> EXPERIMENT:
> 
> The test process is as follows:
> # prepare data disk
> mount /dev/sdb /data1
> 
> # prepare IO scheduler
> echo bfq > /sys/block/sdb/queue/scheduler
> echo 0 > /sys/block/sdb/queue/iosched/low_latency
> echo 1 > /sys/block/sdb/queue/iosched/better_fairness
> 
> It is worth noting here that nr_requests limits the number of
> requests, and it does not perceive priority. If nr_requests is
> too small, it may cause a serious priority inversion problem.
> Therefore, we can increase the size of nr_requests based on
> the actual situation.
> 
> # create cgroup v1 hierarchy
> cd /sys/fs/cgroup/blkio
> mkdir rt be0 be1 be2 idle
> 
> # prepare cgroup
> echo "1 0" > rt/blkio.bfq.ioprio
> echo "2 0" > be0/blkio.bfq.ioprio
> echo "2 4" > be1/blkio.bfq.ioprio
> echo "2 7" > be2/blkio.bfq.ioprio
> echo "3 0" > idle/blkio.bfq.ioprio

Here are some concerns:

* The main benefit of bfq compared to cfq at least was that the behavior
  model was defined in a clearer way. It was possible to describe what the
  control model was in a way which makes semantic sense. The main problem I
  see with this proposal is that it's an interface which grew out of the
  current implementation specifics and I'm having a hard time understanding
  what the end results should be with different configuration combinations.

* While this might work around some scheduling latency issues but I have a
  hard time imagining it being able to address actual QoS issues. e.g. on a
  lot of SSDs, without absolute throttling, device side latencies can spike
  by multiple orders of magnitude and no prioritization on the scheduler
  side is gonna help once such state is reached. Here, there's no robust
  mechanisms or measurement/control units defined to address that. In fact,
  the above direction to increase nr_requests limit will make priority
  inversions on the device and post-elevator side way more likely and
  severe.

So, maybe it helps with specific scenarios on some hardware, but given the
ad-hoc nature, I don't think it justifies all the extra interface additions.
My suggestion would be slimming it down to bare essentials and making the
user interface part as minimal as possible.

Thanks.

-- 
tejun
