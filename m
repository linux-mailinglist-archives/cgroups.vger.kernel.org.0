Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42745191913
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCXS13 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 14:27:29 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:41760 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCXS13 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 14:27:29 -0400
Received: by mail-qt1-f174.google.com with SMTP id i3so11982879qtv.8;
        Tue, 24 Mar 2020 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x+AJ73g67Lv+1tYqp3JK2cKPMpi2aKN3Up6Cs52zqao=;
        b=vPcBHMCUcEGWwF6ReF3V5Oj14G9fzThxHKTmhQWjdrqvvIU9w3190k+I52sQr16+Ij
         oLI36ieeOKdcMESeKCP0s24tJvKWfCQUYwfrD41UAeIb0gw84GL36gxKS0INNJBA5pzu
         y5iXEEJRgq7+T+bK1a76JZ/eLF7uVGK7Be8OZlrMhcSQ28zyswt2Lwj3o3NDu8M04eBq
         jbpWIyfyWojPE0y1UPULVXZCGWsxOa4n1gQa07TQR0uAgB2ZDs+J/hPstNCRW6pycLVy
         VbFTImV9nQ8yIf6tFuqUAFcBDKV2V3X9WYdzJ7gF4668/MFNL0sPsMeCdVxmyPlTzz/Q
         qdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=x+AJ73g67Lv+1tYqp3JK2cKPMpi2aKN3Up6Cs52zqao=;
        b=Y81SfIWoaqUMGHkvL5Jo9bngKltXm3EaZdHBhHotQPj1pqZyvpJAU9EbtIJzYoK2h/
         vlEHncxsBXlibPNQkDqg41Yi7BVdenF7zfRNbWiFY0pGPz/m13t1n8T7fKk1Pbd97ydx
         atCu8Dqf5uLTe2d02jhigDj8qbfjUXeZCCJVMfeeHngKOzjra2wkI5K/neQFb3JNCANP
         bpf8CBr2YEpHo/o6LYWnli5Wmw7/B3+SFYDnlFiLj8Dm5ljHOn7Lgm5WBvhZsSDoVb0X
         pF6aq+krep3W/r2jfXSj+LiBOogOpxVJI6AJlxcXB6/6vb8PP5gBaXGyUQg8yqRdzL6S
         7jAg==
X-Gm-Message-State: ANhLgQ27peiFbTNy8LhCgv9EVlowLgSri4CUO2QEwBi5hi28u9aalDY4
        zpFoAqxOHwMZfXGT6q3cs6M=
X-Google-Smtp-Source: ADFU+vtmcT7gz4S7OovLma2taKH6A60dohcmWOI2PX7RmOQhGId2yOdfxujTItaPvCUIUDDsyNnl8w==
X-Received: by 2002:ac8:3148:: with SMTP id h8mr28064345qtb.341.1585074447461;
        Tue, 24 Mar 2020 11:27:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id r3sm14029528qkd.3.2020.03.24.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:27:27 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:27:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC 0/3] blkcg: add blk-iotrack
Message-ID: <20200324182725.GG162390@mtj.duckdns.org>
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584728740.git.zhangweiping@didiglobal.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 21, 2020 at 09:20:36AM +0800, Weiping Zhang wrote:
> The user space tool, which called iotrack, used to collect these basic
> io statistics and then generate more valuable metrics at cgroup level.
> From iotrack, you can get a cgroup's percentile for io, bytes,
> total_time and disk_time of the whole disk. It can easily to evaluate
> the real weight of the weight based policy(bfq, blk-iocost).
> There are lots of metrics for read and write generate by iotrack,
> for more details, please visit: https://github.com/dublio/iotrack.
> 
> Test result for two fio with randread 4K,
> test1 cgroup bfq weight = 800
> test2 cgroup bfq weight = 100
> 
> Device      io/s   MB/s    %io    %MB    %tm   %dtm  %d2c %hit0 %hit1 %hit2 %hit3 %hit4 %hit5  %hit6  %hit7 cgroup
> nvme1n1 44588.00 174.17 100.00 100.00 100.00 100.00 38.46  0.25 45.27 95.90 98.33 99.47 99.85  99.92  99.95 /
> nvme1n1 30206.00 117.99  67.74  67.74  29.44  67.29 87.90  0.35 47.82 99.22 99.98 99.99 99.99 100.00 100.00 /test1
> nvme1n1 14370.00  56.13  32.23  32.23  70.55  32.69 17.82  0.03 39.89 88.92 94.88 98.37 99.53  99.77  99.85 /test2

Maybe this'd be better done with bpf?

-- 
tejun
