Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568DD199848
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCaOTV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 10:19:21 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40214 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgCaOTV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 10:19:21 -0400
Received: by mail-qt1-f170.google.com with SMTP id c9so18407854qtw.7;
        Tue, 31 Mar 2020 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWkjn/y5z/dvwzoJa8fqZIHet243GVuFUj07PejuwaE=;
        b=T6T/0Cx78XqhWhUA60nml5Yrd74RnfM3vsZkhJ9RcOX3N2/3yw2IiD61b7qinK/6Mg
         u+f6SZWEH4A6U7ffH7NexMNDW84Kl4Yy2zNFuNZ9pvvTt2VGHMO0NYHkQNF1tR331Bkm
         E6MJYizuWuC1PU3HmLQr+cwhMgHCyQWGn4nIRkfhdlGUnuNYBPNahoIjZK1tYNklipdG
         qguOlG4bxfVxlKljm69N13GRRqBzZ9mAU3nKpQ5Qg0FfUhFOH8DKVQLwXtcwN+e4iAB6
         4zPr7BxxdiGlM9pgipr5clQLkJu0YN/2uyph8cTAWAcSJ4pWInpiufYuzws96hKDfLL7
         aXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vWkjn/y5z/dvwzoJa8fqZIHet243GVuFUj07PejuwaE=;
        b=PdmD/JfrrTuCZShHqQpC6RPdvxyqmRxoqV6tzxl2UJcMT6pZrr50tpqRdrxfKWo/Mw
         NBtdO9Ob+vvqB9JBhm/bo5bg38ER04o8H6juqoxmLbYpeoftb/rllmz1SXXZtSbadpR0
         t6ZNv8ppjKNaS/N/wYjSZ+cUnUpUhcyT1sPKXONoVPaJkv0kO+aQbA6HtvkHfAcLO+zk
         vDDbLf2hz89mKhp7spu6m9ieYitQ4h9btENDrUqC/KRieaVx8wweZ7qOSG2JSKh/QLOP
         LiqmIMVMN3x1/TQ6loOvMQbYLXWpkOqmL05jqgEdc/yP6HAv82nrTQ6b9irVS+Wd7Apj
         4GKg==
X-Gm-Message-State: ANhLgQ37zip4Mc7wwpehPqW8COZdpSa4U9ovif6/CFrKGPAV9yB0dTxS
        wle1FGbg1BRecOFG6nnm49A=
X-Google-Smtp-Source: ADFU+vt2TsP3mq6Y9g809xdqWk6Buy/hS1xuCBkfykEQYk0Zaw7P4Iu/Azqzq8/0uo0+xdIef+kB9Q==
X-Received: by 2002:ac8:39c6:: with SMTP id v64mr5304613qte.344.1585664359757;
        Tue, 31 Mar 2020 07:19:19 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id q142sm12392644qke.45.2020.03.31.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:19:18 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:19:16 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC 0/3] blkcg: add blk-iotrack
Message-ID: <20200331141916.GR162390@mtj.duckdns.org>
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
 <20200324182725.GG162390@mtj.duckdns.org>
 <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
 <20200325141236.GJ162390@mtj.duckdns.org>
 <CAA70yB5yH9H6-gaKfRSTmgd6vvzP4T9N7v-NAD0MsRL+YTexHw@mail.gmail.com>
 <CAA70yB4e65nbV=ZA8OT-SUkq+ZQOGGB9e-3QKJ_PqXjVaXGvFA@mail.gmail.com>
 <20200326161328.GN162390@mtj.duckdns.org>
 <CAA70yB66fBdAOnv+8rXauwbuPu+UY+gr9ZKeSsQNgq+ZHhJn3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB66fBdAOnv+8rXauwbuPu+UY+gr9ZKeSsQNgq+ZHhJn3Q@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Weiping.

On Fri, Mar 27, 2020 at 12:27:11AM +0800, Weiping Zhang wrote:
> I really appreciate that if you help review blk-iotrack.c, or just
> drop io.iotrakc.stat
> and append these  statistics to the io.stat? I think these metrics is usefull,

So, the problem is that you can get the same exact and easily more information
using bpf. There definitely are benefits to baking in some stastics in terms of
overhead and accessbility but I'm not sure what's being proposed is generic
and/or flexible enough to bake into the interface at this point.

Something which can be immediately useful would be cgroup-aware bpf progs which
expose these statistics. Can you please take a look at the followings?

  https://github.com/iovisor/bcc/blob/master/tools/biolatency.py
  https://github.com/iovisor/bcc/blob/master/tools/biolatency_example.txt

They aren't cgroup aware but can be made so and can provide a lot more detailed
statistics than something we can hardcode into the kernel.

Thanks.

-- 
tejun
